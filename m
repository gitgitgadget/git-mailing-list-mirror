Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809E4C19F2D
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 02:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiHGCtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 22:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiHGCtr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 22:49:47 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B34BF79
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 19:49:46 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-10ea9ef5838so7090144fac.3
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 19:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6NHgmlE10TEx7OaWU9WBAzKd/17n0z4uf9CZ6qZIrP0=;
        b=lAmomj56fFnNwEIGGC/IvfWhKOcf712C5zMcgpySvN7rcKQGk2UmbvbZN14gIxX104
         OdK0s7TRRBUTNKXSgldpdoM3mAOaAwiZsxx3wziS4/NmPUlIyRYmO/O2Qt7p461lcPsW
         BQ8M6xTOfbmBcdmuTs1Ddrrj40NB9OlPSGlToIR5ech7LLHBr4KLcGtFUQq59l10idfJ
         liOXGPOpU9yTFTgspuEEqGwJu/M3LRfey65iKFzMnCm5ZKhnW1tBGA4HrJ9kePE8SMR0
         Ll6NamAMv6RNmF4AzzTOuGTbQwhHk1qb2RFmd6PuyN3QIMvt99zl4/ztoMkEgjGkW4AZ
         +F6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6NHgmlE10TEx7OaWU9WBAzKd/17n0z4uf9CZ6qZIrP0=;
        b=P5u9+S7N9yYAhV1C+DYSmnMR9hhqPgSPgFg0Qzn4J4ag0wwzRMA4vNGC6Y+MG1cDfa
         yACC3JlMy/+/608EQkiBgCoipLXeIMja+Q//vb4bZdBMZXmt6DEy+yZ9TKwwJ/p1UnHt
         4aiga5/CHhsQNhgS2cqlZJr0rcuKZlYLgz3zLMACQC4l5O05XTE2PGZWTO0Xv1VU98Z8
         7H62k1s6VBC+PGyP9gFOd/bs3HGlIwooN9F7IX++OHYPFgrsCA5uM75iO7eTMmtR8yI1
         TA8aKOixzPL8sDf25FRNkithtLPka1p8DwoUuLKo04NyuAbXVIUgxnx+HY+awvcgjLYc
         4YQA==
X-Gm-Message-State: ACgBeo1263DDnKXdAhqOnyoJk2qKJZ8eBL8X4GZ5m/yMDF6k+hgLl3rz
        txXErJAlBmaeW92nsXjT8N0V9h+gvCE=
X-Google-Smtp-Source: AA6agR6lqGIPtUMwjJhtAImVQ8sfzIQcc+O7dmIgl+l5KkAPXouVGyoE7jUoK1tYUp09UQ16tIV/Bw==
X-Received: by 2002:a05:6870:1483:b0:10e:6bd9:e023 with SMTP id k3-20020a056870148300b0010e6bd9e023mr6106860oab.40.1659840585702;
        Sat, 06 Aug 2022 19:49:45 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:afaf:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id a32-20020a056870a1a000b0010d997ffe7asm1588631oaf.37.2022.08.06.19.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 19:49:45 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/9] mergetools: vimdiff: shuffle single window case
Date:   Sat,  6 Aug 2022 21:49:34 -0500
Message-Id: <20220807024941.222018-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1.378.g3f95da6bac
In-Reply-To: <20220807024941.222018-1-felipe.contreras@gmail.com>
References: <20220807024941.222018-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We clearly want to do something different in these use cases.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 mergetools/vimdiff | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index ea416adcaa..9805d139bc 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -315,6 +315,14 @@ gen_cmd () {
 
 	LAYOUT=$1
 
+	# A single window is handled specially
+
+	if ! echo "$LAYOUT" | grep ",\|/" >/dev/null
+	then
+		CMD=$(gen_cmd_aux "$LAYOUT")
+		FINAL_CMD="-c \"$CMD | bufdo diffthis\" -c \"tabfirst\""
+		return
+	fi
 
 	# Search for a "@" in one of the files identifiers ("LOCAL", "BASE",
 	# "REMOTE", "MERGED"). If not found, use "MERGE" as the default file
@@ -334,18 +342,7 @@ gen_cmd () {
 	# Obtain the first part of vim "-c" option to obtain the desired layout
 
 	CMD=$(gen_cmd_aux "$LAYOUT")
-
-
-	# Adjust the just obtained script depending on whether more than one
-	# windows are visible or not
-
-	if echo "$LAYOUT" | grep ",\|/" >/dev/null
-	then
-		CMD="$CMD | tabdo windo diffthis"
-	else
-		CMD="$CMD | bufdo diffthis"
-	fi
-
+	CMD="$CMD | tabdo windo diffthis"
 
 	# Add an extra "-c" option to move to the first tab (notice that we
 	# can't simply append the command to the previous "-c" string as
-- 
2.37.1.378.g3f95da6bac

