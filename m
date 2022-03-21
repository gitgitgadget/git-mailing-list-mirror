Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FEBC433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiCUXLZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbiCUXKC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:10:02 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502C558819
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:58:23 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id h4so4690848wrc.13
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YDYe+wAshZCSB7sN+NAhKi5Ef6AE28uHuKw5bIy9fLI=;
        b=VmflCwz/x3hGwv8YozmE8P/m90/zA1D/mXDgVXzqCUyk6+mDY+m6bpBZ0RomZm74Ct
         3A1SkFYOdFKXLyMTLeo8a+11XEpofvbnZ1Q3WNkzZJ/d9NEY5emf9AL+v7R0YHG2o5BN
         K2p//+pkSmoylb7WWSzRBa42b/2005UM3seipxhZ5CIv1Vv96DUPGQ5wn6HiOGvL7J9P
         nczFmHt4VcjSDt9eR5+tioMTlhIrVP4He5ng6clN7pS3xjQbsIXvNoaYh1sBi3yLH62e
         irtSvruN1lpI9B0Urub38S0fH/DLWbr9Geju+LDhVUkXW1HQJUBgBMD6/ZJNZMsLyLzM
         cblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YDYe+wAshZCSB7sN+NAhKi5Ef6AE28uHuKw5bIy9fLI=;
        b=S+lG2IL2sIH+Av/AVl0iF+UQLe12P61+VZ546LUboTDqjf0BwmZssSwuze71drbEC6
         n4JbNwj5kVjmzPmao7rVzV/zar1zJhFrp36kwxAbTksQz0A7M/68VH8JiN1qRlp9czJ1
         2/LsH0pvYnaNHwHBR8OV2t/JYMTspXOECL9VvEagZnLcIpmy12Y2Nl2FOHRt0uf7758v
         HuBAsli/qQocxd2g4wge36xf95eGg7W5pKNENi4fMtJklooYHA4fNRte8n+D2YkipKWk
         p0hUIBjZOEgpzDANMOekjWQKCzIDHtTV7/roZJRca1/IYVEDOGq8XHFfAahvg7hIz+IG
         ZJOA==
X-Gm-Message-State: AOAM530NIYkJNU38TLRkNp6LGb/9sp6psUnFqzm4w25fcHRcdZwDMnXX
        IczY7JsIy4fhrA1DnvX4XN7Won9jzAc=
X-Google-Smtp-Source: ABdhPJw76eMS+GQVfNpLgwoc7Jdd9aSxXYQXgo8ojdpXttw1b0n35Ovb4OOGlAzWI5wwGZqaEtwUDg==
X-Received: by 2002:adf:f94d:0:b0:1e5:5ca1:2b80 with SMTP id q13-20020adff94d000000b001e55ca12b80mr20100755wrr.323.1647903368889;
        Mon, 21 Mar 2022 15:56:08 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:56:08 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 29/41] http-backend.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:55:11 +0000
Message-Id: <20220321225523.724509-30-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321225523.724509-1-gitter.spiros@gmail.com>
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C standard specifies two constants, EXIT_SUCCESS and  EXIT_FAILURE, that may
be  passed  to exit() to indicate successful or unsuccessful termination,
respectively. The value of status in exit(status) may be EXIT_SUCCESS,
EXIT_FAILURE, or any other value, though only the least significant 8 bits (that
is, status & 0377) shall be available to a waiting parent proces. So exit(-1)
return 255.

Use the C standard EXIT_SUCCESS and EXIT_FAILURE to indicate the program exit
status instead of "0" or "1", respectively. In <stdlib.h> EXIT_FAILURE has the
value "1": use EXIT_FAILURE even if the program uses exit(-1), ie 255, for
consistency.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 http-backend.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 81a7229ece..932d92d70b 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -137,7 +137,7 @@ static NORETURN void not_found(struct strbuf *hdr, const char *err, ...)
 	if (err && *err)
 		vfprintf(stderr, err, params);
 	va_end(params);
-	exit(0);
+	exit(EXIT_SUCCESS);
 }
 
 __attribute__((format (printf, 2, 3)))
@@ -153,7 +153,7 @@ static NORETURN void forbidden(struct strbuf *hdr, const char *err, ...)
 	if (err && *err)
 		vfprintf(stderr, err, params);
 	va_end(params);
-	exit(0);
+	exit(EXIT_SUCCESS);
 }
 
 static void select_getanyfile(struct strbuf *hdr)
@@ -488,7 +488,7 @@ static void run_service(const char **argv, int buffer_input)
 	cld.clean_on_exit = 1;
 	cld.wait_after_clean = 1;
 	if (start_command(&cld))
-		exit(1);
+		exit(EXIT_FAILURE);
 
 	close(1);
 	if (gzipped_request)
@@ -501,7 +501,7 @@ static void run_service(const char **argv, int buffer_input)
 		close(0);
 
 	if (finish_command(&cld))
-		exit(1);
+		exit(EXIT_FAILURE);
 }
 
 static int show_text_ref(const char *name, const struct object_id *oid,
@@ -628,7 +628,7 @@ static void check_content_type(struct strbuf *hdr, const char *accepted_type)
 			"Expected POST with Content-Type '%s',"
 			" but received '%s' instead.\n",
 			accepted_type, actual_type);
-		exit(0);
+		exit(EXIT_SUCCESS);
 	}
 }
 
@@ -668,7 +668,7 @@ static NORETURN void die_webcgi(const char *err, va_list params)
 		hdr_nocache(&hdr);
 		end_headers(&hdr);
 	}
-	exit(0); /* we successfully reported a failure ;-) */
+	exit(EXIT_SUCCESS); /* we successfully reported a failure ;-) */
 }
 
 static int die_webcgi_recursing(void)
-- 
2.35.1

