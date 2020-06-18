Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4204EC433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 10:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11BBA2070A
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 10:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPOJeSWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgFRKnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgFRKnr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 06:43:47 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903CBC06174E
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 03:43:47 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l17so4982719qki.9
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 03:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1t3kAnsVrHcTrsswCN7PHhSZ4zNjqt0iiaJeUTOl4X8=;
        b=MPOJeSWlnz9R93KywD2Ma/v+/ETurEw2AwujUmBULXmdCOIfXq8sBaWnpTOzcU9XyP
         csoXGOvmeAadsT8MxCFyOAHSTkcnsC0RhSu8NWxQG7GNCsXxJIc608PK4bmDv0ZJkaUS
         kRqyILlMKepJYNS9lPBbSmwcFlds6osNIcq3U/S69fB3zQh6Wu/KL5mZxkdrccKILxxN
         rTOiQfQc6dpTdoDrr9f6B9RQlUlQsGbcSj2ZhORgERKq2VuNVxKdZGp2g8qBJmtwAiiM
         zvKXRfcTW00ODyIf0iOtXqQKwsYQiv0CYCBtJlkrEowFoGyOZdPHxmMehyEZ+6NWyDNe
         91XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1t3kAnsVrHcTrsswCN7PHhSZ4zNjqt0iiaJeUTOl4X8=;
        b=uI3e472qadfuJqU8WomnzOT24GdWgPeMIA1P8qGIKYRutoA1AG9d7WeNN/O7HYtjb9
         vtPbKCXY4w/rcXZwAW6ZlZBGjKYeDAAl5lEgJF1wxEcM3NYMfsc/xAQL2a43pVZc+EgS
         HmJ+xoKFUg2mPFQrzdv5HA03ya8dZwx72o/CnsIPwFmx7MwpAIDtV0ioYLm+KAPx2FkP
         q12NCOuwxbCHOZCiGbXhKz6w++dj7lLr+c/dDGM8ba3NO3uAmiq2kH7TolQXugCAiCCO
         ufj/4EzJjytusvrhjeeEDf0DlIVpUoPIBjhhQPUpFCFXNe2S+y5WLpQaAULlksEXV312
         F9/g==
X-Gm-Message-State: AOAM530DgdOC07lZcAc5hvVKFli1gJ87Hhk4LKX+qdWB//B2hDNo+M2r
        S+AWMGfUESlaQC4Qn89SUh5coKjctDQ=
X-Google-Smtp-Source: ABdhPJwBEgmxKiPcdELFl5vb6mNDzTtM0Xh2m0Isiw3Gd9nbYAIgVZ8NLnZNJboAVsFNwT+5eVYjFg==
X-Received: by 2002:a37:3d5:: with SMTP id 204mr2911552qkd.403.1592477026533;
        Thu, 18 Jun 2020 03:43:46 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id p6sm2761523qtd.91.2020.06.18.03.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 03:43:46 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] builtin/diff: update usage comment
Date:   Thu, 18 Jun 2020 06:43:34 -0400
Message-Id: <54c5de021a50ca7f39588efde1b89119aaf4cffa.1592476980.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
In-Reply-To: <a9aea5dbb821544eea636bc5de9fe8185bb603fb.1592219700.git.liu.denton@gmail.com>
References: <a9aea5dbb821544eea636bc5de9fe8185bb603fb.1592219700.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A comment in cmd_diff() states that if one tree-ish and no blobs are
provided, (the "N=1, M=0" case), it will provide a diff between the tree
and the cache. This is incorrect because a diff happens between the
tree-ish and the working tree. Remove the `--cached` in the comment so
that the correct behavior is shown. Add a new section describing the
"N=1, M=0, --cached" behavior.

Next, describe the "N=0, M=0, --cached" case, similar to the above since
it is undocumented.

Finally, fix some spacing issues. Add spaces between each section for
consistency and readability. Also, change tabs within the comment into
spaces.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Notes:
    This change can be broken down into three separate commits but I figured
    it is a little bit overkill considering how little the scope of each
    individual change would be. If it's more readable as separate commits, I
    can resubmit it, though.

