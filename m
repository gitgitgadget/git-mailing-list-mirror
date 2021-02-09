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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D12C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 01:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B203D6023B
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 01:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhBIBZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 20:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhBIBZx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 20:25:53 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44CDC061788
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 17:25:12 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m1so1011256wml.2
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 17:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r2BIuKYkt+BfTzofOmH7P5WZtBcUxoG76hKeBRXyf1c=;
        b=l2Ch10IgJDxrIw/150IpHK2OHdCu9RYedk3zZhGKmRFTGqKcCtGRwIs8eRBeGuyA0+
         n5z0qajuL65z2jKurWLEqDySTaFq5Iosl9XF7NxBK2yYufjnxzdgyLpsA8/jzxVXwh4Y
         cossvNKfBtNjNp2cNJjtoPslQCjPOWNI1Qo6QgSzOTOfcRvDn7iSCwg+S/PXzidsBPxy
         IXXDS5Yp6pjABi+Yop3btjaKc1k3zagpyTsZ4uYeNT0NpEXu23L4LKS/gP6FKb/rmfsB
         K8E5cU5O1jxxdRew3VQVFP9dQMvDIqFanRoL5NKlAl1VhAs/4cEHIf1QgF5xgsJ1VKy1
         S2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r2BIuKYkt+BfTzofOmH7P5WZtBcUxoG76hKeBRXyf1c=;
        b=ikuwckUiUqKZ3vJkfppEJkY8g+pPVHoI+gg+9TjMvx0Smb2RqMskBL1y7G3GfdBeI7
         jpQG+4pQj47/efr3QFw6BgPjTrV+JFvhiSyHP/+c59GG/UezA/BjSo5Ch3nEAEbY0Lom
         pAN1XZxy9psYhaKeEgi/5VgDJRQrY+jxjWAMcvpFXA1UirIniWrdH+SrcVfzSPstodAL
         sBr9ZfWQQziEsz7vOaDKCzDVwYmNK8vg8jUIV5pYyWyTIk3R2bFYVeUnguWn8kSrRpgq
         LUveKXnejqAfgCHZ47ZqwBBdEBdjeXttQZb9BrqwMMzZdRbSgdD+eFFEPx5D5QBzWKs4
         nuGA==
X-Gm-Message-State: AOAM533mkalhCB9zOwHXvlcj2UZ/dxYQCX9qCYRmLqxQcRsXNw4jjeCa
        pLUY/D8Lh7zqNA5qo0WkV/+nCGaL0eI=
X-Google-Smtp-Source: ABdhPJxgHZtCHoDQWPwopwlfLnyVIun/rGQ98/HvBJX7e7b2SV5AfLUb11VGkl2s2iGQCiuHua8hDg==
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr1145414wmj.126.1612833911359;
        Mon, 08 Feb 2021 17:25:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm1449481wmq.7.2021.02.08.17.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 17:25:10 -0800 (PST)
Message-Id: <pull.841.v2.git.git.1612833909210.gitgitgadget@gmail.com>
In-Reply-To: <pull.841.git.git.1600395427.gitgitgadget@gmail.com>
References: <pull.841.git.git.1600395427.gitgitgadget@gmail.com>
From:   "Andrew Klotz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Feb 2021 01:25:08 +0000
Subject: [PATCH v2] config: improve error message for boolean config
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
```
fatal: bad numeric config value 'non-boolean' for 'commit.gpgsign': invalid unit
```

now the error message mentions `non-boolean` is a bad boolean value:
```
fatal: bad boolean config value 'non-boolean' for 'commit.gpgsign'
```

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
    
    Signed-off-by: Andrew Klotz agc.klotz@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-841%2FKlotzAndrew%2Fbetter_bool_errors-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-841/KlotzAndrew/better_bool_errors-v2
Pull-Request: https://github.com/git/git/pull/841

