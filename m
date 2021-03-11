Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BF6C432C3
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD7A64FFA
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhCKRFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhCKRFC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:05:02 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED56DC061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:05:01 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id u20so22664098iot.9
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Dpw82TuFjocm9ACB5yEdiaROpRMDQAQQQwUX1fhkE0k=;
        b=htIGZf3w5c8GIOfaFJ+ubCUki5BAu7paSCs4FOqE430XDKaa3aeET4p+J1lWNgXj8j
         3FsbOGe+5bnfHv+WvOa8Y4tluHRTYhBRlVZY4gatszRcK4UWPhqgygz07TkIw9jKYBgF
         XIjcqLnnB7ct2hist3CpdiiHwD+a8Ib50T3QvmiXj78fPZp9rXAHKFqP/IHOSnDHXGRm
         xL9B7uHlqxKc/8VufSHiqkS2FF4OO6b4jMtOlMqotJuMnK5+tcqtvMUj5ztpY+zrcSrO
         oF0bFKRgacoVolgLJ/MmpxhtHzv02qHbgBdAYLl6XnILRR7LtHnqvDhT28Pc0YKyj9jW
         6+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Dpw82TuFjocm9ACB5yEdiaROpRMDQAQQQwUX1fhkE0k=;
        b=IL5BncND92k1f4H2MxRSde0WezD+sX8gdTI3VIY5VK7xN01G4BOYZd6akQ1lyDzzNf
         9S0Agzv2uAiJUJK2D3gHhkAEEi9Tg0NqtLOR5hC9lUnx0LbU+rdn3HfI9Xeb0MpwrH9U
         tD4M/6IzzW+xaV76+TUArf/QQmprMDn3z3SO0CWudT6f4/qWjD3i7xdNtJ0hOv0/wlBX
         NRroE/m5FYmFCOs9b6CrIH+5FPHpJS7wi5ioAyBh/UevksCtoTDvncEX8+9wr6r6hoaq
         yWUvH58IimFWPsAeTCUWFs8lX0qnur/Y+Ev/Bcenk3+59Y/ZkuNwsNNhCRK4h3iOiXJv
         dDaA==
X-Gm-Message-State: AOAM531nlKlB/wgVN2QxalvDYZbyCu6LnCDG2HVNThVXW0+ldUUA09Dz
        fg6RvBfQiDo8S2wZbKmhdm2YoScjo9vTre1x
X-Google-Smtp-Source: ABdhPJwynTSDKoEeg7wJjjNs6nwl7c/XUR4iwBFYM9QS5kbuVE6zt+zxIxyGDMik9zuh0BnMoatJTw==
X-Received: by 2002:a02:850a:: with SMTP id g10mr4594908jai.140.1615482301130;
        Thu, 11 Mar 2021 09:05:01 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f947:1686:6ada:db5b])
        by smtp.gmail.com with ESMTPSA id e4sm1564224ils.10.2021.03.11.09.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:05:00 -0800 (PST)
Date:   Thu, 11 Mar 2021 12:04:57 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com, peff@peff.net
Subject: [PATCH v3 06/16] builtin/multi-pack-index.c: display usage on
 unrecognized command
Message-ID: <f117e442c3460661dc88beba6f1853d6c388b0fd.1615482270.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1615482270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When given a sub-command that it doesn't understand, 'git
multi-pack-index' dies with the following message:

    $ git multi-pack-index bogus
    fatal: unrecognized subcommand: bogus

Instead of 'die()'-ing, we can display the usage text, which is much
more helpful:

    $ git.compile multi-pack-index bogus
    usage: git multi-pack-index [<options>] write
       or: git multi-pack-index [<options>] verify
       or: git multi-pack-index [<options>] expire
       or: git multi-pack-index [<options>] repack [--batch-size=<size>]

	--object-dir <file>   object directory containing set of packfile and pack-index pairs
	--progress            force progress reporting

While we're at it, clean up some duplication between the "no sub-command"
and "unrecognized sub-command" conditionals.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/multi-pack-index.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index b5678cc2bb..243b6ccc7c 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -153,8 +153,7 @@ int cmd_multi_pack_index(int argc, const char **argv,
 		opts.object_dir = get_object_directory();
 
 	if (argc == 0)
-		usage_with_options(builtin_multi_pack_index_usage,
-				   builtin_multi_pack_index_options);
+		goto usage;
 
 	if (!strcmp(argv[0], "repack"))
 		return cmd_multi_pack_index_repack(argc, argv);
@@ -165,5 +164,7 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	else if (!strcmp(argv[0], "expire"))
 		return cmd_multi_pack_index_expire(argc, argv);
 	else
-		die(_("unrecognized subcommand: %s"), argv[0]);
+usage:
+		usage_with_options(builtin_multi_pack_index_usage,
+				   builtin_multi_pack_index_options);
 }
-- 
2.30.0.667.g81c0cbc6fd

