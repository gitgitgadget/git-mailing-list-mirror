Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B10C63798
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BA0F611CE
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354571AbhGSWUu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387473AbhGSUK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 16:10:29 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E8CC061574
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 13:49:19 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id g22so21622493iom.1
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 13:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5m43b8cvcVTJIuZ3AYq0Kx3ZWFZJGI8RLmRzfl6QDdk=;
        b=xANtflnqjPcFW8ExXgmS4525ESm4TgwdTVExhCm4OoVKi+PFCpGHUdjk8Fm/mOj/2/
         ESPfYzfhuwPH/qoo7rrbmvhV0dd62qnWWnN4LscgFS9+07XBlBlAkZg5GiTVIy52gMI0
         ELMKy/93Pg7mRxuezVBWgeUOUoqOQOE6zsVVY7p8nS2OtxVTNXylAjbLSwAlOxlpCenZ
         CQbd586qWCqwvHnryJI5PYMlDBLNsyGvNZjz/4qlVjXBGosL00bYC/uebeEMyhkhiPSs
         LMrwoT+bUe+G4M+jtvpF6KJmt0qpbsVCVQyvKN4Y87t4U2alzFPctdxrplKhtg+bR5UP
         wgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5m43b8cvcVTJIuZ3AYq0Kx3ZWFZJGI8RLmRzfl6QDdk=;
        b=q8sqM1SzK4jxrbqiQ7K/+t80IW0b5XiWBktAXpCUJoRSjsGPD3OZfdqsVNcEjkMQIF
         A1z18I5YN6Mv4xI7B43qp8jurmBNiSQ+3SNOXMIJK1beYnAhhnb0HZhngqpbsTKtj08y
         mjDQm1hvF/ef8J2ADgsdcTP4oQwguaKkAoEFihOdYh/HyjXuGZzSK0yf1EIcG8ByoRww
         LyO5VdpL7ghrH/mXW/PxQKacYbHo2st6uFRpwn4laOpdzmEeEgHk9yO+C0IWG6DkLDEz
         dwjGxJMUs5nFEmUilnO12XtfBVXNg1Ow8XNcIyFWEXQfop7FqzipNluZjaAYoQjxd93L
         azwQ==
X-Gm-Message-State: AOAM5307ZbitdIzr7PU/sQ8YQ6b6hbVAjHhiwC9i8oZoncxkIUA79pje
        B1tV/hg9eTb2eY9NEvqR9R1vxw==
X-Google-Smtp-Source: ABdhPJzG2z9MeteyCKdyCv4kbHWT5wZ1BFV1tW7xlqdpnwne2aWG2yK1XNI76nedgxMzE6bAH6cl9A==
X-Received: by 2002:a5e:d70d:: with SMTP id v13mr19739203iom.115.1626727867949;
        Mon, 19 Jul 2021 13:51:07 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:a0a0:3329:4f28:d1a3])
        by smtp.gmail.com with ESMTPSA id n14sm9999390ili.22.2021.07.19.13.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 13:51:07 -0700 (PDT)
Date:   Mon, 19 Jul 2021 16:51:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Sun Chao via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Martin Fick <mfick@codeaurora.org>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Sun Chao <16657101987@163.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] packfile: freshen the mtime of packfile by
 configuration
Message-ID: <YPXluqywHs3u4Qr+@nand.local>
References: <pull.1043.v2.git.git.1626226114067.gitgitgadget@gmail.com>
 <pull.1043.v3.git.git.1626724399377.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1043.v3.git.git.1626724399377.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 19, 2021 at 07:53:19PM +0000, Sun Chao via GitGitGadget wrote:
