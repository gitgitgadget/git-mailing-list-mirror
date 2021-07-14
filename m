Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D73AC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E2E613C2
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbhGNQtv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 12:49:51 -0400
Received: from m12-16.163.com ([220.181.12.16]:47435 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229595AbhGNQtq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 12:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Mime-Version:Subject:From:Date:Message-Id; bh=lNK0P
        nHXmXhpeBrCuBw/K1ttA3nJ4lMfu6xNy73dn2M=; b=e16CTanV9Jatz+6b9gcfc
        rPiBibYPRYbksKLLd/y6P7uo2eOeoaHU2Q2ripLRS7GteofcfyRJ1eAWJTT3gI00
        fQDzX6+z6Ds0i91HMHdHKNkk6aguifmI/1DomCVxNDZk9V4cWG1Aok6rr3CABsuX
        8WhDSUd7/JkhVFt16KQv28=
Received: from smtpclient.apple (unknown [60.176.228.14])
        by smtp12 (Coremail) with SMTP id EMCowADX3Fj3FO9gO_yA2Q--.36499S3;
        Thu, 15 Jul 2021 00:46:47 +0800 (CST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v2] packfile: freshen the mtime of packfile by
 configuration
From:   Sun Chao <16657101987@163.com>
In-Reply-To: <YO5RZ0Wix/K5q53Z@nand.local>
Date:   Thu, 15 Jul 2021 00:46:47 +0800
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <ACE7ECBE-0D7A-4FB8-B4F9-F9E32BE2234C@163.com>
References: <pull.1043.git.git.1625943685565.gitgitgadget@gmail.com>
 <pull.1043.v2.git.git.1626226114067.gitgitgadget@gmail.com>
 <87wnpt1wwc.fsf@evledraar.gmail.com> <YO5RZ0Wix/K5q53Z@nand.local>
To:     Taylor Blau <me@ttaylorr.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-CM-TRANSID: EMCowADX3Fj3FO9gO_yA2Q--.36499S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxWry5KF4rZF1DZF47JF17GFg_yoWrXr1rpF
        ZIg3WkGw1ktFWfAr1xCan2qFWFyan3Jrs8XryYgFyUuwn8GryS9rs3K3yY9a4DCrn5Aw4Y
        vFWxKr95ZF4DZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-a93UUUUU=
X-Originating-IP: [60.176.228.14]
X-CM-SenderInfo: rprwlkyxrqimiyx6il2tof0z/1tbiQwbPglc7UtstlAAAsU
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> 2021=E5=B9=B47=E6=9C=8814=E6=97=A5 10:52=EF=BC=8CTaylor Blau =
<me@ttaylorr.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Jul 14, 2021 at 03:39:18AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>> Hrm, per my v1 feedback (and I'm not sure if my suggestion is even =
good
>> here, there's others more familiar with this area than I am), I was
>> thinking of something like a *.bump file written via:
>>=20
>>    core.packUseBumpFiles=3Dbool
>>=20
>> Or something like that, anyway, the edge case in allowing the user to
>> pick arbitrary suffixes is that we'd get in-the-wild user arbitrary
>> configuration squatting on a relatively sensitive part of the object
>> store.
>>=20
>> E.g. we recently added *.rev files to go with
>> *.{pack,idx,bitmap,keep,promisor} (and I'm probably forgetting some
>> suffix). What if before that a user had set:
>>=20
>>    core.packMtimeSuffix=3Drev
>=20
> I think making the suffix configurable is probably a mistake. It seems
> like an unnecessary detail to expose, but it also forces us to think
> about cases like these where the configured suffix is already used for
> some other purpose.

Thanks, I agree with you and will fix it, such like the *.keep file, we
do not use the suffix configuration to create keep files.

>=20
> I don't think that a new ".bump" file is a bad idea, but it does seem
> like we have a lot of files that represent a relatively little amount =
of
> the state that a pack can be in. The ".promisor" and ".keep" files =
both
> come to mind here. Some thoughts in this direction:
>=20
>  - Combining *all* of the pack-related files (including the index,
>    reverse-index, bitmap, and so on) into a single "pack-meta" file
>    seems like a mistake for caching reasons.
>=20
>  - But a meta file that contains just the small state (like promisor
>    information and whether or not the pack is "kept") seems like it
>    could be OK. On the other hand, being able to tweak the kept state
>    by touching or deleting a file is convenient (and having to rewrite
>    a meta file containing other information is much less so).

Yes, read and rewrite a meta file also means we need do lock/unlock, =
which
may cause inconvenient operations.

>=20
> But a ".bump" file does seem like an awkward way to not rely on the
> mtime of the pack itself. And I do think it runs into compatibility
> issues like =C3=86var mentioned. Any version of Git that includes a
> hypothetical .bump file (or something like it) needs to also update =
the
> pack's mtime, too, so that old versions of Git can understand it. (Of
> course, that could be configurable, but that seems far too obscure to
> me).

Here we will have a configuration and default is backward compatiblity,
and if user decide to use the '.bump' file, which means he can not use
the old versions of Git, like the Repository Format Version, it is =
limited.

>=20
> Stepping back, I'm not sure I understand why freshening a pack is so
> slow for you. freshen_file() just calls utime(2), and any sync back to
> the disk shouldn't need to update the pack itself, just a couple of
> fields in its inode. Maybe you could help explain further.
>=20
> In any case, I couldn't find a spot in your patch that updates the
> packed_git's 'mtime' field, which is used to (a) sort packs in the
> linked list of packs, and (b) for determining the least-recently used
> pack if it has individual windows mmapped.

The reason why we want to avoid freshen the mtime of ".pack" file is to
improve the reading speed of Git Servers.

We have some large repositories in our Git Severs (some are bigger than =
10GB),
and we created '.keep' files for large ".pack" files, we want the big =
files
unchanged to speed up git upload-pack, because in our mind the file =
system
cache will reduce the disk IO if a file does not changed.

However we find the mtime of ".pack" files changes over time which makes =
the
file system always reload the big files, that takes a lot of IO time and =
result
in lower speed of git upload-pack and even further the disk IOPS is =
exhausted.

>=20
> Thanks,
> Taylor
>=20


