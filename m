Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04D001FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbdFTCtc (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:49:32 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35331 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbdFTCsm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:42 -0400
Received: by mail-pf0-f169.google.com with SMTP id c73so2561290pfk.2
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LdIVXa/Y/Y568qkkyIjSsd/acOr18tMAVbtEDy9W9XM=;
        b=ct3EHGiEdJIZaF+VM4o05tSUvrIIod6aOGFW3oYqj3G6sLWKs5wLfHudM78W+3q7Po
         CA+Lbe2MdU+FMSLDC7zuOmAXj4SrtGaluyMKwst+pG0ia20ehz2U2qiBhpSIqqzhZKW9
         WMelzFIAyMs9o3KY6DtoYjccRJwVOO5jtttdAuj1M2KrM/j83HAxNiLHPVIfMVGLJYns
         Bvafm5qXQITeEXW9tJpgIATOW+w1LEB3/HSAA6hceCN4mFPKQChCb5jjJVc6LUSurPK7
         9MzucNF3csHhRBdGCTTdMrdZWxzdoAibG4IHU/LvQd6bFlzB6L0pxdeck6XhHbwmt4ps
         VLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LdIVXa/Y/Y568qkkyIjSsd/acOr18tMAVbtEDy9W9XM=;
        b=UMOE5t/Tg29yNiywbXI6VYSFYSDFzryFY5C+bz3P6sUXMcbaXExKOjCytsnlKVZ2dW
         hG1ABiJ10OZdPLZDX44OVSlFSSuyszezI8AYCicPknOUwf+jlLz7tzvPJrHc2IgSZUfs
         a33dvyH65nn2BEtnpMUTBygB9+sA4etmxyGho6XqAgOELaDGbnG4vV5JZ3bG/MtE7kjP
         Kq4GGlifd9OtnRuzbFfCgAOWtY4sdBqbCEPlmoy/k5jKjghmJRhATdSYfEOl9KcWv2+F
         9ggAq0dPlRZW3xS7K5nCGHKlMFakCaIN+4I/uzYQb1uogHOo4HFwy6vwpq55C9q8NxEO
         N+Tg==
X-Gm-Message-State: AKS2vOxoFpPI3mGzLkqJ5m1CyG5EJUPTPl2ECyTlfz1Xah2u9WmpuhkZ
        0KR4KdFxYnc8/LHB
X-Received: by 10.101.88.130 with SMTP id d2mr29611711pgu.58.1497926916889;
        Mon, 19 Jun 2017 19:48:36 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id j6sm24617756pgc.1.2017.06.19.19.48.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:36 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 10/26] diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_INCOMPLETE
Date:   Mon, 19 Jun 2017 19:48:00 -0700
Message-Id: <20170620024816.20021-11-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170620024816.20021-1-sbeller@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 7096457c8a..e6029e8213 100644
--- a/diff.c
+++ b/diff.c
@@ -565,6 +565,7 @@ enum diff_symbol {
 	DIFF_SYMBOL_CONTEXT_FRAGINFO,
 	DIFF_SYMBOL_NO_LF_EOF,
 	DIFF_SYMBOL_CONTEXT,
+	DIFF_SYMBOL_CONTEXT_INCOMPLETE,
 	DIFF_SYMBOL_PLUS,
 	DIFF_SYMBOL_MINUS,
 	DIFF_SYMBOL_WORDS_PORCELAIN,
@@ -637,6 +638,11 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 		emit_line_ws_markup(o, set, reset, line, len, ' ',
 				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
 		break;
+	case DIFF_SYMBOL_CONTEXT_INCOMPLETE:
+		context = diff_get_color_opt(o, DIFF_CONTEXT);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		emit_line(o, context, reset, line, len);
+		break;
 	case DIFF_SYMBOL_PLUS:
 		set = diff_get_color_opt(o, DIFF_FILE_NEW);
 		reset = diff_get_color_opt(o, DIFF_RESET);
@@ -1448,8 +1454,8 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	default:
 		/* incomplete line at the end */
 		ecbdata->lno_in_preimage++;
-		emit_line(o, diff_get_color(ecbdata->color_diff, DIFF_CONTEXT),
-			  reset, line, len);
+		emit_diff_symbol(o, DIFF_SYMBOL_CONTEXT_INCOMPLETE,
+				 line, len, 0);
 		break;
 	}
 }
-- 
2.12.2.575.gb14f27f917

