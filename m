Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E24DC433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D690023108
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbhASX26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 18:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbhASXZM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 18:25:12 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C15C0613D3
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:24:12 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id w79so23700609qkb.5
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ro3fdB4B2LfJwi30FywhEmnh6LjPrtyH5R4H+Ed9tPs=;
        b=EC3ZAHCVwUsHXteLQ/hZ2id/QgUZiZgNT3qAfcI//irVENoJKtLqvsjt2L2d1EeeCe
         ePe79rrvGYsFief3xrvTOXVpTZ82SDNnmuJPyd7DhY9zVfFqTZQWMa63KKzWXHJ6at2H
         JPkkYUISWM/SjxRtdHCfVZT0OgRDXGTSsM9c4NbvVqCBoR+av/H9qXC0rLv7eqTKoVMH
         e+4p4ljXNAiutHZeFmBKOXCBxLyB9C9fS/tkoDH6MlxX6SCEW0AecWW2gb9Y4xymdPUL
         eNoju/guawTwob8LkjyMpgXBG3UNwZmUO2OvKdIbNFMnVFeXe6Gl1iGgCqYPcZdUFLIC
         ve0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ro3fdB4B2LfJwi30FywhEmnh6LjPrtyH5R4H+Ed9tPs=;
        b=XNUqH4dppyt2pjq/q0MmVgXeRN8wwdBCYdmTtP8siani9MKH8lvGHDf382b3TiG7bB
         gN/FV5bGVu5B5Gr3uqu6oF5KpItjQzS6QpNw8OfeMj5d0WUnXllulYclu7E5I3HvdBm+
         HfV6rIvPrxqnBCiP1KPwFNcp993a5P+vFWKXmiNh6kbTIpRzWZv/VkOhAXOz0tb6zTh+
         wqL48J/OSO4c0r1Nn8Lq4V4ZVhOH7MQkdLVFTNT5K0c/Fwp7B9X4p/T/guc3BOpEQygD
         vVHnNMKEii880TFUgmvSreem7iyJN7EnDYWZftz+kjlMg90fHV7jGHGcgMYbUqW7O/9z
         gNgQ==
X-Gm-Message-State: AOAM530SGi6PuR6mT9glvE2Y11mogwtlctQmVR+Nqh3Wt+90ZfzEcMi4
        dHB4Kl4iVJFj31Qzcgo2YRrLqoIXHtFEaw==
X-Google-Smtp-Source: ABdhPJw1mif8cCed1QZPPgRQklq2eTfyIusJ/3cW3GNY+KrrwDYdkPWwDAcY0YTxuOD5iqE2za9iNQ==
X-Received: by 2002:a05:620a:122d:: with SMTP id v13mr7035941qkj.186.1611098651268;
        Tue, 19 Jan 2021 15:24:11 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id i129sm155203qkd.114.2021.01.19.15.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 15:24:10 -0800 (PST)
Date:   Tue, 19 Jan 2021 18:24:08 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 03/10] builtin/pack-objects.c: learn
 '--assume-kept-packs-closed'
Message-ID: <2da42e9ca26c9ef914b8b044047d505f00a27e20.1611098616.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611098616.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach pack-objects an option to imply the revision machinery's new
'--no-kept-objects' option when doing a reachability traversal.

When '--assume-kept-packs-closed' is given as an argument to
pack-objects, it behaves differently (i.e., passes different options to
the ensuing revision walk) depending on whether or not other arguments
are passed:

  - If the caller also specifies a '--keep-pack' argument (to mark a
    pack as kept in-core), then assume that this combination means to
    stop traversal only at in-core packs.

  - If instead the caller passes '--honor-pack-keep', then assume that
    the caller wants to stop traversal only at packs with a
    corresponding .keep file (consistent with the original meaning which
    only refers to packs with a .keep file).

  - If both '--keep-pack' and '--honor-pack-keep' are passed, then
    assume the caller wants to stop traversal at either kind of kept
    pack.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-pack-objects.txt | 11 ++++++
 builtin/pack-objects.c             | 13 +++++++
 t/t6114-keep-packs.sh              | 59 ++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 54d715ead1..cbe08e7415 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -135,6 +135,17 @@ depth is 4095.
 	leading directory (e.g. `pack-123.pack`). The option could be
 	specified multiple times to keep multiple packs.
 
