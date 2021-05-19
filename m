Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91C2C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 09:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD7DA611BD
	for <git@archiver.kernel.org>; Wed, 19 May 2021 09:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344999AbhESJaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 05:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhESJaM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 05:30:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545FCC06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 02:28:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id y14so11146914wrm.13
        for <git@vger.kernel.org>; Wed, 19 May 2021 02:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FiMktC460bv9ueOcB4PEfTku0MBoBtXb/DhW+POBAXY=;
        b=QNu7DUcUvDTmDmzY9tj5kej8BrxKxZhu7R9xrC2f17w1s8c2o6W5UZBo6FSgkz/DWa
         pDobDz2ywAwMe4fxc4rGgKlW+bdkyWwT9hv4U4JwyUBd22KxyO+QWn3LZXKBMRyEUIur
         4+pYYnWpRb8mcfNxjPgy5AZY2nnNDr5pvobOr5YQzRpVNU80m83/KS3IFQDDuLgr2izx
         w0CPaRZ2PLrOYy2+5n31O7KYDY1jb7lbpfv6vzhaOcMF1A2q//qxshYLposEIw9HO6PE
         3SNR0v23MI3RLT83wxX/tc8dLsqAeOWZVDljuywEzLg02xhwE1yvRo8fn+FVaGVQQDwe
         /z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FiMktC460bv9ueOcB4PEfTku0MBoBtXb/DhW+POBAXY=;
        b=WXNH/3J09MOL/FmMxuFcHjQtdv53PDbPCZVVdTvlUy8aeSqpW1Stetxv7G0k21gSPN
         CzC9MNIc5PgW3ldJBk+UeAXi/u1NzIznKJAhYyokx9WGyZhHS6bZudAzTJykqbIz/x4J
         zNgFk78Yyi3MNV6KBvD0CaWq7rq0NMfpn6GZRTRtsNKBWbZc5m7/XF+EWETkhHvtHEgR
         7QJr+iIayo925NbATFQ1ql/Ad6V6qcbASuxIpZ7Weqd04/4Ty2GXuqfM6RsnqgY3Jbr/
         K4ITZi/37NX8WoFhliXteS9YJmDLyj9rjBlhApXuEyW7skK9wSocmtT1gkRZ2aGPTHok
         o2oQ==
X-Gm-Message-State: AOAM531Tu0LK9ozUIEmhMpmp4venE/5IZjX2TjQptnKc3p56i7njV96x
        JZduFSbrtPB/0TAtOECiNvpjraUmyxY=
X-Google-Smtp-Source: ABdhPJwEJzgNMJlj9I19R7elJnAXVvN5yh9G40DKFbBEXycpWmmTJS68SyU3uEmCpGOvHqBtO/9YEw==
X-Received: by 2002:a5d:4982:: with SMTP id r2mr13176617wrq.96.1621416531010;
        Wed, 19 May 2021 02:28:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p187sm9592584wmp.28.2021.05.19.02.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 02:28:50 -0700 (PDT)
Message-Id: <pull.957.v2.git.1621416530195.gitgitgadget@gmail.com>
In-Reply-To: <pull.957.git.1621406381404.gitgitgadget@gmail.com>
References: <pull.957.git.1621406381404.gitgitgadget@gmail.com>
From:   "Reuven Y. via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 May 2021 09:28:49 +0000
Subject: [PATCH v2] docs: improve fast-forward in glossary content
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Reuven Y." <robi@post.jce.ac.il>, Reuven Y <robi@post.jce.ac.il>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Reuven Y <robi@post.jce.ac.il>

The text was somewhat confusing between the revision itself and the autour,
improved through a discussion with @Junio

Signed-off-by: Reuven Yagel <robi@post.jce.ac.il>
---
    typo in glossary content
    
    his->this The 't' probably just failed while typing, since we refer here
    to a branch not a person

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-957%2Frobi-y%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-957/robi-y/master-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/957

Range-diff vs v1:

 1:  c063a7f9abfd ! 1:  66a3f7e642b6 docs: typo in glossary content
     @@ Metadata
      Author: Reuven Y <robi@post.jce.ac.il>
      
       ## Commit message ##
     -    docs: typo in glossary content
     +    docs: improve fast-forward in glossary content
      
     -    his->this
     -    The 't' probably just failed while typing, since we refer here to a branch not a person
     +    The text was somewhat confusing between the revision itself and the autour,
     +    improved through a discussion with @Junio
      
          Signed-off-by: Reuven Yagel <robi@post.jce.ac.il>
      
     @@ Documentation/glossary-content.txt: current branch integrates with) obviously do
       	<<def_branch,branch>>'s changes that happen to be a descendant of what
       	you have. In such a case, you do not make a new <<def_merge,merge>>
      -	<<def_commit,commit>> but instead just update to his
     -+	<<def_commit,commit>> but instead just update to this
     - 	revision. This will happen frequently on a
     +-	revision. This will happen frequently on a
     ++	<<def_commit,commit>> but instead just update your branch to point at the same
     ++    revision as the branch you are merging. This will happen frequently on a
       	<<def_remote_tracking_branch,remote-tracking branch>> of a remote
       	<<def_repository,repository>>.
     + 


 Documentation/glossary-content.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 67c7a50b96a0..a22cef39fab0 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -146,8 +146,8 @@ current branch integrates with) obviously do not work, as there is no
 	<<def_revision,revision>> and you are "merging" another
 	<<def_branch,branch>>'s changes that happen to be a descendant of what
 	you have. In such a case, you do not make a new <<def_merge,merge>>
-	<<def_commit,commit>> but instead just update to his
-	revision. This will happen frequently on a
+	<<def_commit,commit>> but instead just update your branch to point at the same
+    revision as the branch you are merging. This will happen frequently on a
 	<<def_remote_tracking_branch,remote-tracking branch>> of a remote
 	<<def_repository,repository>>.
 

base-commit: bf949ade81106fbda068c1fdb2c6fd1cb1babe7e
-- 
gitgitgadget
