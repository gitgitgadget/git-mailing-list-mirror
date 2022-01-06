Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AB3C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 19:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243482AbiAFTuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 14:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243474AbiAFTuR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 14:50:17 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF18C061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 11:50:17 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id i187so3763056qkf.5
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 11:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3+In0LDFNjcx03dsEy/0yRZX0NrR5Hhw3LnPhTqwE5k=;
        b=eglAWc3GkXRuxvE0Sp1RU8GntH4CiTXyZo6d2VrWDE1fb9P3t03KnPWLdf8pQEcspl
         O5tu+m1o1504khCXqr13AWl+XtZjlAyYn0X+ZfbAn1DaUbuphveDgYiVDj0r9Tbe/GES
         OMZhWAEW6WPJS+Mq5yrR3WkKJ7FMGPFx4Ag6HmwPki05NhwAEntq4Tp91K9wILi2uATc
         sC/oxWCWrRfYfeRlVtq23jHbZXtOBMfFZ33lu45ynczTRoJA4ayZcQuzbfqkP4PjFYUO
         lIned67Q3TO3x8pkMqZeYECRQoINht5SJdrIDg47EugsVn85TdmdTOHI7oJ2sM5zRFi1
         ZWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3+In0LDFNjcx03dsEy/0yRZX0NrR5Hhw3LnPhTqwE5k=;
        b=0xs9a5NaFUtzOCpiag4TWh2dw9Z/6X36SEZ2frYffVoGuycq3+0WmtyIsE492gvO1S
         fcLDUkAL8Nq0sgCaCWJJtGgd4NEnmne2hLMAH9t1txbehd/9Dz4FaNeeGd45+YEb3APJ
         pGerEKBvMmBY7K+AcnS+WRiTeypVFfmEiVXrS5jiTWpRYC34hJvXhMW3YOv5WIFi4cYl
         tedtjNM3lU+6EuSR3YgJqwWn8WL9UBbLLsf7k0l5P2yRzkhHxnCUgmXSnWRJ5VXGklGf
         f1mwQPanlz1QRXEdn2Mt/Ps1n+fjBmOWIoXKlweD2/pGOLNV2i5JF5dvvfqr/tyS5aOP
         r5SQ==
X-Gm-Message-State: AOAM531GF0XhuktuT0k3OEjn82Ysy/5nbExK/Ri7kZ1klm5mjraLMtiL
        0UI4RsefySfg0eqnS5vqubef+xvaBAhBlQ==
X-Google-Smtp-Source: ABdhPJx2AX8A2FzaFh5LbYLqTC4T4wZfTlS0hLCadKYoevSO2LSjIbMSV7gUrStBJws6aiuxgV5oGg==
X-Received: by 2002:a05:620a:1477:: with SMTP id j23mr43941595qkl.152.1641498616260;
        Thu, 06 Jan 2022 11:50:16 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m20sm2378470qtx.39.2022.01.06.11.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 11:50:15 -0800 (PST)
Date:   Thu, 6 Jan 2022 14:50:15 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     l.s.r@web.de, gitster@pobox.com
Subject: [PATCH 2/2] grep: use grep_and_expr() in compile_pattern_and()
Message-ID: <71bd2d1bcc6486f2e21c649708d3f4fa67dc162c.1641498525.git.me@ttaylorr.com>
References: <ea01f9b6-2ce3-57e8-533f-4cc29937f700@web.de>
 <cover.1641498525.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1641498525.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as a previous commit, use the new `grep_and_expr()`
to construct the AND node in `compile_pattern_and()`.

Unlike the aforementioned previous commit, this is not about code
duplication, since this is the only spot in grep.c where an AND node is
constructed. Rather, this is about visual consistency with the other
`compile_pattern_xyz()` functions.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 grep.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/grep.c b/grep.c
index d772fe6cc5..ab4fdacaed 100644
--- a/grep.c
+++ b/grep.c
@@ -619,6 +619,11 @@ static struct grep_expr *grep_or_expr(struct grep_expr *left, struct grep_expr *
 	return grep_binexp(GREP_NODE_OR, left, right);
 }
 
+static struct grep_expr *grep_and_expr(struct grep_expr *left, struct grep_expr *right)
+{
+	return grep_binexp(GREP_NODE_AND, left, right);
+}
+
 static struct grep_expr *compile_pattern_or(struct grep_pat **);
 static struct grep_expr *compile_pattern_atom(struct grep_pat **list)
 {
@@ -687,11 +692,7 @@ static struct grep_expr *compile_pattern_and(struct grep_pat **list)
 		y = compile_pattern_and(list);
 		if (!y)
 			die("--and not followed by pattern expression");
-		CALLOC_ARRAY(z, 1);
-		z->node = GREP_NODE_AND;
-		z->u.binary.left = x;
-		z->u.binary.right = y;
-		return z;
+		return grep_and_expr(x, y);
 	}
 	return x;
 }
-- 
2.34.1.455.gd6eb6fd089