+--assume-kept-packs-closed::
+	This flag causes `git rev-list` to halt the object traversal
+	when it encounters an object found in a kept pack. This is
+	dissimilar to `--honor-pack-keep`, which only prunes unwanted
+	results after the full traversal is completed.
++
+Without any `--keep-pack=<pack-name>` arguments, only packs with an
+on-disk `*.keep` files are used when considering when to halt the
+traversal. If other packs are artificially marked as "kept" with
+`--keep-pack`, then those are considered as well.
+
 --incremental::
 	This flag causes an object already in a pack to be ignored
 	even if it would have otherwise been packed.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2a00358f34..a5dcd66f52 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -78,6 +78,7 @@ static int have_non_local_packs;
 static int incremental;
 static int ignore_packed_keep_on_disk;
 static int ignore_packed_keep_in_core;
+static int assume_kept_packs_closed;
 static int allow_ofs_delta;
 static struct pack_idx_option pack_idx_opts;
 static const char *base_name;
@@ -3542,6 +3543,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("create packs suitable for shallow fetches")),
 		OPT_BOOL(0, "honor-pack-keep", &ignore_packed_keep_on_disk,
 			 N_("ignore packs that have companion .keep file")),
+		OPT_BOOL(0, "assume-kept-packs-closed", &assume_kept_packs_closed,
+			 N_("assume the union of kept packs is closed under reachability")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
 				N_("ignore this pack")),
 		OPT_INTEGER(0, "compression", &pack_compression_level,
@@ -3631,6 +3634,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		use_internal_rev_list = 1;
 		strvec_push(&rp, "--unpacked");
 	}
+	if (assume_kept_packs_closed)
+		use_internal_rev_list = 1;
 
 	if (exclude_promisor_objects) {
 		use_internal_rev_list = 1;
@@ -3711,6 +3716,14 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		if (!p) /* no keep-able packs found */
 			ignore_packed_keep_on_disk = 0;
 	}
+	if (assume_kept_packs_closed) {
+		if (ignore_packed_keep_on_disk && ignore_packed_keep_in_core)
+			strvec_push(&rp, "--no-kept-objects");
+		else if (ignore_packed_keep_on_disk)
+			strvec_push(&rp, "--no-kept-objects=on-disk");
+		else if (ignore_packed_keep_in_core)
+			strvec_push(&rp, "--no-kept-objects=in-core");
+	}
 	if (local) {
 		/*
 		 * unlike ignore_packed_keep_on_disk above, we do not
diff --git a/t/t6114-keep-packs.sh b/t/t6114-keep-packs.sh
index 9239d8aa46..0861305a04 100755
--- a/t/t6114-keep-packs.sh
+++ b/t/t6114-keep-packs.sh
@@ -66,4 +66,63 @@ test_expect_success '--no-kept-objects excludes kept non-MIDX object' '
 	test_cmp expect actual
 '
 
+test_expect_success '--no-kept-objects can respect only in-core keep packs' '
+	test_when_finished "rm -fr actual-*.idx actual-*.pack" &&
+	(
+		git rev-list --objects --no-object-names packed..kept &&
+		git rev-list --objects --no-object-names loose
+	) | sort >expect &&
+
+	git pack-objects \
+	  --assume-kept-packs-closed \
+	  --keep-pack=pack-$MISC_PACK.pack \
+	  --all actual </dev/null &&
+	idx_objects actual-*.idx >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'setup additional --no-kept-objects tests' '
+	test_commit additional &&
+
+	ADDITIONAL_PACK=$(git pack-objects --revs .git/objects/pack/pack <<-EOF
+	refs/tags/additional
+	^refs/tags/kept
+	EOF
+	)
+'
+
+test_expect_success '--no-kept-objects can respect only on-disk keep packs' '
+	test_when_finished "rm -fr actual-*.idx actual-*.pack" &&
+	(
+		git rev-list --objects --no-object-names kept..additional &&
+		git rev-list --objects --no-object-names packed
+	) | sort >expect &&
+
+	git pack-objects \
+	  --assume-kept-packs-closed \
+	  --honor-pack-keep \
+	  --all actual </dev/null &&
+	idx_objects actual-*.idx >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success '--no-kept-objects can respect mixed kept packs' '
+	test_when_finished "rm -fr actual-*.idx actual-*.pack" &&
+	(
+		git rev-list --objects --no-object-names kept..additional &&
+		git rev-list --objects --no-object-names loose
+	) | sort >expect &&
+
+	git pack-objects \
+	  --assume-kept-packs-closed \
+	  --honor-pack-keep \
+	  --keep-pack=pack-$MISC_PACK.pack \
+	  --all actual </dev/null &&
+	idx_objects actual-*.idx >actual &&
+
+	test_cmp expect actual
+'
+
 test_done
-- 
2.30.0.138.g6d7191ea01

