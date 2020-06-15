Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB214C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 10:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7BAC2068E
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 10:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2FY/yBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgFOK5w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbgFOK5s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 06:57:48 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472BCC05BD43
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 03:57:48 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o15so16904844ejm.12
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 03:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RQBXikzfLzcYGiX/f3FHQ6WOpsHy4OdS8ad4tVUcLC8=;
        b=a2FY/yBcYk+E/TwfnT/6lZMzomr/GWFDR24rA/uqsrB2/BGNQARQ3Yf/f52k4P0lWb
         11tCO4Qsaj8QdbRFfyuaGz8ty7E8ryO1iI8QCghsMl8l8aeOQh0pM19SO6nelZdIB1e3
         WDMyovpqYxlfkRUfwsYd2R0GkFvsMrlAVoiawxPKa7Q57s3sTbse25J+vCSEj6jolDB1
         KREUtFUsafqDrV9AHIZ1v5/t9ZqPCFyETo9y6cEV0af6j9IpJFrn1DGiBihsxL+KIr/r
         FDa7i8PTt19dAsV7SPd/PlH37VFvb+wZi+SXwSeaQfY2n2sBjUHw6Zf8pcLxee6b6Ein
         ccdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RQBXikzfLzcYGiX/f3FHQ6WOpsHy4OdS8ad4tVUcLC8=;
        b=rtsxIZg12JqHISWhnsiEXwNvKUAna5qr/sHvtW7y1LlFPJByquKw3nPhgVaJSiKyHJ
         wBeKE5gmIx7T973TmKNhwwWXy6ZMBEP4WHRSSAygysBUxo8zvVY/qRHvkI6siGs8jN5i
         kpKXH+e1Nknif3zNT+D6O+GcQ0mVMPAwJFs62ELbJsGPSx2ACMj77PXBFORmP8uWC/ch
         W8NzM/LBz0GmFO5fMCDXELI9X+96Q/4jkJETba9Q4Yo/O00ptpRx3ytqqiEjriqpY+7A
         qwwoEeWBRQDOQGYX2rEChBSAjrM2k9dS3rkU+I4M+BnRlyhlrmmGybEb/ONLCqVsjEzv
         O9JA==
X-Gm-Message-State: AOAM532+/qcvBFzzSdy2yBZITriMAVnpVifKk8NRewIdAIN9MjDpusCe
        0rhtVgicAPlC/tnF5LqBz74ibbf1
X-Google-Smtp-Source: ABdhPJzDWFs2f1HqXlsel69P36WlrjrZ3BY+JYe+c3cf2KqQkbDBhgc9GzSH5Qpicq3kxYxtk5/sqg==
X-Received: by 2002:a17:906:178c:: with SMTP id t12mr24104191eje.464.1592218666876;
        Mon, 15 Jun 2020 03:57:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id nw22sm8862394ejb.48.2020.06.15.03.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 03:57:46 -0700 (PDT)
Message-Id: <0eecb653d21355d7d2ab3dd209cfdb3c24365417.1592218662.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.658.git.1592218662.gitgitgadget@gmail.com>
References: <pull.658.git.1592218662.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 10:57:41 +0000
Subject: [PATCH 4/5] ref_format: add option to skip `\n` at eol
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

We might always need a `\n` at end of line in the case of
`git for-each-ref`. But as we intend to use ref-filter's logic
in pretty, having an option to skip `\n` will be useful.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 ref-filter.c | 3 ++-
 ref-filter.h | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index bf7b70299b4..0e2fecbda4c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2410,7 +2410,8 @@ void show_ref_array_item(struct ref_array_item *info,
 	fwrite(final_buf.buf, 1, final_buf.len, stdout);
 	strbuf_release(&error_buf);
 	strbuf_release(&final_buf);
-	putchar('\n');
+	if(format->need_newline_at_eol)
+		putchar('\n');
 }
 
 void pretty_print_ref(const char *name, const struct object_id *oid,
diff --git a/ref-filter.h b/ref-filter.h
index 8ecc33cdfa5..410446dc412 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -81,11 +81,13 @@ struct ref_format {
 	int quote_style;
 	int use_color;
 
+	int need_newline_at_eol;
+
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;
 };
 
-#define REF_FORMAT_INIT { NULL, 0, -1 }
+#define REF_FORMAT_INIT { NULL, 0, -1, 1 }
 
 /*  Macros for checking --merged and --no-merged options */
 #define _OPT_MERGED_NO_MERGED(option, filter, h) \
-- 
gitgitgadget

