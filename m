Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDA7CCA47F
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 14:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbiGOOAY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 10:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbiGOOAC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 10:00:02 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C318E371A2
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 06:59:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y4so6414430edc.4
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 06:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=np2oA32J9RcnyXheivbD5iW+gexnoKe4hLGbCA0x4BE=;
        b=Ez2mBr31iHXmDgmuxe1qWmKYt1K7DDYC+W0VindY3XUdcI+ao+R9K8o7P5LDl+5c57
         tOF6iXCh/dg7IFQCSD0rZVXHsPcD4sJTLA+4kOKtNQHJrColI7Yvc268hl49Xj5Vd7n6
         UkiqBprsGdNVkxsyATe1NoVsFHs9scfQVNNOYs8Rxn3qX2y2ncfkqgx8KLfWuNH6r1F9
         4ov4N90bsoHKy5JwNMquEEARjaLxgWWDy3UiIpyAYVIf4XbaW1dGSV/Twf/ljHV1FBHC
         f/3tPZ3wT+0gPBPbD8GRPzoJ8qNBYpQWm7NZgRhtUSJX/aWqKH/OFdkVtLlH2CdPjD9P
         DpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=np2oA32J9RcnyXheivbD5iW+gexnoKe4hLGbCA0x4BE=;
        b=UIaetUWKJkzFsfzGPCVCzmiWPV9mrTcc9tvDQWENcAuYtP+/R0lydBJcZqcD6EUedi
         DyiyY3ghYrD2dd9SsTpJNew8Pg7nwWpSKs/Ew6jwUm8CFvpSKBpFqF7OzDIHAZqCFH3U
         90BPXpbUbmRVQbwzvLKplS7aGUbGi36ANDt3Gj1dYgj2CiHSk0gMPyKTh01I1XGDx4f9
         wL64qwSXD1zS6PqXwblClRt0A9fxc2bZlDEupUBzZb/Ul+ALz1nhphgUujbey3Y0HUwK
         AZ8ZEtLiMN4ImjO8TfuQkfRcJDsxStlOFv9Y0hGymdw+rzXBEOVJR5gr+VEMfuQ7pcTm
         iHCw==
X-Gm-Message-State: AJIora/R5GRfmFDLmPO893BmQBsbeKPAA1fXFvrMXTZ3P8lo9X9W5UTu
        I/xtyhc0zZIabEybQYF6jJDcI92ncBNRig==
X-Google-Smtp-Source: AGRyM1vzyRM8o+/yDcFB2gUvQAcr7GYBLRg1g87cs0SG6gfXevWAvMd2CG7tIXWW96tG/s19fnHIXQ==
X-Received: by 2002:a05:6402:3593:b0:43a:a259:2518 with SMTP id y19-20020a056402359300b0043aa2592518mr19195985edc.117.1657893598273;
        Fri, 15 Jul 2022 06:59:58 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id p20-20020a17090653d400b0072eec799e52sm1299260ejo.145.2022.07.15.06.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 06:59:57 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oCLrH-002lhd-Qd;
        Fri, 15 Jul 2022 15:59:55 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Neeraj Singh <neerajsi@microsoft.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: ab/squelch-empty-fsync-traces & hx/unpack-streaming bug (was:
 What's cooking in git.git (Jul 2022, #04; Wed, 13))
Date:   Fri, 15 Jul 2022 15:40:13 +0200
References: <xmqq7d4g8onl.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq7d4g8onl.fsf@gitster.g>
Message-ID: <220715.86bktqzdb8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 13 2022, Junio C Hamano wrote:

> * ab/squelch-empty-fsync-traces (2022-06-30) 1 commit
>  . trace2: don't include "fsync" events in all trace2 logs
>
>  Omit fsync-related trace2 entries when their values are all zero.
>
>  Breaks tests in hx/unpack-streaming with an interesting interaction.
>  source: <patch-v2-1.1-a1fc37de947-20220630T084607Z-avarab@gmail.com>

[...]

> * hx/unpack-streaming (2022-06-13) 6 commits
>   (merged to 'next' on 2022-07-08 at 4eb375ec2f)
>  + unpack-objects: use stream_loose_object() to unpack large objects
>  + core doc: modernize core.bigFileThreshold documentation
>  + object-file.c: add "stream_loose_object()" to handle large object
>  + object-file.c: factor out deflate part of write_loose_object()
>  + object-file.c: refactor write_loose_object() to several steps
>  + unpack-objects: low memory footprint for get_data() in dry_run mode
>
>  Allow large objects read from a packstream to be streamed into a
>  loose object file straight, without having to keep it in-core as a
>  whole.
>
>  Will merge to 'master'.
>  source: <cover.1654914555.git.chiyutianyi@gmail.com>

I hadn't had time to look at this until now. There's some interesting
behavior here.

The code to check the hardware flush was added in aaf81223f48
(unpack-objects: use stream_loose_object() to unpack large objects,
2022-06-11) (that series is now on master).

But as my ab/squelch-empty-fsync-traces notes we always add this to the
event, so the:

	grep fsync/hardware-flush trace2.txt &&

Is equivalent to:

	true &&

I.e. it's not testing worthwhile at all. The reason you're seeing a
failure is deu to 412e4caee38 (tests: disable fsync everywhere,
2021-10-29), i.e. our tests disable fsync(). What you have queued will
pass as:

	GIT_TEST_FSYNC=true ./t5351-unpack-large-objects.sh

But I think that would be meaningless, since we'll write out that on
FSYNC_HARDWARE_FLUSH whether we actually support "bulk" or not. AFAICT
the way to detect if we support "bulk" at all is to check for
fsync/writeout-only.

*Except* that we we unconditionally increment the "writeout only"
counter, even if we don't actually support that "bulk" mode. We're just
doing a regular fsync().

So, narrowly it looks easy to "fix" my ab/squelch-empty-fsync-traces, I
could apply this on top:

diff --git a/t/t5351-unpack-large-objects.sh b/t/t5351-unpack-large-objects.sh
index 8ce8aa3b147..29cab843eb9 100755
--- a/t/t5351-unpack-large-objects.sh
+++ b/t/t5351-unpack-large-objects.sh
@@ -53,8 +53,12 @@ BATCH_CONFIGURATION='-c core.fsync=loose-object -c core.fsyncmethod=batch'
 test_expect_success 'unpack big object in stream (core.fsyncmethod=batch)' '
 	prepare_dest 1m &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+	GIT_TEST_FSYNC=true \
 		git -C dest.git $BATCH_CONFIGURATION unpack-objects <pack-$PACK.pack &&
-	grep fsync/hardware-flush trace2.txt &&
+	grep fsync/ trace2.txt >wo.txt &&
+	sed -e "s/.*value\":\"//" -e "s/\".*//" <wo.txt >actual &&
+	test_write_lines 6 1 >expect &&
+	test_cmp expect actual &&
 	test_dir_is_empty dest.git/objects/pack &&
 	git -C dest.git cat-file --batch-check="%(objectname)" <obj-list >current &&
 	cmp obj-list current

But does this make any sense in the larger scheme of things?  I.e. the
trace2 logging isn't at all logging that we're actually doing with
fsync, but what we intended to do based on the application logic, is
that intended & OK or not?