Range-diff vs v1:

 1:  689d84672422 ! 1:  32dd4ee1e373 config: improve error message for boolean config
     @@ Commit message
          boolean error message when we know the value is neither a bool text or
          int.
      
     -    `GIT_TEST_GETTEXT_POISON` is a boolean so we no longer fail on
     -    evaluating it as an int in `git_config_int`. Because of that we can
     -    move the special translation case into the boolean config check where
     -    we are now failing with an updated message
     -
          before with an invalid boolean value of `non-boolean`, its unclear what
          numeric is referring to:
          ```
     @@ Commit message
      
       ## config.c ##
      @@ config.c: static void die_bad_number(const char *name, const char *value)
     - 	if (!value)
     - 		value = "";
     - 
     --	if (!strcmp(name, "GIT_TEST_GETTEXT_POISON"))
     --		/*
     --		 * We explicitly *don't* use _() here since it would
     --		 * cause an infinite loop with _() needing to call
     --		 * use_gettext_poison(). This is why marked up
     --		 * translations with N_() above.
     --		 */
     --		die(bad_numeric, value, name, error_type);
     --
     - 	if (!(cf && cf->name))
     - 		die(_(bad_numeric), value, name, _(error_type));
     - 
     -@@ config.c: int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
     - 		return v;
       	}
     - 	*is_bool = 0;
     --	return git_config_int(name, value);
     -+	if (git_parse_int(value, &v))
     -+		return v;
     -+
     + }
     + 
     ++NORETURN
     ++static void die_bad_bool(const char *name, const char *value)
     ++{
      +	if (!strcmp(name, "GIT_TEST_GETTEXT_POISON"))
      +		/*
      +		 * We explicitly *don't* use _() here since it would
     @@ config.c: int git_config_bool_or_int(const char *name, const char *value, int *i
      +		die("bad boolean config value '%s' for '%s'", value, name);
      +	else
      +		die(_("bad boolean config value '%s' for '%s'"), value, name);
     - }
     ++}
     ++
     + int git_config_int(const char *name, const char *value)
     + {
     + 	int ret;
     +@@ config.c: int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
       
       int git_config_bool(const char *name, const char *value)
     + {
     +-	int discard;
     +-	return !!git_config_bool_or_int(name, value, &discard);
     ++	int v = git_parse_maybe_bool(value);
     ++	if (0 <= v)
     ++		return v;
     ++	else
     ++		die_bad_bool(name, value);
     + }
     + 
     + int git_config_string(const char **dest, const char *var, const char *value)
      
       ## t/t0205-gettext-poison.sh ##
      @@ t/t0205-gettext-poison.sh: test_expect_success 'eval_gettext: our eval_gettext() fallback has poison semant
 2:  1e9caf1911d3 < -:  ------------ formatting for error messages


 config.c                  | 21 +++++++++++++++++++--
 t/t0205-gettext-poison.sh |  2 +-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 4c0cf3a1c15d..5e4fd6b5561b 100644
--- a/config.c
+++ b/config.c
@@ -1030,6 +1030,20 @@ static void die_bad_number(const char *name, const char *value)
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
@@ -1102,8 +1116,11 @@ int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 
 int git_config_bool(const char *name, const char *value)
 {
-	int discard;
-	return !!git_config_bool_or_int(name, value, &discard);
+	int v = git_parse_maybe_bool(value);
+	if (0 <= v)
+		return v;
+	else
+		die_bad_bool(name, value);
 }
 
 int git_config_string(const char **dest, const char *var, const char *value)
diff --git a/t/t0205-gettext-poison.sh b/t/t0205-gettext-poison.sh
index f9fa16ad8363..b66d34c6f2bc 100755
--- a/t/t0205-gettext-poison.sh
+++ b/t/t0205-gettext-poison.sh
@@ -33,7 +33,7 @@ test_expect_success 'eval_gettext: our eval_gettext() fallback has poison semant
 
 test_expect_success "gettext: invalid GIT_TEST_GETTEXT_POISON value doesn't infinitely loop" "
 	test_must_fail env GIT_TEST_GETTEXT_POISON=xyz git version 2>error &&
-	grep \"fatal: bad numeric config value 'xyz' for 'GIT_TEST_GETTEXT_POISON': invalid unit\" error
+	grep \"fatal: bad boolean config value 'xyz' for 'GIT_TEST_GETTEXT_POISON'\" error
 "
 
 test_done

base-commit: 66e871b6647ffea61a77a0f82c7ef3415f1ee79c
-- 
gitgitgadget
