Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03319C54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 11:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiIVLXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 07:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiIVLXX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 07:23:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B535E05FC
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 04:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663845799;
        bh=He39lDZYRUU14tRac59tAwUvbkqmpC3msSeYSlavYuo=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=HwJ1GJMDZGZ0YP3OhQVqKHrHLJyqQnmV3JQjjFCVVnx+CUTNQdSiasIUXYPgJPi6a
         dAQ4TIkxMc3FSZyQup0r2k4E1wDmGcMLEA4oBhwdbhO15ismWgHGBnfxInG9dZoWUd
         jBwcEQ0s9jhtdq396UDqCjFr63EPvImrIbV3z1jQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [176.72.143.73] ([176.72.143.73]) by web-mail.gmx.net
 (3c-app-mailcom-bs01.server.lan [172.19.170.58]) (via HTTP); Thu, 22 Sep
 2022 13:23:19 +0200
MIME-Version: 1.0
Message-ID: <trinity-15566df8-59d7-4597-b59d-2143ec978b12-1663845799823@3c-app-mailcom-bs01>
From:   djvortex@gmx.com
To:     git@vger.kernel.org
Subject: Handling rebasing better
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 22 Sep 2022 13:23:19 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:YOWAIGNs5DIX5r6unEKztxQhHDhuBalr/h+j5P9HKvNXLnaPPMYJvUEUD+6L9VBrPfo8Y
 XddqtQ0Uv5hTZhxu13V7VtRMUjLZptVjBDt2GDrfvcHSDrrto0cBPD18rxuHti4gYVb+9BIyZztO
 HhobteqQsxDDjIcKTZqdcJslm6qF+weWOtm4akH4MF910SQD3WNW4UCbNkxXlctxD2AW+Vw/PWDa
 06p3bj3yFShYwiHkJSAiUxK7X2aghdfMLquTtgja/bB+0BJ2KoKf8+KRraHTEtaeZpvfZDn/Vizs
 Tw=
X-UI-Out-Filterresults: notjunk:1;V03:K0:T5NgCrgq4bw=:RGNZGv3YuYike3ZrCDLmjo
 HnjNqaYQkH43Gy1eilCubiOtTTpzwsIH72ObEnhD83+qvQycVXp6WBUyAErme/c3gqXTqB/Uy
 StONDah7wMTdCe9SZqcy7pxLsVigVxK+2PMlkypVFLYfR+xHzFkSMLp1fzQy7FEPhdMBfXpct
 EdSuL0Ppfe9UpGney81kYc22CAaDBVvMEaPWy9pAp9mON3zFAIFt007hlOwtCXzlxrOqLDb7h
 tY4vG0YkF6h+FF9C1oC94UsfbbFtVAAT3WpDFzBRJP5k+B4v93KXrCwPhhviZJNz9hE3ybQeI
 l821mPW9nGsZZxV5EHRcCHHOuo+J38p+oYkSlU195LQNx+t+PUjbhHlVf0dt29L7D7QF+DYwK
 MRgZRZI9SUzNUO4nsUuHdfnnRxJdOpMOLCIHn6Utv28CRey32HCkv/atgwwg8cbjEVzjP04mi
 cVksXegxdnKhZo5mCkFOFvT7CVnenklPa9B6Q0b00txQyJa2bkVyE+NcMqeQphl845/qo4OcY
 f28QaKrrvc3KxDB+jpV2OXL7CsvQY2tUyd8f6SqFO4w1hhM0fgrU6t7WdPVxGCKYw64gaXf1f
 PVg07aiDXJ5TVIzx5d2o3K3IPTWKApQfiuTCUotzZpkhzmL7w/hT2bkrSWfxCK9iMcFXUAayr
 qyi+TJVcX6vB6jmJBoGP8FSJDHtZDda8PPciidoPH+Vn+pReXljFfxBOlnuYJ+DegI0VPfqvU
 eSKoLrXokitv7rN8MJIAKrVc8Mf76g0yQvMAH59QYCFy8oU9ezE46sFOnXDbrJXlst+3mREll
 ZWxqHFh
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello.

