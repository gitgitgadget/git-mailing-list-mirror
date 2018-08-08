Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3532D208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 13:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeHHQLd (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 12:11:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43894 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeHHQLd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 12:11:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id j21-v6so1284973edp.10
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 06:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kuGs0o3e94evsB1FEupXT5BGmmSwaiNBSdnGz5Z5150=;
        b=aAKNMWkgmBiv5SVutzSMQ8pyoYePID7eN5dYbdulWco8WhwueO4CJLGNf4HCpl/92D
         /q4FSuUpzFk6rWZg36dNM2ybCpcqe11KMSEXK5ZZjCUEP7yFcxJ3HpNkuJYf/IzPENFt
         tl2bCudacZjuiSE0Odq77j2kee79wDbni/l7cXXaRuolk+rj1tRTbBkNtWGzxbaGdk5m
         7XSWQGEs+g51TLqCyoKE5ud9wsIeRbOC4yfsCk9ZztpLb/vzQgH+dqtoFmPfy+a16egP
         36hnmU66Hj4AMqgnZVbflWUFVLfvKNRwsW7hHDsrO9diwj/9IMc/FfMIu+RwxA7TfXHO
         g23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kuGs0o3e94evsB1FEupXT5BGmmSwaiNBSdnGz5Z5150=;
        b=blzeXowUN1d9Rf2fpII5bGeYiF5ASWS1evjP3Ds+WwT9ssEbSNnLD1DuZ4orl3c6sx
         oyO/j5h5MEcR26BdEi/z7K5T/VbU/HjQiUgE591glhhihlWBE71C7fZd0riODR6s/+/T
         ESA/R9Lnj7wOdCMqKDlYl1fca8QAmt0tZAfMX+32zJgLPNzKjT01cnLaIp9dgv5letGb
         uNdrrIpz/pYl8hp4L7Dt0Ojf5qNNSF4A+vd8l89t0e3vOI+FSl9JR8n9zYUc/7K4xyZp
         FodHcns3VqMJ9vzl+cufPIHtmirJMGN1MShxgeXLQbUmbVB+sguiTLbenNAxbZE89R0G
         SIpw==
X-Gm-Message-State: AOUpUlHqUEtUvRGi4uVV5gmgj/ai66Ce5OEMu/qqhns1l+D1q5UDchKf
        kXq6f9OeRwtVeRXXewOO6ScvfTjk
X-Google-Smtp-Source: AA+uWPxGHb1Y/az1VTBt3E96ekaQSrjEtO8gGpHYgtFQczL17cx6lyOGNr4s8EdZPbjfdVrDpjVB/A==
X-Received: by 2002:a50:9818:: with SMTP id g24-v6mr3509018edb.174.1533736306140;
        Wed, 08 Aug 2018 06:51:46 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id u3-v6sm1619420edo.44.2018.08.08.06.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 06:51:45 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 10/11] builtin rebase: only store fully-qualified refs in `options.head_name`
Date:   Wed,  8 Aug 2018 19:33:29 +0545
Message-Id: <20180808134830.19949-11-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808134830.19949-1-predatoramigo@gmail.com>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running a rebase on a detached HEAD, we currently store the string
"detached HEAD" in options.head_name. That is a faithful translation of
the shell script version, and we still kind of need it for the purposes of
the scripted backends.

It is poor style for C, though, where we would really only want a valid,
fully-qualified ref name as value, and NULL for detached HEADs, using
"detached HEAD" for display only. Make it so.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index a261f552f1..63634210c0 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -169,7 +169,8 @@ static int run_specific_rebase(struct rebase_options *opts)
 	add_var(&script_snippet, "upstream_name", opts->upstream_name);
 	add_var(&script_snippet, "upstream",
 				 oid_to_hex(&opts->upstream->object.oid));
-	add_var(&script_snippet, "head_name", opts->head_name);
+	add_var(&script_snippet, "head_name",
+		opts->head_name ? opts->head_name : "detached HEAD");
 	add_var(&script_snippet, "orig_head", oid_to_hex(&opts->orig_head));
 	add_var(&script_snippet, "onto", oid_to_hex(&opts->onto->object.oid));
 	add_var(&script_snippet, "onto_name", opts->onto_name);
@@ -251,6 +252,9 @@ static int reset_head(struct object_id *oid, const char *action,
 		*old_orig = NULL, oid_old_orig;
 	int ret = 0;
 
+	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
+		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
+
 	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
 
@@ -558,7 +562,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * branch_name -- branch/commit being rebased, or
 	 * 		  HEAD (already detached)
 	 * orig_head -- commit object name of tip of the branch before rebasing
-	 * head_name -- refs/heads/<that-branch> or "detached HEAD"
+	 * head_name -- refs/heads/<that-branch> or NULL (detached HEAD)
 	 */
 	if (argc > 0)
 		 die("TODO: handle switch_to");
@@ -575,7 +579,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				branch_name = options.head_name;
 
 		} else {
-			options.head_name = xstrdup("detached HEAD");
+			free(options.head_name);
+			options.head_name = NULL;
 			branch_name = "HEAD";
 		}
 		if (get_oid("HEAD", &options.orig_head))
-- 
2.18.0

