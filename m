Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71222207EC
	for <e@80x24.org>; Wed, 28 Sep 2016 11:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753537AbcI1LoT (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 07:44:19 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35859 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753389AbcI1LoS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 07:44:18 -0400
Received: by mail-pa0-f67.google.com with SMTP id cd13so157445pac.3
        for <git@vger.kernel.org>; Wed, 28 Sep 2016 04:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J/z3wKLTI0lxoDOwlupbuGSPBHSqUq4YeXNrfx2GuUs=;
        b=aOp2niGBIbV/qjEWwb4w6pxBEU6cRJipTjZm11f8SL/8YH+RZFPlDd+rn4Ge8JLIa9
         m5NoH60YzJSRr+B+ZVpt9MyaObZxMfixFIV5QTXp2CFr9pi8X0wNbT2a1Fm1FkWyGeJc
         MXIWVxSMPG/q/SEc+EvPqE7N6KBy8C1dP7W5L0JBCA63+3iELXalJDA2zhzB8VUeLBuC
         u8/wby+EJLdx6tWNqPNblVJaLuN7Tz5+akeHWGNjcWw+xsZ020N8JU2Bg5Xag7+SQmaZ
         jYhNz6lbctKvhorbtY033kM1j3cD3ZKlCvC++ysE4P+Ncjd505IAKceYynam3886xUAJ
         g2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J/z3wKLTI0lxoDOwlupbuGSPBHSqUq4YeXNrfx2GuUs=;
        b=TallD+CadMYg7I0pkX+nTnV6D37UcsF7vmQNjfVWWnALe2ROOVu6EMSpUTiQDiW6bc
         ugeo8rIP7WLmXDF4gq+TE3mQ7JZjeF9NAF1/YGalDIoibO9NvdAlhCj/oOENdLPGZ7wb
         r6bZxFTxNTixfMy5Zv4Vz93ccq93mNr1eUlEEwKXEDxBu/f1SM+2Ga28TMzuL9pyL+fH
         oo7w8Ep9poWhkdTNMAlIWI9PdouTeahOgGARz2pUD3Tw1lIZ24K496kGzEE/0PnEocNu
         9hXFn4ZhC0nke+EecWVmCOs4lBpSd6HXvyA/dEaMCKc2Mr3SezhmYzptb51X0nl9CmHa
         VMaQ==
X-Gm-Message-State: AA6/9Rn25jL6H8s7Omx5G1/TeJZ6URCRtDqHylMZRlYZ2hp0sCZzIRGQwoMl/wIa8B/c5w==
X-Received: by 10.66.8.135 with SMTP id r7mr39296546paa.169.1475063057426;
        Wed, 28 Sep 2016 04:44:17 -0700 (PDT)
Received: from ash ([115.76.130.63])
        by smtp.gmail.com with ESMTPSA id j1sm12025808pfg.95.2016.09.28.04.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Sep 2016 04:44:16 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 28 Sep 2016 18:44:12 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/3] commit: don't be fooled by ita entries when creating initial commit
Date:   Wed, 28 Sep 2016 18:43:48 +0700
Message-Id: <20160928114348.1470-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160928114348.1470-1-pclouds@gmail.com>
References: <20160928114348.1470-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ita entries are dropped at tree creation phase. If the entire index
consists of just ita entries, the result would be a a commit with no
entries, which should be caught unless --allow-empty is specified.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/commit.c      | 11 ++++++++---
 t/t2203-add-intent.sh | 10 ++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index bb9f79b..56b24cb 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -894,9 +894,14 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (amend)
 			parent = "HEAD^1";
 
-		if (get_sha1(parent, sha1))
-			commitable = !!active_nr;
-		else {
+		if (get_sha1(parent, sha1)) {
+			int i, ita_nr = 0;
+
+			for (i = 0; i < active_nr; i++)
+				if (ce_intent_to_add(active_cache[i]))
+					ita_nr++;
+			commitable = active_nr - ita_nr > 0;
+		} else {
 			/*
 			 * Unless the user did explicitly request a submodule
 			 * ignore mode by passing a command line option we do
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index aa06415..65314fc 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -129,6 +129,16 @@ test_expect_success 'cache-tree does skip dir that becomes empty' '
 	)
 '
 
+test_expect_success 'commit: ita entries ignored in empty intial commit check' '
+	git init empty-intial-commit &&
+	(
+		cd empty-intial-commit &&
+		: >one &&
+		git add -N one &&
+		test_must_fail git commit -m nothing-new-here
+	)
+'
+
 test_expect_success 'commit: ita entries ignored in empty commit check' '
 	git init empty-subsequent-commit &&
 	(
-- 
2.8.2.524.g6ff3d78

