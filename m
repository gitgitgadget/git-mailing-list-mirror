Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDEB61F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 17:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440494AbfJQRfP (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 13:35:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54755 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393451AbfJQRfN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 13:35:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so3408303wmp.4
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 10:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJNVAdvf/H1r6geV9N2K08yheIPQq9KqXpWFm2eAaGM=;
        b=Hy0DvcXRldwC3+ZKVBXmLPsD3jHUblensKJgRFzL/AGloaEVKBn0qaFVKuL7u7YnG3
         lIREq9y93QMWRDClBneVn0NBNLu7j99QrQ29DlTbSxbYZxrHqPWDuxE27kVt09aPwFzB
         DUjLidWXO36NA3qhQoDXcy5W3MsH07CDewL4gHIjrgZLfsO/wbp46ZpgJDhr5qZAghel
         MAOOb/wGTj62Do/cr+CL5wbfeLd1l0r/qavoFMJjH8E8INQ+GYlhtex1+hEP0Zq5B2L7
         er7ML7GXQ4ODNRD8awJe5zhkuRGBYUJD4j5Hn30MiEUfelOLfAlnAoj/ZFOtr0Mggszn
         FsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJNVAdvf/H1r6geV9N2K08yheIPQq9KqXpWFm2eAaGM=;
        b=q7YfB7xv9wIc8lL/PSjAjYRdqdG6Dg9sC6xCjuJ46ahlstWxD6SBn3W2ngdLutisiX
         du7AmVRY4eCvOE6z8O7mUPcqrNeCqw4V/f8z6DZBUDjIwzHse3eKvTAy3KKrsOFGTvy3
         5/HuA9o2J0O/CcwWZZVC60SJ0t6Z9GPFcF+pIiBzDW42r7uLCayXijJo6BtNXvs50Vyg
         TgBwjylsJctXpUOxB6B63XVnRjEE8va5nMzndrCR+m2IFN0/4ZUrpZPyG3AlyFQ2+Gbp
         vOHeFK2Y1rJgDTXfzCcqiOHfgQfG3T3eP/3p2f5ns7Cru2FiKqrwsQ5UCgtwjT148uOA
         kMgw==
X-Gm-Message-State: APjAAAXAN/F64ScVsTcXfCy5SEDX5lDkAk0AuhFl+EsrN2kVdMUJtOE1
        VGVZOk6+Oh3qyXev39xvj2I=
X-Google-Smtp-Source: APXvYqysEDeNXHo812CzR+PXhLlblpfuPMaPhLk41QY5a74gQ0KKa8e9B3hI9ECwthQX9nKlKTMGKQ==
X-Received: by 2002:a05:600c:143:: with SMTP id w3mr3624169wmm.35.1571333710807;
        Thu, 17 Oct 2019 10:35:10 -0700 (PDT)
Received: from localhost.localdomain (x4db41bda.dyn.telefonica.de. [77.180.27.218])
        by smtp.gmail.com with ESMTPSA id f20sm2599876wmb.6.2019.10.17.10.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Oct 2019 10:35:10 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/6] t9902-completion: add tests for the __git_find_on_cmdline() helper
Date:   Thu, 17 Oct 2019 19:34:56 +0200
Message-Id: <20191017173501.3198-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.1084.gae250eaa40
In-Reply-To: <20191017173501.3198-1-szeder.dev@gmail.com>
References: <20191017173501.3198-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following two patches will refactor and extend the
__git_find_on_cmdline() helper function, so let's add a few tests
first to make sure that its basic behavior doesn't change.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t9902-completion.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 54f8ce18cb..847ce601d2 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1363,6 +1363,34 @@ test_expect_success 'teardown after path completion tests' '
 	       BS\\dir '$'separators\034in\035dir''
 '
 
+test_expect_success '__git_find_on_cmdline - single match' '
+	echo list >expect &&
+	(
+		words=(git command --opt list) &&
+		cword=${#words[@]} &&
+		__git_find_on_cmdline "add list remove" >actual
+	) &&
+	test_cmp expect actual
+'
+
+test_expect_success '__git_find_on_cmdline - multiple matches' '
+	echo remove >expect &&
+	(
+		words=(git command -o --opt remove list add) &&
+		cword=${#words[@]} &&
+		__git_find_on_cmdline "add list remove" >actual
+	) &&
+	test_cmp expect actual
+'
+
+test_expect_success '__git_find_on_cmdline - no match' '
+	(
+		words=(git command --opt branch) &&
+		cword=${#words[@]} &&
+		__git_find_on_cmdline "add list remove" >actual
+	) &&
+	test_must_be_empty actual
+'
 
 test_expect_success '__git_get_config_variables' '
 	cat >expect <<-EOF &&
-- 
2.23.0.1084.gae250eaa40

