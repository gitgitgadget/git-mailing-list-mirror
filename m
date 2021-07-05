Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CB5C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2520613AE
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhGEMe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhGEMe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:34:56 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB06AC061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:18 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id t24-20020a9d7f980000b029046f4a1a5ec4so18195940otp.1
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SRcvqel+3yC5OJOh9fWMay2wHUWwhrsVkld23PgM71g=;
        b=ckP3TAzm6EbGuRJF4XRHFKDEOKfyqPVw1VpsUpKiQLQapQ7wMkYjTssd/ATBE2NDev
         qFdPopAU/xgk7gDF3swuqeL/MWu2KkL0++KHZtqDWxh0+USyWnbQGgLJmu8fpBzSV/xo
         AnjgP1e9PE4Ahs4IKyGwyd66LWjMDIXjIxPxpMriWR4Pj8iVvKZBNXdqQooVG1WHPIey
         6915t1dEHMcQPf75TEl+eAojBNbpDMsomXyz6Btanydh9Oj0+ET9KCQfj1udzrVdvH6n
         NEuxG3nFZiWPhX5taJKcjx2tpxGnpsBodk0P3/tLQ61F/NcuP1EBW0IaT7htyihMaWAd
         0slg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SRcvqel+3yC5OJOh9fWMay2wHUWwhrsVkld23PgM71g=;
        b=bV2lYWGXBTMlqyfKC0eqweqBJLP/XJYm7kf0sew9YM7rF4FA3cZ2EeDCuVs50cOixh
         lhzhwqMW4eHCGo8J4vA9TdZgyb2fid4GFH8oXMzv60oNDyPss2X1ZIzFEQoI4Bh5GhlE
         zmvz669jdYogOocVaHr/4Z/znJcbfW2QMHjI/5YEX+gANuuJXUtzjUC+fMS3hoNnZNmk
         imim4Jr1F3blHNr36jJ3axYu2M7y7J+u4XfFBlWAWDDGTYNFbiNvpO7/rOtEEaK7ww50
         wPBaLhVf8QsUkqqeAhAxOTNFCSB/RPJInnh8Rkj0Jg5gUoJFkX+NHx2IPGeI//3u9/hZ
         zmfQ==
X-Gm-Message-State: AOAM533BAMvb0JJMj0697nNxie3Z/ZKnOeVWZU61cYtbu/izmbdMqO2k
        q5PUFxA+do2IrXnBA+lWST/WS/Aomnn9jw==
X-Google-Smtp-Source: ABdhPJycpynoPVLpK9dsZVoMrfEO4ORJEXQQ6KJfvM1ogmVpj/U6XVLQwHM9eRUKKiy0UDyc/k/0Gw==
X-Received: by 2002:a05:6830:119:: with SMTP id i25mr4821815otp.28.1625488338068;
        Mon, 05 Jul 2021 05:32:18 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id 59sm2547314otp.68.2021.07.05.05.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:17 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 04/35] doc: fast-forward: explain what it is
Date:   Mon,  5 Jul 2021 07:31:38 -0500
Message-Id: <20210705123209.1808663-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-fast-forward.txt | 32 +++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-fast-forward.txt b/Documentation/git-fast-forward.txt
index d457022629..b7322c437e 100644
--- a/Documentation/git-fast-forward.txt
+++ b/Documentation/git-fast-forward.txt
@@ -15,11 +15,41 @@ DESCRIPTION
 Incorporates changes into the current branch. By default the upstream branch is
 used, but a different commit can be specified in the arguments.
 
+Assume the following history exists and the current branch is
+`master`:
+
+------------
+    D---C---B---A origin/master
+	^
+	|
+      master
+------------
+
+Then `git fast-forward` will advance the local `master` to `origin/master`:
+
+------------
+    D---C---B---A master, origin/master
+------------
+
+This operation is not always possible; if you made changes and the branches
+have diverged:
+
+------------
+    D---C---B---A origin/master
+	 \
+	  X---Y master
+------------
+
+then the fast-forward command will fail.
+
+In those cases you need to either `git merge`, or `git rebase` in order to
+synchronize the two branches.
+
 THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOUR MAY CHANGE.
 
 SEE ALSO
 --------
-linkgit:git-merge[1]
+linkgit:git-merge[1], linkgit:git-rebase[1]
 
 GIT
 ---
-- 
2.32.0.36.g70aac2b1aa

