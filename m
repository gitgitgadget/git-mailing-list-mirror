Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A07C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 02:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABC0207DD
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 02:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COJH78dP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfK0CJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 21:09:27 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37297 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfK0CJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 21:09:27 -0500
Received: by mail-pj1-f68.google.com with SMTP id bb19so5643726pjb.4
        for <git@vger.kernel.org>; Tue, 26 Nov 2019 18:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JIRONt4eVDia24S068TJ4YBtQTJiUFIG9TnFAFHkdD0=;
        b=COJH78dPhWDqwJ/oJ56/pmg7gjt30sPiVXP6dG5teNOGBQTKlb0Xd7W8oyDdoLdDY/
         6eA03WeJ19hclnA6Os4Asu8Ff1/9c0OFcRRIK0V43febdlAjgv/i7oXh3FZW79ELz2ah
         s5V1tkDA0TytyHSpbuseLSXP5WQtvxm4iL0UK9sWmlAt6a0+Q8SeDXPcJzhPma4mQKoZ
         pbxEtTdouKH/RP4qpqlsGxs9jJJCVriGhplNNpUn1GeoXZPzAOnwDZVriH14olkjV6Yy
         fxWdQMSlgIsQtbDqRFXqzxUrt9cDJrWrpVZNG2MFSaJ/927wsF89+RX1mxuAnOQNbBT2
         SKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JIRONt4eVDia24S068TJ4YBtQTJiUFIG9TnFAFHkdD0=;
        b=bRq90DozR65sZ4hVQdMrcTrKnH1DRt6FI9mPfjhjx4VUI9Cxp++3h4iwtvkdIGL11T
         VdT1nz59+k2lne7SMXQ9Rwb+80usPP75Eb5N1aSKVwKwgiQgQ0x5EWew5rwyV+MTWvEW
         4hSw1nZFeDS/a0PtjVmmJMI0Cv9TAXH1hiPwCw9+1rNjL6SxDrnucXibVHrWyKLHOdL3
         xRMWjK2CwCXj1a8lA7b0iZnuljl886rqdgmZ78QQrSt8345MRG6IiLR+bJcNIlB9/Zyh
         6jctXtLI5wFbx2lsfY5XAQBb3XGHySmN87erv/2PUp1ZlETf6kSdBl+Sak4GVRBWoV4P
         6SJA==
X-Gm-Message-State: APjAAAWCEtERAw4L8bqBopko4zk/WnIPRMac9m8rji+4cyLoS4Ab8LFm
        gjOhyCi+bAJmYnYFQ2R0g9cV9yzs
X-Google-Smtp-Source: APXvYqzmVSYtprAsiuw4CyT77EMsXPd29exeJuJxwtsJexCosVpbyccL3whJQBwvk5VuLp+c4kkltQ==
X-Received: by 2002:a17:90a:ec07:: with SMTP id l7mr2840369pjy.68.1574820564615;
        Tue, 26 Nov 2019 18:09:24 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id ds4sm4422916pjb.6.2019.11.26.18.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 18:09:24 -0800 (PST)
Date:   Tue, 26 Nov 2019 18:09:22 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>
Subject: [PATCH 5/5] rebase: fix `format.useAutoBase` breakage
Message-ID: <15e6ccb2037d1e27b461d2344a13ebf1d5e10136.1574820308.git.liu.denton@gmail.com>
References: <CAPTJ0XEcMJEwPBEL4akncJ_A5XwyQyKL95fpf2tC0rNXJK65Og@mail.gmail.com>
 <cover.1574820308.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574820308.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With `format.useAutoBase = true`, running rebase resulted in an
error when an upstream was't set:

	fatal: failed to get upstream, if you want to record base commit automatically,
	please use git branch --set-upstream-to to track a remote branch.
	Or you could specify base commit by --base=<base-commit-id> manually
	error:
	git encountered an error while preparing the patches to replay
	these revisions:

	    ede2467cdedc63784887b587a61c36b7850ebfac..d8f581194799ae29bf5fa72a98cbae98a1198b12

	As a result, git cannot rebase them.

Fix this by always passing `--no-base` to format-patch from rebase so
that the effect of `format.useAutoBase` is negated.

Reported-by: Christian Biesinger <cbiesinger@google.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/rebase.c  | 3 ++-
 t/t3400-rebase.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e755087b0f..51980ab63d 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1012,7 +1012,8 @@ static int run_am(struct rebase_options *opts)
 	argv_array_pushl(&format_patch.args, "format-patch", "-k", "--stdout",
 			 "--full-index", "--cherry-pick", "--right-only",
 			 "--src-prefix=a/", "--dst-prefix=b/", "--no-renames",
-			 "--no-cover-letter", "--pretty=mboxrd", "--topo-order", NULL);
+			 "--no-cover-letter", "--pretty=mboxrd", "--topo-order",
+			 "--no-base", NULL);
 	if (opts->git_format_patch_opt.len)
 		argv_array_split(&format_patch.args,
 				 opts->git_format_patch_opt.buf);
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index ca99e8c6c4..1323f30fee 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -159,7 +159,7 @@ test_expect_success 'fail when upstream arg is missing and not configured' '
 	test_must_fail git rebase
 '
 
-test_expect_failure 'rebase works with format.useAutoBase' '
+test_expect_success 'rebase works with format.useAutoBase' '
 	test_config format.useAutoBase true &&
 	git checkout topic &&
 	git rebase master
-- 
2.24.0.504.g3cd56eb17d

