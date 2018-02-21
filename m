Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B2271F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeBUBzJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:55:09 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43665 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbeBUBzA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:55:00 -0500
Received: by mail-pl0-f66.google.com with SMTP id f23so83127plr.10
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g1SMnfShrosNiFJfmDWBvZyx471DfVVulZWvSPDFXrg=;
        b=iaRLwMHXCT/om5U/mRt06TumNhZBwpveq00kkGFzMeoeR4XAKn3roeU9XtE/kt/d2R
         5C3BdPZnYmHBch2x0BkXbcxWvnEp2eHbHSkvvtMnZ8FkASW23VXLZsdS576mqmJJZmdG
         oLp4tNmIwlArA8qPfbgitVCixj8h41jZQm9/LfZ4BXT/49ZvljBEXPkohORzb/RHWqgP
         8QlT1h794ZHKA5g5Cp4/+EWQeSIyJY7QWBhx6CqeG7PsW2EfS52YUT59wDfuKEXXyf25
         3a/iR7ue/Uz5degZ/LKmstvEzARNxdkGXr3y1PRaBTqY2xO00Wwi4SdRtqxHaLLzwAKP
         Mu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g1SMnfShrosNiFJfmDWBvZyx471DfVVulZWvSPDFXrg=;
        b=Hx7zEOFM8r3eU1fjEPra6+J3gRr99qB7ay7qUDb5V7FPGRbHUHC99j4znHGUDBwkE4
         M2PGSBl1+STiJgu5F4A0KnlKfBU0C/BFcCeBGcFYJGyLGY2+RFwWol4bAO/aRVljxcNd
         eo3Dn/vFJ0i++aKXWtDO8Z3eG9XJpPH4hVCxlSgpd5FZxDFuxs3KYUWF6VksZKxROzd0
         ZADKtCTZ7NwszuzXHzNkVfckVR+zytDtEZzali/I42CxA9YeFkkTTISuaNbSkCnW2JLt
         goDJYWrQvQMmjaqL2BMTXqTKX/HW+OoSgahFG8mvdUVs01uzSN1qynpbBYa6GgorDlEO
         IM5Q==
X-Gm-Message-State: APf1xPD1b2sX0LWVL0TO6hwheLzyoGYpp7AMh0RWjhdGgHIUcliJAd8U
        4DlTXeRQoDUbt2/Jp4x5EeStzROCDME=
X-Google-Smtp-Source: AH8x226rJK+8qqeqxTxMRQyNUUqsBN1l/44KIfhoREIdr6tSVDzrzU9wPCGyePpZvNkdzRKhVBNF+w==
X-Received: by 2002:a17:902:14cb:: with SMTP id y11-v6mr1534476plg.294.1519178099073;
        Tue, 20 Feb 2018 17:54:59 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id a28sm62809776pfe.70.2018.02.20.17.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:54:58 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/27] sha1_file: add repository argument to link_alt_odb_entries
Date:   Tue, 20 Feb 2018 17:54:15 -0800
Message-Id: <20180221015430.96054-13-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See previous patch for explanation.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 6edcc3d3a7..a0e9116318 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -467,8 +467,12 @@ static const char *parse_alt_odb_entry(const char *string,
 	return end;
 }
 
-static void link_alt_odb_entries(const char *alt, int sep,
-				 const char *relative_base, int depth)
+#define link_alt_odb_entries(r, a, s, rb, d) \
+	link_alt_odb_entries_##r(a, s, rb, d)
+static void link_alt_odb_entries_the_repository(const char *alt,
+						int sep,
+						const char *relative_base,
+						int depth)
 {
 	struct strbuf objdirbuf = STRBUF_INIT;
 	struct strbuf entry = STRBUF_INIT;
@@ -511,7 +515,7 @@ static void read_info_alternates_the_repository(const char *relative_base,
 		return;
 	}
 
-	link_alt_odb_entries(buf.buf, '\n', relative_base, depth);
+	link_alt_odb_entries(the_repository, buf.buf, '\n', relative_base, depth);
 	strbuf_release(&buf);
 	free(path);
 }
@@ -565,7 +569,8 @@ void add_to_alternates_file(const char *reference)
 		if (commit_lock_file(&lock))
 			die_errno("unable to move new alternates file into place");
 		if (the_repository->objects.alt_odb_tail)
-			link_alt_odb_entries(reference, '\n', NULL, 0);
+			link_alt_odb_entries(the_repository, reference,
+					     '\n', NULL, 0);
 	}
 	free(alts);
 }
@@ -578,7 +583,8 @@ void add_to_alternates_memory(const char *reference)
 	 */
 	prepare_alt_odb();
 
-	link_alt_odb_entries(reference, '\n', NULL, 0);
+	link_alt_odb_entries(the_repository, reference,
+			     '\n', NULL, 0);
 }
 
 /*
@@ -681,7 +687,8 @@ void prepare_alt_odb(void)
 
 	the_repository->objects.alt_odb_tail =
 			&the_repository->objects.alt_odb_list;
-	link_alt_odb_entries(alt, PATH_SEP, NULL, 0);
+	link_alt_odb_entries(the_repository, alt,
+			     PATH_SEP, NULL, 0);
 
 	read_info_alternates(the_repository, get_object_directory(), 0);
 }
-- 
2.16.1.291.g4437f3f132-goog

