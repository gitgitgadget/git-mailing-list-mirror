Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF03C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 06:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01B9E60FF4
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 06:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbhGTFsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 01:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbhGTFsA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 01:48:00 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A648C061574
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 23:28:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v1so27093724edt.6
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 23:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=zLV2pzoHOvBT9u/nTlNAWNwEnd9I6laXoxJ9r8/DldA=;
        b=py7d75oQ0c3u3nGZS8mDn8ATScjX7G/v0o3sGT+UM/VFVhXHd7iso+BGY607ttkKfW
         0VxgVyaGALT1MaIPbdng7ok7t3qK1vYD600Ice5owI3kVdJp/X3TnuM5w99PY66b6dtr
         YwsJt0WaXPLINJpXx41oWrzV6RzDCeBWwy4hBVMCQ0AqbPR7ygzXyD9ih/uWlIcKWBxb
         KMyDHS79jVCf5ogEPfhAFp4qkzUBBKbOsL95QxwEHcEzuwXW5VVA20fCq0pDW5Jg8Sxj
         VFXRSB1KUemNk9jw9nAtvt5cS6Po4AoIqRGaQ9nvISHmNA8eDeDx4QaOcaZD2uYRNT2c
         qmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=zLV2pzoHOvBT9u/nTlNAWNwEnd9I6laXoxJ9r8/DldA=;
        b=EjIGITtCLan0WixmLH1BkleDpYXOcvyxiN0a5SkBuZwsPWXO87hg+XvlURg8tGHBEB
         ppzR2gGRVXmd25cfxtoa7UkbwVgo+AGn8Fudjouoqy/hxeybnKkpL3vl+IJ9kO0gZ9Ny
         dvGihMCRoamXoOns+meafU2VeEtyGEzN7nFXxfoBQFVyJQdaH+o9u90/9podO8hL3/jZ
         6MLSjXmOPFaG22rFhGNgnsYO9cVLt7YSMZL1fZMEFFKfO+9Ka/1Y2Ms2ZzA9Quj9vo64
         67rcCf1bJEzDwnEyA8iAsTy04iDOP+rJJ8oqK7q1ZkjmXATqCGGRcVZIBbEPaV0ZCdXc
         Q1JQ==
X-Gm-Message-State: AOAM530J2QxDYkd9WrDdZENAeM6xR7+Y0bn0YzS9bvBF2eC/O6UNIPBA
        Tb3cwy2dAgJB6BiyP6bGppE=
X-Google-Smtp-Source: ABdhPJyhEjnl3h9ggONQvR5L//e9n0lrWGIFHwrMLuGLFk98cxZ2SL2Fdn7hyMyPJJ02JtiHlgtYLg==
X-Received: by 2002:a05:6402:1c10:: with SMTP id ck16mr38577108edb.339.1626762516463;
        Mon, 19 Jul 2021 23:28:36 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id dn23sm8757103edb.56.2021.07.19.23.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 23:28:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Martin Fick <mfick@codeaurora.org>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Sun Chao <16657101987@163.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] packfile: freshen the mtime of packfile by
 configuration
Date:   Tue, 20 Jul 2021 08:19:17 +0200
References: <pull.1043.v2.git.git.1626226114067.gitgitgadget@gmail.com>
 <pull.1043.v3.git.git.1626724399377.gitgitgadget@gmail.com>
 <YPXluqywHs3u4Qr+@nand.local>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YPXluqywHs3u4Qr+@nand.local>
Message-ID: <87bl6xwlaz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 19 2021, Taylor Blau wrote:

> On Mon, Jul 19, 2021 at 07:53:19PM +0000, Sun Chao via GitGitGadget wrote:
>> From: Sun Chao <16657101987@163.com>
>>
>> Commit 33d4221c79 (write_sha1_file: freshen existing objects,
>> 2014-10-15) avoid writing existing objects by freshen their
>> mtime (especially the packfiles contains them) in order to
>> aid the correct caching, and some process like find_lru_pack
>> can make good decision. However, this is unfriendly to
>> incremental backup jobs or services rely on cached file system
>> when there are large '.pack' files exists.
>>
>> For example, after packed all objects, use 'write-tree' to
>> create same commit with the same tree and same environments
>> such like GIT_COMMITTER_DATE and GIT_AUTHOR_DATE, we can
>> notice the '.pack' file's mtime changed. Git servers
>> that mount the same NFS disk will re-sync the '.pack' files
>> to cached file system which will slow the git commands.
>>
>> So if add core.freshenPackfiles to indicate whether or not
>> packs can be freshened, turning off this option on some
>> servers can speed up the execution of some commands on servers
>> which use NFS disk instead of local disk.
>
> Hmm. I'm still quite unconvinced that we should be taking this direction
> without better motivation. We talked about your assumption that NFS
> seems to be invalidating the block cache when updating the inodes that
> point at those blocks, but I don't recall seeing further evidence.

