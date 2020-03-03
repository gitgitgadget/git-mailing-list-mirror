Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9286C3F2D7
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 18:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B9020656
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 18:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIbuBkaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbgCCSN3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:13:29 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34898 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730684AbgCCRqW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 12:46:22 -0500
Received: by mail-wm1-f67.google.com with SMTP id m3so3800009wmi.0
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 09:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BzRN4SCDOFw6G906g5BzTQyvvzRkBfLk262VPRuv6HQ=;
        b=IIbuBkaZ2EnrxpIuC5dUtM+Bp57eMZ6KFr0rBIyXU+c/0Pdxy2buwg+ZTbEYibpSFt
         LQguX9QEeR0lCBdTsz5xbVLV6bXfYl4DowIDlNEMmG/gz9U9/cB0GiAI67gZrjyP+TNB
         LG897fTfHuSxaXPWH2u5mS47Q0FwdXM8+RtAiwb5AG3SLSi4Zh9ozEu2WkloWmZOAOWc
         9K44I1aj1RN11pf0djjLc6FUkjVa/0WMpsadxb+CgwN5s8548pBoiVCUL2P/78NaANDo
         CKSomzV274YsgZZx/HJeP4xv+wffCjGxlVTl2jKvjMYcAyOdBSplRe4EzYl8LaNqXWiA
         QVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BzRN4SCDOFw6G906g5BzTQyvvzRkBfLk262VPRuv6HQ=;
        b=hN/lTlBpg57CQN4ev/h0xR2UETPvgl9I8JfGi7A7vEFpuigEYUWbncPyNu1XxcDk5P
         PjOwZYOC+C7q4eSDQbEU7Y1lPboP3zZS1zxnRu1cg04F//p3SKZ1egcWBDAgdUoJ5AFq
         LnLfnWZU/ymcc0ETj10LdxW5KiTrC9pTxOCs3/EVL+hr/Gd0vVrn8xD9PUWoPR0AZ6EI
         fIg8jt3hm2vNH4BtLBFYzoBVybHvN7t97/fAnFsr8JBhtNY7hmUqgqTSEm2ORihISAmK
         e+/CyWIwPhhCA/JkgzZLnlWFYvwErqBNNZyJIY5nsNisbOqO7x/nXVH2l1GOQ19Ph3K2
         54fQ==
X-Gm-Message-State: ANhLgQ1SBhlJWgEx36ghRLnLQPR2Je/7J5ybSJ984DYgHIlGpa3QlN05
        yvWRwFCMRsuBL076z8knGTaomWqE
X-Google-Smtp-Source: ADFU+vs/U+PK78Y/c90HtNlgvy2zPI/LlfZr2PeLBm7+AvKznPaWWNxWIeIXm4UosTph2xNYeRjGqQ==
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr5108480wmk.131.1583257580547;
        Tue, 03 Mar 2020 09:46:20 -0800 (PST)
Received: from localhost ([2.28.70.205])
        by smtp.gmail.com with ESMTPSA id v11sm21111630wrs.54.2020.03.03.09.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Mar 2020 09:46:19 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Son Luong Ngoc <son.luong@booking.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 1/2] stash: get git_stash_config at the top level
Date:   Tue,  3 Mar 2020 17:46:12 +0000
Message-Id: <20200303174613.3557960-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.25.1.460.g2f268890c2
In-Reply-To: <20200302181832.GA1571684@cat>
References: <20200302181832.GA1571684@cat>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the next commit we're adding another config variable to be read
from 'git_stash_config', that is valid for the top level command
instead of just a subset.  Move the 'git_config' invocation for
'git_stash_config' to the top-level to prepare for that.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/stash.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 879fc5f368..f371db270c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -712,7 +712,7 @@ static int git_stash_config(const char *var, const char *value, void *cb)
 		show_patch = git_config_bool(var, value);
 		return 0;
 	}
-	return git_default_config(var, value, cb);
+	return git_diff_basic_config(var, value, cb);
 }
 
 static int show_stash(int argc, const char **argv, const char *prefix)
@@ -749,7 +749,6 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	 * any options.
 	 */
 	if (revision_args.argc == 1) {
-		git_config(git_stash_config, NULL);
 		if (show_stat)
 			rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT;
 
@@ -1573,7 +1572,7 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 	trace_repo_setup(prefix);
 	setup_work_tree();
 
-	git_config(git_diff_basic_config, NULL);
+	git_config(git_stash_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
 			     PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
-- 
2.25.1.460.g2f268890c2

