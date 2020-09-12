Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F235C10DAA
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 15:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F9220855
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 15:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdK/86I+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbgILPFs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Sep 2020 11:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgILPFS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Sep 2020 11:05:18 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA458C061757
        for <git@vger.kernel.org>; Sat, 12 Sep 2020 08:05:18 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m5so8392014pgj.9
        for <git@vger.kernel.org>; Sat, 12 Sep 2020 08:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bulHFA06xc982RpqLlWsNfKreRN6N5sQYquzXbJuVNg=;
        b=qdK/86I+h66aDDJBlg9gQi8oUIZu7ymPLO+ff3P3+al8sWWu05KdvM4Tg/08B9QDVO
         7UmfLSNq9B5BvCpNDkfay8LRW+tSEYpHfmSD+fJilQCzw58S1Bk0fiQtHl9l9DZh40Yx
         xDGwSufTieiXZQEQH/i8hVQcM03ya3MDhs1YEFbhJDmKLoIgchKl49zX9x/S8iGGbHaQ
         lyGyUJ7H9xMUHZ5eclLQNumH/iIMxfzg7VLi1ZSinnadw18X61VTXrahJKFX6NzBBJQp
         tanMCT0uNwDD8bjfEN31UQFsFLauRvrosV5wCXfYtD4Sd3/jPKdttM1sQS0TBBXz+iQ9
         tB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bulHFA06xc982RpqLlWsNfKreRN6N5sQYquzXbJuVNg=;
        b=fSs+YGMc6e4AwcMfoezLQaFTac+cG6/YhcSQNtcQ9WpOmXCTWUXV3ACxiM4rE+hjAw
         dvvfkzhCND8tsFz7cM2hLexbfzRwV/x6+TCNLxFJKlhUSo3W1M4FvzYmbZiE2gpcXYEj
         zCHDNfoywYiUSYknp38Nf48AZKx5RpYaWo2R4/hX78mB1Cn8/fI6V5wC0MRwaErmKU0E
         XKJO+dUZPbeFP2/Xf1Z4u7YFNep86ssC3mkp6eDScVSTwxudgm8IraktKeXt37cYz1U0
         7BcAtpXoEXeIQViRHq6a9TZ91QMo5r67YEElKJQupnZi2eGhURhJfOgKrZODdPgUEAud
         K3YA==
X-Gm-Message-State: AOAM530BSUJ4ZIKkFkOKiIaTdKqmkWMdHDmUAjEF35SGI5Ul8QlTYLCL
        /EDOsNPsLQzxfd0cUW5P2L+l+XZTevbm5w==
X-Google-Smtp-Source: ABdhPJzg5EWCL0dQJqgQ/l81I5nSLvDR4csQErcLEguH1SEwRU+U3eU1KLfnsO0h/nk/lL2nXzEa0A==
X-Received: by 2002:a63:d25:: with SMTP id c37mr4975501pgl.403.1599923118007;
        Sat, 12 Sep 2020 08:05:18 -0700 (PDT)
Received: from localhost.localdomain ([124.123.104.38])
        by smtp.gmail.com with ESMTPSA id q24sm5479196pfs.206.2020.09.12.08.05.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Sep 2020 08:05:17 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: [PATCH v2 2/2] push: enable "forceIfIncludesWithLease" by default
Date:   Sat, 12 Sep 2020 20:34:59 +0530
Message-Id: <20200912150459.8282-3-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
 <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set `push.forceIfIncludesWithLease` to `true` if experimental
features are enabled.

Signed-off-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
---
 Documentation/config/feature.txt |  6 ++++++
 builtin/push.c                   | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
index c0cbf2bb1c..4a8a386132 100644
--- a/Documentation/config/feature.txt
+++ b/Documentation/config/feature.txt
@@ -18,6 +18,12 @@ skipping more commits at a time, reducing the number of round trips.
 * `protocol.version=2` speeds up fetches from repositories with many refs by
 allowing the client to specify which refs to list before the server lists
 them.
++
+* `push.forceIfIncludesWithLease=true` adds `--force-if-includes` as an
+additional option along with `--force-with-lease[=<refname>[:<expect>]`
+when "<refname>" or "<expect>" valus are unspecified for linkgit:git-push[1].
+Allows forced updates only if the local branch has incorporated changes
+from the remote-tracking ref.
 
 feature.manyFiles::
 	Enable config options that optimize for repos with many files in the
diff --git a/builtin/push.c b/builtin/push.c
index 7fb07eb38e..658694edff 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -540,6 +540,17 @@ static int git_push_config(const char *k, const char *v, void *cb)
 		else
 			*flags &= ~TRANSPORT_PUSH_FORCE_IF_INCLUDES;
 
+		return 0;
+	} else if (!strcmp(k, "feature.experimental")) {
+		/*
+		 * Set `push.forceIfIncludesWithLease` to true,
+		 * if experimental features are enabled.
+		 */
+		if (git_config_bool(k, v))
+			*flags |= TRANSPORT_PUSH_FORCE_IF_INCLUDES;
+		else
+			*flags &= ~TRANSPORT_PUSH_FORCE_IF_INCLUDES;
+
 		return 0;
 	}
 	return git_default_config(k, v, NULL);
-- 
2.28.0

