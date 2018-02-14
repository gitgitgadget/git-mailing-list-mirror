Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCE211F576
	for <e@80x24.org>; Wed, 14 Feb 2018 10:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967195AbeBNKv7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 05:51:59 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43855 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967114AbeBNKv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 05:51:58 -0500
Received: by mail-pl0-f65.google.com with SMTP id f4so8315421plr.10
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 02:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HnWSns3iA0+hhnvraGdT8pQR5HpqlDo/+6zk3du53go=;
        b=S8aEGZ47uM+G2gwVfcEXvfXE62ipR3jDCPq0uOiYy6p4QHCc3axagfsS8+iD9q8R7G
         Yh0lRqiFgNpXpsQm3UW40ji2AjcUFQy5AhnLMlGF3cRvieE7RXPsBo5j1cevSL2ERTIH
         1PI/lQ712SQfWLkWsCKoUpLpLx67QNDoEYUXyVOZduDiE6U+kDTIkIQcMV6KcMKOH0xv
         tF+3hY06MJ+prOgQNzuAn+mgnNOpbuJudtRHezr52pLoggGzRo/zvHcSOWwyRNoBFa1q
         eFwBofEkN53030UamsmVYopXwKtluR6nMS45CvUwg4CDuIvYiDI5CvRqFI2Vwz2ieBrB
         mVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HnWSns3iA0+hhnvraGdT8pQR5HpqlDo/+6zk3du53go=;
        b=kxVx1Guiq8mlvpneMZMQAf8Uu3adX3OnT1BxxxmLazyFtyGMlsC8uOzfX4lUYu6A2B
         Kre9AQSg514RgdaIacbf4l1RxLU5V0+nRE0z59hiUmxZqApAsh9uNadbwEMjPuO7v/Er
         duNimcaHTfoWe9eBu85hfeq8NTx2etFq2/EpvS9xL3eTPvdb+oeCdj2L8hCzds/A975l
         ju53vWsG8wmCVa7hcFyfth5Ixcw5/UtkHQRUzw37wPRtpp0t0X25iLxxOW1Iv0tVCmOg
         dOOmuAj9kC+tS+8KnLgfnqZ8n3YfbV/a255GFoE8iysm2MljRi8IbGlyhEfiwtAe8eJS
         JCaQ==
X-Gm-Message-State: APf1xPCZDNvT2Az7cb/yOV7SDZpHC/q0uD58SZRwiW7tfz26Bufs803A
        aCqH2mdkX0S0qu4PDlahAlwaFw==
X-Google-Smtp-Source: AH8x225R1uv/ddH5z/+dQS7c502oPRVav89zRyW2J6J5QqRTueMbVJQpSxqGDavMkd1rMwIq1C92Ww==
X-Received: by 2002:a17:902:bcc1:: with SMTP id o1-v6mr4023289pls.78.1518605517592;
        Wed, 14 Feb 2018 02:51:57 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id r13sm30295524pgq.25.2018.02.14.02.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2018 02:51:56 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 14 Feb 2018 17:51:52 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     doron.behar@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/2] parse-options: expand $HOME on filename options
Date:   Wed, 14 Feb 2018 17:51:48 +0700
Message-Id: <20180214105149.28896-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180214101019.gaenosifgq3wx2nm@NUC.localdomain>
References: <20180214101019.gaenosifgq3wx2nm@NUC.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When you specify "--path ~/foo", the shell will automatically expand
~/foo to $HOME/foo before it's passed to git. The expansion is not done
on "--path=~/foo". An experienced user sees the difference but it could
still be confusing for others (especially when tab-completion still
works on --path=~/foo).

Support $HOME expansion for all filename options. There are about seven
of them.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index d265a756b5..c33f14c74e 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -38,10 +38,13 @@ static int get_arg(struct parse_opt_ctx_t *p, const struct option *opt,
 
 static void fix_filename(const char *prefix, const char **file)
 {
-	if (!file || !*file || !prefix || is_absolute_path(*file)
-	    || !strcmp("-", *file))
+	if (!file || !*file || is_absolute_path(*file) ||
+	    !strcmp("-", *file))
 		return;
-	*file = prefix_filename(prefix, *file);
+	if (**file == '~')
+		*file = expand_user_path(*file, 0);
+	else if (prefix)
+		*file = prefix_filename(prefix, *file);
 }
 
 static int opt_command_mode_error(const struct option *opt,
-- 
2.16.1.435.g8f24da2e1a

