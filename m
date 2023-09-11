Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1B1CA0ECB
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 23:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349230AbjIKVcy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241350AbjIKPHE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 11:07:04 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A38BCCD
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 08:07:00 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so5909348a12.0
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 08:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694444818; x=1695049618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09gYl9Y07QXFDU3uzM7+wnBf8+wahIJIfEr+6TB1JqM=;
        b=OjfuKLqcQfKkPnsTDcwZ63vq6U+3kljXc0D28DyL9/VOWWFUARN575CTUS3lQfH6No
         F/yCZKwVNG5X+cEwHkqKuMjRSe5OIVd759KzMMXXZcR7xE4Ni7FxnDrpSooVWJY56cL9
         WiCaRewSQtWfea1AlLZEx3ms7OHUWQdh2fqzIj0ZulmNhNnLlar+Oyo3wf9iXZitZopk
         3ctDsy9q4oxwSYK5WLzxS7r8IetOcoVYADn+Lejp5Eb/RDD3kWPbj7vsy5uSRlqRLZTx
         90KkTYQuGrwEyYeeVYxc0sk9IehohonuCn3QmcT1JQbWK69MNTLJ8PKDx8Av8w2MKzQV
         DHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694444818; x=1695049618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09gYl9Y07QXFDU3uzM7+wnBf8+wahIJIfEr+6TB1JqM=;
        b=JROT/g+bemJkKbATwoau4dtYR8xI6zwM6f779CWC1B3bk3/Kq/BPruObPnwAlV7PGn
         bmX2s+YyOirsBRjUtCNUqZoQo6AG7cegUPPg0lozpQ9J50++2htDxzax+dsNou7BDOdG
         NWMtoUAREmHjbwLf8qCbWcCDMXcIhSQJVTbqDA2l0akdUc86d1DcRcRdJFayB/bmlkiD
         Gst0j5vljMJTEn6cDZWTpbBG3Lrg13bzGbRSSeiWPAdFhzqua28OoGIVw5c/vZTj/zIq
         BYHYXz8ggpkgt7m75+B+s78uu24yFSXgF+5ougoGf8AwDNIhK+8ctKvyFq4GvjiIfq0S
         Y07w==
X-Gm-Message-State: AOJu0YzjoNarIIT6I2oMv4NGOUMHmYIXs+Hx/vXJE6SSBMOWplXloLEI
        EVy6ZqpVlZy+HmnPRK2w1JX/3gZGluM=
X-Google-Smtp-Source: AGHT+IFGdCRzkAYvoIHigd78Ty0Y/oXER1eBZXdZ+LRBlMd+/XP2nDR7+/+fG7GELpFfaCcvMekbxg==
X-Received: by 2002:a17:907:a045:b0:9a9:f09d:7c10 with SMTP id gz5-20020a170907a04500b009a9f09d7c10mr8475386ejc.11.1694444818001;
        Mon, 11 Sep 2023 08:06:58 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:1085:31e2:f2be:e47a:b382:4542])
        by smtp.gmail.com with ESMTPSA id f5-20020a170906138500b0099cb1a2cab0sm5485617ejc.28.2023.09.11.08.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:06:57 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 7/9] gc: add `gc.repackFilter` config option
Date:   Mon, 11 Sep 2023 17:06:16 +0200
Message-ID: <20230911150618.129737-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.167.gd6ff314189
In-Reply-To: <20230911150618.129737-1-christian.couder@gmail.com>
References: <20230812000011.1227371-1-christian.couder@gmail.com>
 <20230911150618.129737-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A previous commit has implemented `git repack --filter=<filter-spec>` to
allow users to filter out some objects from the main pack and move them
into a new different pack.

Users might want to perform such a cleanup regularly at the same time as
they perform other repacks and cleanups, so as part of `git gc`.

Let's allow them to configure a <filter-spec> for that purpose using a
new gc.repackFilter config option.

Now when `git gc` will perform a repack with a <filter-spec> configured
through this option and not empty, the repack process will be passed a
corresponding `--filter=<filter-spec>` argument.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/gc.txt |  5 +++++
 builtin/gc.c                |  6 ++++++
 t/t6500-gc.sh               | 13 +++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index ca47eb2008..2153bde7ac 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -145,6 +145,11 @@ Multiple hooks are supported, but all must exit successfully, else the
 operation (either generating a cruft pack or unpacking unreachable
 objects) will be halted.
 
+gc.repackFilter::
+	When repacking, use the specified filter to move certain
+	objects into a separate packfile.  See the
+	`--filter=<filter-spec>` option of linkgit:git-repack[1].
+
 gc.rerereResolved::
 	Records of conflicted merge you resolved earlier are
 	kept for this many days when 'git rerere gc' is run.
diff --git a/builtin/gc.c b/builtin/gc.c
index 369bd43fb2..607c0ac23e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -61,6 +61,7 @@ static timestamp_t gc_log_expire_time;
 static const char *gc_log_expire = "1.day.ago";
 static const char *prune_expire = "2.weeks.ago";
 static const char *prune_worktrees_expire = "3.months.ago";
+static char *repack_filter;
 static unsigned long big_pack_threshold;
 static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
 
@@ -170,6 +171,8 @@ static void gc_config(void)
 	git_config_get_ulong("gc.bigpackthreshold", &big_pack_threshold);
 	git_config_get_ulong("pack.deltacachesize", &max_delta_cache_size);
 
+	git_config_get_string("gc.repackfilter", &repack_filter);
+
 	git_config(git_default_config, NULL);
 }
 
@@ -355,6 +358,9 @@ static void add_repack_all_option(struct string_list *keep_pack)
 
 	if (keep_pack)
 		for_each_string_list(keep_pack, keep_one_pack, NULL);
+
+	if (repack_filter && *repack_filter)
+		strvec_pushf(&repack, "--filter=%s", repack_filter);
 }
 
 static void add_repack_incremental_option(void)
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 69509d0c11..232e403b66 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -202,6 +202,19 @@ test_expect_success 'one of gc.reflogExpire{Unreachable,}=never does not skip "e
 	grep -E "^trace: (built-in|exec|run_command): git reflog expire --" trace.out
 '
 
+test_expect_success 'gc.repackFilter launches repack with a filter' '
+	test_when_finished "rm -rf bare.git" &&
+	git clone --no-local --bare . bare.git &&
+
+	git -C bare.git -c gc.cruftPacks=false gc &&
+	test_stdout_line_count = 1 ls bare.git/objects/pack/*.pack &&
+
+	GIT_TRACE=$(pwd)/trace.out git -C bare.git -c gc.repackFilter=blob:none \
+		-c repack.writeBitmaps=false -c gc.cruftPacks=false gc &&
+	test_stdout_line_count = 2 ls bare.git/objects/pack/*.pack &&
+	grep -E "^trace: (built-in|exec|run_command): git repack .* --filter=blob:none ?.*" trace.out
+'
+
 prepare_cruft_history () {
 	test_commit base &&
 
-- 
2.42.0.167.gd6ff314189

