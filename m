Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6DDC61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjBBJcz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjBBJcr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:32:47 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555E974C3D
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:32:46 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so883574wmq.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFtOhchuQF+QU6XMHWMrTv/NX3VDwdnvSVuj3x6KWCQ=;
        b=BBCzaq91OaIo5cmYU/3gcPRe411ZqTMaCs6TH1d+tWywHDrd6JN0fcAGddWxLFCDaN
         2IimMrK+G38DmSfdRqe1ksRBwat9F4+OUA3KIzn81kCdcr+GUHQBXxpl5FN9+viC2fdf
         J45kt3I2sgQkl9GjOa2f+IZ899n1vT6tJR+raBduKQiJZWEqbhd98bNFjzTXVk1XJD4k
         +SKdoEr/QLB3wsJXwOesnc60UhAjVQYN+dvWkgV6xCzd2HHK9R6Ty2ZY7bB6Po8avxdt
         997KuqI+p5edJX+flGAJSQXFQi/gC0oKR7ePk3pnhTOF6fu41Ce3wIIyg3s/d8UuPq2J
         Z24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFtOhchuQF+QU6XMHWMrTv/NX3VDwdnvSVuj3x6KWCQ=;
        b=ZTnpSQipa6ST5MD7srz1idHhNl6vxAQZWZrWFhRf0t+cyuGyQt67TU8RhO2EajnI13
         LwWdJSr6L3aOasI/BUdgHIQMojIkJbeigz5j0aEjMRnmbRM4U5BOtv/7h+b/SF8vQJFL
         /P+nwhykk5L0fo+YwXTWCmooz8Pv46UWjLLJYNgxeGmENBSNKmxPUZVKG10mRVtleYv4
         efuY3YU28BRbs74eEiIvXxjpEITYDeTiSJnhDrf+Op7UcGfC1Vt+J0yGur8neO5MWPSa
         9YSJwKBGgxgXq9ExDe+AYjgs2JDsCUFlMne5MZ5Ej1wHMJIFjBig+2UxzGhhJFDGfsnW
         fFVQ==
X-Gm-Message-State: AO0yUKU/7ocRWyB/5xSZzVC9VkVQo50594g7fscw3dMbF4m0LZzUOvOU
        WUPJFsu0XRpqgIqud9WQdBpnGFN6pvljG3Zc
X-Google-Smtp-Source: AK7set+HZMIJJNBt0OT4jNRpEgbpd7Ms1IYxjyHvp3MZA1fHltko14GJSrxftSownajPjhvVwIDNyQ==
X-Received: by 2002:a05:600c:46c9:b0:3db:1d8:9f25 with SMTP id q9-20020a05600c46c900b003db01d89f25mr4839835wmo.2.1675330364491;
        Thu, 02 Feb 2023 01:32:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c2cd300b003cf71b1f66csm4238753wmc.0.2023.02.02.01.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:32:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eli Schwartz <eschwartz93@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/9] archive-tar.c: move internal gzip implementation to a function
Date:   Thu,  2 Feb 2023 10:32:25 +0100
Message-Id: <patch-5.9-498037b2e65-20230202T093212Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
References: <230131.86357rrtsg.gmgdl@evledraar.gmail.com> <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the code added in 76d7602631a (archive-tar: add internal gzip
implementation, 2022-06-15) to call the magic "git archive gzip"
command as a function.

A subsequent commit will start using this as a fallback, but for now
there's no functional changes here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive-tar.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 8c5de949c64..dfc133deac7 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -465,12 +465,33 @@ static void tgz_write_block(const void *data)
 
 static const char internal_gzip_command[] = "git archive gzip";
 
-static int write_tar_filter_archive(const struct archiver *ar,
-				    struct archiver_args *args)
+static int gzip_internally(const struct archiver *ar,
+			   struct archiver_args *args)
 {
 #if ZLIB_VERNUM >= 0x1221
 	struct gz_header_s gzhead = { .os = 3 }; /* Unix, for reproducibility */
 #endif
+	int r;
+
+	write_block = tgz_write_block;
+	git_deflate_init_gzip(&gzstream, args->compression_level);
+#if ZLIB_VERNUM >= 0x1221
+	if (deflateSetHeader(&gzstream.z, &gzhead) != Z_OK)
+		BUG("deflateSetHeader() called too late");
+#endif
+	gzstream.next_out = outbuf;
+	gzstream.avail_out = sizeof(outbuf);
+
+	r = write_tar_archive(ar, args);
+
+	tgz_deflate(Z_FINISH);
+	git_deflate_end(&gzstream);
+	return r;
+}
+
+static int write_tar_filter_archive(const struct archiver *ar,
+				    struct archiver_args *args)
+{
 	struct strbuf cmd = STRBUF_INIT;
 	struct child_process filter = CHILD_PROCESS_INIT;
 	int r;
@@ -478,22 +499,8 @@ static int write_tar_filter_archive(const struct archiver *ar,
 	if (!ar->filter_command)
 		BUG("tar-filter archiver called with no filter defined");
 
-	if (!strcmp(ar->filter_command, internal_gzip_command)) {
-		write_block = tgz_write_block;
-		git_deflate_init_gzip(&gzstream, args->compression_level);
-#if ZLIB_VERNUM >= 0x1221
-		if (deflateSetHeader(&gzstream.z, &gzhead) != Z_OK)
-			BUG("deflateSetHeader() called too late");
-#endif
-		gzstream.next_out = outbuf;
-		gzstream.avail_out = sizeof(outbuf);
-
-		r = write_tar_archive(ar, args);
-
-		tgz_deflate(Z_FINISH);
-		git_deflate_end(&gzstream);
-		return r;
-	}
+	if (!strcmp(ar->filter_command, internal_gzip_command))
+		return gzip_internally(ar, args);
 
 	strbuf_addstr(&cmd, ar->filter_command);
 	if (args->compression_level >= 0)
-- 
2.39.1.1392.g63e6d408230

