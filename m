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
	by dcvr.yhbt.net (Postfix) with ESMTP id 412541F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387728AbfGZPxO (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:53:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44906 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfGZPxM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:53:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so24888329plr.11
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VCZxsILUVcitpoGXsTjVqdvtgRMVgTPW5fsCj5O6VH8=;
        b=g9C3lOwCNFtsuPapfmGAVX7CVkmtm00PNjdlMxmIBdNv+sV/ddTs87TFbLcNqB+r27
         Bghyu7m92oYKmEDc3/M4xHNNl9CfaXS+wqucai1+zUAIqHo8tATzkMJdn2EWfXIIEqfj
         O1oziFpJaAHT+yK4yjWv2FZhfABVmSiSIzaYY8iv479LpQYkfBo0gqKK3bCQxsPFxMoJ
         6EnNjKJiAzO1IfwpWbgcCwbaXbllfydrJ/0td/G6g0QWk+0mXavvdj7sanjddDfyp7VX
         bFHDgFY7dGCRG/H0M4PldcYhI0IPntqpnz9jf0D3zX08FJcHwtsg+P9UhkSls5aUeG+t
         QnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VCZxsILUVcitpoGXsTjVqdvtgRMVgTPW5fsCj5O6VH8=;
        b=iW4cRj4vYMAblSUcf0HgTL/Bhf0Xsw0DNHmnjF51rGytlL/YkkuQzFzcytYreOh3Zw
         DRwsqgTOWkOcH0PrCiAI8tdDomwTRltCM276Nt52qWpKys2k34wB58NvS3AXJQEgrwL/
         Z+gyxJBJhmD1v1bI1Noaseu3zdCRQ4t887vRea+7Xep9bO3KQLZkbIbi8gTiUFmM6Feh
         ZaAKXY17qaHkWlJFXwLs7S/bZWIUdnyGaUjqhw9q0zIs9tU/hBKEFam3IbUsITQdqTlj
         TCKvMLyZSBreMdDCduiqmEfUX8r1mSOtRSBgP+5qAqwveE0CDC5czVCjD+ldIwL4hKsV
         EX5A==
X-Gm-Message-State: APjAAAWsuEikM/CktDpMfgV3BURh0mK2lM4s8NwhifGqWaFntADG48fL
        x4ADekfOm64WUzSO/YcBDK3NEeia
X-Google-Smtp-Source: APXvYqy3uq3kwtu+np0fgGrsX8v3ujYVCqsVXZyxtPxdUFRmisrcelZwDd5BzYZ7md/BPJnZ8NadMA==
X-Received: by 2002:a17:902:44e:: with SMTP id 72mr97000358ple.326.1564156391516;
        Fri, 26 Jul 2019 08:53:11 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id f27sm36669638pgm.60.2019.07.26.08.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 08:53:10 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 06/20] merge-recursive: don't force external callers to do our logging
Date:   Fri, 26 Jul 2019 08:52:44 -0700
Message-Id: <20190726155258.28561-7-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.550.g71c37a0928.dirty
In-Reply-To: <20190726155258.28561-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
 <20190726155258.28561-1-newren@gmail.com>
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
index 4a481c3929..308e350ff1 100644
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
 
@@ -3607,7 +3604,9 @@ static int merge_start(struct merge_options *opt, struct tree *head)
 
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
2.22.0.550.g71c37a0928.dirty

