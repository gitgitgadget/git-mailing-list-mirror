From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Git drawbacks?
Date: Fri, 6 Nov 2009 12:51:42 -0500
Message-ID: <32541b130911060951q3358ce9ahe28fb0cf902853f2@mail.gmail.com>
References: <loom.20091106T160709-387@post.gmane.org> <32541b130911060849s2d8f13f5sb9b8390f075f8d15@mail.gmail.com> 
	<loom.20091106T180313-750@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dmitry Smirnov <divis1969@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 18:52:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Syn-00082z-QH
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 18:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756596AbZKFRv5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Nov 2009 12:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756012AbZKFRv5
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 12:51:57 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:47873 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbZKFRv4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2009 12:51:56 -0500
Received: by ywh40 with SMTP id 40so1100274ywh.33
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 09:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=FYz486J7CJe/bZMHEiixVEr+2t0l5OL67MVURMdZY2w=;
        b=H/zwZWrEBWK8ZniptHoYdWrtYBrwykZwi2VfQ42qZ80pR8DpU5QaWCLlwRlLN1uXf3
         c5cWY/h6Lzz1v6L2xZOlKLMEWL7PiFOYnFUJ3yv0CusBUMwkaLcknLKNCtxCBcUVtTkX
         ICzagNq5L44ErmzuP/TD/giwmYq9U1gAJZCFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=AHGoZSbsH54VsFLwDzR912AAp50t9paMy25/FwdzIyCW5uzo9bI0TGJwbMutOTDSib
         SW+5Z3XlRrnVxnRYHTG6LSWOEWYQTgMKvla3X7731wfBfURUvKlB/HXjV0+/TLtPRFnp
         MzfMFh2NCovn2/NTvxRkmC19HqIdlMVMzSnUo=
Received: by 10.150.16.14 with SMTP id 14mr8252243ybp.246.1257529922052; Fri, 
	06 Nov 2009 09:52:02 -0800 (PST)
In-Reply-To: <loom.20091106T180313-750@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132315>

On Fri, Nov 6, 2009 at 12:35 PM, Dmitry Smirnov <divis1969@gmail.com> w=
rote:
> No, #2 is about the repository slicing, branching, merging (SCM in ot=
her words).
> Let's suppose I have the product that have 2 directories: component1 =
and
> component2. They were developing together for =A0previous product (on=
 the same
> branch, for example). Now, I would like to have component1 and replac=
e
> component2 with some 3rd party component. What should I do with Git t=
o get this?
> Or maybe I wish to stick with some version of component2 and provide =
only bug
> fixes for this product...

There are three methods I know of to manage this:

1) Just commit whatever version of a subproject you want as a subtree
of your current project, and if you want to replace/delete/upgrade it,
just do that.  (You rarely want to track the actual *history* of the
third party tool, just the history of versions *you* used, which is
easy to do.)

2) Use git-submodule to link repositories together.  (Arguably, one
major reason 'repo' was written is that git-submodule is too
complicated, though.)

3) Try my git-subtree tool, which basically makes it easier to
split/join repositories (similar to #1) without losing the history
(similar to #2).

>> This
>> lousy performance isn't the case in git (except in Windows). =A0Are =
you
>> using Windows, by chance?
>
> yes. I did not yet noticed any performance problems with Git on windo=
ws, except
> a sync/download time (for android, mostly)

Basically, performance is linear with the number of files in your
repo.  If you can check out just a "slice" of your repo (say 10% of
the whole), you'll have faster performance (eg. 10x) from any VCS.

git on Linux is so fast that this isn't very necessary most of the
time.  But git on Windows isn't really any faster than other VCSes on
Windows, so the time-per-file is much greater, and thus the penalty
for huge repositories is much worse.  Doing things like switching
branches, which is near-instantaneous on Linux even with tens of
thousands of files, really crawls on Windows.

So I can see an argument that Windows users would want arbitrary
"slices" much more often than Linux+git users, but I think this is
largely due to performance, not because people really *want* to be
stuck with a restricted view of the repo.

Have fun,

Avery
