From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: Corrupted git repository?
Date: Wed, 16 Feb 2011 17:44:03 +0100
Message-ID: <AANLkTimZgpWUAncLgO=y5CvKsYGdYWTHNUzncjrC5UO6@mail.gmail.com>
References: <AANLkTimMon7ztbyT26YhotiZ=jd=QpNTvOkPCKwHg+e_@mail.gmail.com>
	<7vk4h1nk3x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 16 17:44:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpkU8-0001aO-Nk
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 17:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231Ab1BPQoH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Feb 2011 11:44:07 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:56797 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191Ab1BPQoF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 11:44:05 -0500
Received: by vxb37 with SMTP id 37so643146vxb.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 08:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=wLnjcCgwQYdrIYMVSVIkSLx0sQaSy5ImoBqAUVO6Ezs=;
        b=wDiVH2kn+5JAV9j5rLOM81H8zWE7TA4Z+a1bXHoqPSek0iWtuZRXjVlM4YyKEFcyJa
         2/AYm4HRtePiKROE4saiWdyKRco+88xDQ65suaZ2SayK8CEM3Bfbu8Q57hKOt99UlsIA
         QvKZFWN8JqZrfeWF7e1Oj6uQEE04e0GyrhE8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=iuwELIVvL4s4at0UODVfFiT0vRWx+8pegGiP/WjEfDHMTMCKLEwU+dcP8uzhUBwnkm
         qAUj/z2RGCsioVgZqM6xf7AYw5k8DkzGAc645UQcts4gCIrZsKsAeN1GojbcAyNEv9ai
         37U4g7ctYCIbXARg8Y1/hMq4lFyEbm6R6/hyA=
Received: by 10.229.186.75 with SMTP id cr11mr965592qcb.113.1297874644028;
 Wed, 16 Feb 2011 08:44:04 -0800 (PST)
Received: by 10.220.195.132 with HTTP; Wed, 16 Feb 2011 08:44:03 -0800 (PST)
In-Reply-To: <7vk4h1nk3x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166973>

On Tue, Feb 15, 2011 at 9:00 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com> writes:
>
>> it looks like my git repository got corrupted today.
>>
>> git status shows no changes,
>> git cherry-pick says "error: Your local changes to the following fil=
es
>> would be overwritten by merge:",
>
> with some paths, or without naming any path?

With one path:

$ git status
# On branch master
nothing to commit (working directory clean)

$ git cherry-pick 7d193bb0c1f14908361d9d9d5e30f0c12d5f2c2f
error: Your local changes to the following files would be overwritten b=
y merge:
	<<PATH>>
Please, commit your changes or stash them before you can merge.
Aborting

$ git status
# On branch master
nothing to commit (working directory clean)

7d193bb comes from trunk, master was reset to a branch,
the <<PATH>> is a file that was not changed in the commit,
git clean -n -- <<PATH>> does not show anything

They should not have "assume unchanged" bit because I did
git update-index --no-assume-unchanged --verbose -- <<PATH>>


>> git fsck starts checking objects but hangs on one "Checking tree"
>
> I take it that you are talking about "git fsck -v". =A0Is it really "=
hangs",
> or just "takes a long time"?

I was too hasty - fsck finished fine. It just took long time for one ob=
ject
(a couple of minutes while other checked objects took less than second)=
=2E

It only printed several dangling objects:

$ git fsck
dangling tree 0ff163a56128d95c5b88c520f68792f6f900bb18
dangling commit deb988eeb2404dd1e57c8894c3cfd93dd316aca3
dangling tree 50323779bd6c0d4eb19664a3945c6c31fe9dadd4
dangling commit 9ed87852fdf6775a3c071faec05388eda5cd5de1
dangling commit a4d09c76a1b58bbf51f2b701407493c5ed9f9b78


>=A0You mentioned that a clone is expensive so I
> am guessing that your repository has some huge trees or objects in
> general.

That's one reason, the other is that I'm using git-svn ...


> The details you gave in your message are a bit sketchy to give you an
> exact diagnosis, but if "cherry-pick" stops with the above message an=
d
> tells you the names of files that are not tracked in your current bra=
nch,

"git log -- <<PATH>>" shows two commits for this file on this branch an=
d
on trunk, and "git status" does not list the file as untracked.


> I don't see there is anything unusual going on. =A0You have these fil=
es with
> random contents that git does not know about, and git is refusing to
> lose their contents by overwriting them during the cherry-pick.
>
> After making sure that they are indeed untracked paths, if you think =
you
> can remove them (or move them away), first do so and retry cherry-pic=
k,
> and then everything should be Ok.

I believe the file is tracked and is not modified?

I have deleted the whole top-level directory in which the file was and =
run:

$ git status | grep  <<PATH>>
#	deleted:    <<PATH>>

$ git checkout -- <<top dir>>

$ git status
# On branch master
nothing to commit (working directory clean)

$ git cherry-pick 7d193bb0c1f14908361d9d9d5e30f0c12d5f2c2f
error: Your local changes to the following files would be overwritten b=
y merge:
	<<PATH>>
Please, commit your changes or stash them before you can merge.
Aborting


--=20
Piotrek
