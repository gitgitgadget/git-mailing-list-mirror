Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8997AC433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7DB223119
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="soSaiPCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgHFQt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbgHFQlS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:41:18 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E864C0A8939
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 09:41:18 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u10so18426475plr.7
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 09:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q9dnXzWj3uH+B7A14K52gX/1lSMGIABjfODAH/v6+Lw=;
        b=soSaiPCD3kkUkr8WdO2xkYSX6Xw03uewQTrKSY6Fs14cq8I076o0v+u/mbeM9NTngc
         gbxBzfCUPzJcvLX40fGX7W/YntD3m8sXERImN3PRAmH368IYNyY/WCV6TDaZCFB6A8fY
         wK0mTfBhPIGZiP671x6LFoSK9+S2K9WzjC8yjGTfawzkKJn/Fn7dh3uZqIaNd/q9PYOQ
         mzUEpkRTMGvMpnocriAAIVMrr3ZsGrU71LV5grIFvszHV9UvF8d8m8vR8AZE2dZLa6kE
         mRc+rUCAIDnq+tr6IMoVawBFB1jJscv7l5gTUtMSax0GlXxycbt9Rn+xgl6E2gjobcor
         tKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q9dnXzWj3uH+B7A14K52gX/1lSMGIABjfODAH/v6+Lw=;
        b=E3f34hL03uTo7OXy8/eAxM56xFlJzhn36SjXB8v2H83pz2+1ne5srFsO9C/7h6JH0H
         jgxS41xKI4OiqzeiLwOyd3qLz2vcgJOe7ARi/Q9a28aDfMwMA61XPsxA2NyM7hDjEO2q
         b3cxHRELHHAtyknRyo5uK7N0o7RRfFYvCm+YqAEZw+jLMcAce02HDTSym/wRYTEcNSq0
         aXIe6Rts7kj+gREAT50UrK11lbWfcyMVDP7hy2ITG819FhYTi6QvDbgIwnyiRo+lH2p2
         S/VXBRF+rLFIgTzfQ0BasRCdcA0Cp5FWYXypE5iLjIt24DyghUXyYosYIft/kzGP6xIR
         OboQ==
X-Gm-Message-State: AOAM532Jx35zTy0oLOBU9A8ega/lyYFU5Bhv6502ZCOctHq0Ar9UInVi
        LjJ6qLvvBc8FB7AnfZ1jlVz40ohBAxA=
X-Google-Smtp-Source: ABdhPJyRrgzVsj9R9lIW/7XGphl5FyAnV3ElvxETiOcZw/B2nDoj8tUZ8tn7YGgf2idcy2mQKCmEPg==
X-Received: by 2002:a17:902:9f82:: with SMTP id g2mr8783902plq.254.1596732077101;
        Thu, 06 Aug 2020 09:41:17 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.60])
        by smtp.gmail.com with ESMTPSA id w16sm8008381pjd.50.2020.08.06.09.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 09:41:16 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/5] submodule: expose the '--for-status' option of summary
Date:   Thu,  6 Aug 2020 22:10:58 +0530
Message-Id: <20200806164102.6707-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200806164102.6707-1-shouryashukla.oo@gmail.com>
References: <20200806164102.6707-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'for-status' option is used to compute the summary of submodule(s)
in a superproject by skipping the ignored submdules i.e., those with
'submodule.<name>.ignore' set to 'all' in the '.gitmodules' or
'.git/config', with the latter taking precedence over the former.

The option was introduced in d0f64dd44d (git-submodule summary:
--for-status option, 2008-04-12), refined in 3ba7407b8b (submodule
summary: ignore --for-status option, 2013-09-06) and finally perfected
in 927b26f87a (submodule: don't print status output with ignore=all,
2013-09-01). But, it was not mentioned in the 'git submodule'
Documentation.

Expose the '--for-status' option accepted by the command 'git submodule
summary'.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 Documentation/git-submodule.txt        | 8 +++++++-
 contrib/completion/git-completion.bash | 2 +-
 git-submodule.sh                       | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 7e5f995f77..d944e4c817 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -190,7 +190,7 @@ set-url [--] <path> <newurl>::
 	automatically synchronize the submodule's new remote URL
 	configuration.
 
-summary [--cached|--files] [(-n|--summary-limit) <n>] [commit] [--] [<path>...]::
+summary [--cached|--files] [--for-status] [(-n|--summary-limit) <n>] [commit] [--] [<path>...]::
 	Show commit summary between the given commit (defaults to HEAD) and
 	working tree/index. For a submodule in question, a series of commits
 	in the submodule between the given super project commit and the
@@ -309,6 +309,12 @@ OPTIONS
 	compares the commit in the index with that in the submodule HEAD
 	when this option is used.
 
+--for-status::
+	This option is only valid for the summary command. This command
+	skips the submodules with `submodule.<name>.ignore` set to `all`
+	in the `.gitmodules` or `.git/config`. The configuration in
+	`.git/config` overrides the configuration in `.gitmodules`.
+
 -n::
 --summary-limit::
 	This option is only valid for the summary command.
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0fdb5da83b..2b7b033c17 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3059,7 +3059,7 @@ _git_submodule ()
 		__gitcomp "--default --branch"
 		;;
 	summary,--*)
-		__gitcomp "--cached --files --summary-limit"
+		__gitcomp "--cached --files --for-status --summary-limit"
 		;;
 	foreach,--*|sync,--*)
 		__gitcomp "--recursive"
diff --git a/git-submodule.sh b/git-submodule.sh
index 43eb6051d2..dda3fee167 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -13,7 +13,7 @@ USAGE="[--quiet] [--cached]
    or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--[no-]single-branch] [--] [<path>...]
    or: $dashless [--quiet] set-branch (--default|--branch <branch>) [--] <path>
    or: $dashless [--quiet] set-url [--] <path> <newurl>
-   or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
+   or: $dashless [--quiet] summary [--cached|--files] [--for-status] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]
    or: $dashless [--quiet] absorbgitdirs [--] [<path>...]"
-- 
2.28.0

