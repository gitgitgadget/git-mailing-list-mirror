Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE0471FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 00:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757556AbcLCAbg (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 19:31:36 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36316 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756682AbcLCAax (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 19:30:53 -0500
Received: by mail-pg0-f50.google.com with SMTP id f188so112441076pgc.3
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 16:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mRl7yykuIcnXZxsqAob273SSruNplcLOY/wtlc4182g=;
        b=WLjj6KdAW/5FfbtOmzEO8G93u9MzvkmNgzDJm5mwJTklswqpvaENas8NQpntLEHYCo
         3swXh9wJJCxaTiNPrYdoxfqbzWf8Pv22pQDrMEMJs4HkJQj4NNstTJRO5TpmVygG1um6
         ncubkqV/NeHq1w8A91ExMQysJnBKQah035kSviqwcI9MFXVu6kBM4ne7/LPIWedyx7SG
         jfr0tZxlGeJhWAiN/vkVQvtr08SSH1SBI0afUD/GEObO+cGWQDMkxbcOysHTls1ZMq42
         1gpvAWAt+ZIvewm+F0F1E6gnKYBeIRhdnB7/y3y10zfPFz0dnRwg6R2hJi3rf4PucqDR
         1TLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mRl7yykuIcnXZxsqAob273SSruNplcLOY/wtlc4182g=;
        b=b3KpIEl519zJ6PO+KTqVwpyePYYc0InH8qjoabFpFQg0IzJPCRuXWT/AN7DuuSUkqt
         MucwtFiLLSgN++bkF7r63frmicD/V7rilGK0FAlR39UKBrnI/r4FyIeLsln8mTBsO/6b
         hU5VJSwptkpQZ3hG0wn5IXWwxPHkPHM9R04eH7vzdsNZ77YdldAbV3/kSs/g2BYUg81I
         0T/gC/7BI816rcclvw0J/9KMk0wYb0zA5TO2jgdqlnrXEK7dQJx4UdVdC+9xlCyK1XTJ
         EEB/KFT5QXepgN5bdF+7eMfUEpABOW9wSumd7KVfn8jcGPA/HNIcwDKCFDBUHH1axUd+
         wEzQ==
X-Gm-Message-State: AKaTC01ZKTX4tPBP8bzZ5UKejkohB2ADMaIUgk9A1ivQojawL9HN8oTqS1qurmXVXP6WArhs
X-Received: by 10.84.140.133 with SMTP id 5mr99807653plt.76.1480725052875;
        Fri, 02 Dec 2016 16:30:52 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id y89sm10150463pfk.83.2016.12.02.16.30.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 16:30:52 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, David.Turner@twosigma.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        hvoigt@hvoigt.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFC PATCHv2 17/17] checkout: add config option to recurse into submodules by default
Date:   Fri,  2 Dec 2016 16:30:22 -0800
Message-Id: <20161203003022.29797-18-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2673dad
In-Reply-To: <20161203003022.29797-1-sbeller@google.com>
References: <20161203003022.29797-1-sbeller@google.com>
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
 t/t2013-checkout-submodule.sh  | 16 ++++++++++++++++
 4 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a0ab66aae7..67e0714358 100644
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
index a0ea2c5651..819c430b6e 100644
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
index 4253f7f044..e4e326bce4 100644
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
index 33fb2f5de3..673021fb80 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -137,6 +137,22 @@ test_expect_success '"checkout --recurse-submodules" repopulates submodule' '
 	submodule_creation_must_succeed delete_submodule base
 '
 
+test_expect_success 'option checkout.recurseSubmodules updates submodule' '
+	test_config checkout.recurseSubmodules 1 &&
+	git checkout base &&
+	git checkout -b advanced-base &&
+	git -C submodule commit --allow-empty -m "empty commit" &&
+	git add submodule &&
+	git commit -m "advance submodule" &&
+	git checkout base &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached base &&
+	git checkout advanced-base &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached advanced-base &&
+	git checkout --recurse-submodules base
+'
+
 test_expect_success '"checkout --recurse-submodules" repopulates submodule in existing directory' '
 	git checkout --recurse-submodules delete_submodule &&
 	mkdir submodule &&
-- 
2.11.0.rc2.28.g2673dad

