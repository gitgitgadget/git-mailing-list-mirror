Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B13152022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751500AbdBWXtH (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:49:07 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33047 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbdBWXs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:48:58 -0500
Received: by mail-pf0-f179.google.com with SMTP id 2so496632pfz.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ErrLYTxJRbRKMOGwMoMlQ/KngXbgGGCQT7xwcZFSAC4=;
        b=ozDzojQEAG0wzC8sNoocbxStDbQq6ABmsdXr5BDIsffQcYMWT12KHBXRcXbFI06WBG
         LKqThsA+kQY9MBdAugUzYFWzzMTNVwGSWG+bRmkLiArXbcHW+Ws33cdIWXhcPFAVxbPk
         Ve1XDJBT9PvTWRfF8x9e3bkbcWGlIryif62k8WV1IKGYbeDE2rhQtye6e0Ud6TEFR114
         0RTekfijC91JO5yOcG7xamIxWumg8YaU33yNgb51o5kJb14rmMJy37aTtbfyPSzR3Xd8
         uU7fYB8YYJTE8gLBgNbyGXV214566U0roIzlq0Z//yCVfITdkvc0qNaGXv3mdHRapqoa
         TauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ErrLYTxJRbRKMOGwMoMlQ/KngXbgGGCQT7xwcZFSAC4=;
        b=TV2o0KA1E8YF9Iy7BwSlBZbaRZRvUTDXAfxCSNlXbQvcVkxZI4VkIhzxhKc4v/zzsY
         6hxUMe55a4xhBQUWdaTkT+2RZttlRvE6Tg8vFBiQVbWo7Vs1Fibp7uxEiVy3fw4xUpxt
         U+GNMNv/krdgx7IFtpQ3c+fEmmADu9+rym+HxE88xjOG9uGScOIwzLce6IEpEJD8Lhzj
         MAwImGscQ5z4Y78tZsCUUvtnJXbZY0kzYsq2X5VdKR+OQoUooZ/ok26W2pRTAucM9rOY
         oi/UNoFVXcmVWPQJSQbNfb+T8s+4p828D8mwq6CmIqsl2KOuE6dS8Sd434uS9jCFGWiK
         nmyQ==
X-Gm-Message-State: AMke39moHJ8CjWmUQh93lgWFAjx9ejNYZeTHZGjJ0zKQdfaY/Bjn/78+RpWvIimSC+lmxkzY
X-Received: by 10.84.174.4 with SMTP id q4mr49480685plb.35.1487893672032;
        Thu, 23 Feb 2017 15:47:52 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id r74sm11660300pfb.67.2017.02.23.15.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 15:47:50 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 09/10] submodule sync: use submodule--helper is-active
Date:   Thu, 23 Feb 2017 15:47:27 -0800
Message-Id: <20170223234728.164111-10-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170223234728.164111-1-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 02b85dceb..f35345775 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1127,7 +1127,7 @@ cmd_sync()
 			;;
 		esac
 
-		if git config "submodule.$name.url" >/dev/null 2>/dev/null
+		if git submodule--helper is-active "$sm_path"
 		then
 			displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
 			say "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"
-- 
2.11.0.483.g087da7b7c-goog

