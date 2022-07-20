Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF233C43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 21:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiGTVWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 17:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiGTVWV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 17:22:21 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBB24D4EB
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:19 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z13so8301817wro.13
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t1RO+TqtVIL+LW42ZvJUPdbLtpW6e7cMgtrIGypNRiw=;
        b=Zq6Driismo/60JvKVXQWmjOM0YYVxCv83klViNHKM2I236n3o/4j3ufxiAtV8pBl71
         IG2+ZpHrOnp2UpqJOz+XtPMQ/aAQavoMRXD/1GLuis5pZkxtBG4AjjnQ/7fYtA+1CRuA
         xxXUhbhByc1DyzV5/jBDKPWXuZTS1/0cAah2qzloM4YOR5Fpr6Al3QBqBeCEzz39617S
         KJgY1DjYotgamZ+68OsE8J7uGH7PX0GZZuvif9D8OpgH/ot2S5k6BLxYyokp7TwdXwbr
         12p+NNS4348hD8DJwFTnzHd9KfMY92UI8JDZYSI9/vo2TiYzF5E1WWmEXPwvScNcuN+B
         f3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t1RO+TqtVIL+LW42ZvJUPdbLtpW6e7cMgtrIGypNRiw=;
        b=GKOA8cNSTW6Wx2VAfe5QjDhPPRKqOV/J8ON45HAj+ovyFChN95hlsHoROrRhcj1Eam
         KYTpPyd6av3v13io7GflOvnOAyEny3QHeNFlQ1TKnGNYXGBqx+DJVLnMGSJfcZZZtTYf
         UbNaq+WC7xzUbvfq7dtdoypvhpCEGSfAGlPggMogy31D8Wj6V13J3WWMwljjFhkbldXT
         tBft/YKGRD6pIln73Ljzj+Q69GluJQwtNqaQ5JKymK/JB2C1xZY5oNlAZkbPmk4ygTLc
         k2aLBtuScetH0OPOZtvyvCmxTo2pfhb7pkh8XPMxFgEvQB7JNKH3fjUqweo6crj7rYZO
         YmFw==
X-Gm-Message-State: AJIora9jori9XfMoJ+/imSNd5MsGk94D67yikBKBWienyBONMY7zJZO3
        1THDuN4VlEWGCcETiyBHGEQmY/GNBo7G8A==
X-Google-Smtp-Source: AGRyM1s5r8Nj2ieTA5EltI8BGsj8xUqcdP+Pq0tB8CmiFl35pIhTfmd4qtWrf8jAXd+qSn44ao8DCg==
X-Received: by 2002:a05:6000:1882:b0:21d:9f46:aadb with SMTP id a2-20020a056000188200b0021d9f46aadbmr31146954wri.64.1658352137972;
        Wed, 20 Jul 2022 14:22:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003a0375c4f73sm3605441wmj.44.2022.07.20.14.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:22:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/14] test-lib: add a GIT_TEST_PASSING_SANITIZE_LEAK=check mode
Date:   Wed, 20 Jul 2022 23:21:48 +0200
Message-Id: <patch-v2-10.14-78a47d2b348-20220720T211221Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1064.gc96144cf387
In-Reply-To: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new "GIT_TEST_PASSING_SANITIZE_LEAK=check" mode to the
test-lib.sh.

As noted in the updated "t/README" this compliments the existing
"GIT_TEST_PASSING_SANITIZE_LEAK=true" mode added in
956d2e4639b (tests: add a test mode for SANITIZE=leak, run it in CI,
2021-09-23).

Rather than document this all in one (even more) dense paragraph split
up the discussion of how it combines with --immediate into its own
paragraph following the discussion of
"GIT_TEST_SANITIZE_LEAK_LOG=true".

Before the removal of "test_external" in a preceding commit we would
have had to special-case t9700-perl-git.sh and t0202-gettext-perl.sh.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README      | 17 +++++++++++++++++
 t/test-lib.sh | 34 ++++++++++++++++++++++++++--------
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/t/README b/t/README
index 98f69ed13d2..e13063195e5 100644
--- a/t/README
+++ b/t/README
@@ -371,11 +371,28 @@ declared themselves as leak-free by setting
 "TEST_PASSES_SANITIZE_LEAK=true" before sourcing "test-lib.sh". This
 test mode is used by the "linux-leaks" CI target.
 
+GIT_TEST_PASSING_SANITIZE_LEAK=check checks that our
+"TEST_PASSES_SANITIZE_LEAK=true" markings are current. Rather than
+skipping those tests that haven't set "TEST_PASSES_SANITIZE_LEAK=true"
+before sourcing "test-lib.sh" this mode runs them with
+"--invert-exit-code". This is used to check that there's a one-to-one
+mapping between "TEST_PASSES_SANITIZE_LEAK=true" and those tests that
+pass under "SANITIZE=leak". This is especially useful when testing a
+series that fixes various memory leaks with "git rebase -x".
+
 GIT_TEST_SANITIZE_LEAK_LOG=true will log memory leaks to
 "test-results/$TEST_NAME.leak/trace.*" files. The logs include a
 "dedup_token" (see +"ASAN_OPTIONS=help=1 ./git") and other options to
 make logs +machine-readable.
 
+GIT_TEST_PASSING_SANITIZE_LEAK=check when combined with "--immediate"
+will run to completion faster, and result in the same failing
+tests. The only practical reason to run
+GIT_TEST_PASSING_SANITIZE_LEAK=check without "--immediate" is to
+combine it with "GIT_TEST_SANITIZE_LEAK_LOG=true". If we stop at the
+first failing test case our leak logs won't show subsequent leaks we
+might have run into.
+
 GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
 default to n.
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 453d980bcf7..5785eaf08dc 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1452,17 +1452,34 @@ BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK () {
 # skip non-whitelisted tests when compiled with SANITIZE=leak
 if test -n "$SANITIZE_LEAK"
 then
-	if test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
+	# Normalize with test_bool_env
+	passes_sanitize_leak=
+
+	# We need to see TEST_PASSES_SANITIZE_LEAK in "git
+	# env--helper" (via test_bool_env)
+	export TEST_PASSES_SANITIZE_LEAK
+	if test_bool_env TEST_PASSES_SANITIZE_LEAK false
+	then
+		passes_sanitize_leak=t
+	fi
+
+	if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check"
 	then
-		# We need to see it in "git env--helper" (via
-		# test_bool_env)
-		export TEST_PASSES_SANITIZE_LEAK
+		if test -n "$invert_exit_code"
+		then
+			BAIL_OUT "cannot use --invert-exit-code under GIT_TEST_PASSING_SANITIZE_LEAK=check"
+		fi
 
-		if ! test_bool_env TEST_PASSES_SANITIZE_LEAK false
+		if test -z "$passes_sanitize_leak"
 		then
-			skip_all="skipping $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=true"
-			test_done
+			say "in GIT_TEST_PASSING_SANITIZE_LEAK=check mode, setting --invert-exit-code for TEST_PASSES_SANITIZE_LEAK != true"
+			invert_exit_code=t
 		fi
+	elif test -z "$passes_sanitize_leak" &&
+	     test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
+	then
+		skip_all="skipping $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=true"
+		test_done
 	fi
 
 	if test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
@@ -1481,7 +1498,8 @@ then
 		prepend_var LSAN_OPTIONS : log_path=\"$TEST_RESULTS_SAN_FILE\"
 		export LSAN_OPTIONS
 	fi
-elif test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
+elif test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check" ||
+     test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
 then
 	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_PASSING_SANITIZE_LEAK=true"
 elif test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
-- 
2.37.1.1064.gc96144cf387

