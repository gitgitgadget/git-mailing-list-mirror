Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E5EE1FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751771AbdFTCsv (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:48:51 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34301 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbdFTCss (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:48 -0400
Received: by mail-pg0-f53.google.com with SMTP id e187so4230456pgc.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+jjL1XFwXpTpL4zQxw4draTGyfgkQXukJLZQ6daAVN4=;
        b=i7RegXS3w/nP0bOE8GtYbEYbKEdmbf3meFXofKSGO83F41/Ob4No7PvlvI3PpRcMJR
         FX/GqdqDn/tl5A3Ga7DLpROSJ3AQcUFMPKKaxv3wPTWP2G2mdtr8Or3rPfsXOQ6xT/fT
         f8UJZkgSuOdsaGFJeg26Q8o0pu7KQsiwdVyV7FIc8Uu/V2635flpTDk6i9oM+eVBaMeO
         SPiNtEE2L7eYMwSO0E+fYABaESCp5z4lBBH43gM8RYg2xquvGCFf+2eCR5sHGETxi4BW
         hx6Jy5goQqVixUKgPHLd018ZwbF411R5PEUYzQ70T/+aD+9zj9lnHYOU2Km+pHzD1Txx
         qyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+jjL1XFwXpTpL4zQxw4draTGyfgkQXukJLZQ6daAVN4=;
        b=d80TGj5aP3XX6zHX+WUQZytL26QNfKje6df4w+mEFCWomiPjBXENd2pc6leGGnXTIA
         V+VBJAO8JGuijs1Cks3cqjQd0iuEHP4lAlNjq6q577k9mVzjabaBFvqCJfoC9GNFZUTl
         iOOnrLW3p5yWGeffH2yYHytPEVXVIlGSMAZoWgelvsX+y79d+d2t3XSXa6JWO66N2s7r
         prKPT/lfyH7tkWjPCqxWWQ13uGbThq6OGy7UorWkDuZ6D3Lf2TryYkzOmZ65xysgjMIC
         c8uwEmFiItPrnsxeS1deZWMnZ05upqEa/d1lZk0WM/UJtO/3hxdv+LBohUZ31R54olM4
         E5Iw==
X-Gm-Message-State: AKS2vOxchBpihsDGZTekweCvE2S8zVzwXJYCdz741609BMjHAQs9Rnsk
        5JjaKQ01aN+4+/Ucd0MSXw==
X-Received: by 10.98.220.12 with SMTP id t12mr28522060pfg.203.1497926927809;
        Mon, 19 Jun 2017 19:48:47 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id o2sm23487028pgq.44.2017.06.19.19.48.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:47 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 19/26] diff.c: emit_diff_symbol learns about DIFF_SYMBOL_STAT_SEP
Date:   Mon, 19 Jun 2017 19:48:09 -0700
Message-Id: <20170620024816.20021-20-sbeller@google.com>
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
 diff.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 5b46baa12a..18bfc4720b 100644
--- a/diff.c
+++ b/diff.c
@@ -591,6 +591,7 @@ enum diff_symbol {
 	DIFF_SYMBOL_STATS_SUMMARY_INSERTS_DELETES,
 	DIFF_SYMBOL_STATS_LINE,
 	DIFF_SYMBOL_WORD_DIFF,
+	DIFF_SYMBOL_STAT_SEP,
 };
 /*
  * Flags for content lines:
@@ -776,6 +777,9 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 	case DIFF_SYMBOL_WORD_DIFF:
 		fprintf(o->file, "%.*s", len, line);
 		break;
+	case DIFF_SYMBOL_STAT_SEP:
+		fputs(o->stat_sep, o->file);
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
@@ -5085,10 +5089,10 @@ void diff_flush(struct diff_options *options)
 	if (output_format & DIFF_FORMAT_PATCH) {
 		if (separator) {
 			emit_diff_symbol(options, DIFF_SYMBOL_SEPARATOR, NULL, 0, 0);
-			if (options->stat_sep) {
+			if (options->stat_sep)
 				/* attach patch instead of inline */
-				fputs(options->stat_sep, options->file);
-			}
+				emit_diff_symbol(options, DIFF_SYMBOL_STAT_SEP,
+						 NULL, 0, 0);
 		}
 
 		diff_flush_patch_all_file_pairs(options);
-- 
2.12.2.575.gb14f27f917

