Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C19DC77B6F
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 22:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjDJWx7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 18:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDJWxr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 18:53:47 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08613211B
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 15:53:46 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id z9so6211241ybs.9
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 15:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681167225; x=1683759225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fziDqg2Z1UHsm3H8cJvq5x//xNnwMbr1AO0i2gwl/KM=;
        b=urg/siUdW0I7aIf4JPsYkRwueUWqDaZVoo038D+eM5Y0/Cmz/JmwjT5G/59HbtEkXE
         bA8ZijxiXmsxBcouwa2cH6kYM4r66nSIAkefP/irzwOVdmPzj+cQEQ9kzCizAdbeq0Jc
         +9EzwtbTN0WH+HFMIXzctQsS1iFGZruaP4LtwLfu9mj2MNAhYJy+VXmleIR1ydTwXfGP
         Fq2O9IBqxeOhkMIQVRMrvReUoQXSHuGMCvK+CU/Rp41JEYKrpyOZofI7gf/ljhmu99tt
         ZH5D6CTrlfC1kdYQhXtrPUY12zucnt+w1uoahkimKx4Gt+rEo+3zv6UlxBEpjiJUhgOA
         A8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681167225; x=1683759225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fziDqg2Z1UHsm3H8cJvq5x//xNnwMbr1AO0i2gwl/KM=;
        b=1B27jRMzANeH/Q+obJguRtg3Uks7L6ruOcmnFM3PKjuHwaRU8aV4+1C+p4p/lNSvgd
         Wka7s3Na6GWK8Go+KSEQJTVzBgnsrhCMAr3/kSbeXAoEbCUPhpgZ4pQM9LkQovGZ/+kY
         /CZIko+NBDQwSGuWi6v5v/MFEugR7yNQVbzZ65aZLD0mCvM8cH9vX4041Lo+vgRUWxA/
         YtQJq7LI7juGJgU7JEY5PaNdVgBzJtoPacsKuZeOtRnBHVyscgtv0irbnbYRGPTPm7NE
         A/eBgLPWplD2OonuaAt0cUlmulMS4JGZ+vPDQDhLyCmL03uueK3X4oryEDmc7kKECBeH
         Fedw==
X-Gm-Message-State: AAQBX9dMUnX0D4QG1FAwoScLIC3XR2Gpi6eN12SYmIceiRMo3hPn0vYy
        53ywhOwAaME6ujbLWHQyY8IpJVHiIrnvdbitS5iOjA==
X-Google-Smtp-Source: AKy350aOqGa+XksLVRi2JBbah/eeyTFQt1EOg6fB3np4zVJR01FYsTUiF4UgCwUYhQj4rdzp5jPHvw==
X-Received: by 2002:a25:a265:0:b0:b8c:49c:85cf with SMTP id b92-20020a25a265000000b00b8c049c85cfmr9928419ybi.3.1681167225036;
        Mon, 10 Apr 2023 15:53:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v72-20020a252f4b000000b00b7767ca747csm3194951ybv.25.2023.04.10.15.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:53:44 -0700 (PDT)
Date:   Mon, 10 Apr 2023 18:53:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/7] t: invert `GIT_TEST_WRITE_REV_INDEX`
Message-ID: <9c80379958824ac8fb7834f4f98000d11c3dc4e0.1681166596.git.me@ttaylorr.com>
References: <cover.1681166596.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681166596.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Back in e8c58f894b (t: support GIT_TEST_WRITE_REV_INDEX, 2021-01-25), we
added a test knob to conditionally enable writing a ".rev" file when
indexing a pack. At the time, this was used to ensure that the test
suite worked even when ".rev" files were written, which served as a
stress-test for the on-disk reverse index implementation.

Now that reading from on-disk ".rev" files is enabled by default, the
test knob `GIT_TEST_WRITE_REV_INDEX` no longer has any meaning.

We could get rid of the option entirely, but there would be no
convenient way to test Git when ".rev" files *aren't* in place.

