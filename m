Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E061A20437
	for <e@80x24.org>; Tue, 31 Oct 2017 18:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932542AbdJaSTZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 14:19:25 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:55220 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932532AbdJaSTX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 14:19:23 -0400
Received: by mail-pf0-f193.google.com with SMTP id n89so14377621pfk.11
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 11:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=li4qnlYYZqM10dZvMAE+mxNoNIjoSkGjuuDyU72y9JM=;
        b=B5s0fTPcpxgdyanT6AasRFBrIjixAD8S87alW/FoTnwF4LW3ViVsaF0Sf08U6NCgoX
         1Jc7/I7gqwTZKOEGj7HKPli0EU+X7SGwavSopKlBaKpFfQn6TzAg/bOIe4t1xPlyFDpj
         VMSZAzsrUOgSjcotSS+/YHSUpSf2yGPTQJSX8es8x8jXL1i+774xmATXaw7UpXQl7G8r
         oufAV0d2phu9iJl8zXnhdm8TPTDwq1KbTh/+yqDOAO4WbMZpZU9wkBu9uIFDZ83SA/Qn
         szdATwnfanlDLXIAN7yiuDRjEBtdyoOxlkg3KRbMF41/l28ud8EU0DSegJB7FSYEkL5K
         PWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=li4qnlYYZqM10dZvMAE+mxNoNIjoSkGjuuDyU72y9JM=;
        b=GraXjet/lJ84FLcRocnufNcG33TJCAt6QPT2axZhEnupGs3crP4rE+nDNcNLazETZ4
         vqSaCJV+toHjvRlAQL3IyD7kpec8q7DtoxODDScgWQw2hcd0Ua6UJnSwVDQXQqkm3TBb
         nvN9zWOjvpLCwzOk48yAPuPSBDE4xX37TVNBq7ZA1BY8q7juxMuARsP9bqzqAKOGd+Bd
         AMYaEYaRfHJjU3oyh8lqBj6hQCMPVUJePTx5Yh55ULBI+4fKAhG3LUXIYtHwdnFeR22O
         sIUj6ldAWhifZzN6RgIV3yCh1/HxCzsMeSjApHqnNo0/YoAS5+leBTbf8s5xB4H7SzFe
         0wLg==
X-Gm-Message-State: AMCzsaUEghjK4r3B08QAa0YmwqGbVv8xphDvAoIQN4OnJYjhKnuFReSm
        9zU6BL3Omopt9Wkv1XZpX3pAbTXN+0k=
X-Google-Smtp-Source: ABhQp+Ta1ehhyguBZJc3+HG3doheAD0CLfAIFktl9i/yK2WgTyFMFCmX5zbpEKcTOJMB4KE5UQV59w==
X-Received: by 10.99.52.196 with SMTP id b187mr2748758pga.222.1509473962157;
        Tue, 31 Oct 2017 11:19:22 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id a78sm4308985pfl.122.2017.10.31.11.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Oct 2017 11:19:20 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 4/8] diff: remove touched flags
Date:   Tue, 31 Oct 2017 11:19:07 -0700
Message-Id: <20171031181911.42687-5-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.403.gc27cc4dac6-goog
In-Reply-To: <20171031181911.42687-1-bmwill@google.com>
References: <20171030194646.27473-1-bmwill@google.com>
 <20171031181911.42687-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the set of parallel touched flags are no longer being used,
remove them.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/log.c | 2 --
 diff.h        | 6 ++----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 82131751d..9c0815270 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -134,8 +134,6 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 
 	if (default_date_mode)
 		parse_date_format(default_date_mode, &rev->date_mode);
-
-	memset(&rev->diffopt.touched_flags, 0, sizeof(struct diff_flags));
 }
 
 static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
diff --git a/diff.h b/diff.h
index d077d3c10..26a1cab87 100644
--- a/diff.h
+++ b/diff.h
@@ -107,9 +107,8 @@ static inline void diff_flags_or(struct diff_flags *a,
 }
 
 #define DIFF_OPT_TST(opts, flag)	((opts)->flags.flag)
-#define DIFF_OPT_TOUCHED(opts, flag)	((opts)->touched_flags.flag)
-#define DIFF_OPT_SET(opts, flag)	(((opts)->flags.flag = 1),((opts)->touched_flags.flag = 1))
-#define DIFF_OPT_CLR(opts, flag)	(((opts)->flags.flag = 0),((opts)->touched_flags.flag = 1))
+#define DIFF_OPT_SET(opts, flag)	((opts)->flags.flag = 1)
+#define DIFF_OPT_CLR(opts, flag)	((opts)->flags.flag = 0)
 
 #define DIFF_XDL_TST(opts, flag)    ((opts)->xdl_opts & XDF_##flag)
 #define DIFF_XDL_SET(opts, flag)    ((opts)->xdl_opts |= XDF_##flag)
@@ -138,7 +137,6 @@ struct diff_options {
 	const char *line_prefix;
 	size_t line_prefix_length;
 	struct diff_flags flags;
-	struct diff_flags touched_flags;
 
 	/* diff-filter bits */
 	unsigned int filter;
-- 
2.15.0.403.gc27cc4dac6-goog

