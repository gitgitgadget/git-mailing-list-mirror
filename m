Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800E9C43381
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 12:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C8864FE7
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 12:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhCKM4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 07:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbhCKM42 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 07:56:28 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B01DC061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 04:56:28 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id t26so13623794pgv.3
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 04:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y6dmFzxP10iUwxXZQtLOu1ATFPmHRCSgNY15RaoJUKY=;
        b=HTi2kc8E2lX34OzyYzXHndIJbULiueybAeqsUx+kpJnueXPgskHWBOZQt8PrjXZaxR
         lDMgtaL+GyJSlmPKkaWmyAj6/AUdheYFCebax6obu6hhBY37kyDd0kygv+3IcSSCwYiD
         ADA8sFXhBTYzme5TUonYeBtYVhJziqKwr4UlRgZN664j1UNObNLWaKm2JIoc1cN88RB9
         dD871x/P9A6I03oOuyj4pKQaiatha4NgZ8FVP2IWzCb7RqCszjyU+MxC7H7PpFao/Nri
         w6hJWyak3hi6PwOJ6DLzOtqsbfZQ+wlsQZna/F5JMSnaxy0pXDVAkZwalXyPxPn7L8ix
         Xl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y6dmFzxP10iUwxXZQtLOu1ATFPmHRCSgNY15RaoJUKY=;
        b=LfUG/6+8qh83yhJosSD9zwzkhXdDjWqHUp/L/3KNSHWyfCdJorcsZd8CQHlEckjxFz
         jCiMk2yn3dDyzUdtfSmfK0TwBQdtvpi0Gf3qfzwpMqISEf5dC2mKQG7aBzAuuESqARGl
         cfpXP735NEx75ip/SFL6QxRUjIjiHzhEfLwCSY96bmiMjRLoanPcG5aLx42B3O2Hfm/7
         LhfLjY9Nl0INXJTDTYpTO8QjMlXROXa4mA1dNKDafpAoKD8B+ey30v8RXPN/RiKNCWEO
         0HxXacjyOtu8rT+wpzyAgrIK8W6SFHuigtdLVwjHZek8R0uje89FH1ZfgOjMBD7vHKOT
         mqag==
X-Gm-Message-State: AOAM530ExshGKmqDxpNAompV5FcvqdWM9M9CsP/K7cdTUCgdB6wf8FhS
        DVHTqr0jggbfetZPs3s99Yv6b+8rVfhNtw==
X-Google-Smtp-Source: ABdhPJz9Yi/VAaEUz8Z72ora3/ar5pLM8GyxQDQAlPzjbMI9ZNaZTZNvj73vgGEs2zRl/vIj3vD6Mw==
X-Received: by 2002:a63:fd0a:: with SMTP id d10mr6930667pgh.405.1615467387807;
        Thu, 11 Mar 2021 04:56:27 -0800 (PST)
Received: from ubuntu.mate (subs03-180-214-233-84.three.co.id. [180.214.233.84])
        by smtp.gmail.com with ESMTPSA id o1sm2389418pjp.4.2021.03.11.04.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 04:56:27 -0800 (PST)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     worldhello.net@gmail.com, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 3/3] po/README: document l10n conventions
Date:   Thu, 11 Mar 2021 19:55:11 +0700
Message-Id: <20210311125511.51152-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311125511.51152-1-bagasdotme@gmail.com>
References: <20210311125511.51152-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document things that l10n contributors must folow.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 po/README | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/po/README b/po/README
index eda7edf4e6..e1a0494b17 100644
--- a/po/README
+++ b/po/README
@@ -344,3 +344,24 @@ Below are the usage examples:
         po-helper.sh check XX.po
 
 Run po-helper.sh without arguments for usage help.
+
+
+Conventions
+-----------
+
+There are some conventions that l10n contributors must follow:
+
+   1. The subject of each commit should be prefixed with `l10n: `.
+   2. The length of commit log title (subject) should be less than 50
+      characters, and the length of other lines (commit log body)
+      should be no more than 72 characters.
+   3. Add "Signed-off-by" trailer to your commit log, like other
+      commits in Git. You can automatically add the trailer by
+      committing with `git commit -s`.
+   4. Check syntax with `msgfmt` or `po-helper.sh check` before
+      committing.
+   5. Squash trivial commits to make history clear.
+   6. Do NOT edit files outside po/ directory.
+   7. Other subsystems ("git-gui", "gitk", and Git itself) have their
+      own workflow. See Documentation/SubmittingPatches if you want
+      to make contributions to these subsystems.
-- 
2.25.1

