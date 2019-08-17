Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45AAF1F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfHQSmO (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 14:42:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44522 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfHQSmM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:42:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so4577707pgl.11
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iXiiIlQMqcCviuDYjOffVk+ojpLauEx41TtFe4Xh1Mk=;
        b=Zmnh3DKIFKPwW0pwnpQ95IofdHMHqWl2R8pPvIx0XrIbJvDWpjqlOZNWVocEswq8UM
         3SHElH9Rx9r5AttaXBn22eBXOvGRHT3SqLGFbpySWCmDlTVJlS8+pTO1uJZShe829Pxq
         25gIGd4tL0MULm5gSI5rerLD5yCN75v4AbokoSznGEO96A8GtrVwqsjezMtEpmPCa7ro
         rAykk0CQNdriu4t+UKaoB1cgGduUhqDE4ZnJMvMvYBjKU9mY1foIO8qlW1PP5Pe3PJm2
         13CzU+OCHs0eSKx7Rt6a4WbBPHHi+furPIkgZJ6/gTPCTvw4/6a7I2pwwP5W7Nw+uqkx
         cc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iXiiIlQMqcCviuDYjOffVk+ojpLauEx41TtFe4Xh1Mk=;
        b=r/l3jotUJ59uPfljqFlv1/Njx2gNPOyl7eSGnnumMxjtKzSMv4zxbhJVZfbYD66rQc
         7NYTy+kAoxApfDKSFBJqaMGrsQxb+h6t3CusOAvU9aPobfZZ9Tt7PF4V1jxHSpELP/jc
         panj27lDsbS5wm59DLCxOxwDJKujoCTAe27Qa7FDjXYL91qx4MkUVCi8VhbXj4rJB7iD
         62XaEgJ+9cyYA98cbsfoxx8O8ZNbkf2dMRwzDmwOit7562UeAAK9o8V3pFGDc5evLj3s
         V6aIMvLUHoYtxrszgVdTjGMnXMJl5HlpOawC0dPj0K28gAVENNSkaouQW/A5ZAp7GgTw
         9tZA==
X-Gm-Message-State: APjAAAWjY3mOVwfQzMlPVPGs6tz7l1P5W9fnUduS0WLOpG7NHFXYOVex
        uefKqnVtyltkEyhEsGR/zAVJdpR9
X-Google-Smtp-Source: APXvYqy5e2v85sOtzgtZlakjSGXvPuaFaD5csgV5cVhIUsY8JSmdiTc9RmVV2wa78gxTkDeQl0ODwQ==
X-Received: by 2002:a65:6401:: with SMTP id a1mr12938831pgv.42.1566067331020;
        Sat, 17 Aug 2019 11:42:11 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j15sm9990422pfr.146.2019.08.17.11.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 11:42:10 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 11/24] merge-recursive: don't force external callers to do our logging
Date:   Sat, 17 Aug 2019 11:41:31 -0700
Message-Id: <20190817184144.32179-12-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.28.g5f89f15d7b.dirty
In-Reply-To: <20190817184144.32179-1-newren@gmail.com>
References: <20190815214053.16594-1-newren@gmail.com>
 <20190817184144.32179-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alternatively, you can view this as "make the merge functions behave
more similarly."  merge-recursive has three different entry points:
merge_trees(), merge_recursive(), and merge_recursive_generic().  Two of
these would call diff_warn_rename_limit(), but merge_trees() didn't.
This lead to callers of merge_trees() needing to manually call
diff_warn_rename_limit() themselves.  Move this to the new
merge_finalize() function to make sure that all three entry points run
this function.

Note that there are two external callers of merge_trees(), one in
sequencer.c and one in builtin/checkout.c.  The one in sequencer.c is
cleaned up by this patch and just transfers where the call to
diff_warn_rename_limit() is made; the one in builtin/checkout.c is for
switching to a different commit and in the very rare case where the
warning might be triggered, it would probably be helpful to include
(e.g. if someone is modifying a file that has been renamed in moving to
the other commit, but there are so many renames between the commits that
the limit kicks in and none are detected, it may help to have an
explanation about why they got a delete/modify conflict instead of a
proper content merge in a renamed file).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 7 +++----
 sequencer.c       | 1 -
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 4ce783dbfa..fda67dd371 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3595,9 +3595,6 @@ static int merge_recursive_internal(struct merge_options *opt,
 	flush_output(opt);
 	if (!opt->call_depth && opt->buffer_output < 2)
 		strbuf_release(&opt->obuf);
-	if (show(opt, 2))
-		diff_warn_rename_limit("merge.renamelimit",
-				       opt->needed_rename_limit, 0);
 	return clean;
 }
 
@@ -3617,7 +3614,9 @@ static int merge_start(struct merge_options *opt, struct tree *head)
 
 static void merge_finalize(struct merge_options *opt)
 {
-	/* Common code for wrapping up merges will be added here later */
+	if (show(opt, 2))
+		diff_warn_rename_limit("merge.renamelimit",
+				       opt->needed_rename_limit, 0);
 }
 
 int merge_trees(struct merge_options *opt,
diff --git a/sequencer.c b/sequencer.c
index c4ed30f1b4..094a4dd03d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -617,7 +617,6 @@ static int do_recursive_merge(struct repository *r,
 	if (is_rebase_i(opts) && clean <= 0)
 		fputs(o.obuf.buf, stdout);
 	strbuf_release(&o.obuf);
-	diff_warn_rename_limit("merge.renamelimit", o.needed_rename_limit, 0);
 	if (clean < 0) {
 		rollback_lock_file(&index_lock);
 		return clean;
-- 
2.23.0.rc2.28.g5f89f15d7b.dirty

