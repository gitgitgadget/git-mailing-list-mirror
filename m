Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D829CC433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 20:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A58E164D73
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 20:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhBKUbx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 15:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhBKUbh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 15:31:37 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D76AC061756
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 12:30:57 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id a16so6563731wmm.0
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 12:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p9V6ywcrEhQofrUK1TYNQGXKjGL+IVGuoeqzIK51kFI=;
        b=GQHLTVaFY4hFKNkhsbCB46/1Lh2ci8rfEDrvIMS+CvCVzDJJSRGrGlBWPMDGoE4yK/
         9FZmhbqxm6vdI9bx0OFFKaaOoA6b229GTV4o5WQ3ab93UHXjbgcfUa2XnKQPi6MwXxUz
         ysojb9nfuQYsaQNvvEL1KzpyXKT85oCtxGUuT+p4r5A8kyfPgkDIhVkBbcaMmXWzTo5z
         uYS1ThqGEfF+ZPB+FyjyKneGbkSoDu+B5UGpv+5xyqDztm43BeJ5APBEfNq6jT1ONgIO
         23N0CXfN6SafXwhFN9SvjpHidD8SBmoVDD06PWdIK8X/BZXjBENRtsJ4+l95HMpkb41w
         XhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p9V6ywcrEhQofrUK1TYNQGXKjGL+IVGuoeqzIK51kFI=;
        b=IJtokpKSqioqtsdJMhj52RkdOlrPYFxWQfSF/dLPD9FU3Xe+uTbj0NNHBChxBh/sYx
         J7YFWZXxqiW+6N2cTOz48xs1hua5zKvr0Z4wb1IWCB4MLLEa1mcsU+I5wnThjmG4xP4d
         gByAFYPUWidZIUCxogQv9t7YLTahKRxMIoF9K/lt+dTXR3jFFmNOfaEmbjQI1+yZn6Ge
         T5UF7V888ocaIOMzvh6PcYoD1pOGT4DQanGhCDMOcYMqYFaJCqMFgslIyhsUF0jltBha
         3AJsSJRYzkiYPVL3AL+1oKB2wY9dDmhVIpHmTAwW+fwckDpAmaqhid97JP1stnUaHUvo
         KQrg==
X-Gm-Message-State: AOAM533THtiFdG9ApI/Od46UrzI0vNfIc5oxGNCwHWYR7X8IPnjYov0/
        UpI/6BLkaxkY9/b6y1QXh0NhWzqD5CM=
X-Google-Smtp-Source: ABdhPJwTCj/+0bKpgeGTrwzfFUGnhyrOsZZTh6yMU4iqj20PzccyktDYiIcWcoJdkJnRY9hOQSb8Nw==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr6900533wmb.78.1613075455920;
        Thu, 11 Feb 2021 12:30:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10sm6844248wro.4.2021.02.11.12.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 12:30:55 -0800 (PST)
Message-Id: <pull.841.v3.git.git.1613075454274.gitgitgadget@gmail.com>
In-Reply-To: <pull.841.v2.git.git.1612833909210.gitgitgadget@gmail.com>
References: <pull.841.v2.git.git.1612833909210.gitgitgadget@gmail.com>
From:   "Andrew Klotz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Feb 2021 20:30:53 +0000
Subject: [PATCH v3] config: improve error message for boolean config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Andrew Klotz <agc.klotz@gmail.com>,
        Andrew Klotz <agc.klotz@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrew Klotz <agc.klotz@gmail.com>

Currently invalid boolean config values return messages about 'bad
numeric', which is slightly misleading when the error was due to a
boolean value. We can improve the developer experience by returning a
boolean error message when we know the value is neither a bool text or
int.

before with an invalid boolean value of `non-boolean`, its unclear what
numeric is referring to:
  fatal: bad numeric config value 'non-boolean' for 'commit.gpgsign': invalid unit

now the error message mentions `non-boolean` is a bad boolean value:
  fatal: bad boolean config value 'non-boolean' for 'commit.gpgsign'

Signed-off-by: Andrew Klotz <agc.klotz@gmail.com>
---
    config: improve error message for boolean config
    
    Currently invalid boolean config values return messages about 'bad
    numeric', which I found misleading when the error was due to a boolean
    string value. This change makes the error message reflect the boolean
    value.
    
    The current approach relies on GIT_TEST_GETTEXT_POISON being a boolean
    value, moving its special case out from die_bad_number() and into
    git_config_bool_or_int(). An alternative could be for die_bad_number()
    to handle boolean values when erroring, although the function name might
    need to change if it is handling non-numeric values.
    
    changes since v1
    
     * moved boolean error message change out of git_config_bool_or_int to
       just in git_config_bool and added die_bad_boolean instead of
       modifying die_bad_number.
    
    changes since v2
    
     * added a test for boolean config values
     * changed the condition to hit die_bad_bool from if (0 <= v) to if (v <
       0)
     * removed change in get-text-poison.sh test
    
    Signed-off-by: Andrew Klotz agc.klotz@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-841%2FKlotzAndrew%2Fbetter_bool_errors-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-841/KlotzAndrew/better_bool_errors-v3
