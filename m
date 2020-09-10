Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A0DC2BB84
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 07:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8233C20795
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 07:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBYu3AY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbgIJHdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgIJHco (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 03:32:44 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B65C061757
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 00:32:44 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k15so4110605pfc.12
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 00:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rupAiabRDgtPF1NJ4d/pjYnNSXyE4EjbhLrxZBEG168=;
        b=pBYu3AY2UQFcZMwFhiIl0yfPLd7FHXNXejZMqdjD6HM31NqcS3IAOT7wT/jyU6z1SO
         9sAn8B+31IK0Z4lnvbAz3xg/dfvr2j28T+QpW2BgAe+9vMH3VjvNuyMA8xECt07JImWA
         r3OGnQdIJL2THGvDMGGUgolfZshMKFpbVe+wX85Sir/+BY8ZG1E9GFXyrLGK/nToCb4L
         1ZWibw2otgh2VjpgrOt2a7ubE19E6l7AbAC0iWZoRrsUClRmUoNMWIcC9LdUg65aeT0i
         rHqwm58SN67GHVG6SPhm8zKU1Rd3uOerQYaI8cxMfgr+YAMCW6IRQx5ZklFZcEiicoFt
         zTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rupAiabRDgtPF1NJ4d/pjYnNSXyE4EjbhLrxZBEG168=;
        b=MUulbIiUgHQrCTYuq2pkZWdi1mJlrV1ExpgNOFd85COLzyrXeioi4fMLexfebCSQ0K
         B/7Y6TquUUPZQ89kpHDPS2Zk6ZHvULlut20ubLiqiN8LjDCyB/9QbBvenaUt5r6Y1jR1
         N6iQveH45/g/H6INXSooMmLnivWWdi0rmYjVoF0EAbae0FwEF8v/R/hfrG+8iB6J7f8E
         4rJdJlzFDbZ2D9Kv8BP6Op0Tz52FaLuvndiDT3pNBlprCkNCSD4JRqoKABeyszmMvsmz
         EQp4j3+ubVkQLf/gzRUC5RrVd0rZtamfPxiM9Pbn6stEHpgg22OXIcQL0ShNXcKFZgfy
         6hAg==
X-Gm-Message-State: AOAM532IqFFAJllCVFPZArmXYx6A+i6h5gzh1PuadsODq2eDXMC8R0S6
        Rs39jrljFZEAQC5aBYeEZT7jWP2lEIg=
X-Google-Smtp-Source: ABdhPJzV39MXWpFKDfAi3ZN/n0tkWj6p5WrZwdesPbSLJ2eO/HmLTnC7Bxl2C5wUliFS6GphexnSpA==
X-Received: by 2002:a63:4611:: with SMTP id t17mr3449103pga.225.1599723163373;
        Thu, 10 Sep 2020 00:32:43 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:5900:d670::1ab5])
        by smtp.gmail.com with ESMTPSA id q127sm4990550pfb.61.2020.09.10.00.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 00:32:42 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] git-diff.txt: backtick quote command text
Date:   Thu, 10 Sep 2020 00:32:18 -0700
Message-Id: <8e72bd8fea276d40729705eb8dcc63bcc9faef2c.1599723087.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <cover.1599723087.git.liu.denton@gmail.com>
References: <cover.1599332861.git.liu.denton@gmail.com> <cover.1599723087.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The modern way to quote commands in the documentation is to use
backticks instead of double-quotes as this renders the text with the
code style. Convert double-quoted command text to backtick-quoted
commands. While we're at it, quote one instance of `^@`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-diff.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 727f24d16e..8f7b4ed3ca 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -68,13 +68,13 @@ files on disk.
 	This form is to view the results of a merge commit.  The first
 	listed <commit> must be the merge itself; the remaining two or
 	more commits should be its parents.  A convenient way to produce
-	the desired set of revisions is to use the {caret}@ suffix.
+	the desired set of revisions is to use the `^@` suffix.
 	For instance, if `master` names a merge commit, `git diff master
 	master^@` gives the same combined diff as `git show master`.
 
 'git diff' [<options>] <commit>..<commit> [--] [<path>...]::
 
-	This is synonymous to the earlier form (without the "..") for
+	This is synonymous to the earlier form (without the `..`) for
 	viewing the changes between two arbitrary <commit>.  If <commit> on
 	one side is omitted, it will have the same effect as
 	using HEAD instead.
@@ -83,20 +83,20 @@ files on disk.
 
 	This form is to view the changes on the branch containing
 	and up to the second <commit>, starting at a common ancestor
-	of both <commit>.  "git diff A\...B" is equivalent to
-	"git diff $(git merge-base A B) B".  You can omit any one
+	of both <commit>.  `git diff A...B` is equivalent to
+	`git diff $(git merge-base A B) B`.  You can omit any one
 	of <commit>, which has the same effect as using HEAD instead.
 
 Just in case you are doing something exotic, it should be
 noted that all of the <commit> in the above description, except
-in the last two forms that use ".." notations, can be any
+in the last two forms that use `..` notations, can be any
 <tree>.
 
 For a more complete list of ways to spell <commit>, see
 "SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
 However, "diff" is about comparing two _endpoints_, not ranges,
-and the range notations ("<commit>..<commit>" and
-"<commit>\...<commit>") do not mean a range as defined in the
+and the range notations (`<commit>..<commit>` and
+`<commit>...<commit>`) do not mean a range as defined in the
 "SPECIFYING RANGES" section in linkgit:gitrevisions[7].
 
 'git diff' [<options>] <blob> <blob>::
@@ -144,9 +144,9 @@ $ git diff HEAD       <3>
 +
 <1> Changes in the working tree not yet staged for the next commit.
 <2> Changes between the index and your last commit; what you
-    would be committing if you run "git commit" without "-a" option.
+    would be committing if you run `git commit` without `-a` option.
 <3> Changes in the working tree since your last commit; what you
-    would be committing if you run "git commit -a"
+    would be committing if you run `git commit -a`
 
 Comparing with arbitrary commits::
 +
-- 
2.28.0.618.gf4bc123cb7

