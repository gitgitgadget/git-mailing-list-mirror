Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 198C21F404
	for <e@80x24.org>; Wed, 28 Mar 2018 17:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753262AbeC1R40 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 13:56:26 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43346 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753240AbeC1R4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 13:56:25 -0400
Received: by mail-lf0-f66.google.com with SMTP id v207-v6so4714035lfa.10
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 10:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8x09ygNjsp78dnb4MlzwrX3T84db1amDSGszkX5vqPE=;
        b=pNVetPL/wgtDKMaeFn7CZp8V1s9JTQZjOEkDGJ+Z+u8alwgSr69RGfxl3pW5EQZu0G
         f/XyInzKyUj+Kd/IW87FRRou+0N7H5XJxTjCHopfkVYrcLAmtt8FUkmR3awn1bYKGrmi
         3btUfLv6rLqOHwGBMKnghsD8AHWG1vp6hf9Bll/qrPjWV7z5KAa2O/qv7rQxW674x1x8
         kh4n8xKxO2ej0YDauGB69TVBEZlCacLnRUbChoFaYB2rC590srJczhBLXBnm3xfvY8oa
         G+7B9/fvw1EqNISdbeC+2fKewRUXLOgaSo11b5Ak2xJin88/J6HkQjQfaMn6iwXaEJuW
         bwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8x09ygNjsp78dnb4MlzwrX3T84db1amDSGszkX5vqPE=;
        b=XukyDv9AE4i6GDtfX06J9iA7MrtigvSHdOm7/0ysQyYHROZqycMDpFLW3m6nW2me38
         q4mjjnUt/2+GwDFbo8AcIIsSrzGipn1BdQJYQDqOJp6HpRm6q+BMN7QjBJuITXs5Mc1c
         +sNxdi+R3wKV9yaS/1casJlJFLdIVhtcf08cqpleqGOMgfCMKuw8sQ2P1bN2LbCkx85M
         enAvCGGZIqcKCWM9P7Wz0YkWqSoArjGraChDWmwCtUDRXjO9PRAEYK2b0Fvw+wZbdgaM
         w+xo1+2hHcs96UaK7GVxD5OYlnvhap5KECyTZYN5hX+mEzZ/cvlhqY0NX1jjJ39Gkt37
         ZYLw==
X-Gm-Message-State: AElRT7HB2hV8knRYUEdNFNq/gzy2bdIksRas2kG5pGMPPTGvN8++8voh
        8Nl9ceO7LUx/LFT8E9MrQHsSYQ==
X-Google-Smtp-Source: AIpwx4//SKSxDK57aOZ/KqYBrdzfjBtfIUwhGZ6kq4nCMQVf3jGz0HWFY3aJaY8EC4YBR89CXfAxxw==
X-Received: by 10.46.80.71 with SMTP id v7mr3038824ljd.45.1522259783833;
        Wed, 28 Mar 2018 10:56:23 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s12sm706658ljj.49.2018.03.28.10.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 10:56:23 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Rafael Ascensao <rafa.almas@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 2/8] strbuf.c: reintroduce get_pwd_cwd() (with strbuf_ prefix)
Date:   Wed, 28 Mar 2018 19:55:31 +0200
Message-Id: <20180328175537.17450-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.439.gca064e2955
In-Reply-To: <20180328175537.17450-1-pclouds@gmail.com>
References: <20180328094733.GA1523@sigill.intra.peff.net>
 <20180328175537.17450-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Duy Nguyen <pclouds@gmail.com>

This function was added in 10c4c881c4 (Allow add_path() to add
non-existent directories to the path - 2008-07-21) because getcwd()
may fail on non-existing cwd and we want to construct non-existing
absolute paths sometimes.

The function was merged back in strbuf_add_absolute_path() some time
later. Move it out again because it will have another caller shortly.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 strbuf.c | 37 ++++++++++++++++++++++---------------
 strbuf.h |  6 ++++++
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index d5b7cda61e..aed4bec856 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -746,27 +746,34 @@ void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
 	}
 }
 
+void strbuf_get_pwd_cwd(struct strbuf *sb)
+{
+	struct stat cwd_stat, pwd_stat;
+	char *cwd = xgetcwd();
+	char *pwd = getenv("PWD");
+
+	if (pwd && strcmp(pwd, cwd) &&
+	    !stat(cwd, &cwd_stat) &&
+	    (cwd_stat.st_dev || cwd_stat.st_ino) &&
+	    !stat(pwd, &pwd_stat) &&
+	    pwd_stat.st_dev == cwd_stat.st_dev &&
+	    pwd_stat.st_ino == cwd_stat.st_ino)
+		strbuf_addstr(sb, pwd);
+	else
+		strbuf_addstr(sb, cwd);
+	free(cwd);
+}
+
 void strbuf_add_absolute_path(struct strbuf *sb, const char *path)
 {
 	if (!*path)
 		die("The empty string is not a valid path");
 	if (!is_absolute_path(path)) {
-		struct stat cwd_stat, pwd_stat;
 		size_t orig_len = sb->len;
-		char *cwd = xgetcwd();
-		char *pwd = getenv("PWD");
-		if (pwd && strcmp(pwd, cwd) &&
-		    !stat(cwd, &cwd_stat) &&
-		    (cwd_stat.st_dev || cwd_stat.st_ino) &&
-		    !stat(pwd, &pwd_stat) &&
-		    pwd_stat.st_dev == cwd_stat.st_dev &&
-		    pwd_stat.st_ino == cwd_stat.st_ino)
-			strbuf_addstr(sb, pwd);
-		else
-			strbuf_addstr(sb, cwd);
-		if (sb->len > orig_len && !is_dir_sep(sb->buf[sb->len - 1]))
-			strbuf_addch(sb, '/');
-		free(cwd);
+
+		strbuf_get_pwd_cwd(sb);
+		if (sb->len > orig_len)
+			strbuf_ensure_trailing_dir_sep(sb);
 	}
 	strbuf_addstr(sb, path);
 }
diff --git a/strbuf.h b/strbuf.h
index 62dc7f16fa..f712c4ff92 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -458,6 +458,12 @@ extern int strbuf_getwholeline_fd(struct strbuf *, int, int);
  */
 extern int strbuf_getcwd(struct strbuf *sb);
 
+/**
+ * Return the current directory, fall back to $PWD if the
+ * current directory does not exist.
+ */
+extern void strbuf_get_pwd_cwd(struct strbuf *sb);
+
 /**
  * Add a path to a buffer, converting a relative path to an
  * absolute one in the process.  Symbolic links are not
-- 
2.17.0.rc1.439.gca064e2955

