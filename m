Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F1541F4B6
	for <e@80x24.org>; Thu, 11 Jul 2019 16:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbfGKQJH (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 12:09:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40921 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGKQJG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 12:09:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so6910177wrl.7
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O0O/eXuhEnD5jx/0ReEjojd9SJEmu2xsvsKP7ud/r9I=;
        b=ZatYcW8L9XJE9tsYyanIiuPw6i9EK4/E5Me38Qq4rNuh9JJsICVLxEAqM/84BR9h/m
         Ll0Bkb9d90aXdEWfxCZ+nawK3deI6l8qRruY3AeniCp6D1pvt2YoJ2y03gA303TU+6T1
         B7SwvmC2dXoBgROFM5HXoLBGy1tD3RSaWf1iyQq9UeusJvlqUr8/JstoGRjvn1ETYiy5
         T4e3YFxcpW/nt3L91c99hhsWG19TtqwOVkWQ00sBWkcHEtGIXxdd1VOUZetyJZrAj4Ps
         ax1cAQrL+V3Hapeksq5xZd1Ob01bQ5tZpyanTiT2O/+4Nz9V+4RMRk9gegkZFk9RJx/2
         HREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O0O/eXuhEnD5jx/0ReEjojd9SJEmu2xsvsKP7ud/r9I=;
        b=snPPjEFRZSIrobXYUDEUeHZoPsimcemn9oDquOZi4QbPy2vSy4Hqy6aGDW0zanACfX
         dnfIUInJdK1znKPApvjDu03yCLMLJ8kxvMxBNccKx9046owdZs8yOIX5Me5g70quGCDE
         2BafkHIHSrVs8mOYu00UbyqHTqfsXy7rEcTupGYwJ1ryowZTV5Lp8vnyeGQXoMst6pJn
         aXR8zb5hc+lE8FIhntuXL7SIfHDvmMI0skEJ649WImrDfb9Q8Qd2/JiAOB8cSEpdE1zZ
         c6waM4BRK9Re3O707VZB03eov/TdPHhSjftTj/bQRG3Hf5v7SIIgwIVbc3FyH6LB841G
         v5vg==
X-Gm-Message-State: APjAAAUZBWmCf44lVhYc+Omi+iGoCIMo+Wzt6lNyo/NolRbozsHRINmr
        Of5cgUPS/uFP1D8LRFLNrPrZ0pCePSs=
X-Google-Smtp-Source: APXvYqxlMJ8ssy99JP+ZauZdG5q4ceAHZyG+zg9WZeZlvC+B0+vozb0dMZFwJLXn3Ykow1snUO6IRQ==
X-Received: by 2002:a5d:5450:: with SMTP id w16mr6258685wrv.128.1562861344868;
        Thu, 11 Jul 2019 09:09:04 -0700 (PDT)
Received: from localhost (host232-157-dynamic.24-79-r.retail.telecomitalia.it. [79.24.157.232])
        by smtp.gmail.com with ESMTPSA id c78sm6742616wmd.16.2019.07.11.09.09.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 09:09:03 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 04/14] apply: only pass required data to check_header_line
Date:   Thu, 11 Jul 2019 17:08:41 +0100
Message-Id: <20190711160851.14380-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190711160851.14380-1-t.gummerer@gmail.com>
References: <20190708163315.29912-1-t.gummerer@gmail.com>
 <20190711160851.14380-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently the 'check_header_line()' function takes 'struct
apply_state' as parameter, even though it only needs the linenr from
that struct.

This function is in the callchain of 'parse_git_header()', which we
want to make more generally useful in a subsequent commit.  To make
that happen we only want to pass in the required data to
'parse_git_header()', and not the whole 'struct apply_state', and thus
we want functions in the callchain of 'parse_git_header()' to only
take arguments they really need.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 apply.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index ac668e754d..1602fd5db0 100644
--- a/apply.c
+++ b/apply.c
@@ -1302,15 +1302,15 @@ static char *git_header_name(int p_value,
 	}
 }
 
-static int check_header_line(struct apply_state *state, struct patch *patch)
+static int check_header_line(int linenr, struct patch *patch)
 {
 	int extensions = (patch->is_delete == 1) + (patch->is_new == 1) +
 			 (patch->is_rename == 1) + (patch->is_copy == 1);
 	if (extensions > 1)
 		return error(_("inconsistent header lines %d and %d"),
-			     patch->extension_linenr, state->linenr);
+			     patch->extension_linenr, linenr);
 	if (extensions && !patch->extension_linenr)
-		patch->extension_linenr = state->linenr;
+		patch->extension_linenr = linenr;
 	return 0;
 }
 
@@ -1380,7 +1380,7 @@ static int parse_git_header(struct apply_state *state,
 			res = p->fn(state, line + oplen, patch);
 			if (res < 0)
 				return -1;
-			if (check_header_line(state, patch))
+			if (check_header_line(state->linenr, patch))
 				return -1;
 			if (res > 0)
 				return offset;
-- 
2.22.0.510.g264f2c817a

