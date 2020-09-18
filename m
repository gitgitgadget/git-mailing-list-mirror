Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00597C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 02:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B695B23718
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 02:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsiLZoEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbgIRCWb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbgIRCRL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 22:17:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99554C061756
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:17:10 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k18so3944337wmj.5
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f1AcX2qbBwFu0+6E1VBs+9CybYDYaX0KVAmi/fzJiOc=;
        b=JsiLZoEo0EFMHzupOFXVc9wsQbxooQEWf1fPMZRfYz3Bq2uqNhoFFmHxenH5vjuY1M
         RKkTNHYhC57qj+kU+g6bOQSTrNb2KC8to1Ad/y9fWfHEebfwt/1Edyf5VGileFjlzqrO
         S1S+3P4b/Hq1hVIppTApiMyDZTx/sjUtCuAye+7b4EO+SH1xMYIQAuVltiW32EfiDgyO
         1OrUmomCSKeeDlDKp6nwPQ64bnUThesCTL6cuD2OYR979pqFdqU6PoR1Qp7jeNIJhSra
         jRNbiK78sBi0F63xiF8GAMNnb/hNomZl0wBiPFEWeTwJ4iCABwxTKWSft+a4pgbzF1q9
         fPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f1AcX2qbBwFu0+6E1VBs+9CybYDYaX0KVAmi/fzJiOc=;
        b=c1UlgaA09K28wNwUdUW0Yl0G6pA8+LB+36wtyPDz+oyfocPN+AOW8482MFItUsMuVP
         4D65VcVx4AYhQYjCSKqrzVJCnLtOckcYg8HdM7Gxps2fNiMykG50Y/2vQ1/6r9t+P/Y2
         CxbfsEWnVvSKrAj6EE6mamGM9YUd/xTW06dzlW6IsPhs7mezTdmebMXVxNkCyaorWHRR
         +wGKf+Kw72bjU6YVzgbCIUO4niV5os+qxG2SBlr4ZCVdkR/fk3j36dCCho4FkmyFo3Vo
         JUzDNwxc7HgI5XZKa9ZV1/uc8xok3Bwc2RxRi1C8M5BKx9KYe7/AIcNnBQNEX3UzdK8f
         MIeg==
X-Gm-Message-State: AOAM531cd9Klx7G7loMP++10g6PSFzK8rgCAT+3tXj43o3hIbSwT1CZ7
        RUN4Gvt18e/3K8SotOLPbF1kvnF2fPw=
X-Google-Smtp-Source: ABdhPJzRhdeoVF5Oss81TdVqHQ07qkKEtyQqnW5AgoJYUGvg5V2eqv+/Lll5RAKAMXZ1fUUrUspUww==
X-Received: by 2002:a1c:610b:: with SMTP id v11mr13335411wmb.181.1600395429179;
        Thu, 17 Sep 2020 19:17:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v204sm2238925wmg.20.2020.09.17.19.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 19:17:08 -0700 (PDT)
Message-Id: <689d84672422dd96d1eb89ea6137e79ce4030248.1600395427.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.841.git.git.1600395427.gitgitgadget@gmail.com>
References: <pull.841.git.git.1600395427.gitgitgadget@gmail.com>
From:   "Andrew Klotz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Sep 2020 02:17:06 +0000
Subject: [PATCH 1/2] config: improve error message for boolean config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrew Klotz <agc.klotz@gmail.com>,
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

`GIT_TEST_GETTEXT_POISON` is a boolean so we no longer fail on
evaluating it as an int in `git_config_int`. Because of that we can
move the special translation case into the boolean config check where
we are now failing with an updated message

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
 config.c                  | 22 ++++++++++++----------
 t/t0205-gettext-poison.sh |  2 +-
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/config.c b/config.c
index 2bdff4457b..198d0d3216 100644
--- a/config.c
+++ b/config.c
@@ -996,15 +996,6 @@ static void die_bad_number(const char *name, const char *value)
 	if (!value)
 		value = "";
 
-	if (!strcmp(name, "GIT_TEST_GETTEXT_POISON"))
-		/*
-		 * We explicitly *don't* use _() here since it would
-		 * cause an infinite loop with _() needing to call
-		 * use_gettext_poison(). This is why marked up
-		 * translations with N_() above.
-		 */
-		die(bad_numeric, value, name, error_type);
-
 	if (!(cf && cf->name))
 		die(_(bad_numeric), value, name, _(error_type));
 
@@ -1097,7 +1088,18 @@ int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 		return v;
 	}
 	*is_bool = 0;
-	return git_config_int(name, value);
+	if (git_parse_int(value, &v))
+		return v;
+
+	if (!strcmp(name, "GIT_TEST_GETTEXT_POISON"))
+		/*
+		 * We explicitly *don't* use _() here since it would
+		 * cause an infinite loop with _() needing to call
+		 * use_gettext_poison().
+		 */
+		die("bad boolean config value '%s' for '%s'", value, name);
+	else
+		die(_("bad boolean config value '%s' for '%s'"), value, name);
 }
 
 int git_config_bool(const char *name, const char *value)
diff --git a/t/t0205-gettext-poison.sh b/t/t0205-gettext-poison.sh
index f9fa16ad83..b66d34c6f2 100755
--- a/t/t0205-gettext-poison.sh
+++ b/t/t0205-gettext-poison.sh
@@ -33,7 +33,7 @@ test_expect_success 'eval_gettext: our eval_gettext() fallback has poison semant
 
 test_expect_success "gettext: invalid GIT_TEST_GETTEXT_POISON value doesn't infinitely loop" "
 	test_must_fail env GIT_TEST_GETTEXT_POISON=xyz git version 2>error &&
-	grep \"fatal: bad numeric config value 'xyz' for 'GIT_TEST_GETTEXT_POISON': invalid unit\" error
+	grep \"fatal: bad boolean config value 'xyz' for 'GIT_TEST_GETTEXT_POISON'\" error
 "
 
 test_done
-- 
gitgitgadget

