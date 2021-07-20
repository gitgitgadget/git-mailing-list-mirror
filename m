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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B14C07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 15:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 767D961029
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 15:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239686AbhGTPFi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 11:05:38 -0400
Received: from m12-14.163.com ([220.181.12.14]:41813 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239663AbhGTOUL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 10:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Mime-Version:Subject:From:Date:Message-Id; bh=+Fr+c
        6BSAUObNVSx7WF9YsXXIUvpktNnuqJlduvUBVg=; b=izG6d8RK8CLnNJF5Eg2Mb
        U76JDpa20dnOnsvwmasTj02JPkN4iKiZ7l6taArDjiWEBGniycbvjDleWI4xD4Rc
        GHiAhFzFLl54l0xzCTMGf/O13IqeHnXmNkm40j+Yl3zOjbG3i/5fZI0Wwr5uTd3x
        MKwvvheZn6wCfuHLwugxOg=
Received: from smtpclient.apple (unknown [115.198.205.80])
        by smtp10 (Coremail) with SMTP id DsCowAB3j2cD5fZg0cC4Bw--.1891S3;
        Tue, 20 Jul 2021 23:00:19 +0800 (CST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v3] packfile: freshen the mtime of packfile by
 configuration
From:   Sun Chao <16657101987@163.com>
In-Reply-To: <YPXluqywHs3u4Qr+@nand.local>
Date:   Tue, 20 Jul 2021 23:00:18 +0800
Cc:     Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Martin Fick <mfick@codeaurora.org>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5D8CDAF1-256C-4CC3-920C-2063CFACE9BD@163.com>
References: <pull.1043.v2.git.git.1626226114067.gitgitgadget@gmail.com>
 <pull.1043.v3.git.git.1626724399377.gitgitgadget@gmail.com>
 <YPXluqywHs3u4Qr+@nand.local>
To:     Taylor Blau <me@ttaylorr.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-CM-TRANSID: DsCowAB3j2cD5fZg0cC4Bw--.1891S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxuw4fury3JF18uw4xZr17Awb_yoWxWr1UpF
        Zaqw1DKa4kXFWxGw4DZ3W8JryFqrZ3Zr15WF90g3yjywn8JFyxKrW3t34Y9FyUCrs7Ca1Y
        vF48Kas5AayUZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jaiihUUUUU=
X-Originating-IP: [115.198.205.80]
X-CM-SenderInfo: rprwlkyxrqimiyx6il2tof0z/1tbi6wXVglXlw3ufiQAAsn
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> 2021=E5=B9=B47=E6=9C=8820=E6=97=A5 04:51=EF=BC=8CTaylor Blau =
<me@ttaylorr.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, Jul 19, 2021 at 07:53:19PM +0000, Sun Chao via GitGitGadget =
wrote:
>> From: Sun Chao <16657101987@163.com>
>>=20
>> Commit 33d4221c79 (write_sha1_file: freshen existing objects,
>> 2014-10-15) avoid writing existing objects by freshen their
>> mtime (especially the packfiles contains them) in order to
>> aid the correct caching, and some process like find_lru_pack
>> can make good decision. However, this is unfriendly to
>> incremental backup jobs or services rely on cached file system
>> when there are large '.pack' files exists.
>>=20
>> For example, after packed all objects, use 'write-tree' to
>> create same commit with the same tree and same environments
>> such like GIT_COMMITTER_DATE and GIT_AUTHOR_DATE, we can
>> notice the '.pack' file's mtime changed. Git servers
>> that mount the same NFS disk will re-sync the '.pack' files
>> to cached file system which will slow the git commands.
>>=20
>> So if add core.freshenPackfiles to indicate whether or not
>> packs can be freshened, turning off this option on some
>> servers can speed up the execution of some commands on servers
>> which use NFS disk instead of local disk.
>=20
> Hmm. I'm still quite unconvinced that we should be taking this =
direction
> without better motivation. We talked about your assumption that NFS
> seems to be invalidating the block cache when updating the inodes that
> point at those blocks, but I don't recall seeing further evidence.

Yes, these days I'm trying to asking help from our SRE to do tests in =
our
production environments (where we can get the real traffic report of NFS =
server),
such like:

- setup a repository witch some large packfiles in a NFS disk
- keep running 'git pack-objects --all --stdout --delta-base-offset =
>/dev/null' in
multiple git servers that mount the same NFS disk above
- 'touch' the packfiles in another server, and check (a) if the IOPS and =
IO traffic
of the NFS server changes and (b) if the IO traffic of network =
interfaces from
the git servers to the NFS server changes

I like to share the data when I receive the reports.

Meanwhile I find the description of the cached file system for NFS =
Client:
   =
https://www.ibm.com/docs/en/aix/7.2?topic=3Dperformance-cache-file-system
It is mentioned that:

  3. To ensure that the cached directories and files are kept up to =
date,=20
     CacheFS periodically checks the consistency of files stored in the =
cache.
     It does this by comparing the current modification time to the =
previous
     modification time.
  4. If the modification times are different, all data and attributes
     for the directory or file are purged from the cache, and new data =
and
     attributes are retrieved from the back file system.

It looks like reasonable, but perhaps I should check it from my test =
reports ;)

