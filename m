Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DD13207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 11:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944797AbdDTL3f (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 07:29:35 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36677 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031824AbdDTL1g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 07:27:36 -0400
Received: by mail-oi0-f66.google.com with SMTP id a3so3200975oii.3
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 04:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v9ykC/IaLpHTH6OWvR6EpRn8L6TRcYKLvGLhvZoxL1I=;
        b=UAKBPD2sIsm4Oj1TqQ2c9+8O+8wZ4L0mn1CVTRLUkBqqL6n6Qps3EHUySdW+I5vsWD
         /BRS3kK2wL2D5MY7XevZV4H2nKD1MCyIEf5U1Oklu+rC5KyTvQmbZ3Z8KpQ4W+zxbm1Y
         yM+XSlIRtoojVVB0zlTmXE/aZ6MvEQoKjqOtvcHRXOnaqH3C37ujWx7LYPhPpPMR6RIj
         8P5eQaWUu/hIne2XYT0tyxt5hc8oZxvriwF/xH5iDwljL2iPbrpLjJEvfB6QW/T1718C
         T+gnZWGlnW62U2PDckXGUE7VF3f8uGOG9yogg5unh+qtVgSWq2hVBXBL+vn6wtW9Tn7J
         LysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v9ykC/IaLpHTH6OWvR6EpRn8L6TRcYKLvGLhvZoxL1I=;
        b=b75VQrKYWCaULfs4nUzTmI0yoilKMgEMeWBYMPnG0vx0Kk0wBHIEQX4PRtOyFmSdSM
         D+sCn/Qd1Fj5ZIE8jKknADtFGXEgCf+/u/+zbwLvn3GdNGYgUewtAA3fWPhS88JyCk2k
         /f+4VDHehdyV3tmXqS0IhLVa7RvSQ8A+5zL0RTflDrjTep9wgTnTCb/QtpiBSSqaFYXw
         2oMat91T7wey//y+bTaHw1XzcNh2jjrhZi1zltSxb3FmvwErHIBAozzaaDW8xWwiTT60
         HMAgkDePW9U8Xyq1sv8dArSU3qsSQXcMXzFi5PhqpqVEOQG+r1zjGNaxzn23vWDQ2+gC
         s21A==
X-Gm-Message-State: AN3rC/7VPg6tJ0/w4Uqwg9TJizEQOt9kWU3kpOIaURIH5lDK3qAJWnFo
        5J7vxdjHXFwhCg==
X-Received: by 10.84.224.70 with SMTP id a6mr9786814plt.25.1492687655180;
        Thu, 20 Apr 2017 04:27:35 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id z5sm10048335pff.73.2017.04.20.04.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 04:27:34 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Apr 2017 18:27:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/15] config.c: handle error on failing to fopen()
Date:   Thu, 20 Apr 2017 18:26:08 +0700
Message-Id: <20170420112609.26089-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170420112609.26089-1-pclouds@gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com>
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
 config.c              | 8 +++++++-
 t/t1308-config-set.sh | 4 +++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 1a4d85537b..ac9effa7aa 100644
--- a/config.c
+++ b/config.c
@@ -1401,7 +1401,8 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 		ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename, filename, f, data);
 		funlockfile(f);
 		fclose(f);
-	}
+	} else if (errno != ENOENT)
+		warn_on_inaccessible(filename);
 	return ret;
 }
 
@@ -2601,6 +2602,11 @@ int git_config_rename_section_in_file(const char *config_filename,
 	}
 
 	if (!(config_file = fopen(config_filename, "rb"))) {
+		if (errno != ENOENT) {
+			warn_on_inaccessible(config_filename);
+			ret = -1;
+			goto out;
+		}
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

