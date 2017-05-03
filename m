Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4EC2207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752636AbdECKTq (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:19:46 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34214 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753434AbdECKTm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:19:42 -0400
Received: by mail-pg0-f67.google.com with SMTP id t7so27650969pgt.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lwk+Xm6lgH58Rj+uEkD5m+VIuiB/fkg+1x5ewChbVzc=;
        b=rc+gZvtNTDwLE6VnpukvvVRDMDQB83uweo3mDOHprRbhVbtWZjbtoLF/R0zAfNC8Bb
         ePWHD4AgYQpEoBTOpkKCpGA3k8lzCLVKmS1mXYc4osU5UAvVkvofMncmOw8fD5xp8y8z
         gY7m4AxKtXjbiq6vJ34nxRrOajA+JbwPG7EoDPv8iHEunKIOSNvM6GUum5d4gK6wgsgS
         y6pd5DrC9QKP8odmLwfG84zAxgesgaE5KRbhWjg+C/CjL+sI9jzdX/Vb525loyEfxlsB
         NFKTOc4IMkoz8xt8O3vVp6S5+TShEAetdyPZhE3uhr6smuQp3ntNZXff/Sjnor4p/aVb
         9yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lwk+Xm6lgH58Rj+uEkD5m+VIuiB/fkg+1x5ewChbVzc=;
        b=j6B/K0F9smLU17SDbaAQqmppVTDakrpsfYpuM2rTE95N5EWzTc22o5LQxHZ82Ah8oT
         CI8ekO9/kBjwGoMsos72n7u26ijyAZFIXDX3ylqTn3evVMqJ3XZJN/aOU+orEywIcPRC
         oBVb7jCBHrdxPN+STk3Ji7fEiJCmoq3te0RC2vX0RjsGfnpuIpP+oqN/3Z5SV0lv7Sn7
         nCnbctM0dKBOfkQkPSp4l9sCQK7zVa2Aqbh06YJqTzZ/RLlfpiUuDpnnzXqwkxYi067R
         t4DBx1thfyC7RxnKTA0XmEGHwZlEt8uL7wHoBHff7I7RZezom8ENtBHqA7p2n03C49eW
         P1hg==
X-Gm-Message-State: AN3rC/6ioRpvW/v5JvyUPY+Qbi6+6fQ5EgVtZrgZvY8nGIGeJzkmvxbx
        XX+yoJfIj+gLQ3NJ
X-Received: by 10.84.231.16 with SMTP id f16mr47116297plk.58.1493806781860;
        Wed, 03 May 2017 03:19:41 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id c83sm3964684pfd.113.2017.05.03.03.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 03:19:41 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 May 2017 17:19:36 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 18/21] wt-status.c: report error on failure to fopen()
Date:   Wed,  3 May 2017 17:17:03 +0700
Message-Id: <20170503101706.9223-19-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 wt-status.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index 0375484962..cdf9f5eed2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1065,7 +1065,8 @@ static void show_am_in_progress(struct wt_status *s,
 static char *read_line_from_git_path(const char *filename)
 {
 	struct strbuf buf = STRBUF_INIT;
-	FILE *fp = fopen(git_path("%s", filename), "r");
+	FILE *fp = fopen_or_warn(git_path("%s", filename), "r");
+
 	if (!fp) {
 		strbuf_release(&buf);
 		return NULL;
-- 
2.11.0.157.gd943d85

