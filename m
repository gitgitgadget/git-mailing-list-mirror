Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAAFC433EF
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 00:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379342AbiFQAUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 20:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379291AbiFQAUr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 20:20:47 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4BD6339C
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 17:20:44 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f8so2540917plo.9
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 17:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1mqh/Omx9B3AqQ74nJFiXcowOTYVbPp2rDfld65dSt8=;
        b=YzAnU5+Y5ZJ/Fl02Ly6//XwI9wzwS37UqolTZ8yYa3NvbspYb9PeWeDkwiJSAQqHn2
         AIB90SdjaaKNyfpM0NH9l/WCX3A6DFcG3vCn9W9hTyQIrQptu0iQxwicuhddXgEkFO+G
         Lfx5dgjExFwlN1fMQGofpvKNh2SWcxLOa4WiJCwgk2XPVFSFF+/WoFXiAxKYTplx+4mu
         8BMYbsi6SY2cfb+UAMnuatt5HqA+CMhQ4It2f+sUC9UC9TJ5UFDpN2Ta9ufYmkfB+49B
         IpksYEemvdGZEVvgkpYPvDFSjNHatjWoDv8w6tAqctp/+jnONX1k5qX4mk9bA3LQORZd
         /uXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1mqh/Omx9B3AqQ74nJFiXcowOTYVbPp2rDfld65dSt8=;
        b=UYfvzMcByX6d1TQiRT96BFRYRU4dAhp6P+394PX9X/WRyaggIjgz8Jteeosh8s+4/m
         dCpxuqs4hNaMVfe4CfL65N1HzSU9zZ9hAl+Ywp0gPyroDl6XLU3coUPaei34Kq4l7t+H
         Dvx+QqlgWS/VKXOAnfS9x/eKBkhQpj2lPG+uAQJqwmPRnLSBIrGBO/iH2x0ofNcfkS6J
         lAWlNrU//DO9iDyjCN1r59jVAHgme9Is8PkOoVBnEormF5SCeeEx9XZAETdFL6cJsTbf
         9OBgREI5HxEnHBLG1h+sel3nWvTGhdXCXgsrUMfX1FTzPfFEsyxybHnHKQqqjp0l+qGb
         BiMA==
X-Gm-Message-State: AJIora9a16m2tWgPuVRBFUPz9s5bHXivVHpcSgbykmdyASVIe/UxHrRU
        8nMr91Mb1PJxFuCcw3M8vY38Bj6P2oc=
X-Google-Smtp-Source: AGRyM1ttXX7UcOwEH2dJ1O1l8hIPJT2PGCLeZek70Fih7C9wKt5qHJlqhvaegK2ZWtHBJN74oF2BZg==
X-Received: by 2002:a17:90a:e643:b0:1ea:f354:3fb4 with SMTP id ep3-20020a17090ae64300b001eaf3543fb4mr5121084pjb.53.1655425244099;
        Thu, 16 Jun 2022 17:20:44 -0700 (PDT)
Received: from JEKELLER-HOME.localdomain ([50.39.231.65])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090301c100b001663165eb16sm2260623plh.7.2022.06.16.17.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 17:20:43 -0700 (PDT)
From:   Jacob Keller <jacob.keller@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3 6/6] remote: add test for negative refspec with prune
Date:   Thu, 16 Jun 2022 17:20:36 -0700
Message-Id: <20220617002036.1577-7-jacob.keller@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220617002036.1577-1-jacob.keller@gmail.com>
References: <20220617002036.1577-1-jacob.keller@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git remote prune does not handle negative refspecs properly. If a
negative refspec got added after a fetch, a user may expect that the
resulting refs that were previously fetched would now be considered
stale, and thus removed by git remote prune. Show that this isn't the
case with a new test case.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 t/t5505-remote.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 8cad753023ef..0810e7d8d0b7 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -399,6 +399,19 @@ test_expect_success 'prune --dry-run' '
 	test_cmp expect output
 '
 
+cat >expect <<EOF
+Pruning origin
+URL: $(pwd)/one
+ * [would prune] origin/side2
+EOF
+
+test_expect_failure 'prune --dry-run negative refspec' '
+	test_config -C test --add remote.origin.fetch ^refs/heads/side2 &&
+	git -C test remote prune --dry-run origin >output &&
+	git -C test rev-parse refs/remotes/origin/side2 &&
+	test_cmp expect output
+'
+
 test_expect_success 'add --mirror && prune' '
 	mkdir mirror &&
 	git -C mirror init --bare &&
-- 
2.36.1

