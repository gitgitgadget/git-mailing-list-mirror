Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D9CC2D0C0
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 14:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1902720684
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 14:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="w8/hoTZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfLVOBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 09:01:53 -0500
Received: from ms11p00im-qufo17292001.me.com ([17.58.38.49]:55937 "EHLO
        ms11p00im-qufo17292001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbfLVOBx (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Dec 2019 09:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1577023310;
        bh=DzqcEvnatj1NyEPGgcTdSSlOS/A44fNXJBb6mizyEx8=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=w8/hoTZrGt0O+O0A4eg9AlaYhDTE29M0qx3tN4VQYd5sKtJ3nYQxBi9X8i3RNKu63
         f8n0xyGrSoWWWN6xPx7CdPpRZdKvX8tRW5D+Nbg67oUjoVum52acATgzd7lCbrA1Ms
         Ik4YpqZwwOvhN1CqQckseS9oAOGIoOySYuWuAkIrmMGlOQIxPdmAmw1xB8Boqr8+7+
         rQZyL0eOdf6sfIztLrzZ9P8UxJ7EJFAbYxunpJERAcQ3TZoxKN4Va1nbtBPU9ka8ig
         wTuTeUJhmheNRoK6Ja2va+f7Qb4o3OHFg2gs2g8wL2E5EOByTG24Kv0YloAk9IER4z
         wYhdm8hd4Y6fg==
Received: from [192.168.0.8] (106-69-210-73.dyn.iinet.net.au [106.69.210.73])
        by ms11p00im-qufo17292001.me.com (Postfix) with ESMTPSA id E6269880716;
        Sun, 22 Dec 2019 14:01:49 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: git-subtree split misbehaviour with a commit having empty ls-tree
 for the specified subdir
From:   Tom Clarkson <tqclarkson@icloud.com>
In-Reply-To: <CAPyFy2Ar+OncJtgZZyAzxs0PkXy5rSU6ALS+MimK8x5TzWjLug@mail.gmail.com>
Date:   Mon, 23 Dec 2019 01:01:47 +1100
Cc:     git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <905A443A-7E2B-45C2-985F-46C3E295670A@icloud.com>
References: <CAPyFy2AKSVQJtSY0RNgJDJ5k1P=-gjNXVjDgPh+CdghhZtJXDw@mail.gmail.com>
 <F0FBE3B6-0DF5-40A4-B1A3-18EF65D48FF3@icloud.com>
 <CAPyFy2Ar+OncJtgZZyAzxs0PkXy5rSU6ALS+MimK8x5TzWjLug@mail.gmail.com>
To:     Ed Maste <emaste@freebsd.org>
X-Mailer: Apple Mail (2.3601.0.10)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-22_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912220128
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 21 Dec 2019, at 2:56 am, Ed Maste <emaste@freebsd.org> wrote:
>=20
> On Wed, 18 Dec 2019 at 19:57, Tom Clarkson <tqclarkson@icloud.com> =
wrote:
>>=20
>>> Overall I think your proposed algorithm is reasonable (even though I
>>> think it won't address some of the cases in our repo). Will your
>>> algorithm allow us to pass $dir to git rev-list, for the initial
>>> split?
>>=20
>> Is this just for performance reasons? As I understand it that was =
left out because it would exclude relevant commits on an existing =
subtree, but it could make sense as an optimization for the first split =
of a large repo.
>=20
> Yes, it's for performance reasons on a first split that I'd like to
> see it. On the FreeBSD repo the difference is some 40 minutes vs. a
> few seconds.

I tried out the dir filter after getting the full revlist to produce a =
reasonable result.  It is a lot faster, but unfortunately it doesn=E2=80=99=
t produce the same output - If you use actual parent commits, you have =
to process the 50k irrelevant ones to keep a valid path. If you let =
rev-list find what it thinks is the most recent relevant change, the =
subtree merges resolve to nothing.

>> So the process becomes something like
>>=20
>> # clear the cache - shouldn't usually be necessary, but it's a =
universal debugging step.
>> git subtree clear-cache --prefix=3Ddir
>>=20
>> # ref and all its parents are before subtree add. Treat any children =
as inital commits.
>> git subtree ignore --prefix=3Ddir ref
>>=20
>> # ref and all its parents are known subtree commits to be included =
without transformation.
>> git subtree existing --prefix=3Ddir ref
>>=20
>> # Override an arbitrary mapping, either for performance or because =
that commit is problematic
>> git subtree map --prefix=3Ddir mainline-ref subtree-ref
>>=20
>> # Run the existing algorithm, but skipping anything defined manually
>> git subtree split --prefix=3Ddir
>=20
> This sounds about perfect.
>=20
>>> For a concrete example (from the repo at
>>> https://github.com/freebsd/freebsd), 7f3a50b3b9f8 is a mainline =
commit
>>> that added a new subtree, from 9ee787636908. I think that if I could
>>> inform subtree split that 9ee787636908 is the root it would work for
>>> me.
>>=20
>> Aside from the metadata, that one is a bit different from a standard =
subtree add in that it copies three folders from the subtree repo rather =
than the root - so the contents of contrib/elftoolchain will never =
exactly match the actual elftoolchain repo, and 9ee787636908 is neither =
mainline nor subtree as subtree split understands it.
>=20
> Fair enough, and we have lots of examples of slightly strange history
> in svn that svn2git represents in interesting ways.
>=20
>> If you ignore 9ee787636908, the resulting subtree will be fairly =
clean, but won=E2=80=99t have much of a relationship to the external =
repo.
>>=20
>> If you treat 9ee787636908 as an existing subtree, the second commit =
on your subtree will be based on 7f3a50b3b9f8, which deletes most of the =
contents of the subtree. You should still be able to merge in updates =
from the external repo, but if you try to push changes upstream the =
deletion will break things.
>=20
> I think this is fine - our main goal here is to be able to update
> contrib/ code within FreeBSD as we do today with svn, and we may well
> always have some changes that are never intended to be pushed
> upstream.
>=20
> Continuing the example from our repo, there is more history in the
> "subtree" already, with 061ef1f9424f as the head. ca8624403626 is the
> merge to mainline.


If you want to try out my update, it=E2=80=99s at  =
https://github.com/gitgitgadget/git/pull/493. The commands I ended up =
with were

git subtree ignore --clear-cache --prefix=3Dcontrib/elftoolchain 4d43158
git subtree use --prefix=3Dcontrib/elftoolchain 9e78763
git subtree split --prefix=3Dcontrib/elftoolchain =
53f2672ff78be42389cf41a8258f6e9ce36808fb

On my machine, ignore takes about 2 minutes to flag 200k commits as =
irrelevant. The split takes around 15 to go through the remaining 50k.=
