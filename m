Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3AFC433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 12:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 949CD61969
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 12:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhC1Mz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 08:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhC1MzC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 08:55:02 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3040BC061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 05:55:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j9so8400938wrx.12
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 05:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2vZXNTAjiPL+b7iixEpwLYePpno//QCZMAKEYf4pHGo=;
        b=VtNH+MZmsg4oa1kXj8a7wLrv/NZiIws30PuatOzBX6QQIW46Dl+eE0lHCpDM0gEi9s
         6Uxs9o21d39sQdrVNa5CQxuTzyfoksA7hzrXob7c5UGeCyfZrEcaEim1iM9m6eVm1v2P
         KS6po/FioqLyHOaNmqIUn0QFFVlRm0mmg+5lASrrUXUpaFh+pGwJUQxMzBonMylh+xKc
         3zrozturEe46A2vT8pPtFmmEhElWIjOM4oFCKDFvNxOLgo1YwOY+TKAp7JsiGfvvAgff
         q8av8JNdDZnfNzPQlzbCbc/+jCSDaWEbP5zdwkzkWwJPXx5XfVEc0Nn2Hh/gWiInzPvT
         thQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2vZXNTAjiPL+b7iixEpwLYePpno//QCZMAKEYf4pHGo=;
        b=sYpFftoPolkFjN4v64Is1XGPANmeRKOS34mlvepSIzlzpTuv52ZwLb9tGnxrFS8wJh
         h0VM/EqXLvVis4GE6EqvyZ1TA4mMEc/P33QifwcEFcmLLmJd0F3ntbJ+JzEst6k+HIwF
         zgpj13DaZCifBCz1FC0Wxik7l2g+50cBBJb3wSHmWkoz39YzPQ6EibhkcDRsWtOCNKpT
         Ynu7jNDjwqTD7Fza8ytHfRJkOj8h2+HEPwLxHfCqUdnjlVj0XsCny2ehG/vZTXV76v/S
         hGSDBpBnh91vTkhKmc4i3vfC2vD3SufxdGsv4MGUQ+DJ7788aQ4+aU1HTMmOfuwzCKe7
         DRAA==
X-Gm-Message-State: AOAM530+B3k+BjAsROd7bhhWy+YUkhkDk7sKjbgoBzYbYNpX0YcFfYN6
        1bU6rRAjOu6lb0IYRAsiy4F1s/gZWuc=
X-Google-Smtp-Source: ABdhPJzR/PVMf0Vex1cK7Bjmo8PCL0MkocUHQYcF7IvmJXIu+ADOw97+g2HnSOccUl4egve74MfDEg==
X-Received: by 2002:adf:ea82:: with SMTP id s2mr24111925wrm.1.1616936100875;
        Sun, 28 Mar 2021 05:55:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2sm13862302wrt.47.2021.03.28.05.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 05:55:00 -0700 (PDT)
Message-Id: <pull.918.v2.git.1616936099778.gitgitgadget@gmail.com>
In-Reply-To: <pull.918.git.1616926790227.gitgitgadget@gmail.com>
References: <pull.918.git.1616926790227.gitgitgadget@gmail.com>
From:   "Chinmoy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 Mar 2021 12:54:59 +0000
Subject: [PATCH v2] Documentation: updated documentation for git commit --date
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Chinmoy <chinmoy12c@gmail.com>,
        Chinmoy Chakraborty <chinmoy12c@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chinmoy Chakraborty <chinmoy12c@gmail.com>

This commit lists the special strings used with `--date`
in `git-commit.txt` and also a brief explanation about
the strings in `date-formats.txt`.

Signed-off-by: Chinmoy Chakraborty <chinmoy12c@gmail.com>
---
    Documentation: updated documentation for git commit --date
    
    This commit lists the special strings used with --date in git-commit.txt
    and also a brief explanation about the strings in date-formats.txt.
    
    Signed-off-by: Chinmoy Chakraborty chinmoy12c@gmail.com
    
    
    Related Issue
    =============
    
    #302

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-918%2Fchinmoy12c%2Fissue_302-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-918/chinmoy12c/issue_302-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/918

Range-diff vs v1:

 1:  818ac39b5203 ! 1:  20da93dea971 Documentation: updated documentation for git commit --date
     @@ Commit message
      
       ## Documentation/date-formats.txt ##
      @@
     -+[[DATE FORMATS]]
     ++[[DATE-FORMATS]]
       DATE FORMATS
       ------------
       
     @@ Documentation/git-commit.txt: See linkgit:git-rebase[1] for details.
      +	Override the author date used in the commit. The value of <date>
      +	may be any one of the following special values - "yesterday",
      +	"noon", "midnight", "tea", "PM", "AM", "never", "now"
     -+	(see <<DATE FORMATS>>).
     ++	(see <<DATE-FORMATS>>).
       
       -m <msg>::
       --message=<msg>::


 Documentation/date-formats.txt | 32 ++++++++++++++++++++++++++++++++
 Documentation/git-commit.txt   |  5 ++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
index 99c455f51c04..83c423a3ec2e 100644
--- a/Documentation/date-formats.txt
+++ b/Documentation/date-formats.txt
@@ -1,6 +1,38 @@
+[[DATE-FORMATS]]
 DATE FORMATS
 ------------
 
+`yesterday`::
+	Change commit time to yesterday, that is, 24 hours ago.
+
+`noon`::
+	Change commit time to noon, that is 12:00. If current
+	time is less than 12:00, the time will be set to 12:00
+	on the previous day, else it will be set to 12:00 on
+	the same day.
+
+`midnight`::
+	Change commit time to midnight, that is, 00:00.
+
+`tea`::
+	Change commit time to 17:00(tea time). If the current
+	time is less than 17:00, the time will be set to 17:00
+	on the previous day, else it will be set to 17:00 on
+	the same day.
+
+`PM`::
+	Change commit time from AM to PM. If the current time
+	is already greater than 12:00, then the time remains
+	unaltered.
+
+`AM`::
+	Change commit time from PM to AM. If current time is
+	already less than 12:00, then the time remains
+	unaltered.
+
+`now`::
+	Change commit time to current time.
+
 The `GIT_AUTHOR_DATE` and `GIT_COMMITTER_DATE` environment variables
 support the following date formats:
 
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 3c69f461c9af..1935fad33f35 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -176,7 +176,10 @@ See linkgit:git-rebase[1] for details.
 	the commit author is then copied from the first such commit found.
 
 --date=<date>::
-	Override the author date used in the commit.
+	Override the author date used in the commit. The value of <date>
+	may be any one of the following special values - "yesterday",
+	"noon", "midnight", "tea", "PM", "AM", "never", "now"
+	(see <<DATE-FORMATS>>).
 
 -m <msg>::
 --message=<msg>::

base-commit: 84d06cdc06389ae7c462434cb7b1db0980f63860
-- 
gitgitgadget
