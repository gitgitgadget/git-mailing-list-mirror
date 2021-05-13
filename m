Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF7BC433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 18:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A70666143E
	for <git@archiver.kernel.org>; Thu, 13 May 2021 18:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhEMST3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 14:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhEMSTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 14:19:25 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2B3C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 11:18:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z9so39745395lfu.8
        for <git@vger.kernel.org>; Thu, 13 May 2021 11:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sTDTMk2ke/k5ktAyyxOoxZSf7pkA8knuG+qdVeb8XUY=;
        b=np3QTJWavGug1dggcuse7VwysSE+6bAkjOnkUA+8QhEdelm+tue+RJO8xn2uHpVSGM
         ZGTVj2wZARkv6K5HSFd9+EiY9WvhACCUC9rY1mbVqlzLI5SD2A3SMPLdl3thIG+aH+LY
         Q7b8JXIz3fYvy34J+GvIkMc1RUoQR5BmwsAWuIZKlY0T+XLG9u7nUS4TcD94ap4mLO5Z
         O913Qkp5Kl0V/CWt97I08QotgcZ/NwXShFDIxw9wWDRnUxhust7W/2qbfwEF5LtwWqw0
         bmCW/zLGwAV8NIqWbJ6A+UTkX5AfXxobRcpMeAPjngotdTFLF75MiC6SkqSS3Spk+pmf
         aDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sTDTMk2ke/k5ktAyyxOoxZSf7pkA8knuG+qdVeb8XUY=;
        b=tyYU+/zUNL08skIMK02tc7IcO1GkHf8cO59+hmSGXUyuLYi891gWYXPnsy98thlVIb
         538yU6v//0EvRTUb8jhpWAZr6aaqAEhntqbTRrlgtjF1ceXW0iuhsJ4D3iJfv4UBCVUv
         sEAQBSzHHAu9HD8CHZgoY3xvlVcle77NGjitJ5IDm4yZ9vH64WSJga75pvkO7sgrv6yW
         IdAi1WSvBmMuNSOh1v3pu1Rj3k+rroRuO+poAm3LrbKczAP/wR0sELy2J4jlWXQ34dkU
         OF/ieQzckphAM5dl5bDD5A4wxw/aFd+ey9L+XJ2AcKlHYAIZGC3ojnjnZRJUdBzPlgMG
         HoYw==
X-Gm-Message-State: AOAM533Uz3Y6iAHO2wMyhEJFpQ+jz471yQCftrMxEQsUeTnkE4Ar32k2
        89Vx3njemdsjlBpwT1FHSJyh+IjHDAs=
X-Google-Smtp-Source: ABdhPJxVHy5nmD7DFezIXREOysS1BAACbtDWzjNDCqePPQMh4OBGhEWFiEO+fvRnJp9iYwbzir5pbA==
X-Received: by 2002:ac2:53a1:: with SMTP id j1mr28679129lfh.337.1620929893080;
        Thu, 13 May 2021 11:18:13 -0700 (PDT)
Received: from localhost.localdomain (81-231-136-235-no600.tbcn.telia.com. [81.231.136.235])
        by smtp.gmail.com with ESMTPSA id v8sm554153ljn.17.2021.05.13.11.18.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 11:18:12 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 4/6] diff-options.txt: move monospace markup out of attribute
Date:   Thu, 13 May 2021 20:17:43 +0200
Message-Id: <f6241315a4d90185882a247d1c81ed7ee595d9a9.1620928059.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd
In-Reply-To: <cover.1620928059.git.martin.agren@gmail.com>
References: <cover.1620928059.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-log.txt and git-show.txt want to use different defaults for the
`--no-diff-merges` option. They do this by defining a
"diff-merges-default" attribute as, e.g., `off` (with backticks), which
is then referenced in the common diff-options.txt.

AsciiDoc renders the default in monospace, as wanted, but Asciidoctor
renders the backticks literally.

Pull the formatting into diff-options.txt and define
"diff-merges-default" without any quotation or markup. We can't write
`{diff-merges-default)` with backticks since that would render as
"{diff-merges-default}", but we can use +{diff-merges-default}+ -- both
Asciidoc and Asciidoctor do the substitution and the parsing of the
plusses in the order we want.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/diff-options.txt | 2 +-
 Documentation/git-log.txt      | 2 +-
 Documentation/git-show.txt     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 530d115914..6eb8bfff5d 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -37,7 +37,7 @@ ifdef::git-log[]
 --diff-merges=(off|none|on|first-parent|1|separate|m|combined|c|dense-combined|cc)::
 --no-diff-merges::
 	Specify diff format to be used for merge commits. Default is
-	{diff-merges-default} unless `--first-parent` is in use, in which case
+	+{diff-merges-default}+ unless `--first-parent` is in use, in which case
 	`first-parent` is the default.
 +
 --diff-merges=(off|none):::
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 1bbf865a1b..19560650bf 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -115,7 +115,7 @@ is when `--first-parent` is in use, in which case `first-parent` is
 the default format.
 
 :git-log: 1
-:diff-merges-default: `off`
+:diff-merges-default: off
 include::diff-options.txt[]
 
 include::diff-generate-patch.txt[]
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 2b1bc7288d..f8341e51c0 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -51,7 +51,7 @@ The options below can be used to change the way `git show` generates
 diff output.
 
 :git-log: 1
-:diff-merges-default: `dense-combined`
+:diff-merges-default: dense-combined
 include::diff-options.txt[]
 
 include::diff-generate-patch.txt[]
-- 
2.31.1.751.gd2f1c929bd

