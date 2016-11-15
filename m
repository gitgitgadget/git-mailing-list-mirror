Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43A492021E
	for <e@80x24.org>; Tue, 15 Nov 2016 23:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753578AbcKOXMU (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 18:12:20 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36715 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbcKOXMT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 18:12:19 -0500
Received: by mail-pg0-f41.google.com with SMTP id f188so71413246pgc.3
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 15:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nxEzzh9Rt+Sy+nFQUFVspJ0GUTueJd5qPLQ+6b7e1IM=;
        b=WqPehVM97d/5LYQDAZOPu1FidQ8sERqeNvKEbcrBv09OQrb+kIXRQwQTTeSGfTBSez
         mN6fXfoOssZw9/vIDC3vQRcdRyGsyutupJFEBKCH/Ad1SqO+EKAoALbHQ2n8acrBXRkX
         RqB9zKF3Et7MLjVL6ZVFB62jE/zeuavtmYVC00YnYvu3bP8AEpj4aPr1iR/ELpa32ki3
         LDfXhde33TRykBBKMUl37DuDmDqb51f/bLWgVfSS6Pt2HwL/Z0M0vqrvEW6hVAtOyiE2
         In3JUOXCIx46qH6hWcHFr6qJrm2kp+Up3kolE8DONjqhgq37CZYdZmxKJL7QjJysBKyk
         zvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nxEzzh9Rt+Sy+nFQUFVspJ0GUTueJd5qPLQ+6b7e1IM=;
        b=S2KHjUUlwipW+CBQYGKCZ5E+9V8xat1O2YyqzP8Ecca5TVV3CYZ20D3FI5v/aWr1pz
         mIggLcXNlbWqaTRww6eOhMXOs9wtiJcY6uBRmhmh+19cM/qPdZthyU/Ehc9yyzoGgDWu
         yQNQ2KzvBCK4L/nUy1M1twLGDTEyJWVEy3G2NXPy3ipPccfCMu768TbgyAzfDWPyTHoq
         KHhSUuUTkq8YIVmEBkVyml1W4CSffb0/4/mgHvC8Fh0fNOJlXWNC3xoyp6giYXxipThf
         amGhGHu9QA9hsnKOMIb0ZdZ5jQJi4X91zdNvEWRHPAAJACGncW9HGN4/gCWv2Z2rv4r2
         TkRg==
X-Gm-Message-State: ABUngveK0BRxv3h6C2zEYQXbuqj5ilXsl3/a73Xy0Gfc1AqG/tUeLtnVNkNPiW1Gti4HWOY9
X-Received: by 10.98.24.136 with SMTP id 130mr62953pfy.73.1479251232983;
        Tue, 15 Nov 2016 15:07:12 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:1161:a721:e128:bf5f])
        by smtp.gmail.com with ESMTPSA id d29sm29915736pfk.78.2016.11.15.15.07.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 15:07:12 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        jrnieder@gmail.com, mogulguy10@gmail.com,
        David.Turner@twosigma.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 16/16] checkout: add config option to recurse into submodules by default
Date:   Tue, 15 Nov 2016 15:06:51 -0800
Message-Id: <20161115230651.23953-17-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161115230651.23953-1-sbeller@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To make it easier for the user, who doesn't want to give the
`--recurse-submodules` option whenever they run checkout, have an
option for to set the default behavior for checkout to recurse into
submodules.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt       |  6 ++++++
 Documentation/git-checkout.txt |  5 +++--
 submodule.c                    |  6 +++---
 t/t2013-checkout-submodule.sh  | 19 +++++++++++++++++++
 4 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a0ab66a..67e0714 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -949,6 +949,12 @@ clean.requireForce::
 	A boolean to make git-clean do nothing unless given -f,
 	-i or -n.   Defaults to true.
 
+checkout.recurseSubmodules::
+	This option can be set to a boolean value.
+	When set to true checkout will recurse into submodules and
+	update them. When set to false, which is the default, checkout
+	will leave submodules untouched.
+
 color.branch::
 	A boolean to enable/disable color in the output of
 	linkgit:git-branch[1]. May be set to `always`,
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index a0ea2c5..819c430 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -260,8 +260,9 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 	Using --recurse-submodules will update the content of all initialized
 	submodules according to the commit recorded in the superproject. If
 	local modifications in a submodule would be overwritten the checkout
-	will fail until `-f` is used. If nothing (or --no-recurse-submodules)
-	is used, the work trees of submodules will not be updated.
+	will fail until `-f` is used. If `--no-recurse-submodules` is used,
+	the work trees of submodules will not be updated. If no command line
+	argument is given, `checkout.recurseSubmodules` is used as a default.
 
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
diff --git a/submodule.c b/submodule.c
index 2149ef7..0c807d9 100644
--- a/submodule.c
+++ b/submodule.c
@@ -160,10 +160,10 @@ int submodule_config(const char *var, const char *value, void *cb)
 		return 0;
 	} else if (starts_with(var, "submodule."))
 		return parse_submodule_config_option(var, value);
-	else if (!strcmp(var, "fetch.recursesubmodules")) {
+	else if (!strcmp(var, "fetch.recursesubmodules"))
 		config_fetch_recurse_submodules = parse_fetch_recurse_submodules_arg(var, value);
-		return 0;
-	}
+	else if (!strcmp(var, "checkout.recursesubmodules"))
+		config_update_recurse_submodules = parse_update_recurse_submodules_arg(var, value);
 	return 0;
 }
 
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index 60f6987..788c59d 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -149,6 +149,25 @@ test_expect_success '"checkout --recurse-submodules" repopulates submodule' '
 	)
 '
 
+test_expect_success 'option checkout.recurseSubmodules updates submodule' '
+	test_config -C super checkout.recurseSubmodules 1 &&
+	(
+		cd super &&
+		git checkout base &&
+		git checkout -b advanced-base &&
+		git -C submodule commit --allow-empty -m "empty commit" &&
+		git add submodule &&
+		git commit -m "advance submodule" &&
+		git checkout base &&
+		git diff-files --quiet &&
+		git diff-index --quiet --cached base &&
+		git checkout advanced-base &&
+		git diff-files --quiet &&
+		git diff-index --quiet --cached advanced-base &&
+		git checkout --recurse-submodules base
+	)
+'
+
 test_expect_success '"checkout --recurse-submodules" repopulates submodule in existing directory' '
 	(
 		cd super &&
-- 
2.10.1.469.g00a8914

