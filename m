Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9117DC433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 11:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D5B1613A2
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 11:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238017AbhIPLhj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 07:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbhIPLhi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 07:37:38 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53904C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 04:36:18 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id m26so5657700pff.3
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 04:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KTZtfZROWI1akH7SbSfHsMAuuWhGQueY+WMyVUWvXIg=;
        b=ij8vhsz21MTJY/A0ETfj8ijpxo7+W0bvWkTCNX2SL2nnGQwufepkUN/Uf8EkVt0JIF
         8pQq+FVGjdm22MdwxynN7x+MtazghftPUPNnO9g0F9qH4LcGruGppuh/GN9id0eH2sdv
         YNky7aZitx73W4F5H8T2DB3ah7S0x5mZQcSjtn3CRg02WtS54JXBJ4/2gs39XWa4P6Eg
         TXcTFFtVGEvh9/LBpIHMZwoELdvZVKpmdmZUr3ZdtGsUT0PFuRKsDZcDN2Sj6yTgUUjS
         D46PZ5Kht1XxW6+enemij0TEIZEbuDyXPl/TWfgeZeg3rhUIz/H4vPjzOOCh2eOjvUiF
         +0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KTZtfZROWI1akH7SbSfHsMAuuWhGQueY+WMyVUWvXIg=;
        b=MT10oEDqmZRc65/9vWA1l6dKfc8aqtA8oz9sZSLpL8juHXSwGJt0cxP58LwJSc9Mmb
         aE59oap0LrH8rmd1UknHlZlYr0UpjAYgUQmxh31MNLk6KPhguiO+pM6znKg5tGSm3po+
         3m0iY8fyr/Unvcg0QHOoPKe7+hP/dGq7CQs/40fwekVjFx8U+BigxyYJ6ZRJPhp1BgRN
         YnuZvSTtD5yX7uFA9gjhbCwPsqxLupVxdWxBrOk9LTEvoYTt3N+T4cXV35axvbL4Z8I0
         /6fd4fYr8/HionCF76DiJ29BgbQZ0pJxjZwNIAYxINECECO3w7bs68tzf2MVNwwglAJp
         j9Ww==
X-Gm-Message-State: AOAM533rW/5EkNfyWI82TYhD1X4LrsS5IbmABEbjJn6SA5Reoc6exPl2
        oSPeuKuvJ+YAvVDnB2hIb6FW/HpIEXxkiA==
X-Google-Smtp-Source: ABdhPJzlx0iEpr5GMEMiGbPeEw0xupUe+YSZRgDL3Fsfh87jc3zcJhgVOf5q3cYKw+I+LxF2ZvGVRg==
X-Received: by 2002:a63:595f:: with SMTP id j31mr4504888pgm.109.1631792177747;
        Thu, 16 Sep 2021 04:36:17 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-91.three.co.id. [180.214.233.91])
        by smtp.gmail.com with ESMTPSA id d5sm2501188pjs.53.2021.09.16.04.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 04:36:17 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Ryan Anderson <ryan@michonline.com>, pbonzini@redhat.com
Subject: [PATCH 1/2] request-pull: simplify "remote or HEAD" variable in warning messages
Date:   Thu, 16 Sep 2021 18:35:16 +0700
Message-Id: <20210916113516.76445-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916113516.76445-1-bagasdotme@gmail.com>
References: <20210916113516.76445-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order for waring message "Are you sure you pushed 'remote or HEAD'
there?" to be translatable, replace ${remote:-HEAD} (variable access
with defaults) in the message by referring it as $remote_or_head.

Cc: Ryan Anderson <ryan@michonline.com>
Cc: pbonzini@redhat.com
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 git-request-pull.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 2d0e44656c..9e1d2be9eb 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -116,15 +116,17 @@ set fnord $(git ls-remote "$url" | @@PERL@@ -e "$find_matching_ref" "${remote:-H
 remote_sha1=$2
 ref=$3
 
+remote_or_head=${remote:-HEAD}
+
 if test -z "$ref"
 then
 	echo "warn: No match for commit $headrev found at $url" >&2
-	echo "warn: Are you sure you pushed '${remote:-HEAD}' there?" >&2
+	echo "warn: Are you sure you pushed '$remote_or_head' there?" >&2
 	status=1
 elif test "$local_sha1" != "$remote_sha1"
 then
 	echo "warn: $head found at $url but points to a different object" >&2
-	echo "warn: Are you sure you pushed '${remote:-HEAD}' there?" >&2
+	echo "warn: Are you sure you pushed '$remote_or_head' there?" >&2
 	status=1
 fi
 
-- 
2.25.1

