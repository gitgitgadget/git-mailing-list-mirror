Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5243EC7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 22:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjDLWU6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 18:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjDLWUq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 18:20:46 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39F3659E
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 15:20:38 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id n203so1684915ybg.6
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 15:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681338038; x=1683930038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pjcohNR2HZuxa6NkSdaeejPxXtnVK+o6h1kxpBF0hQ0=;
        b=mwSKHbStrzTshrKBCaHStQWBxEmwloCTcjFWX+sd57SvZV606ULBqiCtvqBZprfr8j
         V955KUiSiAJRc3tMctE9R9wqsuCa+M3kcQBlo849us3UC9D9jERpPST3Q1jQHJZ91w2N
         UnnEUdaH0zgV8fQpdU9MIejqdfw1MlZO9+h1gcl07WV8rzodPmqsfIYV0FYJBRUgIKj4
         4Yb2Y6OaSPL3EFjJkIng3A2XcIhF3cDj9xLRFl3TtZRBb3SID30oWrid8xKnxO4Uc9do
         O6EwLEWxu+qh9TbjhkrjTsZzE9qfbXVAT6ubWFcd8GhkcSM7ybySgohpTW5R3NhDA4ap
         eLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681338038; x=1683930038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjcohNR2HZuxa6NkSdaeejPxXtnVK+o6h1kxpBF0hQ0=;
        b=FbSInH+9g/WYLihBqWJ16V34w7ulw2QBJxcdKzBjw6h87h2GSE7XQ4shv/o+px0gVx
         2ckn7TB3mQXeWEQmCV8IbQfO0pZjI+oD3qPTJpEgMeXOj1cluagUAO670qjUG8xvxyjY
         KhAxNYv1/0Nf3oMXVEC0krOiUFL9d+vdfRmek5a1vFHUELHJKIeywguiZfe6lfKAWf9N
         m/Yx1Zdic7mL1OdIyb2Gix/pgZAp//prfV0tTTm/JwJ0DFzpPymrRRwRTyZEe2QjXGly
         NfPsaLhVP+Ql8Rtyvp/OVyJW+ThHqNCPMb0VlJpiegWndR0ZUWSd1W0IKbYsVt5Zob7X
         aaDA==
X-Gm-Message-State: AAQBX9clUBX3ep6pxsHHDa37eqQWRRowvjqnYfu+qqN84jb8WtPVBdZp
        LHuuHc9H9frAhvV25uzKk58LfioXrshrDer899qikQ==
X-Google-Smtp-Source: AKy350bPtz26w9NJ8sBB23wLlgXDAsQs4/nSZ9eGTLvBxnNxSdKAA9vhQ3TAHXajmKpImayBcQsRfQ==
X-Received: by 2002:a25:65c5:0:b0:b8b:d5d7:69cb with SMTP id z188-20020a2565c5000000b00b8bd5d769cbmr32963ybb.47.1681338037941;
        Wed, 12 Apr 2023 15:20:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j19-20020a25d213000000b00b7767ca7487sm4621713ybg.36.2023.04.12.15.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 15:20:37 -0700 (PDT)
Date:   Wed, 12 Apr 2023 18:20:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/7] t: invert `GIT_TEST_WRITE_REV_INDEX`
Message-ID: <edff6a80c63d491fb63cb2187d4c8d5250cb428b.1681338013.git.me@ttaylorr.com>
References: <cover.1681166596.git.me@ttaylorr.com>
 <cover.1681338013.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681338013.git.me@ttaylorr.com>
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

This ensures that, when GIT_TEST_NO_WRITE_REV_INDEX is set to some
spelling of "true", we are still running and exercising Git's behavior
when forced to generate reverse indexes from scratch. Do so by setting
it in the linux-TEST-vars CI run to ensure that we are maintaining good
coverage of this now-legacy code.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/index-pack.c      | 4 ++--
 builtin/pack-objects.c    | 4 ++--
 ci/run-build-and-tests.sh | 2 +-
 pack-revindex.h           | 2 +-
 t/README                  | 2 +-
 t/t5325-reverse-index.sh  | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 323c063f9db..9e36c985cf1 100644
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
index dbaa04482fd..1797871ce90 100644
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
index b098e10f52a..a18b13a41dd 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -27,7 +27,7 @@ linux-TEST-vars)
 	export GIT_TEST_MULTI_PACK_INDEX=1
 	export GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=1
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
-	export GIT_TEST_WRITE_REV_INDEX=1
+	export GIT_TEST_NO_WRITE_REV_INDEX=1
 	export GIT_TEST_CHECKOUT_WORKERS=2
 	;;
 linux-clang)
diff --git a/pack-revindex.h b/pack-revindex.h
index ef8afee88b0..46e834064e1 100644
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
index 29576c37488..bdfac4cceb2 100644
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
index 149dcf5193b..0548fce1aa6 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -7,7 +7,7 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 # The below tests want control over the 'pack.writeReverseIndex' setting
 # themselves to assert various combinations of it with other options.
-sane_unset GIT_TEST_WRITE_REV_INDEX
+sane_unset GIT_TEST_NO_WRITE_REV_INDEX
 
 packdir=.git/objects/pack
 
-- 
2.40.0.323.gedff6a80c63
