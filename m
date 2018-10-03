Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01A8D1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 19:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeJDCmj (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 22:42:39 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:45309 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbeJDCmj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 22:42:39 -0400
Received: by mail-io1-f73.google.com with SMTP id g133-v6so6449150ioa.12
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 12:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eo+qxEhYTUv3+lsEELI+YrG0h/e6PzpHh4BhzyK/WVc=;
        b=gAV1pG9qtW4Gz7g/6wt2I0sUyxQwbYdF40PaC/3Ege7UsbSaXONJYdlkBB4jGBQrS3
         kEqCVl5vnVGQG0Yk1i83qija1/gft0wkQkTODlKy9n31FUPT45r4h0l3hHOOAPaOwoEh
         m3I4sEObEZlein2JixHUBGGqd3lw7R45QgEupkt6R1ysu90bn+q2S0Rsx0NW9CWd2s65
         Ruy63t47pMMupuJP2lxaM0SVOG4fbaWa2nxxEfVGSsEvQCjxxJrYSskWgol5iyH6+n4Y
         ojvgar2+4EUdYiJqeSX/5ex7Ean2n1I4oRCvT/2QcSemVXPVFhlTyHSFh+C7CtpWUHo6
         9v9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eo+qxEhYTUv3+lsEELI+YrG0h/e6PzpHh4BhzyK/WVc=;
        b=InXrf0JBSMyFaCS3AkbFeOuHH6SW444WEEkDQpj54b7xpXe0zEiujqzYk+7fXTbp65
         n7NGZOu4XsouUTBr8w8uRnoRzxgwPWoIDrDCWhBezZoJTIoEv/cUA2ChZIvJA2jIAznI
         8W4f/HvzOCGMTHeoApEqrz3MHqx8NcrNvunoRBd7BQtqs4nIejOlGGFlKZHBU450qUkg
         G5NEdi9akAYlS0vwSYtaix1pygewVUr4e3AAw5rMmptcAgsrjYpfqyccY2gYL2IMXyzF
         vNGBvcarBXv+i+Hj6BMLPrvVCunvJ+7LslRgczmZN1D59t3YaW4lbH1C7qh5ptjYGT2f
         BfWA==
X-Gm-Message-State: ABuFfoiaR7uQcgNtikeaD8f/uIrsslWH+n8DuNirP0ND04fRCDn0JQnW
        G+nAMt9R+w7HulvW7uvUjqaYnBKeLg0lbMjFsUS2XQNdVwSb5aeLIgcsdqZVj0TB+wkpfwZkNvv
        Zj7h5kYGZW5SlBlyEOjDj7vgRnCSoH9NNby1/wRicNJ390q7w1vMLwkKIlUA=
X-Google-Smtp-Source: ACcGV61nyEW7Kc4E6Xn8jc5GLlkiRVYSkr1+iI/QIZS3xeCnNcBBheoD9vnQQR1dHi3ADNA6XCQUoIsSvgGc
X-Received: by 2002:a05:660c:b0c:: with SMTP id f12mr2367551itk.22.1538596369764;
 Wed, 03 Oct 2018 12:52:49 -0700 (PDT)
Date:   Wed,  3 Oct 2018 12:52:17 -0700
In-Reply-To: <cover.1538592829.git.matvore@google.com>
Message-Id: <a16413f2388ef2d08448e4326c0f010a0b81501b.1538592829.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1538592829.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v10 6/8] list-objects-filter: use BUG rather than die
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, sbeller@google.com,
        git@jeffhostetler.com, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, jonathantanmy@google.com,
        gitster@pobox.com, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some cases in this file, BUG makes more sense than die. In such
cases, a we get there from a coding error rather than a user error.

'return' has been removed following some instances of BUG since BUG does
not return.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index a0ba78b20..5f8b1a002 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -44,8 +44,7 @@ static enum list_objects_filter_result filter_blobs_none(
 
 	switch (filter_situation) {
 	default:
-		die("unknown filter_situation");
-		return LOFR_ZERO;
+		BUG("unknown filter_situation: %d", filter_situation);
 
 	case LOFS_BEGIN_TREE:
 		assert(obj->type == OBJ_TREE);
@@ -102,8 +101,7 @@ static enum list_objects_filter_result filter_blobs_limit(
 
 	switch (filter_situation) {
 	default:
-		die("unknown filter_situation");
-		return LOFR_ZERO;
+		BUG("unknown filter_situation: %d", filter_situation);
 
 	case LOFS_BEGIN_TREE:
 		assert(obj->type == OBJ_TREE);
@@ -208,8 +206,7 @@ static enum list_objects_filter_result filter_sparse(
 
 	switch (filter_situation) {
 	default:
-		die("unknown filter_situation");
-		return LOFR_ZERO;
+		BUG("unknown filter_situation: %d", filter_situation);
 
 	case LOFS_BEGIN_TREE:
 		assert(obj->type == OBJ_TREE);
@@ -389,7 +386,7 @@ void *list_objects_filter__init(
 	assert((sizeof(s_filters) / sizeof(s_filters[0])) == LOFC__COUNT);
 
 	if (filter_options->choice >= LOFC__COUNT)
-		die("invalid list-objects filter choice: %d",
+		BUG("invalid list-objects filter choice: %d",
 		    filter_options->choice);
 
 	init_fn = s_filters[filter_options->choice];
-- 
2.19.0.605.g01d371f741-goog

