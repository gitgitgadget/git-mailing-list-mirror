Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFBCA207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753464AbdECKT4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:19:56 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33476 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753434AbdECKTx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:19:53 -0400
Received: by mail-pf0-f195.google.com with SMTP id b23so3689470pfc.0
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CcocXuenXbBejTaG6m5f5hio2ImtqwvbEwTKLv/hC5c=;
        b=KbdMr+p/9z6D9ibJdyCifpACmFPtRDbWtEpa4LQR+wv/enjCA7ufdlQdSiP8CKteLM
         HmzGPDDW0O363K/XhoCRl5ZKX9DdquJMvlhRPkgpLYnl2ppXc5UqwXJSy+IbCF2NTt2O
         ihBGNjGwkBI8Gu1eFZKx3/GnfGNe6YQB7El2DHNcMdK0BQpue31EZsrxw3oJa3+/etMM
         gedGhDbBa+fywH3bnDe2zW7NzoAL4sjgokpy7rHMXrsX7PWBoCIbm6y9JG3AvZYLrceL
         q5p0c4MT+Hz27715V9oH3yi3ID27ONHLH4Qeh7YqXSAPSKTNM2tWMificCORcn2rvvTh
         j5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CcocXuenXbBejTaG6m5f5hio2ImtqwvbEwTKLv/hC5c=;
        b=srxVrUEFOMhegLvOFZ9JwNSxJlL58SGUYMUgANaxrk7KrVi8u4Z18XV3kX6kz0xBbr
         sTsYnmQBhzNTOjJoCUOmvKhZs79uAGoHUuJu9aaLHv5Gy5oRdH9IYl+yWen7cGxAwzEI
         6lXSeGMfDCZzsY3gQypjuKim0B2TqVXpCFA9KKSbI53SQZZCRkbG+ZtlCogFuaRrcrtN
         AvDaFdB4vUstWoQ2FUcHMUgMN1FFVWBhcjpJuWE0YZtUU8M8Bd3DXp08ItngAgxDbN+J
         2CBIDe8h2+H99l5vKRiVbsMFWKgj34T308RAYeaqpO4P7McDsyGwtRj2ckmeXYb1Dc+T
         bvIA==
X-Gm-Message-State: AN3rC/626BgeRMg6DNeA2wl9j9UMrLiuKJzlCIWYqoz+FOdHQtXj4E7G
        PmEEmwe4C6UVkw==
X-Received: by 10.99.167.71 with SMTP id w7mr39165884pgo.138.1493806793242;
        Wed, 03 May 2017 03:19:53 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id y68sm3833442pfi.13.2017.05.03.03.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 03:19:52 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 May 2017 17:19:48 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 20/21] config.c: handle error on failing to fopen()
Date:   Wed,  3 May 2017 17:17:05 +0700
Message-Id: <20170503101706.9223-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170503101706.9223-1-pclouds@gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com>
 <20170503101706.9223-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the first case, we already correctly return -1 if fopen() fails to
open. But we should report something so people know what's wrong.

In the second case, config_file == NULL does not necessarily mean "no
config file". Bail out if needed.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 config.c              | 5 ++++-
 t/t1308-config-set.sh | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index b4a3205da3..e54d99d519 100644
--- a/config.c
+++ b/config.c
@@ -1422,7 +1422,7 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 	int ret = -1;
 	FILE *f;
 
-	f = fopen(filename, "r");
+	f = fopen_or_warn(filename, "r");
 	if (f) {
 		flockfile(f);
 		ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename, filename, f, data);
@@ -2640,6 +2640,9 @@ int git_config_rename_section_in_file(const char *config_filename,
 	}
 
 	if (!(config_file = fopen(config_filename, "rb"))) {
+		ret = warn_on_fopen_errors(config_filename);
+		if (ret)
+			goto out;
 		/* no config file means nothing to rename, no error */
 		goto commit_and_out;
 	}
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index ff50960cca..13e95561f4 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -187,7 +187,9 @@ test_expect_success POSIXPERM,SANITY 'proper error on non-accessible files' '
 	chmod -r .git/config &&
 	test_when_finished "chmod +r .git/config" &&
 	echo "Error (-1) reading configuration file .git/config." >expect &&
-	test_expect_code 2 test-config configset_get_value foo.bar .git/config 2>actual &&
+	test_expect_code 2 test-config configset_get_value foo.bar .git/config 2>output &&
+	grep "^warning:" output &&
+	grep "^Error" output >actual &&
 	test_cmp expect actual
 '
 
-- 
2.11.0.157.gd943d85

