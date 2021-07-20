Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EBAC07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 15:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E0B9610F7
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 15:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241206AbhGTPGT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 11:06:19 -0400
Received: from m12-15.163.com ([220.181.12.15]:33773 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241786AbhGTOyL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 10:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Mime-Version:Subject:From:Date:Message-Id; bh=M86rJ
        IfJHOjhk4b75/Ls5nZxEzrUceh/XYow+a2TQVA=; b=JE6y7RYzJcdz8Jp1pxAS6
        FWySvDulHN0J00Glvc5kVwNmJ2aGUt6hFZcitMPmszssyvDs/EmX6+1btGjfxXyb
        Yy448kZtQlLqJGv+I4He1UvghTg7lCnyzVJycCwsrLyDauuB9TcqU6GT32VtD/l1
        sPp1PvA0FMhJx9cFBCDF1M=
Received: from smtpclient.apple (unknown [115.198.205.80])
        by smtp11 (Coremail) with SMTP id D8CowABHZ2cB7fZgPqPeAg--.774S3;
        Tue, 20 Jul 2021 23:34:28 +0800 (CST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v3] packfile: freshen the mtime of packfile by
 configuration
From:   Sun Chao <16657101987@163.com>
In-Reply-To: <87bl6xwlaz.fsf@evledraar.gmail.com>
Date:   Tue, 20 Jul 2021 23:34:25 +0800
Cc:     Taylor Blau <me@ttaylorr.com>,
        Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Martin Fick <mfick@codeaurora.org>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <29757455-B195-49CD-8185-55B64DCEC1D1@163.com>
References: <pull.1043.v2.git.git.1626226114067.gitgitgadget@gmail.com>
 <pull.1043.v3.git.git.1626724399377.gitgitgadget@gmail.com>
 <YPXluqywHs3u4Qr+@nand.local> <87bl6xwlaz.fsf@evledraar.gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-CM-TRANSID: D8CowABHZ2cB7fZgPqPeAg--.774S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xw1UAry8Kr4DAF13CF4rZrb_yoWxZF43pF
        Z3t3WYkaykXry7GwsFvF1rJryFqrZ3ZrW5WF90g3y8A398ZFyxKFWxKry5uFy8urs29a1Y
        vF4jk3s3J3WUZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jaiihUUUUU=
X-Originating-IP: [115.198.205.80]
X-CM-SenderInfo: rprwlkyxrqimiyx6il2tof0z/xtbBIgrVgl3mAZ6n2AAAsk
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> 2021=E5=B9=B47=E6=9C=8820=E6=97=A5 14:19=EF=BC=8C=C3=86var Arnfj=C3=B6r=C3=
=B0 Bjarmason <avarab@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
> On Mon, Jul 19 2021, Taylor Blau wrote:
>=20
>> On Mon, Jul 19, 2021 at 07:53:19PM +0000, Sun Chao via GitGitGadget =
wrote:
>>> From: Sun Chao <16657101987@163.com>
>>>=20
>>> Commit 33d4221c79 (write_sha1_file: freshen existing objects,
>>> 2014-10-15) avoid writing existing objects by freshen their
>>> mtime (especially the packfiles contains them) in order to
>>> aid the correct caching, and some process like find_lru_pack
>>> can make good decision. However, this is unfriendly to
>>> incremental backup jobs or services rely on cached file system
>>> when there are large '.pack' files exists.
>>>=20
>>> For example, after packed all objects, use 'write-tree' to
>>> create same commit with the same tree and same environments
>>> such like GIT_COMMITTER_DATE and GIT_AUTHOR_DATE, we can
>>> notice the '.pack' file's mtime changed. Git servers
>>> that mount the same NFS disk will re-sync the '.pack' files
>>> to cached file system which will slow the git commands.
>>>=20
>>> So if add core.freshenPackfiles to indicate whether or not
>>> packs can be freshened, turning off this option on some
>>> servers can speed up the execution of some commands on servers
>>> which use NFS disk instead of local disk.
>>=20
>> Hmm. I'm still quite unconvinced that we should be taking this =
direction
>> without better motivation. We talked about your assumption that NFS
>> seems to be invalidating the block cache when updating the inodes =
that
>> point at those blocks, but I don't recall seeing further evidence.
>=20
> I don't know about Sun's setup, but what he's describing is consistent
> with how NFS works, or can commonly be made to work.
>=20
> See e.g. "lookupcache" in nfs(5) on Linux, but also a lot of people =
use
> some random vendor's proprietary NFS implementation, and commonly =
tweak
> various options that make it anywhere between "I guess that's not too
> crazy" and "are you kidding me?" levels of non-POSIX compliant.
>=20
>> Regardless, a couple of idle thoughts:
>>=20
>>> +	if (!core_freshen_packfiles)
>>> +		return 1;
>>=20
>> It is important to still freshen the object mtimes even when we =
cannot
>> update the pack mtimes. That's why we return 0 when "freshen_file"
>> returned 0: even if there was an error calling utime, we should still
>> freshen the object. This is important because it impacts when
>> unreachable objects are pruned.
>>=20
>> So I would have assumed that if a user set =
"core.freshenPackfiles=3Dfalse"
>> that they would still want their object mtimes updated, in which case
>> the only option we have is to write those objects out loose.
>>=20
>> ...and that happens by the caller of freshen_packed_object (either
>> write_object_file() or hash_object_file_literally()) then calling
>> write_loose_object() if freshen_packed_object() failed. So I would =
have
>> expected to see a "return 0" in the case that packfile freshening was
>> disabled.
>>=20
>> But that leads us to an interesting problem: how many redundant =
objects
>> do we expect to see on the server? It may be a lot, in which case you
>> may end up having the same IO problems for a different reason. Peff
>> mentioned to me off-list that he suspected write-tree was overeager =
in
>> how many trees it would try to write out. I'm not sure.
>=20
> In my experience with NFS the thing that kills you is anything that
> needs to do iterations, i.e. recursive readdir() and the like, or to
> read a lot of data, throughput was excellent. It's why I hacked core
> that core.checkCollisions patch.
I have read your patch, looks like a good idea to reduce the expensive =
operations
like readdir(). And in my production environments, IOPS stress of the =
NFS server
bothers me which make the git commands slow.

>=20
> Jeff improved the situation I was mainly trying to fix with with the
> loose objects cache. I never got around to benchmarking the two in
> production, and now that setup is at an ex-job...
>=20
>>> +test_expect_success 'do not bother loosening old objects without =
freshen pack time' '
>>> +	obj1=3D$(echo three | git hash-object -w --stdin) &&
>>> +	obj2=3D$(echo four | git hash-object -w --stdin) &&
>>> +	pack1=3D$(echo $obj1 | git -c core.freshenPackFiles=3Dfalse =
pack-objects .git/objects/pack/pack) &&
>>> +	pack2=3D$(echo $obj2 | git -c core.freshenPackFiles=3Dfalse =
pack-objects .git/objects/pack/pack) &&
>>> +	git -c core.freshenPackFiles=3Dfalse prune-packed &&
>>> +	git cat-file -p $obj1 &&
>>> +	git cat-file -p $obj2 &&
>>> +	test-tool chmtime =3D-86400 .git/objects/pack/pack-$pack2.pack =
&&
>>> +	git -c core.freshenPackFiles=3Dfalse repack -A -d =
--unpack-unreachable=3D1.hour.ago &&
>>> +	git cat-file -p $obj1 &&
>>> +	test_must_fail git cat-file -p $obj2
>>> +'
>>=20
>> I had a little bit of a hard time following this test. AFAICT, it
>> proceeds as follows:
>>=20
>>  - Write two packs, each containing a unique unreachable blob.
>>  - Call 'git prune-packed' with packfile freshening disabled, then
>>    check that the object survived.
>>  - Then repack while in a state where one of the pack's contents =
would
>>    be pruned.
>>  - Make sure that one object survives and the other doesn't.
>>=20
>> This doesn't really seem to be testing the behavior of disabling
>> packfile freshening so much as it's testing prune-packed, and =
repack's
>> `--unpack-unreachable` option. I would probably have expected to see
>> something more along the lines of:
>>=20
>>  - Write an unreachable object, pack it, and then remove the loose =
copy
>>    you wrote in the first place.
>>  - Then roll the pack's mtime to some fixed value in the past.
>>  - Try to write the same object again with packfile freshening
>>    disabled, and verify that:
>>    - the pack's mtime was unchanged,
>>    - the object exists loose again
>>=20
>> But I'd really like to get some other opinions (especially from Peff,
>> who brought up the potential concerns with write-tree) as to whether =
or
>> not this is a direction worth pursuing.
>>=20
>> My opinion is that it is not, and that the bizarre caching behavior =
you
>> are seeing is out of Git's control.
>=20
> Thanks for this, I found the test hard to follow too, but didn't have
> time to really think about it, this makes sense.
>=20
> Back to the topic: I share your sentiment of trying to avoid =
complexity
> in this area.
>=20
> Sun: Have you considered --keep-unreachable to "git repack"? It's
> orthagonal to what you're trying here, but I wonder if being more
> aggressive about keeping objects + some impromevents to perhaps skip
> this "touch" at all if we have that in effect wouldn't be more viable =
&
> something e.g. Taylor would be more comforable having part of git.git.

Yes, I will try to create some more useful test cases with both =
`--keep-unreachable`
and `--unpack-unreachable` if I still believe I need to do something =
with
the mtime, whatever I need to get my test reports first, thanks ;)

