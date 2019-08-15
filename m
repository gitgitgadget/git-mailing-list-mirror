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
	by dcvr.yhbt.net (Postfix) with ESMTP id 56A241F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 21:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732929AbfHOVl2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 17:41:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36724 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732317AbfHOVl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 17:41:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id w2so1991189pfi.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 14:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kk4iUE/1sdBZh5tYDjhT0S5gT9SJsyy5VP1Pc58DjJ0=;
        b=lHL7AjiRRHWMSqDlGWZfcNpjjewBm0wxtsmrD0Y+wnnWTxZMF3fnj+a9Rah0sFphxE
         QDN815RzjybfxcJlzKPy7oZ/yXJedpjOi2gLZaQ00oIgtpcSO60g5SZFuKWNa5pzPDIR
         ImJoI1olBOnZban7j6L7M4Di5YI13gzaJGQkNBq2xwYcwH+cFKjAgV5dkk0/Z4ope5iR
         eCO91aXRdnbDq/3JSILmTApshcLgxeHxPdq9UHm7Ts1lMKcfPwGIuJMJrbMpd2TIXQSd
         m4RfFkgt1MUfzhLLrlN2VH3wtm5Uj0uRXv+bwdQHf/Tv01kYXEm7PHcSDf70rFOMPwch
         GjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kk4iUE/1sdBZh5tYDjhT0S5gT9SJsyy5VP1Pc58DjJ0=;
        b=tzUx1MNhggvI4qVIoP3K/VWd44SHdVvVWuqghI79ptaJJhYaNAM5ooA0ZMa+tno9Ei
         jQ0UtKFU9JeRobrNWk62QHuwYpuEHiNOJGQDFVz2bm/FeNJpuyr8uNp1EVMrwUo6+lhI
         CYr312zxjWc9PuID+fx6IxuFKI47xlMJVHLCNgchpVJkGBZzFKxPnhJ93KkNQhUWVfos
         Vnlmv5RdYQG2EZGZIKa7p4sMKEE2qqvtmCRfjFdH5i+GGiw7VUf5vKqAvUTPZVRrCGGj
         wZdQ5ynXJlr2WegoC5TbfrgzV78B6VNTp3Py0YjDpEp1FWMIz1K2ElbHrOS/6szxFziZ
         whlw==
X-Gm-Message-State: APjAAAW0n0eLNe1TxdsTeMTmb5FC+ncq7OyS1Lm6Aa6w417Al8lg9jfJ
        3/OQU1Fsq6oRZtuAzSLUNUP2m+V3
X-Google-Smtp-Source: APXvYqyogXsWbPjioXXDjrjn82X1Pg4fZGB2G9vz1gpuF28+EKykSScQxY4Ae89cDEHTI+K4ZWJF9Q==
X-Received: by 2002:a63:31cc:: with SMTP id x195mr4981577pgx.147.1565905285390;
        Thu, 15 Aug 2019 14:41:25 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id i124sm4131966pfe.61.2019.08.15.14.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 14:41:24 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 11/24] merge-recursive: don't force external callers to do our logging
Date:   Thu, 15 Aug 2019 14:40:40 -0700
Message-Id: <20190815214053.16594-12-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.32.g2123e9e4e4
In-Reply-To: <20190815214053.16594-1-newren@gmail.com>
References: <20190726155258.28561-1-newren@gmail.com>
 <20190815214053.16594-1-newren@gmail.com>
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
index 89e9a7518c..6cee867d37 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3600,9 +3600,6 @@ static int merge_recursive_internal(struct merge_options *opt,
 	flush_output(opt);
 	if (!opt->call_depth && opt->buffer_output < 2)
 		strbuf_release(&opt->obuf);
-	if (show(opt, 2))
-		diff_warn_rename_limit("merge.renamelimit",
-				       opt->needed_rename_limit, 0);
 	return clean;
 }
 
@@ -3622,7 +3619,9 @@ static int merge_start(struct merge_options *opt, struct tree *head)
 
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
2.23.0.rc2.32.g2123e9e4e4

