From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] worktree: provide better prefix to go back to
 original cwd
Date: Thu, 7 Oct 2010 14:20:38 +0700
Message-ID: <AANLkTim8R2ZxJ1_KnxxRwTjf2mz=NtgQ9MyV_7iAqEpG@mail.gmail.com>
References: <4cad50da.0e958e0a.40e3.5efd@mx.google.com> <7veic2y2c5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, judge.packham@gmail.co, Jens.Lehmann@web.de,
	jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 09:21:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3kmq-0005Oe-Jw
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 09:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759606Ab0JGHVA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 03:21:00 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58780 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756018Ab0JGHU7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 03:20:59 -0400
Received: by wwj40 with SMTP id 40so536931wwj.1
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 00:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=bSehiQEMOQGdUC5GnTzXUWiROTm61oj+SN7a6HfX2Vw=;
        b=YUWpC7dy0RMTfX++IHmB5rDAoQphcuySK7InBjwkHrW3DrBPAWWwTQOlgm92Nh/g9e
         hs2n+Fy66p5EALQpFsj1BZpYxhLUhbXuNWFqy9CaVGY8E0kshb7yPywayiUneNUZiQxW
         F/b44efOqvLqhf+/F2Mc6nEGeBAq1Fhjaa1x8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ERT10p3JaYpTtYL+yMpsKiEprR/ydHQI0BXrgFTAEPrZA7ULUSVmh8jSjYGYN9yWnP
         sTfrDFTpIpZo82WghGpHp3G2oD4glp29KF/ZikMSMmNu1TPU5Zu2E+K82lA/JWzzP6fC
         Vbb04lKrlWqCatqIBAcfQ2GS7SrYOIbVLIVbI=
Received: by 10.227.72.149 with SMTP id m21mr326722wbj.186.1286436058464; Thu,
 07 Oct 2010 00:20:58 -0700 (PDT)
Received: by 10.216.153.195 with HTTP; Thu, 7 Oct 2010 00:20:38 -0700 (PDT)
In-Reply-To: <7veic2y2c5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158378>

On Thu, Oct 7, 2010 at 12:54 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> pclouds@gmail.com writes:
>
>> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>>
>> When both GIT_DIR and GIT_WORK_TREE are set, if cwd is outside
>> worktree, prefix (the one passed to every builtin commands) will be
>> set to NULL, which means "user stays at worktree topdir", but cwd is
>> not moved to worktree topdir.
>
> Well, NULL traditionally meant "_if_ the cwd is inside the working tr=
ee,
> it is at the top", not "stays at worktree topdir" if you started from
> elsewhere.
>
> And when cwd is inside the working tree, we do want to feed paths giv=
en
> from the command line after adding the prefix, so that we will see th=
e
> paths relative to the cwd after we do cd-to-topdir.
>
> Obviously when you run git command that requires you to be in a worki=
ng
> tree from outside the working tree, relative or full paths would not =
make
> any difference. =C2=A0The command should simply fail.
>
> I suspect that you are introducing a new semantics on top of that
> traditional semantics; if so, you may want to state it more clearly.

Yes. The better semantics _when_ cwd is outside worktree.

> For example:
>
> =C2=A0 =C2=A0When you run git command that requires you to be in a wo=
rking tree
> =C2=A0 =C2=A0from outside the working tree, the command should simply=
 fail.
>
> =C2=A0 =C2=A0When GIT_WORK_TREE is in use, however, it could be argue=
d that we do
> =C2=A0 =C2=A0not necessarily have to be in anywhere in the working tr=
ee to perform
> =C2=A0 =C2=A0a whole-tree operation. =C2=A0Instead, we could just say=
 the operation
> =C2=A0 =C2=A0always runs as if the command was started at the root le=
vel of the
> =C2=A0 =C2=A0working tree.
>
> =C2=A0 =C2=A0To support this new mode of operation, however, prefix n=
eeds to be
> =C2=A0 =C2=A0adjusted to allow the program, after running chdir(2) to=
 the root of
> =C2=A0 =C2=A0the working tree, to refer to non-absolute paths origina=
lly given from
> =C2=A0 =C2=A0the command line as relative to the original cwd. =C2=A0=
This patch adds a
> =C2=A0 =C2=A0mechanism to support that.
>
> I have a queasy feeling about the idea of the second paragraph above,
> though.
>
> If the original cwd is inside GIT_WORK_TREE, limiting ourselves insid=
e
> prefix naturally limits the operation to the subdirectory we started =
from
> (if the original cwd is at GIT_WORK_TREE, that would make it a whole-=
tree
> operation). =C2=A0A natural extension of this idea to limit the opera=
tion to
> the part of the subtree of the working tree we started from is to ref=
use
> to work in the case where the original cwd is outside GIT_WORK_TREE (=
the
> current implementation of GIT_WORK_TREE may or may not correctly impl=
ement
> it, though---I never use it myself).

I tend to think that as we go up to worktree's root, prefix is shorten
and the operation area is widen. When cwd is at worktree's, we operate
on full worktree. If it goes up one level higher, the operation area
remains full worktree (but not everything under cwd because cwd now
can have non-worktree directories).

> Futzing with the prefix that is not a prefix to reach into the workin=
g
> tree from sideways may make the relative paths given from the command=
 line
> mean something to the current implementation, but it doesn't change t=
he
> fundamental fact that you are introducing a funny special case where =
your
> cwd does _not_ mean anything with respect to which part of the workin=
g
> tree should be affected.

It would mean full worktree is affected. But not full cwd. In other
words, in set theory, it's a union of cwd and worktree.

>> Some commands may want "path in repository" and "path in file system=
"
>> to be identical. Moreover, output from commands in such situations a=
re
>> relative to worktree topdir (because prefix is NULL), not what users
>> expect. It's just confusing.
>
> My gut feeling is that this is probably made more confusing, not less=
,
> with the change. =C2=A0Perhaps we should instead make sure this fails=
?
>
> =C2=A0 =C2=A0$ cd /srv/git/git.git

Err.. you did not mean bare repo, did you?

> =C2=A0 =C2=A0$ export GIT_DIR=3D$(pwd)/.git GIT_WORK_TREE=3D$(pwd)
> =C2=A0 =C2=A0$ cd /var/tmp ;# no git stuff there
> =C2=A0 =C2=A0$ git status

I think it used to fail some time ago. Though I see nothing wrong if
that command works. And it'd be better if it outputs relative to
/var/tmp rather than /srv/git/git.git. I don't use this a lot but
sometimes I export GIT_DIR/GIT_WORK_TREE, cd around then do "git add
/srv/git/git.git/blah". To me, it should work. I may stand outside
worktree, but I give input inside worktree.
--=20
Duy
