Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4C061FF76
	for <e@80x24.org>; Mon, 19 Dec 2016 09:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755226AbcLSJWS (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 04:22:18 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36655 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753578AbcLSJWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 04:22:16 -0500
Received: by mail-pg0-f68.google.com with SMTP id w68so1888278pgw.3
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 01:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YWSvb8TSmHGCliX1ZYNBbsGdMogkyfuDlkXeFXxn/NI=;
        b=NZOM9xxQkg62ghsMA1bm776c5z8qDQX8ObJVHI7696QL45KS5R3FOPNgCnTFkU/ukD
         pp+aUA0+tExp42tpVxEfZWm2oQnM6cjb9+d6HBFUcEZuYXnjOQGEeRplLzqlI9qu3ugH
         McTKNL7st0mlwv0UkWRC3vOS8VEvnccs+PbXkDfwBO+b/TLBIW893pRepNvDnQP33a1D
         ZI7nTsp+OeyXnfKdZkb4YVVhdmnFZvZlDU56b27xAaszqwX6uBqnvaRzFMnEFAsTl0sK
         0otOktxSmxS2eU2ckiEZkfvhG3lp16XmHoNJ96262vTRx+tuhSY4yWAX78fNAMfmLTsJ
         7SxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YWSvb8TSmHGCliX1ZYNBbsGdMogkyfuDlkXeFXxn/NI=;
        b=pwRUb/BfRK4pm3QK2/Ck8Sahfa0+8h0sXSuaYlPwEWRsDTvR4Bd8l8OnHVnNHdYkAg
         HAVLmGEGmKZv/pA2VIfguej/MQ79Cw7Aq+6ytk7NkIZB4KK1RgwhVJr+Npa6SzI9gEJu
         1tCeTuX1eUvJqH/PTtj9zsDsbEUqpVpE0KVhkEb3vfxGJHocKogdiW1onxF7NdoOpdt2
         +Ce1Ef01fUISMsxXoCQPoEufzUo0K3+Ks917FCFmiWg3PoWMsqvLUih7trffvP5M4JGO
         r2I0gPmq879gCwxpEmMNQmtPCbXtmsIVp9xrVkaqGA+WoaZaZfKI2PUUOEQOdQGIvRXL
         G/Gw==
X-Gm-Message-State: AKaTC03BYNzwOi09HVyahbfHoKTPF7+1UlPMJKyslmniY3FsMbO/qwRxApezos0E3ZMItA==
X-Received: by 10.99.226.3 with SMTP id q3mr27345281pgh.37.1482139336035;
        Mon, 19 Dec 2016 01:22:16 -0800 (PST)
Received: from ash ([115.73.171.119])
        by smtp.gmail.com with ESMTPSA id q26sm29608809pfk.94.2016.12.19.01.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Dec 2016 01:22:15 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 19 Dec 2016 16:22:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, josharian@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] config.c: handle error case for fstat() calls
Date:   Mon, 19 Dec 2016 16:21:55 +0700
Message-Id: <20161219092155.20359-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <CAFAcib_cY8FeLFkW1=MfR+P7xoupGK9DFegNY5boExHSRppAmg@mail.gmail.com>
References: <CAFAcib_cY8FeLFkW1=MfR+P7xoupGK9DFegNY5boExHSRppAmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Will this fix the problem I'm replying to? I don't know. I found this
 while checking the code and it should be fixed regardless.

 config.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 83fdecb..4973256 100644
--- a/config.c
+++ b/config.c
@@ -2194,7 +2194,12 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 			goto out_free;
 		}
 
-		fstat(in_fd, &st);
+		if (fstat(in_fd, &st) == -1) {
+			error_errno(_("fstat on %s failed"), config_filename);
+			ret = CONFIG_INVALID_FILE;
+			goto out_free;
+		}
+
 		contents_sz = xsize_t(st.st_size);
 		contents = xmmap_gently(NULL, contents_sz, PROT_READ,
 					MAP_PRIVATE, in_fd, 0);
@@ -2414,7 +2419,10 @@ int git_config_rename_section_in_file(const char *config_filename,
 		goto unlock_and_out;
 	}
 
-	fstat(fileno(config_file), &st);
+	if (fstat(fileno(config_file), &st) == -1) {
+		ret = error_errno(_("fstat on %s failed"), config_filename);
+		goto out;
+	}
 
 	if (chmod(get_lock_file_path(lock), st.st_mode & 07777) < 0) {
 		ret = error_errno("chmod on %s failed",
-- 
2.8.2.524.g6ff3d78

