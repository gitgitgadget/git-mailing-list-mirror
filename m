Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31A4C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9910A611ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbhETM13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 08:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbhETM0w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 08:26:52 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D8CC0AF7BB
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:25 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id k14so21205006eji.2
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t9/RvS8OpT98zShrRzRwb/Z5xFfD/l/sJ7ZJQVKBfKc=;
        b=mVbTZNkZEQVUNVWIxpAuCQ4if1S5H2SYxa2kX0qiykWpEpGrz4r6gGhG5FrjvtdBGS
         9SdWK0F6PPMIQCVZ52/qvDmuQmDpdgjhNeff1148cTh3GWbv5m1r6dCFKR3cZgvF9UIs
         opoueuWy/1ACHlKzt9Rp0PYFMOhOHL7zXYW6d6gjDu/Kuf2OQU/enkGwN0lQYZLBmISg
         7u4gjlFTfX0wZatfihs3vVwPL6dl6wSLjIUvlec1m1gYkFDdzrx6SdRLPSJOJCjGRWvN
         RKQ3bKjQ3nMhDsqTHaspCU2voppjWX5F8gzGCfMQ6HgM355tnm/0gX00tSKTFtidAP6Z
         +69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t9/RvS8OpT98zShrRzRwb/Z5xFfD/l/sJ7ZJQVKBfKc=;
        b=Cgf1GC2lhPaZgt1u0lG5G+pdu9EsFj+n/0fucU6mx1qO5/I9hBZl5cUhpjsYwte87n
         c9DJIKeqw4YZ7ENevBpGtpuCAvqCJNV9YT/qDnzKEmsVqOxbwj+AcjOK7+I76WRoUgWl
         /en347Gxx94izDLtwCVeeZjNVnRqXIwB3l5MyGsfiJnaeum65KY1rWtpMZu3MUrZTEsM
         214HDPfkSfc9U/JV8wmH8fy7TRGHbLkNf6GFJAjYEtU3TpNDngPd9jeB1CT5ZnN4PCvd
         ez1HQHwr7CoESw1YctSFY/Q4FyetfII31AUUd4B0xKW0CJWOZVeBEN9RVw7YiGNaIIMI
         qcDQ==
X-Gm-Message-State: AOAM530pxFNUyG73kKxbvTn3b7ByV+hGQfp3qvdUT5IU513uDfmQaNRS
        jws/y3PtwbJsxKnQi7MJxzQJvxG4hBTw4Q==
X-Google-Smtp-Source: ABdhPJx0HYtp31wNJzaHfunzVg2WTXyVgpJn+yJXPlaC/Vvz+ucPH/5/TtwbvNwGsmJlmDHEasTLhA==
X-Received: by 2002:a17:906:d14b:: with SMTP id br11mr4241973ejb.490.1621509803319;
        Thu, 20 May 2021 04:23:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jy21sm1243273ejc.13.2021.05.20.04.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:23:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 10/17] object-file.c: add missing braces to loose_object_info()
Date:   Thu, 20 May 2021 13:23:04 +0200
Message-Id: <patch-10.17-5d31d7e1a5-20210520T111610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g73369325f8d
In-Reply-To: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com> <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the formatting in loose_object_info() to conform with our usual
coding style:

    When there are multiple arms to a conditional and some of them
    require braces, enclose even a single line block in braces for
    consistency -- Documentation/CodingGuidelines

This formatting-only change makes a subsequent commit easier to read.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index 527f435381..115054389c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1450,17 +1450,20 @@ static int loose_object_info(struct repository *r,
 		if (unpack_loose_header_to_strbuf(&stream, map, mapsize, hdr, sizeof(hdr), &hdrbuf) < 0)
 			status = error(_("unable to unpack %s header with --allow-unknown-type"),
 				       oid_to_hex(oid));
-	} else if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
+	} else if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0) {
 		status = error(_("unable to unpack %s header"),
 			       oid_to_hex(oid));
-	if (status < 0)
-		; /* Do nothing */
-	else if (hdrbuf.len) {
+	}
+
+	if (status < 0) {
+		/* Do nothing */
+	} else if (hdrbuf.len) {
 		if ((status = parse_loose_header(hdrbuf.buf, oi, flags)) < 0)
 			status = error(_("unable to parse %s header with --allow-unknown-type"),
 				       oid_to_hex(oid));
-	} else if ((status = parse_loose_header(hdr, oi, flags)) < 0)
+	} else if ((status = parse_loose_header(hdr, oi, flags)) < 0) {
 		status = error(_("unable to parse %s header"), oid_to_hex(oid));
+	}
 
 	if (status >= 0 && oi->contentp) {
 		*oi->contentp = unpack_loose_rest(&stream, hdr,
@@ -1469,8 +1472,9 @@ static int loose_object_info(struct repository *r,
 			git_inflate_end(&stream);
 			status = -1;
 		}
-	} else
+	} else {
 		git_inflate_end(&stream);
+	}
 
 	munmap(map, mapsize);
 	if (status && oi->typep)
-- 
2.32.0.rc0.406.g73369325f8d