Range-diff against v1:
1:  a9aea5dbb8 ! 1:  54c5de021a builtin/diff: fix incorrect comment
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    builtin/diff: fix incorrect comment
    +    builtin/diff: update usage comment
     
         A comment in cmd_diff() states that if one tree-ish and no blobs are
    -    provided, it would provide a diff between the tree and the cache. This
    -    is incorrect because a diff happens between the tree-ish and the working
    -    tree. Remove the `--cached` in the comment so that the correct behavior
    -    is shown.
    +    provided, (the "N=1, M=0" case), it will provide a diff between the tree
    +    and the cache. This is incorrect because a diff happens between the
    +    tree-ish and the working tree. Remove the `--cached` in the comment so
    +    that the correct behavior is shown. Add a new section describing the
    +    "N=1, M=0, --cached" behavior.
    +
    +    Next, describe the "N=0, M=0, --cached" case, similar to the above since
    +    it is undocumented.
    +
    +    Finally, fix some spacing issues. Add spaces between each section for
    +    consistency and readability. Also, change tabs within the comment into
    +    spaces.
    +
    +
    + ## Notes ##
    +    This change can be broken down into three separate commits but I figured
    +    it is a little bit overkill considering how little the scope of each
    +    individual change would be. If it's more readable as separate commits, I
    +    can resubmit it, though.
     
      ## builtin/diff.c ##
     @@ builtin/diff.c: int cmd_diff(int argc, const char **argv, const char *prefix)
    - 	 *	compare a blob with a working tree file.
    + 
    + 	/*
    + 	 * We could get N tree-ish in the rev.pending_objects list.
    +-	 * Also there could be M blobs there, and P pathspecs.
    ++	 * Also there could be M blobs there, and P pathspecs. --cached may
    ++	 * also be present.
      	 *
    - 	 * N=1, M=0:
    --	 *      tree vs cache (diff-index --cached)
    + 	 * N=0, M=0:
    +-	 *	cache vs files (diff-files)
    ++	 *      cache vs files (diff-files)
    ++	 *
    ++	 * N=0, M=0, --cached:
    ++	 *      HEAD vs cache (diff-index --cached)
    ++	 *
    + 	 * N=0, M=2:
    + 	 *      compare two random blobs.  P must be zero.
    ++	 *
    + 	 * N=0, M=1, P=1:
    +-	 *	compare a blob with a working tree file.
    ++	 *      compare a blob with a working tree file.
    ++	 *
    ++	 * N=1, M=0:
     +	 *      tree vs files (diff-index)
      	 *
    + 	 * N=1, M=0:
    + 	 *      tree vs cache (diff-index --cached)
    + 	 *
    ++	 * N=1, M=0, --cached:
    ++	 *      tree vs files (diff-index)
    ++	 *
      	 * N=2, M=0:
      	 *      tree vs tree (diff-tree)
    + 	 *

 builtin/diff.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 8537b17bd5..0f1a882bd7 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -266,18 +266,30 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 
 	/*
 	 * We could get N tree-ish in the rev.pending_objects list.
-	 * Also there could be M blobs there, and P pathspecs.
+	 * Also there could be M blobs there, and P pathspecs. --cached may
+	 * also be present.
 	 *
 	 * N=0, M=0:
-	 *	cache vs files (diff-files)
+	 *      cache vs files (diff-files)
+	 *
+	 * N=0, M=0, --cached:
+	 *      HEAD vs cache (diff-index --cached)
+	 *
 	 * N=0, M=2:
 	 *      compare two random blobs.  P must be zero.
+	 *
 	 * N=0, M=1, P=1:
-	 *	compare a blob with a working tree file.
+	 *      compare a blob with a working tree file.
+	 *
+	 * N=1, M=0:
+	 *      tree vs files (diff-index)
 	 *
 	 * N=1, M=0:
 	 *      tree vs cache (diff-index --cached)
 	 *
+	 * N=1, M=0, --cached:
+	 *      tree vs files (diff-index)
+	 *
 	 * N=2, M=0:
 	 *      tree vs tree (diff-tree)
 	 *
-- 
2.27.0.132.g321788e831

