From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 2/4] Abstract a PatchSet object out of Series.
Date: Tue, 19 Jun 2007 23:32:54 +0100
Message-ID: <b0943d9e0706191532w11439866u5a9c1b540d5ccca8@mail.gmail.com>
References: <20070611003117.4736.33551.stgit@gandelf.nowhere.earth>
	 <20070611003330.4736.69293.stgit@gandelf.nowhere.earth>
	 <b0943d9e0706121509j5088e164iadedb561501d6a55@mail.gmail.com>
	 <20070613203821.GQ6992@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0706141556w1fb280dbu12e55dc91f6d5941@mail.gmail.com>
	 <20070615201439.GT6992@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Wed Jun 20 00:33:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0mFv-0004pB-IG
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 00:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369AbXFSWc5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 18:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756822AbXFSWc5
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 18:32:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:51707 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294AbXFSWc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 18:32:56 -0400
Received: by ug-out-1314.google.com with SMTP id j3so220665ugf
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 15:32:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VZ/MoG9bkWu368ufeFRG/tgwUG9Qynyr5lduwY7NTABcwUeHJG/BMyU7zY0bFmjvl8ZdNaofuuEelR/V8aF+uRykKTBOcrktZ0V3irMggXJhEa+U0RdkjEnHve8jiR+4TrMpHfHiar4SETwOq99hsFZ99x8Yt3ZJGmotJjv5Du4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jtlr/MoGWBffFrkdgKskqzGiM6Xid7EmE5TBkXNTc78AJaeE9/cgu+1HrkkuUSoc8rFUm1orARd1CmtAq96Quf2klC3mOoD840k1bn6BF9xYMlqPCVA83mKLi8/cVbl4fLJA7Bqvhzt/yRJR0OrwT0pARHkcIHdo5cahSFiAQ1M=
Received: by 10.67.22.14 with SMTP id z14mr772693ugi.1182292375009;
        Tue, 19 Jun 2007 15:32:55 -0700 (PDT)
Received: by 10.66.255.6 with HTTP; Tue, 19 Jun 2007 15:32:54 -0700 (PDT)
In-Reply-To: <20070615201439.GT6992@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50516>

On 15/06/07, Yann Dirson <ydirson@altern.org> wrote:
> Indeed one of the things that naturally come to mind after hydra, is
> to abstract a parent class above PatchSet and Patch, and allow those
> to be mostly used everywhere one of them is allowed.
>
> That way we can have a (sub-)stack anywhere between 2 patches in a
> stack, and that should I think address the need you describe.  But
> that would also allow to have an hydra built of single patches instead
> of stacks, which would be quite similar to how darcs organizes
> patches.  Combinations are endless, and I don't even count the
> possibility of adding new structures besides stacks and hydras :)

If you can track the patch dependencies, it would be enough to no
longer have a stack but a pool of patches (like darcs but without
exact patch commuting, the diff3 merging provides a good approximation
of this operation and in a much faster time). Simple patch dependency
could be detected by trying to apply a patch without others (it can be
optimised so that only patches touching common files should be
checked).

> > It's not a bug. The import command just uses the e-mail sender or a
> > "From:" line before the patch description (see the default mail
> > template). It doesn't check the sign lines (it is following the kernel
> > patch submission guidelines).
>
> We could surely improve things (and I'm not suggesting we should look
> at sign lines).  Eg, by having stg-mail add an Author pseudo-header
> when the patch author is different from the sender, and having
> stg-import use that when available.

But the 'stg mail' command already adds a "From:" line in the body
(with the default template) and 'import' checks for 'From:' or
'Author:' which override the e-mail sender. You might be using a
different e-mail template.

-- 
Catalin
