Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 556911F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 12:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfHMM1Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 08:27:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36250 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbfHMM1N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 08:27:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so13836329wrt.3
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 05:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5GAZQfyOKiZ5snJgFv3wwkBIVmAMGvSCBoSJ4Dpkxk=;
        b=eBMrgbIXp/qLS+bphcNlSmtQlV6ARvDsHct4smkMwXHXRPVQb1GsrLlQoOlJzF14XS
         dg1EJTW0+ou9baokRjaiTLABkY5XCNwmAWAWddM0vkuun4NY6aTEgvwj1+PwKB3nfXhj
         Kb7AvpgjMDb3itgi96IaRTFJxT82PJwXqAdnES8H/xBlKCErnW5GgAQp11T2NlHcnJWi
         OSvmqnsT9a+Sare/tx56wnbfSDYBz+wm4jmFp1af2LDmRhlgJEOciaePuMzhCTGGAlcs
         8hCrQeYLSENox+kCIzz8K2cHLW87zx+kWap/iSXDMqimrXiIFIZAVrLuoFTiwYGggQV3
         +0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5GAZQfyOKiZ5snJgFv3wwkBIVmAMGvSCBoSJ4Dpkxk=;
        b=McY+ndVFx/IXh4tMN7sRk+H5pJLj4uvUAdQR4MMBcjH97yEo7S7ry94rKz9GTy2oid
         LpaSwIz8TO/ej8z2rbta8cNqgdvycrvfdQdGQbKmO6seWhQemoPLpjzny1lL1gLZJeRW
         RPCfbNvd28/xMhj/ps0dgXCMmQSoPiMA/2UkFwE8RICVKZjcvjGO2LtkfQz3I4GeP081
         GQvdkC8Y4xbIIlZ4UMgVC+pHYURcl5PAkQ6XoRs2mdQ5KH9pHkJ5Tye8XdccD1NFbv92
         CbhWWShrmBRLHC35Bv2FFAyq2PWfcjC1PDmmaR9Cb84+gDGlp+fCnUm9jn6Ph8MjHbzC
         N5Pg==
X-Gm-Message-State: APjAAAUH1f5fi8kI5Hz3E3DQIWXRllhjKF3WfPew6YKvLz/aZMlX3M78
        sSb3tL8ffQaQW/j3vskBZOWUbK5s
X-Google-Smtp-Source: APXvYqx4Hlk4Qag6boeUjiYBMFpFCADZ+RdvIDdD8CQAIgZ8EVFcKYN9hxspi6JmOdX2uJkvNRFRoQ==
X-Received: by 2002:adf:ca0f:: with SMTP id o15mr46165022wrh.135.1565699231724;
        Tue, 13 Aug 2019 05:27:11 -0700 (PDT)
Received: from localhost.localdomain (x4db44abf.dyn.telefonica.de. [77.180.74.191])
        by smtp.gmail.com with ESMTPSA id r5sm1978069wmh.35.2019.08.13.05.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 05:27:11 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 07/11] completion: split _git_config()
Date:   Tue, 13 Aug 2019 14:26:48 +0200
Message-Id: <20190813122652.16468-8-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.350.gf4fdc32db7
In-Reply-To: <20190813122652.16468-1-szeder.dev@gmail.com>
References: <20190813122652.16468-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

_git_config() contains two enormous case statements, one to complete
configuration sections and variable names, and the other to complete
their values.

Split these out into two separate helper functions, so in the next
patches we can use them to implement completion for 'git -c <TAB>'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 39 ++++++++++++++++++++------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fc437bf3eb..3e9c5b6b71 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2228,7 +2228,8 @@ __git_compute_config_vars ()
 	__git_config_vars="$(git help --config-for-completion | sort -u)"
 }
 
-_git_config ()
+# Completes possible values of various configuration variables.
+__git_complete_config_variable_value ()
 {
 	local varname
 
@@ -2320,19 +2321,16 @@ _git_config ()
 		__gitcomp "7bit 8bit quoted-printable base64"
 		return
 		;;
-	--get|--get-all|--unset|--unset-all)
-		__gitcomp_nl "$(__git_config_get_set_variables)"
-		return
-		;;
 	*.*)
 		return
 		;;
 	esac
+}
+
+# Completes configuration sections, subsections, variable names.
+__git_complete_config_variable_name ()
+{
 	case "$cur" in
-	--*)
-		__gitcomp_builtin config
-		return
-		;;
 	branch.*.*)
 		local pfx="${cur%.*}." cur_="${cur##*.}"
 		__gitcomp "remote pushRemote merge mergeOptions rebase" "$pfx" "$cur_"
@@ -2407,6 +2405,29 @@ _git_config ()
 						print s "."
 				}
 				')"
+		;;
+	esac
+}
+
+_git_config ()
+{
+	case "$prev" in
+	--get|--get-all|--unset|--unset-all)
+		__gitcomp_nl "$(__git_config_get_set_variables)"
+		return
+		;;
+	*.*)
+		__git_complete_config_variable_value
+		return
+		;;
+	esac
+	case "$cur" in
+	--*)
+		__gitcomp_builtin config
+		;;
+	*)
+		__git_complete_config_variable_name
+		;;
 	esac
 }
 
-- 
2.23.0.rc2.350.gf4fdc32db7