I wouldn't be surprised if this very subject has already been endlessly di=
scussed over the years, but nevertheless allow me to make a feature reques=
t for git. (If this has already been discussed in the past, which I'm quit=
e certain it has, I would like to hear the details so I can understand the=
 design decisions that have been made in this regard.)

Rebasing is a rather curious feature of git in that it's both an extremely=
 common and normal operation done in many projects, and at the same time i=
t's a very drastic measure that has the potential of badly messing up or e=
ven breaking git commit histories (as any operation that changes history i=
s), or at a very minimum cause a lot of work. Rebasing is extremely common=
 in many projects, so much so that there are many such projects where in f=
act only fast-forward merges are allowed to the master branch (which is of=
ten possible only by rebasing the branch to be merged onto the current mas=
ter branch head).

On the other hand, rebasing, as any other operation that changes commit hi=
story, has the potential of breaking things, or causing a ton of extra wor=
k, when more than one developer has the same branch checked out (and thus =
their local history diverges from the remote history).

So, given how relatively common it is to use rebasing, and how carefully i=
t should be used, it's a bit strange how poorly git seems to handle it. No=
t in terms of doing the rebasing itself, but in terms of subsequent operat=
ions done to the rebased branch.

For starters, if your current branch has been pushed to the remote, and th=
en you rebase it to something else, and then do a "git status", it will te=
ll you that the local and remote histories have diverged... and then sugge=
sts doing a "git pull"! Which is most definitely not what you want to do! =
You just rebased the branch, you don't want to try to merge it with the ol=
d branch history! (Developers who have not encountered this before may bec=
ome really confused if they try the "git pull" and start getting tons of r=
eally strange merge conflicts. The absolute worst thing they could then do=
 is try to "resolve" those conflicts, which is most definitely not what yo=
u want to do! I don't know if there are situations where you actually *don=
't* get any merge conflicts and the two diverged histories just merge... c=
reating a complete mess of a hybridized duplicated history.)

I think that git should be aware of what has happened, in other words, tha=
t the current local branch has been rebased to something else, and is now =
a completely different history from the same branch in the remote, and exp=
ress this clearly and suggest the correct thing (primarily to do a "git pu=
sh -f").

More importantly, I think git should handle better the situation where you=
 are trying to pull a rebased branch (which was rebased by someone else) o=
nto your local original non-rebased one. Again, currently you'll just get =
a huge bunch of weird merge conflicts (if you are lucky), and the worst th=
ing you could do is try to "resolve" them, as that's precisely what you sh=
ouldn't be doing.

I understand that the branch history having changed on the remote can be a=
 nightmare to deal with, when you have a local non-rebased copy of it, esp=
ecially if you have made new local commits to it. AFAIK there are no easy =
clear-cut solutions to this, but one of them is to just write down the has=
hes of your commits, reset to the remote branch, and then cherry-pick your=
 commits in chronological order (resolving any merge conflicts that may ha=
ppen).

The problem is that git isn't exactly helping here. I think that git shoul=
d recognize the situation and give better suggestions on what to do. In ot=
her words, if you are doing a "git pull" and the remote branch has been re=
based, git should stop and tell clearly that this has happened, and sugges=
t what to do. If it detects that the local branch is identical to the old =
remote branch (that existed before the rebase), it could suggest a reset. =
If it detects that there are new local commits on top of the old history, =
it could make another suggestion on how to deal with it. It might also giv=
e the (rather unsafe) option of doing the pull anyway, for example with so=
mething like "git pull -f", with a huge warning.

Perhaps git could even support the "reset-to-the-remote-history and then c=
herry-pick your new local commits" directly, to help the developer in this=
 task (so that you don't need to write down any hashes and do all that man=
ually). But even if this isn't really feasible, at least detecting the sit=
uation and the clearer messages would help enormously.

(I understand that the current design of git might not directly allow this=
 with just some code changes, and would perhaps require adding some kind o=
f extra metadata. But would this be bad? It would certainly help developer=
s handle rebases better.)
