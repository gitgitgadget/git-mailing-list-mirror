From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stgit - continue rebase after merge conflict?
Date: Tue, 26 Feb 2008 16:56:53 +0000
Message-ID: <b0943d9e0802260856j6e9b0053ne4916149d8e4387c@mail.gmail.com>
References: <20080226145725.GA24987@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Alex Chiang" <achiang@hp.com>, catalin.marinas@gmail.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 17:58:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU37p-00041A-2Y
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 17:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856AbYBZQ47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 11:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756636AbYBZQ46
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 11:56:58 -0500
Received: from wr-out-0506.google.com ([64.233.184.239]:16970 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080AbYBZQ46 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 11:56:58 -0500
Received: by wr-out-0506.google.com with SMTP id c48so3386740wra.23
        for <git@vger.kernel.org>; Tue, 26 Feb 2008 08:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=SdjeAliKVsIRnVUfaRAGwAhp527O/brQ5/25t2eAFPU=;
        b=JUnlGCstYsXE3u6IF0ZUlKEBzv54OgZFBqBgvBSh4Js3P6sbX9EFYU+qSVouqwg0y9OLPFnzO3XUfANJiegLDPyfcCIXVdQBdsVCKTb8v2Ow3um6KLEBxrD7jziYdxf7PoOh2tXIKCKKA59ckzGY0DEAD6LOOCBzRjyx+uGSrvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mlCe+GMc80TNr0QFpkBUVRGXNbNCjbHQWP9zemWurGh2Cj5lrVUOfP378xit9NyJBHXnKSveuQk4tax3OfGNZ/K1PHxbLAuKpsAlgZBYtuHluN6yOPMW1UV6OCujAwrG0pgJ1FVKNE3fBpcbHCcUtp1KaZ8EE9YHD3y2pmaQwsk=
Received: by 10.141.153.16 with SMTP id f16mr3480419rvo.246.1204045013928;
        Tue, 26 Feb 2008 08:56:53 -0800 (PST)
Received: by 10.140.193.5 with HTTP; Tue, 26 Feb 2008 08:56:53 -0800 (PST)
In-Reply-To: <20080226145725.GA24987@ldl.fc.hp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75151>

On 26/02/2008, Alex Chiang <achiang@hp.com> wrote:
>  How does one do a stg rebase if there are merge conflicts?

Basically, you solve the conflict, refresh the current patch and
continue with 'stg push' or 'stg goto <top patch>'. The 'rebase'
command does 'pop --all', 'git reset', 'push --all'. In your conflict,
the base of the stack was already changed to the latest and hence only
push/goto is needed. To fix it:

$ vi files   # or simply use 'resolved -i' below
$ stg resolved -a [-i]
$ stg refresh
$ stg goto top-patch

or (if you want to skip that patch):

$ stg push --undo
$ stg push next-patch..

The 'rebase' command doesn't store any information about the state of
the stack and cannot continue it. Maybe we'll do something in the next
release as the refactored code has support for transactions.

Yet another option is to enable the automatic interactive merge ('git
config stgit.autoimerge yes') and, at a conflict, it calls your
three-way merge tool (emacs, xxdiff etc.). If the merge tool succeeds,
the rebase will simply continue.

>  This output tells you how to undo the rebase, but doesn't give
>  any clues on how to continue it, like git would:
>
>  -------------------------------------------------------
>  When you have resolved this problem run "git rebase --continue".
>  If you would prefer to skip this patch, instead run "git rebase --skip".
>  To restore the original branch and stop rebasing run "git rebase --abort".
>  -------------------------------------------------------
>
>  Doing an 'stg help rebase' isn't so helpful.

Yes, indeed. It could be made better.

-- 
Catalin