Pull-Request: https://github.com/git/git/pull/841

Range-diff vs v2:

 1:  32dd4ee1e373 ! 1:  45a51e18c1d3 config: improve error message for boolean config
     @@ Commit message
      
          before with an invalid boolean value of `non-boolean`, its unclear what
          numeric is referring to:
     -    ```
     -    fatal: bad numeric config value 'non-boolean' for 'commit.gpgsign': invalid unit
     -    ```
     +      fatal: bad numeric config value 'non-boolean' for 'commit.gpgsign': invalid unit
      
          now the error message mentions `non-boolean` is a bad boolean value:
     -    ```
     -    fatal: bad boolean config value 'non-boolean' for 'commit.gpgsign'
     -    ```
     +      fatal: bad boolean config value 'non-boolean' for 'commit.gpgsign'
      
          Signed-off-by: Andrew Klotz <agc.klotz@gmail.com>
      
     @@ config.c: int git_config_bool_or_int(const char *name, const char *value, int *i
      -	int discard;
      -	return !!git_config_bool_or_int(name, value, &discard);
      +	int v = git_parse_maybe_bool(value);
     -+	if (0 <= v)
     -+		return v;
     -+	else
     ++	if (v < 0)
      +		die_bad_bool(name, value);
     ++	return v;
       }
       
       int git_config_string(const char **dest, const char *var, const char *value)
      
     - ## t/t0205-gettext-poison.sh ##
     -@@ t/t0205-gettext-poison.sh: test_expect_success 'eval_gettext: our eval_gettext() fallback has poison semant
     - 
     - test_expect_success "gettext: invalid GIT_TEST_GETTEXT_POISON value doesn't infinitely loop" "
     - 	test_must_fail env GIT_TEST_GETTEXT_POISON=xyz git version 2>error &&
     --	grep \"fatal: bad numeric config value 'xyz' for 'GIT_TEST_GETTEXT_POISON': invalid unit\" error
     -+	grep \"fatal: bad boolean config value 'xyz' for 'GIT_TEST_GETTEXT_POISON'\" error
     - "
     + ## t/t1300-config.sh ##
     +@@ t/t1300-config.sh: test_expect_success 'invalid unit' '
     + 	test_i18ngrep "bad numeric config value .1auto. for .aninvalid.unit. in file .git/config: invalid unit" actual
     + '
       
     - test_done
     ++test_expect_success 'invalid unit boolean' '
     ++	git config commit.gpgsign "1true" &&
     ++	test_cmp_config 1true commit.gpgsign &&
     ++	test_must_fail git config --bool --get commit.gpgsign 2>actual &&
     ++	test_i18ngrep "bad boolean config value .1true. for .commit.gpgsign." actual
     ++'
     ++
     + test_expect_success 'line number is reported correctly' '
     + 	printf "[bool]\n\tvar\n" >invalid &&
     + 	test_must_fail git config -f invalid --path bool.var 2>actual &&


 config.c          | 20 ++++++++++++++++++--
 t/t1300-config.sh |  7 +++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index b922b4f28572..f90b633dba21 100644
--- a/config.c
+++ b/config.c
@@ -1180,6 +1180,20 @@ static void die_bad_number(const char *name, const char *value)
 	}
 }
 
+NORETURN
+static void die_bad_bool(const char *name, const char *value)
+{
+	if (!strcmp(name, "GIT_TEST_GETTEXT_POISON"))
+		/*
+		 * We explicitly *don't* use _() here since it would
+		 * cause an infinite loop with _() needing to call
+		 * use_gettext_poison().
+		 */
+		die("bad boolean config value '%s' for '%s'", value, name);
+	else
+		die(_("bad boolean config value '%s' for '%s'"), value, name);
+}
+
 int git_config_int(const char *name, const char *value)
 {
 	int ret;
@@ -1252,8 +1266,10 @@ int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 
 int git_config_bool(const char *name, const char *value)
 {
-	int discard;
-	return !!git_config_bool_or_int(name, value, &discard);
+	int v = git_parse_maybe_bool(value);
+	if (v < 0)
+		die_bad_bool(name, value);
+	return v;
 }
 
 int git_config_string(const char **dest, const char *var, const char *value)
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 936d72041bab..e0dd5d65ceda 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -675,6 +675,13 @@ test_expect_success 'invalid unit' '
 	test_i18ngrep "bad numeric config value .1auto. for .aninvalid.unit. in file .git/config: invalid unit" actual
 '
 
+test_expect_success 'invalid unit boolean' '
+	git config commit.gpgsign "1true" &&
+	test_cmp_config 1true commit.gpgsign &&
+	test_must_fail git config --bool --get commit.gpgsign 2>actual &&
+	test_i18ngrep "bad boolean config value .1true. for .commit.gpgsign." actual
+'
+
 test_expect_success 'line number is reported correctly' '
 	printf "[bool]\n\tvar\n" >invalid &&
 	test_must_fail git config -f invalid --path bool.var 2>actual &&

base-commit: c6102b758572c7515f606b2423dfe38934fe6764
-- 
gitgitgadget
