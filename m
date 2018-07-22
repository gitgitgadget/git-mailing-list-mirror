Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC7D31F597
	for <e@80x24.org>; Sun, 22 Jul 2018 09:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbeGVKyR (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 06:54:17 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35715 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbeGVKyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 06:54:16 -0400
Received: by mail-io0-f195.google.com with SMTP id w11-v6so7735119iob.2
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 02:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XlQSO2s1Msj6F8Az93q+B05beRSSEqWz6Ctizpn74o4=;
        b=rptfp+VlREFm18phqGcbxPRiuojq5b8dewj1BVYDrV9Y3DBtFy6ccwss76O9UgAlZk
         7zhInwyI17ooXzD03VMq+dtufiMveqnkVTTQdYECNEdzzkVyQ3lC0FfhRhUH2//5IJ4a
         5LL8tiwfbx14keGxmGHJMEBWBdawbIFpYV7YOcwqvUNzr+P51MWsifgAcQP/+mJqjpk0
         X1/UIX0wGK4Toarx15vcgnICJE4s2tU9XK+FukACyLy0Pf9xnoZSXJSf73oH7WDaZSTv
         Dm+MvQfb43PfZLGecDgvOSCTrh9gES0nCdlZdkDvc1RteDu2qSViOQDWfBuTIAC801ZR
         ppMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XlQSO2s1Msj6F8Az93q+B05beRSSEqWz6Ctizpn74o4=;
        b=VGHbMXJbrLz4EjnGVIMfr5NwiT5o0gAHvg31UB3t3Lni5ZS97YeHFKXHY2ePzXFPkr
         drlIkHVExe2dcL9duIsUDsB9h1C2AZjFboT3apiSCLIsaXEgkiCXed5YeerIAEd4YqXM
         7M7sniHXldykGkfDDli9Hc7Nf1bowr3a0JJezBidN4ztYjqBca3WuPsmUExLQ+hpK8r5
         spR/oi2C1OdVzuainOUAtmXEGH+tRuNwnzxeaAxobdpa2N3kpgyikxRei+6xGholcJLz
         Xki36qmphBzZYzu/2D1etH5Jl+6WtLlPV31p7ls0T6m3JG6mSLXllQJshY8nwCrNp3il
         qGZg==
X-Gm-Message-State: AOUpUlGKCR1IekHH+Ss/ymo62YQH1s98CbXeLkhwZUYbBqj11MLu0/+P
        c15iWFPm5hEUuZ0r9TofT0m1+BZc
X-Google-Smtp-Source: AAOMgpdnZqbChOYvi7ac/yP1RgSvSSMrsdt9kCTy+MNQ0/AGCPccbolM2DvrWzgwe1xzW9HOVdwGEg==
X-Received: by 2002:a6b:5903:: with SMTP id n3-v6mr6573477iob.7.1532253487215;
        Sun, 22 Jul 2018 02:58:07 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id w13-v6sm3681298itb.29.2018.07.22.02.58.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 02:58:06 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 12/14] format-patch: teach --range-diff to respect -v/--reroll-count
Date:   Sun, 22 Jul 2018 05:57:15 -0400
Message-Id: <20180722095717.17912-13-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180722095717.17912-1-sunshine@sunshineco.com>
References: <20180722095717.17912-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --range-diff option announces the embedded range-diff generically
as "Range-diff:", however, we can do better when --reroll-count is
specified by emitting "Range-diff against v{n}:" instead.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/log.c | 7 ++++++-
 revision.h    | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 4f937aad15..fdb2180d7e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1091,7 +1091,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	}
 
 	if (rev->rdiff1) {
-		fprintf_ln(rev->diffopt.file, "%s", _("Range-diff:"));
+		fprintf_ln(rev->diffopt.file, "%s", rev->rdiff_title);
 		show_range_diff(rev->rdiff1, rev->rdiff2,
 				rev->creation_factor, 1, &rev->diffopt);
 	}
@@ -1496,6 +1496,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	const char *rdiff_prev = NULL;
 	struct strbuf rdiff1 = STRBUF_INIT;
 	struct strbuf rdiff2 = STRBUF_INIT;
+	struct strbuf rdiff_title = STRBUF_INIT;
 
 	const struct option builtin_format_patch_options[] = {
 		{ OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
@@ -1815,6 +1816,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		rev.rdiff1 = rdiff1.buf;
 		rev.rdiff2 = rdiff2.buf;
 		rev.creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
+		rev.rdiff_title = diff_title(&rdiff_title, reroll_count,
+					     _("Range-diff:"),
+					     _("Range-diff against v%d:"));
 	}
 
 	if (!signature) {
@@ -1942,6 +1946,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	strbuf_release(&idiff_title);
 	strbuf_release(&rdiff1);
 	strbuf_release(&rdiff2);
+	strbuf_release(&rdiff_title);
 	return 0;
 }
 
diff --git a/revision.h b/revision.h
index 11159416dc..cd0873b575 100644
--- a/revision.h
+++ b/revision.h
@@ -221,6 +221,7 @@ struct rev_info {
 	const char *rdiff1;
 	const char *rdiff2;
 	int creation_factor;
+	const char *rdiff_title;
 
 	/* commit counts */
 	int count_left;
-- 
2.18.0.345.g5c9ce644c3