> From: Sun Chao <16657101987@163.com>
>
> Commit 33d4221c79 (write_sha1_file: freshen existing objects,
> 2014-10-15) avoid writing existing objects by freshen their
> mtime (especially the packfiles contains them) in order to
> aid the correct caching, and some process like find_lru_pack
> can make good decision. However, this is unfriendly to
> incremental backup jobs or services rely on cached file system
> when there are large '.pack' files exists.
>
> For example, after packed all objects, use 'write-tree' to
> create same commit with the same tree and same environments
> such like GIT_COMMITTER_DATE and GIT_AUTHOR_DATE, we can
> notice the '.pack' file's mtime changed. Git servers
> that mount the same NFS disk will re-sync the '.pack' files
> to cached file system which will slow the git commands.
>
> So if add core.freshenPackfiles to indicate whether or not
> packs can be freshened, turning off this option on some
> servers can speed up the execution of some commands on servers
> which use NFS disk instead of local disk.

Hmm. I'm still quite unconvinced that we should be taking this direction
without better motivation. We talked about your assumption that NFS
seems to be invalidating the block cache when updating the inodes that
point at those blocks, but I don't recall seeing further evidence.

Regardless, a couple of idle thoughts:

> +	if (!core_freshen_packfiles)
> +		return 1;

It is important to still freshen the object mtimes even when we cannot
update the pack mtimes. That's why we return 0 when "freshen_file"
returned 0: even if there was an error calling utime, we should still
freshen the object. This is important because it impacts when
unreachable objects are pruned.

So I would have assumed that if a user set "core.freshenPackfiles=false"
that they would still want their object mtimes updated, in which case
the only option we have is to write those objects out loose.

...and that happens by the caller of freshen_packed_object (either
write_object_file() or hash_object_file_literally()) then calling
write_loose_object() if freshen_packed_object() failed. So I would have
expected to see a "return 0" in the case that packfile freshening was
disabled.

But that leads us to an interesting problem: how many redundant objects
do we expect to see on the server? It may be a lot, in which case you
may end up having the same IO problems for a different reason. Peff
mentioned to me off-list that he suspected write-tree was overeager in
how many trees it would try to write out. I'm not sure.

> +test_expect_success 'do not bother loosening old objects without freshen pack time' '
> +	obj1=$(echo three | git hash-object -w --stdin) &&
> +	obj2=$(echo four | git hash-object -w --stdin) &&
> +	pack1=$(echo $obj1 | git -c core.freshenPackFiles=false pack-objects .git/objects/pack/pack) &&
> +	pack2=$(echo $obj2 | git -c core.freshenPackFiles=false pack-objects .git/objects/pack/pack) &&
> +	git -c core.freshenPackFiles=false prune-packed &&
> +	git cat-file -p $obj1 &&
> +	git cat-file -p $obj2 &&
> +	test-tool chmtime =-86400 .git/objects/pack/pack-$pack2.pack &&
> +	git -c core.freshenPackFiles=false repack -A -d --unpack-unreachable=1.hour.ago &&
> +	git cat-file -p $obj1 &&
> +	test_must_fail git cat-file -p $obj2
> +'

I had a little bit of a hard time following this test. AFAICT, it
proceeds as follows:

  - Write two packs, each containing a unique unreachable blob.
  - Call 'git prune-packed' with packfile freshening disabled, then
    check that the object survived.
  - Then repack while in a state where one of the pack's contents would
    be pruned.
  - Make sure that one object survives and the other doesn't.

This doesn't really seem to be testing the behavior of disabling
packfile freshening so much as it's testing prune-packed, and repack's
`--unpack-unreachable` option. I would probably have expected to see
something more along the lines of:

  - Write an unreachable object, pack it, and then remove the loose copy
    you wrote in the first place.
  - Then roll the pack's mtime to some fixed value in the past.
  - Try to write the same object again with packfile freshening
    disabled, and verify that:
    - the pack's mtime was unchanged,
    - the object exists loose again

But I'd really like to get some other opinions (especially from Peff,
who brought up the potential concerns with write-tree) as to whether or
not this is a direction worth pursuing.

My opinion is that it is not, and that the bizarre caching behavior you
are seeing is out of Git's control.

Thanks,
Taylor