I don't know about Sun's setup, but what he's describing is consistent
with how NFS works, or can commonly be made to work.

See e.g. "lookupcache" in nfs(5) on Linux, but also a lot of people use
some random vendor's proprietary NFS implementation, and commonly tweak
various options that make it anywhere between "I guess that's not too
crazy" and "are you kidding me?" levels of non-POSIX compliant.

> Regardless, a couple of idle thoughts:
>
>> +	if (!core_freshen_packfiles)
>> +		return 1;
>
> It is important to still freshen the object mtimes even when we cannot
> update the pack mtimes. That's why we return 0 when "freshen_file"
> returned 0: even if there was an error calling utime, we should still
> freshen the object. This is important because it impacts when
> unreachable objects are pruned.
>
> So I would have assumed that if a user set "core.freshenPackfiles=false"
> that they would still want their object mtimes updated, in which case
> the only option we have is to write those objects out loose.
>
> ...and that happens by the caller of freshen_packed_object (either
> write_object_file() or hash_object_file_literally()) then calling
> write_loose_object() if freshen_packed_object() failed. So I would have
> expected to see a "return 0" in the case that packfile freshening was
> disabled.
>
> But that leads us to an interesting problem: how many redundant objects
> do we expect to see on the server? It may be a lot, in which case you
> may end up having the same IO problems for a different reason. Peff
> mentioned to me off-list that he suspected write-tree was overeager in
> how many trees it would try to write out. I'm not sure.

In my experience with NFS the thing that kills you is anything that
needs to do iterations, i.e. recursive readdir() and the like, or to
read a lot of data, throughput was excellent. It's why I hacked core
that core.checkCollisions patch.

Jeff improved the situation I was mainly trying to fix with with the
loose objects cache. I never got around to benchmarking the two in
production, and now that setup is at an ex-job...

>> +test_expect_success 'do not bother loosening old objects without freshen pack time' '
>> +	obj1=$(echo three | git hash-object -w --stdin) &&
>> +	obj2=$(echo four | git hash-object -w --stdin) &&
>> +	pack1=$(echo $obj1 | git -c core.freshenPackFiles=false pack-objects .git/objects/pack/pack) &&
>> +	pack2=$(echo $obj2 | git -c core.freshenPackFiles=false pack-objects .git/objects/pack/pack) &&
>> +	git -c core.freshenPackFiles=false prune-packed &&
>> +	git cat-file -p $obj1 &&
>> +	git cat-file -p $obj2 &&
>> +	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.pack &&
>> +	git -c core.freshenPackFiles=false repack -A -d --unpack-unreachable=1.hour.ago &&
>> +	git cat-file -p $obj1 &&
>> +	test_must_fail git cat-file -p $obj2
>> +'
>
> I had a little bit of a hard time following this test. AFAICT, it
> proceeds as follows:
>
>   - Write two packs, each containing a unique unreachable blob.
>   - Call 'git prune-packed' with packfile freshening disabled, then
>     check that the object survived.
>   - Then repack while in a state where one of the pack's contents would
>     be pruned.
>   - Make sure that one object survives and the other doesn't.
>
> This doesn't really seem to be testing the behavior of disabling
> packfile freshening so much as it's testing prune-packed, and repack's
> `--unpack-unreachable` option. I would probably have expected to see
> something more along the lines of:
>
>   - Write an unreachable object, pack it, and then remove the loose copy
>     you wrote in the first place.
>   - Then roll the pack's mtime to some fixed value in the past.
>   - Try to write the same object again with packfile freshening
>     disabled, and verify that:
>     - the pack's mtime was unchanged,
>     - the object exists loose again
>
> But I'd really like to get some other opinions (especially from Peff,
> who brought up the potential concerns with write-tree) as to whether or
> not this is a direction worth pursuing.
>
> My opinion is that it is not, and that the bizarre caching behavior you
> are seeing is out of Git's control.

Thanks for this, I found the test hard to follow too, but didn't have
time to really think about it, this makes sense.

Back to the topic: I share your sentiment of trying to avoid complexity
in this area.

Sun: Have you considered --keep-unreachable to "git repack"? It's
orthagonal to what you're trying here, but I wonder if being more
aggressive about keeping objects + some impromevents to perhaps skip
this "touch" at all if we have that in effect wouldn't be more viable &
something e.g. Taylor would be more comforable having part of git.git.
