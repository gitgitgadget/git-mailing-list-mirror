Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1835CC433E6
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF47222AAC
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732926AbhAYXjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 18:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732682AbhAYXij (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 18:38:39 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A471C061794
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 15:37:46 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id j13so1735269qvu.10
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 15:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XGaYXRQwd3LEGtR8vOpNtea5PT0lfy0gwwpM57sAbEg=;
        b=LRH9H/X/Nc6BmxKhPfegs6FZJyOlg5ux7NWxOnOek1XrheQ5uPbzOZ8NheIv6nG1QX
         hn+zvnWQhuP/z9XvsUDf8JU1+8H74188HIcdcBl32dW7JfLjsYwG6r/SSFJB7Yeqf3z8
         xd4CwWLN92EMJjQ3N44mIvqXup1RJ3m1j5EtgFKIm5aNx30H4/HjFuC1GUrNFLA6w6sM
         b95cf4Ia07rG+1ayPw03YPMoXpN92DLiVfJiHeeJSQzqSx6wv+A3MzhvTBKs82/2KmSM
         jrmdDwdjnkDEcVC0F/5a72KCKivzcE2Wx8N0u4ESz1Q9L2ObSgO3fA5iEkEbzAVju/od
         cOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XGaYXRQwd3LEGtR8vOpNtea5PT0lfy0gwwpM57sAbEg=;
        b=tO4BJpKqQwmzSpIYRfJSfprOzlThnkHtAnP8ijpXEBr07kSBrQp4+JmpWsOkJWg9hE
         IqlK/LW8vMvlL6kSAGmVy+z16hFJWtQjxz69Nr7hzW+jMx00Kahl0nOUuSIUzOjFpXOD
         OhP4fb2QzfPtUZ3WxzpeZCe5+tI9/OrFOgi370qEE2gi5MN8ym7LrNSpoE5e9RdFKaB1
         2V69BPekblEgbBbj9H5r6ieY0HGD+oTBs7LVIe2QwEFBZpIWMZBAn/1O2J9iNFqozSzu
         qtcmRHo9wVCaxnGzb8bUlHxF9S2S6uFK25WTv/k3Ld//PfkMr/152uWpHIO6ixmooarZ
         klLQ==
X-Gm-Message-State: AOAM530TJ13A6cD60/f1oHFiCEujGs3lvhoKmKt+rWVl3nqLBHjes1kd
        SNOTHy4YdQMrNio1zu5knJjLBsVpjp/vVg==
X-Google-Smtp-Source: ABdhPJx+81Ji3PCqWpXfZ6P3prENFyaWXPkmneMe4LE77YLjFWMviic+RRILdBBNQyUUV17dqyZt6Q==
X-Received: by 2002:a05:6214:18d4:: with SMTP id cy20mr3137408qvb.43.1611617865220;
        Mon, 25 Jan 2021 15:37:45 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5e9f:a2e5:e7ac:394d])
        by smtp.gmail.com with ESMTPSA id h22sm11794447qth.55.2021.01.25.15.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 15:37:44 -0800 (PST)
Date:   Mon, 25 Jan 2021 18:37:42 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v3 08/10] t: support GIT_TEST_WRITE_REV_INDEX
Message-ID: <02550a251de4f477a537968fda921b52586794dc.1611617820.git.me@ttaylorr.com>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611617819.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new option that unconditionally enables the pack.writeReverseIndex
setting in order to run the whole test suite in a mode that generates
on-disk reverse indexes. Additionally, enable this mode in the second
run of tests under linux-gcc in 'ci/run-build-and-tests.sh'.

Once on-disk reverse indexes are proven out over several releases, we
can change the default value of that configuration to 'true', and drop
this patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/index-pack.c      | 5 ++++-
 builtin/pack-objects.c    | 2 ++
 ci/run-build-and-tests.sh | 1 +
 pack-revindex.h           | 3 +++
 t/README                  | 3 +++
 5 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index d5cd665b98..54f74c4874 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1748,7 +1748,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (prefix && chdir(prefix))
 		die(_("Cannot come back to cwd"));
 
-	rev_index = !!(opts.flags & (WRITE_REV_VERIFY | WRITE_REV));
+	if (git_env_bool(GIT_TEST_WRITE_REV_INDEX, 0))
+		rev_index = 1;
+	else
+		rev_index = !!(opts.flags & (WRITE_REV_VERIFY | WRITE_REV));
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d784569200..24df0c98f7 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3601,6 +3601,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	reset_pack_idx_option(&pack_idx_opts);
 	git_config(git_pack_config, NULL);
+	if (git_env_bool(GIT_TEST_WRITE_REV_INDEX, 0))
+		pack_idx_opts.flags |= WRITE_REV;
 
 	progress = isatty(2);
 	argc = parse_options(argc, argv, prefix, pack_objects_options,
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 50e0b90073..a66b5e8c75 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -24,6 +24,7 @@ linux-gcc)
 	export GIT_TEST_MULTI_PACK_INDEX=1
 	export GIT_TEST_ADD_I_USE_BUILTIN=1
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+	export GIT_TEST_WRITE_REV_INDEX=1
 	make test
 	;;
 linux-clang)
diff --git a/pack-revindex.h b/pack-revindex.h
index 61b2f3ab75..d1a0595e89 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -16,9 +16,12 @@
  *   can be found
  */
 
+
 #define RIDX_SIGNATURE 0x52494458 /* "RIDX" */
 #define RIDX_VERSION 1
 
+#define GIT_TEST_WRITE_REV_INDEX "GIT_TEST_WRITE_REV_INDEX"
+
 struct packed_git;
 
 /*
diff --git a/t/README b/t/README
index c730a70770..0f97a51640 100644
--- a/t/README
+++ b/t/README
@@ -439,6 +439,9 @@ GIT_TEST_DEFAULT_HASH=<hash-algo> specifies which hash algorithm to
 use in the test scripts. Recognized values for <hash-algo> are "sha1"
 and "sha256".
 
+GIT_TEST_WRITE_REV_INDEX=<boolean>, when true enables the
+'pack.writeReverseIndex' setting.
+
 Naming Tests
 ------------
 
-- 
2.30.0.138.g6d7191ea01

