Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEE4C433E2
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 14:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3D2619B6
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 14:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhCWOVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 10:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbhCWOUc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 10:20:32 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066B0C061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 07:20:32 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id y18so14447543qky.11
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 07:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xkNBVxGhUVdZi5AryzEvRhzyuhydecYpjQdE3C579No=;
        b=vUdlOd3smiXhQt1gBxZiRjSxzshVwhkPaGJrMPxZzdg/lNMojlgPYsPAqfAAUwMFA4
         ljkviNI70k22bXMpQNaR/EASYQ3fd6NwsKXYOdj5fhmE6X1sgw5LvQtKJSCcAZHyUFc+
         FdBD8XtldSG5CEBxg+QRmlviuEykaBtOWwxJ75WBRnCpad+zYrjEK1HOuB640/dpd6vQ
         un5AMJpsgyrnrpuYLYvB0PRZdmX9caSr1PQ/SjJGKQIYTKaj93uDzdIJrbQobITAeFL2
         SHbxCj/UolDMpmCoYZ5VQIwhndRP/+0OSeTiz8CG4hDlNW65YEqzq6vtaHZLPbTPkVXU
         fKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xkNBVxGhUVdZi5AryzEvRhzyuhydecYpjQdE3C579No=;
        b=cFBCLO1m6KhOSP3wtShXzzFqVEJfEPws+6NJhAf6urzt2XxQvbdoNAjc8CIbZHJ+vO
         R0kFyAJ/gQ+y0L5u9TwPR5M0MuaVsGehc3vmVuAN7Lz5N4mGvcj+qnfbjsb7znB8bz2t
         2GwgjiG+RAw/N6KWR+wzkRg9j4EUks+39ywPWkFXgPBaeJsgQ/HBke4BYwInQUUlxlyG
         WZtVBLIPV9RkAKmH7dfhp3KmekKHQaIiBZXFzC2TSk1vxcXcMLgPjE3fHWV+Zmsv8qRQ
         gaK+EXkTH+WrVBL6ypZ+yAYOAMWCXR93wSuXxm9Ov5pI7GNYjHBf/8Q1hzoaGQmFByJU
         ZsSg==
X-Gm-Message-State: AOAM532Yijc4exwJO5vEb+Ff2tDt1yW2knS59PWs/ktgiEu6ZS3YTKKD
        Zy/s18bAvKXQT/zUHkc6pYybvA==
X-Google-Smtp-Source: ABdhPJyf2kP/n22RFUjyQUOVnDiW/7MaF2e9aeZOvGjl9B08KI3dfgBYbLEDh6GaO9v1PSyoW00+pg==
X-Received: by 2002:ae9:e113:: with SMTP id g19mr5422178qkm.480.1616509231224;
        Tue, 23 Mar 2021 07:20:31 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j12sm11011690qtn.36.2021.03.23.07.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 07:20:30 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6 4/9] convert: add classification for conv_attrs struct
Date:   Tue, 23 Mar 2021 11:19:31 -0300
Message-Id: <01ac6176ccd8fb20372cf72b6aee33d5ed98c54f.1616508954.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1616508954.git.matheus.bernardino@usp.br>
References: <cover.1616508954.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create `enum conv_attrs_classification` to express the different ways
that attributes are handled for a blob during checkout.

This will be used in a later commit when deciding whether to add a file
to the parallel or delayed queue during checkout. For now, we can also
use it in get_stream_filter_ca() to simplify the function (as the
classifying logic is the same).

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 convert.c | 26 +++++++++++++++++++-------
 convert.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/convert.c b/convert.c
index 3f39c62cac..3298e4acff 100644
--- a/convert.c
+++ b/convert.c
@@ -1953,13 +1953,7 @@ struct stream_filter *get_stream_filter_ca(const struct conv_attrs *ca,
 {
 	struct stream_filter *filter = NULL;
 
-	if (ca->drv && (ca->drv->process || ca->drv->smudge || ca->drv->clean))
-		return NULL;
-
-	if (ca->working_tree_encoding)
-		return NULL;
-
-	if (ca->crlf_action == CRLF_AUTO || ca->crlf_action == CRLF_AUTO_CRLF)
+	if (classify_conv_attrs(ca) != CA_CLASS_STREAMABLE)
 		return NULL;
 
 	if (ca->ident)
@@ -2015,3 +2009,21 @@ void clone_checkout_metadata(struct checkout_metadata *dst,
 	if (blob)
 		oidcpy(&dst->blob, blob);
 }
+
+enum conv_attrs_classification classify_conv_attrs(const struct conv_attrs *ca)
+{
+	if (ca->drv) {
+		if (ca->drv->process)
+			return CA_CLASS_INCORE_PROCESS;
+		if (ca->drv->smudge || ca->drv->clean)
+			return CA_CLASS_INCORE_FILTER;
+	}
+
+	if (ca->working_tree_encoding)
+		return CA_CLASS_INCORE;
+
+	if (ca->crlf_action == CRLF_AUTO || ca->crlf_action == CRLF_AUTO_CRLF)
+		return CA_CLASS_INCORE;
+
+	return CA_CLASS_STREAMABLE;
+}
diff --git a/convert.h b/convert.h
index 484b50965d..43e567a59b 100644
--- a/convert.h
+++ b/convert.h
@@ -200,4 +200,37 @@ int stream_filter(struct stream_filter *,
 		  const char *input, size_t *isize_p,
 		  char *output, size_t *osize_p);
 
+enum conv_attrs_classification {
+	/*
+	 * The blob must be loaded into a buffer before it can be
+	 * smudged. All smudging is done in-proc.
+	 */
+	CA_CLASS_INCORE,
+
+	/*
+	 * The blob must be loaded into a buffer, but uses a
+	 * single-file driver filter, such as rot13.
+	 */
+	CA_CLASS_INCORE_FILTER,
+
+	/*
+	 * The blob must be loaded into a buffer, but uses a
+	 * long-running driver process, such as LFS. This might or
+	 * might not use delayed operations. (The important thing is
+	 * that there is a single subordinate long-running process
+	 * handling all associated blobs and in case of delayed
+	 * operations, may hold per-blob state.)
+	 */
+	CA_CLASS_INCORE_PROCESS,
+
+	/*
+	 * The blob can be streamed and smudged without needing to
+	 * completely read it into a buffer.
+	 */
+	CA_CLASS_STREAMABLE,
+};
+
+enum conv_attrs_classification classify_conv_attrs(
+	const struct conv_attrs *ca);
+
 #endif /* CONVERT_H */
-- 
2.30.1