Instead of getting rid of the option, invert its meaning to instead
disable writing ".rev" files, thereby running the test suite in a mode
where the reverse index is generated from scratch.

This ensures that we are still running and exercising Git's behavior
when forced to generate reverse indexes from scratch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/index-pack.c      | 4 ++--
 builtin/pack-objects.c    | 4 ++--
 ci/run-build-and-tests.sh | 1 -
 pack-revindex.h           | 2 +-
 t/README                  | 2 +-
 t/t5325-reverse-index.sh  | 2 +-
 6 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 323c063f9d..9e36c985cf 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1758,8 +1758,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (prefix && chdir(prefix))
 		die(_("Cannot come back to cwd"));
 
-	if (git_env_bool(GIT_TEST_WRITE_REV_INDEX, 0))
-		rev_index = 1;
+	if (git_env_bool(GIT_TEST_NO_WRITE_REV_INDEX, 0))
+		rev_index = 0;
 	else
 		rev_index = !!(opts.flags & (WRITE_REV_VERIFY | WRITE_REV));
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index dbaa04482f..1797871ce9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4295,8 +4295,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	reset_pack_idx_option(&pack_idx_opts);
 	pack_idx_opts.flags |= WRITE_REV;
 	git_config(git_pack_config, NULL);
-	if (git_env_bool(GIT_TEST_WRITE_REV_INDEX, 0))
-		pack_idx_opts.flags |= WRITE_REV;
+	if (git_env_bool(GIT_TEST_NO_WRITE_REV_INDEX, 0))
+		pack_idx_opts.flags &= ~WRITE_REV;
 
 	progress = isatty(2);
 	argc = parse_options(argc, argv, prefix, pack_objects_options,
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index b098e10f52..e9fbfb6345 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -27,7 +27,6 @@ linux-TEST-vars)
 	export GIT_TEST_MULTI_PACK_INDEX=1
 	export GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=1
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
-	export GIT_TEST_WRITE_REV_INDEX=1
 	export GIT_TEST_CHECKOUT_WORKERS=2
 	;;
 linux-clang)
diff --git a/pack-revindex.h b/pack-revindex.h
index ef8afee88b..46e834064e 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -34,7 +34,7 @@
 #define RIDX_SIGNATURE 0x52494458 /* "RIDX" */
 #define RIDX_VERSION 1
 
-#define GIT_TEST_WRITE_REV_INDEX "GIT_TEST_WRITE_REV_INDEX"
+#define GIT_TEST_NO_WRITE_REV_INDEX "GIT_TEST_NO_WRITE_REV_INDEX"
 #define GIT_TEST_REV_INDEX_DIE_IN_MEMORY "GIT_TEST_REV_INDEX_DIE_IN_MEMORY"
 #define GIT_TEST_REV_INDEX_DIE_ON_DISK "GIT_TEST_REV_INDEX_DIE_ON_DISK"
 
diff --git a/t/README b/t/README
index 29576c3748..bdfac4cceb 100644
--- a/t/README
+++ b/t/README
@@ -475,7 +475,7 @@ GIT_TEST_DEFAULT_HASH=<hash-algo> specifies which hash algorithm to
 use in the test scripts. Recognized values for <hash-algo> are "sha1"
 and "sha256".
 
-GIT_TEST_WRITE_REV_INDEX=<boolean>, when true enables the
+GIT_TEST_NO_WRITE_REV_INDEX=<boolean>, when true disables the
 'pack.writeReverseIndex' setting.
 
 GIT_TEST_SPARSE_INDEX=<boolean>, when true enables index writes to use the
diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
index 149dcf5193..0548fce1aa 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -7,7 +7,7 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 # The below tests want control over the 'pack.writeReverseIndex' setting
 # themselves to assert various combinations of it with other options.
-sane_unset GIT_TEST_WRITE_REV_INDEX
+sane_unset GIT_TEST_NO_WRITE_REV_INDEX
 
 packdir=.git/objects/pack
 
-- 
2.40.0.323.g9c80379958
