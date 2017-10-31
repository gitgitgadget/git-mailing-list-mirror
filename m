Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA07120437
	for <e@80x24.org>; Tue, 31 Oct 2017 18:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932476AbdJaSTU (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 14:19:20 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:52583 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932386AbdJaSTS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 14:19:18 -0400
Received: by mail-pg0-f65.google.com with SMTP id a192so15343657pge.9
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 11:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IO8tlypddJATV0y2Ya2EIEinq09WBYz+HLfSWiH2ZNI=;
        b=LSKNztacgyMEQR0RQUDwim830Lv6lQ8DmsaXO5pHrSvctTanQITWDPnYnI2nzRMSkS
         XOBT30beG6c6NZrMF+yUemGw63JD6GOHKwVYJbXg708HKmxzd6SOwZAaZIb9+WkE4nkC
         Zrr/m07Xvphy/s4Da3avFieIIyIbwllgDO2dch70gNMAIBvcx8Hpp0LHyxAVmjKaT1GF
         4t8k/XL5DD/30U+TN/I4oD7ta5etOdYt/cGC1TSX6R+nkBDd/5poh4hl4CDGt4muhYky
         5E6RMIM6mOpA1NWBpT6hkbesf2hskC4oRU3ZvTPuvEV0kGdkunnsuM5bCzKQSm5vdyM9
         lkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IO8tlypddJATV0y2Ya2EIEinq09WBYz+HLfSWiH2ZNI=;
        b=FQZEKY7hgBRDRiqoijMyRMPhMUNxzg7qTYNnAOX9XrDgvCtXXUB4R+KwwKMYDkkR/V
         inZkWOJYGsTw6CWUv5g7bv7fua1Qp7ZqPn/RH5Ks3g2Q7kJ3pVallHyjGGsWCOft+MKY
         97Qs6mx9WyUhP7zAEDffUvmSuUfoyLFatWoYQfnZa3o6FRxms/MN5lyDw7u0Y4wq9jMp
         Jj5p5y6EdugZ/lPhme5mCgT0LjMyZnrF8Kt0Fz88mSeVtz5/uS40LTpIljkhqFbe4qcm
         j1WezDo+6GobyMe3gwrt2yU4E0Phge7iUZwmxTLDuRovB9q4SulcPjDciVQvFuoMCPyD
         CmTA==
X-Gm-Message-State: AMCzsaVyngOavV9rUqi7mnNUUd49LlfQZc0+oQv7knwAszZYMlhOK2UG
        zPLYmmntIn0hyEH86yyiNXR9MGuTu3c=
X-Google-Smtp-Source: ABhQp+RHeMrFC5rdewp4rcPHuXH+EsmMu2nCRdn6wSMXzdiripKPA9WQJvomEFSMupn+4vSS6J2Nug==
X-Received: by 10.99.97.139 with SMTP id v133mr2505036pgb.300.1509473957423;
        Tue, 31 Oct 2017 11:19:17 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id a78sm4308985pfl.122.2017.10.31.11.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Oct 2017 11:19:16 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 1/8] add, reset: use DIFF_OPT_SET macro to set a diff flag
Date:   Tue, 31 Oct 2017 11:19:04 -0700
Message-Id: <20171031181911.42687-2-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.403.gc27cc4dac6-goog
In-Reply-To: <20171031181911.42687-1-bmwill@google.com>
References: <20171030194646.27473-1-bmwill@google.com>
 <20171031181911.42687-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of explicitly setting the 'DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG'
flag, use the 'DIFF_OPT_SET' macro.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/add.c   | 2 +-
 builtin/reset.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index a648cf4c5..b70e8a779 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -116,7 +116,7 @@ int add_files_to_cache(const char *prefix,
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = update_callback;
 	rev.diffopt.format_callback_data = &data;
-	rev.diffopt.flags |= DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
+	DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 	clear_pathspec(&rev.prune_data);
diff --git a/builtin/reset.c b/builtin/reset.c
index 9cd89b230..ea2fad5a0 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -166,7 +166,7 @@ static int read_from_tree(const struct pathspec *pathspec,
 	opt.output_format = DIFF_FORMAT_CALLBACK;
 	opt.format_callback = update_index_from_diff;
 	opt.format_callback_data = &intent_to_add;
-	opt.flags |= DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
+	DIFF_OPT_SET(&opt, OVERRIDE_SUBMODULE_CONFIG);
 
 	if (do_diff_cache(tree_oid, &opt))
 		return 1;
-- 
2.15.0.403.gc27cc4dac6-goog

