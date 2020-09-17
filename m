Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76EBC2BBD1
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 07:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7781D2072E
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 07:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i46mmEYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgIQHpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 03:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgIQHoh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 03:44:37 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27067C061756
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 00:44:37 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b124so665467pfg.13
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 00:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rupAiabRDgtPF1NJ4d/pjYnNSXyE4EjbhLrxZBEG168=;
        b=i46mmEYQzgro8bFmTGqznt+zX71qdpYcrGUYorU8BNyyvEdmkKSp3AhdHJIHB26C16
         0imQlKz+lWCmVooP6+5XLMAaZJHAzXhqxDjXHhkMz4EZZbSe8Sa4wJpQmZl0MLhfwOXB
         kLVihL7SWpHZz6B+iJ+FDzH6sFQMZL5jxfp1SI+irZ5GprfRY4JbDT3rmNEYLoDuCMCL
         f26KobFGaslnNhn/cGLag9bsvm92Yx7Fi0TIXcimYj5eaLhOhoEU5s72ViA91gijjFmU
         jOuClHs0Z1vk24RJ7usDHiMiS6ub4lhzr+zLV7xWSZnEtu6vI/hmDWUdR+ZBLIRzuqlf
         CSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rupAiabRDgtPF1NJ4d/pjYnNSXyE4EjbhLrxZBEG168=;
        b=ZqWwnOimw4WFOabIph0V4hKH70jEXcqvHYLeSLa9CqZk2/WFTmN4J2quivZIJajTGC
         ze6kersz6tnplbAkIU1XMrMUbkPwbFT7haHkgzx8Y4oxGhjQXg3l3XxIK0IKdT2NFLOh
         HhpDzxqM/CqaCaBZhDVGSp4seaTtptTwipUGRMpq3kwf/yInDJeV4gGSiZfe0qctBrRe
         UN60GgjobhvTmbKmDSHlL06kjUNZ5MKQGL8O08QUonmjhFZtXyts86NWIHBhl9lB6f1h
         Arxqg94OxLDTYrC8WvxolZzeQao3PA4W8n/G6JUwWaKnepe+MRmB+uNGwtbQLG3SqtWo
         YhGA==
X-Gm-Message-State: AOAM531zAhRp9NR7oM8os93hIhdRH/V9O0TIAxdGRocqPK+oB3OI54Hi
        XGA4TVZuQYn3sITGyeBi7LloA8SJHqDFMQ==
X-Google-Smtp-Source: ABdhPJyMT67qDgaxS9SCAsGgXytELK7JTAFwnqGNQGJ544yxJ+y5qAMrpz4WnDH3asYebTpdpOeWdw==
X-Received: by 2002:a62:380d:0:b029:142:2501:35eb with SMTP id f13-20020a62380d0000b0290142250135ebmr10099370pfa.75.1600328676315;
        Thu, 17 Sep 2020 00:44:36 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id j9sm4931711pfc.175.2020.09.17.00.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 00:44:35 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 03/10] git-diff.txt: backtick quote command text
Date:   Thu, 17 Sep 2020 00:44:07 -0700
Message-Id: <ca9568c2ea7d28605633576609de53a2d79df22e.1600328335.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <cover.1600328335.git.liu.denton@gmail.com>
References: <cover.1599723087.git.liu.denton@gmail.com> <cover.1600328335.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