>=20
> Regardless, a couple of idle thoughts:
>=20
>> +	if (!core_freshen_packfiles)
>> +		return 1;
>=20
> It is important to still freshen the object mtimes even when we cannot
> update the pack mtimes. That's why we return 0 when "freshen_file"
> returned 0: even if there was an error calling utime, we should still
> freshen the object. This is important because it impacts when
> unreachable objects are pruned.
>=20
> So I would have assumed that if a user set =
"core.freshenPackfiles=3Dfalse"
> that they would still want their object mtimes updated, in which case
> the only option we have is to write those objects out loose.
>=20
> ...and that happens by the caller of freshen_packed_object (either
> write_object_file() or hash_object_file_literally()) then calling
> write_loose_object() if freshen_packed_object() failed. So I would =
have
> expected to see a "return 0" in the case that packfile freshening was
> disabled.
>=20
> But that leads us to an interesting problem: how many redundant =
objects
> do we expect to see on the server? It may be a lot, in which case you
> may end up having the same IO problems for a different reason. Peff
> mentioned to me off-list that he suspected write-tree was overeager in
> how many trees it would try to write out. I'm not sure.

You are right, I haven't thought it in details, if we do not update the =
mtime
both of packfiles and loose files, 'prune' may delete them by accident.

>=20
>> +test_expect_success 'do not bother loosening old objects without =
freshen pack time' '
>> +	obj1=3D$(echo three | git hash-object -w --stdin) &&
>> +	obj2=3D$(echo four | git hash-object -w --stdin) &&
>> +	pack1=3D$(echo $obj1 | git -c core.freshenPackFiles=3Dfalse =
pack-objects .git/objects/pack/pack) &&
>> +	pack2=3D$(echo $obj2 | git -c core.freshenPackFiles=3Dfalse =
pack-objects .git/objects/pack/pack) &&
>> +	git -c core.freshenPackFiles=3Dfalse prune-packed &&
>> +	git cat-file -p $obj1 &&
>> +	git cat-file -p $obj2 &&
>> +	test-tool chmtime =3D-86400 .git/objects/pack/pack-$pack2.pack =
&&
>> +	git -c core.freshenPackFiles=3Dfalse repack -A -d =
--unpack-unreachable=3D1.hour.ago &&
>> +	git cat-file -p $obj1 &&
>> +	test_must_fail git cat-file -p $obj2
>> +'
>=20
> I had a little bit of a hard time following this test. AFAICT, it
> proceeds as follows:
>=20
>  - Write two packs, each containing a unique unreachable blob.
>  - Call 'git prune-packed' with packfile freshening disabled, then
>    check that the object survived.
>  - Then repack while in a state where one of the pack's contents would
>    be pruned.
>  - Make sure that one object survives and the other doesn't.
>=20
> This doesn't really seem to be testing the behavior of disabling
> packfile freshening so much as it's testing prune-packed, and repack's
> `--unpack-unreachable` option. I would probably have expected to see
> something more along the lines of:
>=20
>  - Write an unreachable object, pack it, and then remove the loose =
copy
>    you wrote in the first place.
>  - Then roll the pack's mtime to some fixed value in the past.
>  - Try to write the same object again with packfile freshening
>    disabled, and verify that:
>    - the pack's mtime was unchanged,
>    - the object exists loose again
>=20
> But I'd really like to get some other opinions (especially from Peff,
> who brought up the potential concerns with write-tree) as to whether =
or
> not this is a direction worth pursuing.
>=20
> My opinion is that it is not, and that the bizarre caching behavior =
you
> are seeing is out of Git's control.
OK, I will try this. And I will try to get the test reports from our SRE =
and
check how the mtime impacts the caches.=20

>=20
> Thanks,
> Taylor

