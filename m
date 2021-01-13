Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847B7C43333
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D0C235F8
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbhANCF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbhAMWbL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:31:11 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58398C0617AA
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:28:37 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id z11so4453221qkj.7
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R9VxRrGALjumWhx0ag6SP3iU6tyRas3+pb/mtSZZ4vI=;
        b=G5FmC5yR66VUZzfgMM+FLYLh5UyDm9kMjm3BTkitKzD9XDY3A1YlAFufFSIK9dbqdW
         W5PW+l2UHePUNdhR9ZGIyKd19TGtX3faRHkFBZ+Zv4bKB7bJH5fustQQJLM29iw8Mwpz
         EtedvpL/48bFpbuEWbDq4ht+uyGN3DJhpe5YqZfrE5BQ5Gwzla8TMB7RNmHUuzw40/fJ
         ifLpUBj6Zm9w4IeR0TwtkGAHtTj0JEtVgGI0TgX05+LzHnRUQYv+TOctV3yZdoTauALQ
         1BAI3LS+6mzT9w7d8DX4KSFFYStHSlT1Z7vMO/LvkEJrQ8kuIoDdS1iH6jbOYJzUVf92
         zVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R9VxRrGALjumWhx0ag6SP3iU6tyRas3+pb/mtSZZ4vI=;
        b=qqtcrhOaO1savotTCWDSbydgmjMJcCO9QYZqcZsHF8+P8iiEcTnwe3XihtYdEKcgzo
         FwGVBf5APY9T9b+ZRXGhkiCjwSo7i1Mvj0kOrxfUQmtwSifPf3XUKmcMLjxKgcM/PXpJ
         p2DHQdUMdQfHQwjhKQS9HI5cqK3nVQt6pqIS5wCZHhfdZ++w2CxXloWWEp/97pafeHxL
         0DUxhBJ9SmLL1q9ZpoqS08X7GBcXOfd2K7DZyLxxTePoTKon3Mj/HijI+mjak0Gmetr3
         meFT3wakJ/WrAwqms7sdLznYiMbnlRMQykT4329eKOdhn10td6KbN1Cfgwy3/fbRG9Pm
         sFgA==
X-Gm-Message-State: AOAM531fRMwfm6zl26p7JuNQW8wKWom6fXoFZGk7W8LPVbTE/W2p9u4r
        EnQjH63T7k4MaNHhx4dBs7QM31dVg/iQrQ==
X-Google-Smtp-Source: ABdhPJyw6/GBs6Aj4+w85fLaRDYQC9MgaHYF623o2VRgfdF4SjQQ1JraTKEEYThq8/ReKOj6DJitMQ==
X-Received: by 2002:a37:63c3:: with SMTP id x186mr4485254qkb.361.1610576916339;
        Wed, 13 Jan 2021 14:28:36 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id j203sm1889033qke.134.2021.01.13.14.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:28:35 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:28:33 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 7/8] t: support GIT_TEST_WRITE_REV_INDEX
Message-ID: <6b647d9775fd97238f1170dc998770c196a92cc4.1610576805.git.me@ttaylorr.com>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1610576805.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576805.git.me@ttaylorr.com>
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
 pack-revindex.h           | 2 ++
 t/README                  | 3 +++
 5 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 03408250b1..0bde325a8b 100644
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
index 6c27b886b8..d1cbf330a1 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -22,6 +22,7 @@ linux-gcc)
 	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
 	export GIT_TEST_ADD_I_USE_BUILTIN=1
+	export GIT_TEST_WRITE_REV_INDEX=1
 	make test
 	;;
 linux-clang)
diff --git a/pack-revindex.h b/pack-revindex.h
index 01622cf21a..7237b2b6f8 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -16,6 +16,8 @@
  *   can be found
  */
 
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

