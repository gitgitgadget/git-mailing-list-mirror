From: David Aguilar <davvid@gmail.com>
Subject: Re: Re*: mergetool: support --tool-help option like difftool does
Date: Fri, 24 Aug 2012 01:31:04 -0700
Message-ID: <CAJDDKr6zk3ztEXeX8=vn3apZ3k1DxdCAu2ZDyqtNnb=Cb5ZUvQ@mail.gmail.com>
References: <500CF8CE.90906@gmail.com>
	<500CF9D2.30102@gmail.com>
	<500CFAE1.3070304@gmail.com>
	<7vr4s2mnir.fsf@alter.siamese.dyndns.org>
	<7vipdemm0a.fsf_-_@alter.siamese.dyndns.org>
	<7vzk5m41gk.fsf_-_@alter.siamese.dyndns.org>
	<CAJDDKr42YtfcpARQx6Vx8-Uy7KF3yEoGOQ0VzPKsWQA_hG=MgA@mail.gmail.com>
	<7vvcg94if1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 10:31:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4pIe-0002KX-SE
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 10:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394Ab2HXIbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 04:31:22 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:47905 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932208Ab2HXIbG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 04:31:06 -0400
Received: by vbbff1 with SMTP id ff1so1786887vbb.19
        for <git@vger.kernel.org>; Fri, 24 Aug 2012 01:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8J/TBchBxpy86BtV0jVDJDv0rou6HzP2KB4YBJqFQHI=;
        b=JCW41cYoGiTvDl6zOQ0FX+lir62iCCKFuM+Fy+n0Lq8Kag26947xtI0OCdNLN4IiJE
         GLrjLzNXO3fXt/M26pGsJoplvEi/IBrcAR/nJdRdolUxePvMmDkzgCYOeJ25b4qsODp2
         mp6avICv4JSfBPq++Oo5mnHC4LkRuIW8G2I/W2CQV2jk55jqxaHYR31D65kTFxd3GQwE
         ZMV1e+vDHexPmkNpTWw+voa5gxycYlbY7T4n7zNMDa7XR8o/mekp8rHhCH/TuLVKa9rD
         I6opp0XYuiB/Xrk1lvmdwi3bFgWN15L7UBkzRSz3WcZasOORSGB3aD0xuOD4h07DNrNz
         7B2Q==
Received: by 10.59.1.162 with SMTP id bh2mr4361195ved.13.1345797064932; Fri,
 24 Aug 2012 01:31:04 -0700 (PDT)
Received: by 10.58.173.104 with HTTP; Fri, 24 Aug 2012 01:31:04 -0700 (PDT)
In-Reply-To: <7vvcg94if1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204189>

On Thu, Aug 23, 2012 at 10:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>> Would the ability to resolve the various merge situations using
>> the command-line be a wanted addition?
>>
>> This would let a submodule or deleted/modified encountering
>> user do something like:
>>
>> $ git mergetool --theirs -- submodule
>>
>> ...and not have to remember the various git commands that it runs.
>
> Does it have to run various git commands?  For a normal path, all it
> needs to do is "git checkout --theirs $path", no?
>
> What does it mean to resolve a conflicted merge of a gitlink to take
> "theirs"?  We obviously would want to point the resolved gitlink at
> the submodule commit their side wants in the resulting index but what,
> if any, should we do to the submodule itself?
>
> Stepping back a bit, if there is no conflict, and as a result of a
> clean merge (this applies to the case where you check out another
> branch that has different commit at the submodule path), if gitlink
> changed to point at a different commit in the submodule, what should
> happen?
>
> If you start from a clean working tree, with your gitlink pointing
> at the commit that matches HEAD in the submodule, and if the working
> tree of the submodule does not have any local modification, it may
> be ideal to check out the new commit in the submodule (are there
> cases where "git checkout other_branch" in the superproject does not
> want to touch the submodule working tree?).
>
> There are cases where it is not possible; checking out the new
> commit in the submodule working tree may not succeed due to local
> modifications.  But is that kind of complication limited to the
> merge resolution case?  Isn't it shared with normal "switching
> branches" case as well?
>
> If so, it could be that your "git mergetool --theirs -- submodule"
> is working around a wrong problem, and the right solution may be to
> make "git checkout --theirs -- $path" to always do an appropriate
> thing regardless of what kind of object $path is, no?

True.

Admittedly, I'm not a heavy submodule user myself so I
tried crafting the directory vs submodule conflict to see
what the usability is like.

checkout --theirs and --ours could learn a few tricks.

When trying to choose the directory in that situation
I had to  had to "git rm --cached" the submodule path
so that git would recognize that there was no longer a conflict.

That makes sense to me because I was following along by
reading the mergetool code, but I don't think most users
would know to "git rm" a path which they intend to keep.

Afterwards, the .git file is left behind, which could cause
problems elsewhere since we really don't want a .git file
in that situation.  I'm not even sure what to do about the
.gitmodules file either.

Here's the script I was using to setup the merge conflict
in case anyone wants to get a feel for the usability around
this edge case.

Pass --submodule if you want the remote side to have a
submodule.  By default, the local side has a submodule and
the remote side of the merge brings along a directory.

That said, this really isn't an issue, per say.
I first poked at it because I noticed that mergetool
still needed stdin for some things.

It's certainly an edge case, and perhaps this just shows
that mergetool really is the right porcelain for the job
when a user runs into these types of conflicts
(the stdin thing really isn't an issue).


#!/bin/sh
if test "$1" = "--submodule"
then
	first=with-directory
	second=with-submodule
	echo "local will be a directory, remote will be a submodule"
else
	first=with-submodule
	second=with-directory
	echo "local will be a submodule, remote will be a directory"
fi

repo=submodule-conflict-$$ &&
echo "creating $repo" &&
mkdir "$repo" &&
cd "$repo" &&
git init &&
git commit --allow-empty -m'initial' &&
git checkout -b with-directory master &&
mkdir the-conflict &&
touch the-conflict/path &&
git add the-conflict/path &&
git commit -m'added path into the-conflict' &&
git checkout -b with-submodule master &&
git submodule add ./ the-conflict &&
git commit -m'added submodule as the-conflict' &&
git checkout -b tmp-merge master &&
git merge $first &&
git merge $second
-- 
David
