Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CAF820401
	for <e@80x24.org>; Mon, 12 Jun 2017 22:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753021AbdFLWOt (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 18:14:49 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36020 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752371AbdFLWOi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 18:14:38 -0400
Received: by mail-pf0-f175.google.com with SMTP id x63so57245657pff.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 15:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PJP7FyBKsL9c4maE4kAYaMxLaS26RRgc7b8Eb7JoL7U=;
        b=PEFxeM4tDgNL7G/RMoRtVO4uOXZlUx5KVqI846uQSKGS3/GcuM4eqCL62vCdhil8SG
         lsqTMJTLion7hj35dXUhZZRPg46qZ2Ervu2BfiEiMSGTlqaRYk+hJw790g/NSPE4URVG
         rETYv+7fUofs2/PVTxzFUlun19FryNO7QszbqkOoVgIsaXDwhp96gLdHo118ak+u7K0+
         jcDDkpyZ9Wbmtz4BvWCU3FfH+wFEMBDXTG9NAjPzmpFE/WhnyPGg657WXF3tognSlAzd
         6ARw0g05ZIZTr21JTRPEmOg+73FDnDcND6lBraubLfaa/mUU4N8AJDPOE4tzf21dv0eY
         dlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PJP7FyBKsL9c4maE4kAYaMxLaS26RRgc7b8Eb7JoL7U=;
        b=BqJ3S6kardUcV89dt2ZJEqVF0/RSUaSf1zgXSxS3TE4DtTBZ7heq6CHa83kzZxyzYD
         C15x5h5qRyAJgeXllTGRxwtappbA1GgmHDC3iKPhshvVFVpSUOgHgXqBe5AtZ0tQqv9Z
         7rh4BYqQ/el8968gi1jeFtx4uofzb9xlqXEAkHiM1CJTuQXH4Ij9yOS84xZsDEvRKc3m
         fTwmdQgfzjInu/qlPbGLgCtTuVZY0vavCTWtg5I4rdxpF6TAIq8ktuWOQwnAoD0tvaoY
         8blziclWulJ2ymv1m53PRA5i/7hN13JWaQPrnmvIfH16Njk77pTpF9RMGyQNLfC0gdj+
         j33Q==
X-Gm-Message-State: AODbwcBDo2fvEqGHcHzG6Jrn2dk4ydYL8FlPu2ZrH1C9gWgurss3mVem
        HN/kHmA7j+DfkxHUuoUD0g==
X-Received: by 10.99.188.18 with SMTP id q18mr49760676pge.79.1497305677088;
        Mon, 12 Jun 2017 15:14:37 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id i68sm22403884pfi.72.2017.06.12.15.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 15:14:35 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 12/17] ls-files: convert ce_excluded to take an index
Date:   Mon, 12 Jun 2017 15:14:03 -0700
Message-Id: <20170612221408.173876-13-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170612221408.173876-1-bmwill@google.com>
References: <20170612221408.173876-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 375fe09d1..762257f39 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -321,10 +321,11 @@ static void show_ru_info(const struct index_state *istate)
 	}
 }
 
-static int ce_excluded(struct dir_struct *dir, const struct cache_entry *ce)
+static int ce_excluded(struct dir_struct *dir, struct index_state *istate,
+		       const struct cache_entry *ce)
 {
 	int dtype = ce_to_dtype(ce);
-	return is_excluded(dir, &the_index, ce->name, &dtype);
+	return is_excluded(dir, istate, ce->name, &dtype);
 }
 
 static void show_files(struct dir_struct *dir)
@@ -345,7 +346,7 @@ static void show_files(struct dir_struct *dir)
 		for (i = 0; i < active_nr; i++) {
 			const struct cache_entry *ce = active_cache[i];
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
-			    !ce_excluded(dir, ce))
+			    !ce_excluded(dir, &the_index, ce))
 				continue;
 			if (show_unmerged && !ce_stage(ce))
 				continue;
@@ -361,7 +362,7 @@ static void show_files(struct dir_struct *dir)
 			struct stat st;
 			int err;
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
-			    !ce_excluded(dir, ce))
+			    !ce_excluded(dir, &the_index, ce))
 				continue;
 			if (ce->ce_flags & CE_UPDATE)
 				continue;
-- 
2.13.1.518.g3df882009-goog

