Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC90320560
	for <e@80x24.org>; Fri, 27 Oct 2017 22:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932595AbdJ0W3G (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 18:29:06 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43195 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752809AbdJ0W3B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 18:29:01 -0400
Received: by mail-pg0-f67.google.com with SMTP id s75so6294338pgs.0
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 15:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r63tOxsVcdF+VJb4BerAZ67BT3f4xK9fjSyCIq4ZTvk=;
        b=MK07cuGY1ZnX9eCFYuSWttd8MdfDEKVNQJlEg0fwvs2FebWs8qWp+S7lep96D+ezx5
         lEqDK8friQb2y2nMHry2JIKBOH3YB7t1EZPtxp7I4cKRWsmtrbffFLhejNiyPtlw5iiW
         4WpKBoioJOOOQyogZB06AFR0i84TCgquA+7OCDe1MC50Aa49V7APFBuAdDLFd6zXVSlI
         MSK8yivHuxqFgOzID2VksncyN4SKnaWfpMpOMWrbnIPFGkyiY19vHB96k1P4mAy8+W7h
         xOdHUFJ80oeNV+YsjY96dG/3NqFQjkhNjt1cP51mF/wNKbHv3JCEfLLZIhK+WTKbARzX
         yUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r63tOxsVcdF+VJb4BerAZ67BT3f4xK9fjSyCIq4ZTvk=;
        b=fkOnmpD37PuwnczrIV61icc+5q7q3aKR+Rrg6k3pBh2I35WoASJYN0fJVKwEfrlIf5
         lKmcxJpz6WUv8EO+f0EkG1Pfsly0kVc6e1cFBtagLdxh9xY1Pg3oe7Rfd3YUq8pFkW7h
         dCqu3PlQJSBBf3nIANQN8rYwL5A7KgxfC/0U9idhZvrLbidxuaT4NUviQf1Hr24vCMd4
         nrtmurriNVA+0oCHUT0nfv93HRMURVAKShEutEONA7Q8kj0aBgK6bZVVXcohm+UfWpyw
         w/O6PtH1Wx6kbHb0YIqvimGHRdV15kSbEApGNW117ortSS53XHKawHJsl7goqOH4FEx+
         /KuA==
X-Gm-Message-State: AMCzsaXLeGUP7ERnCdXzcyMpdEJsrzvBddobjbGcsimQusDE6nfRXMuK
        0Z5RfP9kEmFdFs1RVjaQYCDj9KFS8tU=
X-Google-Smtp-Source: ABhQp+Sfj+gqpy3P3acpERJQ85QEAbiV8NSSaFViLI+PPKI2+NbNcVZTcrOC6AZx+BS6plTUakVUmA==
X-Received: by 10.84.168.129 with SMTP id f1mr1402835plb.71.1509143339954;
        Fri, 27 Oct 2017 15:28:59 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id c127sm16486842pga.34.2017.10.27.15.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Oct 2017 15:28:58 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 2/3] reset: use DIFF_OPT_SET macro to set a diff flag
Date:   Fri, 27 Oct 2017 15:28:52 -0700
Message-Id: <20171027222853.180981-3-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.rc2.357.g7e34df9404-goog
In-Reply-To: <20171027222853.180981-1-bmwill@google.com>
References: <20171027222853.180981-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of explicitly setting the 'DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG'
flag, use the 'DIFF_OPT_SET' macro.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
2.15.0.rc2.357.g7e34df9404-goog

