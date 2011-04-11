From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Converting merge to rebase in the presence of conflicts
Date: Mon, 11 Apr 2011 16:39:43 +0200
Message-ID: <4DA312AF.80100@drmicha.warpmail.net>
References: <BANLkTi=krC6JMEWj=a5CY1vRCcmh9b+BaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?SHJ2b2plIE5pa8WhacSH?= <hniksic@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 16:40:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9IHZ-0005pH-Or
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 16:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153Ab1DKOjr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Apr 2011 10:39:47 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35115 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752944Ab1DKOjq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Apr 2011 10:39:46 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A3DC520BD5;
	Mon, 11 Apr 2011 10:39:45 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 11 Apr 2011 10:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=zSiywo+s2KIbTuiPU1ndW1Xn6iI=; b=cl0JqGWe1KdQ7EBZZ9VbOrgpyKktIw0HgI4EAdFtardNND8uv5lPgt4hXzQL0fa26n/+knDudnaF3S+QhCymI7nZEpFVAuCbkyYDhNq6XFK45xj9FMymV/eexNa0sdQRNIxZ0eabYFmTNmCdSFmN7lSM62Q1SVO6jQVlu1Cv2QI=
X-Sasl-enc: r6XxEFrJXvsQZg5GePbO2se3e7RBhmAkBVFSkyOue6Yx 1302532785
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2975044740A;
	Mon, 11 Apr 2011 10:39:45 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <BANLkTi=krC6JMEWj=a5CY1vRCcmh9b+BaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171331>

Hrvoje Nik=C5=A1i=C4=87 venit, vidit, dixit 11.04.2011 16:13:
> Is it possible to convert a merge with (resolved) conflicts into a re=
base?
>=20
> I find it useful to always pull commits with "git pull" because it is
> less intrusive on my local commits (if any) than "git pull --rebase",
> and it provides a nicer change summary. Also, conflict resolution
> seems more intuitive when merging than when rebasing. And If I decide
> later to rebase after all, I can simply issue "git rebase origin/bla"=
=2E
> As long as there are no conflicts.
>=20
> If the merge resolves conflicts, the subsequent rebase is unaware of
> that, and the conflicts must be resolved once more. Here is an exampl=
e
> in a single repository that just uses 'merge' to show the scenario:
>=20
> # create a common file with two lines and branch off
> printf 'foo\nbar\n' > a
> git add a && git commit -m '' a
> git add a && git commit -m 'Added.' a
> git branch somebranch
>=20
> # now work on the file in both branches
> echo baz >> a
> git commit -m changed a
> git checkout somebranch
> echo qux >> a
> git commit -m changed2 a
>=20
> # we're on somebranch and decide to merge our changes with master:
> git merge master
> vi a           # resolve conflicts
> git add a
> git commit     # commit the merge
>=20
> At this point say the developer on somebranch changes his mind and
> wants to rebase after all. The result is, again, a conflict:
>=20
> # try to change merge to rebase
> git rebase master
> [... long output on conflicts ...]
>=20
> First, rewinding head to replay your work on top of it...
> Applying: changed2
> Using index info to reconstruct a base tree...
> Falling back to patching base and 3-way merge...
> Auto-merging a
> CONFLICT (content): Merge conflict in a
> Failed to merge in the changes.
> Patch failed at 0001 changed2
>=20
> When you have resolved this problem run "git rebase --continue".
> If you would prefer to skip this patch, instead run "git rebase --ski=
p".
> To restore the original branch and stop rebasing run "git rebase --ab=
ort".
>=20
>=20
> Is there a way to rebase the branch without redoing conflict
> resolution? Some option to rebase, or a trick with rebase -i? The
> conflict resolution must obviously go into some commit, it would be
> nice to be able to choose whether to amend an existing commit with th=
e
> additional changes or to add a new commit.
>=20
> Hrvoje

If you enable rerere before the merge then the merge resolution is
recorded and can be reused by rebase. It still stops but applied the
previous resolution automatically already.

Michael
