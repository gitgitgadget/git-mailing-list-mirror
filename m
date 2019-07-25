Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64CFC1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 17:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403792AbfGYRqX (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 13:46:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46504 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403778AbfGYRqW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 13:46:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id c73so23111920pfb.13
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 10:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6f7Rzb8SHj4dYosrjc9FaSXPFeMSZLmssaIQOBjVe10=;
        b=uk/j7/fuGq0ziQYt5Eps1uhJ9bcZR4fZb0izkIm6LtNh3eENoU8/QbCJ25EbdoXNd3
         jNhvScTGSayHNcICOTL5sJjFK4NL2gWPJ82Grmz1v6VYRX3kH3BdIZoyOVu/q6yF899b
         3bxu7avIw7tjdA9jw7rnYqkQOny5n3TGmwESXi0oCwvY+2VRrmHcDUnWQy3vULQLPxXE
         rzu2kMV10MM04h448ikmTPKvNCD2KYc7kJFcOFh/VhX1dqEf+S7c4BC1atzDsE0gd+7s
         6WPhHs1N+4abT/wC3n4vKtzufHxY78u5ncmXs/XQqSh5I9Wh5HzSp/CyUzjrcgyAM9P1
         XZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6f7Rzb8SHj4dYosrjc9FaSXPFeMSZLmssaIQOBjVe10=;
        b=uHS5sIyGx8EC8E+t+cYrSUPVeYAGMhyOLVXA5WySaltnv59qbel8rtA+xCD5iezwDb
         UKAX1b5lEQdxjLhG5YsbTh6ipGVqgl3aC7yLaIF8cy25tBTNwjlTOwjikofma26pjos3
         +3DBMjD9TAe7bv0d0RkR1RQy5SPKhasUYdP/jG1AOOdmRsLMZRDlFXM84Nb4TuwS1vN8
         lsZlCeIFinxm/hH050C8lu0juBl3M3XLT5VXp1kNG3SjuGu1WogZbnukLv4gXFtz0mL7
         43xibwu3rI8eGMVajMOE4fYzg+qGvzYp5YzLnwtknN93wxKTLdcVUajwgB1IQ4e3O2w6
         PSoQ==
X-Gm-Message-State: APjAAAWm6xTRF5SWIuSLCTQiURVjLSH3bCDqGYy1Tm+JtFosU5WCyfZ0
        TPOtEWJmfBQtuvTFR+Fek3KjyA6H
X-Google-Smtp-Source: APXvYqya+VdIaLqPBa0XxqazJySHRdJ2kIPCBIafh8zr8GojSBzoyqIEdkbj65ypGeKo/6yPx4zylw==
X-Received: by 2002:a63:4c5a:: with SMTP id m26mr85878709pgl.270.1564076781966;
        Thu, 25 Jul 2019 10:46:21 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id v138sm58171800pfc.15.2019.07.25.10.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 10:46:21 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 05/19] merge-recursive: don't force external callers to do our logging
Date:   Thu, 25 Jul 2019 10:45:57 -0700
Message-Id: <20190725174611.14802-6-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.559.g28a8880890.dirty
In-Reply-To: <20190725174611.14802-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 7 +++----
 sequencer.c       | 1 -
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index b762ecd7bd..7f56cb0ed1 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3583,9 +3583,6 @@ static int merge_recursive_internal(struct merge_options *opt,
 	flush_output(opt);
 	if (!opt->call_depth && opt->buffer_output < 2)
 		strbuf_release(&opt->obuf);
-	if (show(opt, 2))
-		diff_warn_rename_limit("merge.renamelimit",
-				       opt->needed_rename_limit, 0);
 	return clean;
 }
 
@@ -3606,7 +3603,9 @@ static int merge_start(struct merge_options *opt, struct tree *head)
 
 static void merge_finalize(struct merge_options *opt)
 {
-	/* Common code for wrapping up merges will be added here later */
+	if (show(opt, 2))
+		diff_warn_rename_limit("merge.renamelimit",
+				       opt->needed_rename_limit, 0);
 }
 
 int merge_trees(struct merge_options *opt,
diff --git a/sequencer.c b/sequencer.c
index 34ebf8ed94..c85e594704 100644
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
2.22.0.559.g28a8880890.dirty

