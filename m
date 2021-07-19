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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D45C12002
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 03:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B36DF6115B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 03:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbhGSDvF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Jul 2021 23:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbhGSDvE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jul 2021 23:51:04 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97528C061762
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 20:48:04 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id a17-20020a9d3e110000b02904ce97efee36so5119064otd.7
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 20:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IUlqObrP1aqww9Xe9K0v0yqjDfvJ3M1ot37ehYictY0=;
        b=EDGpw2LWXjW02etNDNpmrrlIX51x5l0h2SoReXzUekR0QH2kr6ZGkSPptP736sTZOu
         Vkwspqz2X1MDsmk/JQQoQL/Tmz8OOPrVWABCJxs8pGcEziJbGDIEXVj9LSfzVfKIpngB
         ZmPbe6a4wWHRDNytvWG2NC1rjf876FdLWfkniy46bMcM0hl9bBY+jm2HaY1YAXE5Aer3
         QqGSeanH6zfKjnROVQhJQSWFOMb0oNr7VGNTbGz9cW4zTUHJspP/3b+dlQ2q9VcnmxE6
         XEN0olGVHOBoZ+g/7nc0FPnjMYIW7v20yOdqnQODdT1TbgMXSr6Pd2twFEurKVkAR5Zl
         Q47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IUlqObrP1aqww9Xe9K0v0yqjDfvJ3M1ot37ehYictY0=;
        b=p/TduXXL8Qkot//MaT/5A7YR5kZ02MwcjPU6Yq1xExOefMxNNTL+MX90HQ0n7a9mEo
         gVZzQmCx+23FYp0O76pmp7kY2/gm5+H8wJi4wx2fKgaPQOSLKgSk597qrYV94RkzhjgZ
         cedldDO6IosAKpol+cnIxRhM8v/lyN8szkPN9oW1KzpM9opVL2fHfmZdbVwaA9e5YTGu
         g3wABEcqL1/l2YTn/T4YrbOKBvgCFkT1YHiUM5WqGfmqx2CtqE29e5AnkYWRT76S0FUd
         avKqw/Knma5ldBtPgUYde1PE8SCr0CXbkpCnFi5whw2yhZjUjBJjy/la6QWCkDHE4d1c
         UrFw==
X-Gm-Message-State: AOAM533cjOtoy+psIy+97lAYUjuWN8EEyCf2s02WPtLr1sm/hABGtxFT
        IAvooQl4sayiXHb+GTnQNmkiGekqt3HW6w==
X-Google-Smtp-Source: ABdhPJzxvvVlY1N/hg4rp5PWPMn53u6lh3mMJ5xriq8mcER6tNBItoARA5CXI1kzJfSeWE+wfO+pyw==
X-Received: by 2002:a9d:4f02:: with SMTP id d2mr10230034otl.254.1626666483770;
        Sun, 18 Jul 2021 20:48:03 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id y5sm230423ott.72.2021.07.18.20.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 20:48:03 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Mathias Kunter <mathiaskunter@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/2] push: make default consistent
Date:   Sun, 18 Jul 2021 22:47:58 -0500
Message-Id: <20210719034758.1288766-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.40.gb9b36f9b52
In-Reply-To: <20210719034758.1288766-1-felipe.contreras@gmail.com>
References: <20210714164900.606330-1-felipe.contreras@gmail.com>
 <20210719034758.1288766-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The default action "simple" doesn't make sense. It's supposed to be the
same as "current", except with an extra safety in case the name of the
upstream branch doesn't match the name of the current branch (and we are
pushing to the same remote). But if there's no upstream configured
there's no need for any check.

Instead of behaving like "current" if the current branch doesn't have an
upstream configured, `git push` fails like "upstream", so it's a
Frankensteinian action.

If the upstream branch isn't configured, "simple" should not abort, just
like "current".

Reported-by: Mathias Kunter <mathiaskunter@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/push.txt |  5 +++--
 Documentation/git-push.txt    |  6 +++---
 builtin/push.c                | 12 +++---------
 t/t5528-push-default.sh       |  2 +-
 4 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index 632033638c..d267d05e7a 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -27,8 +27,9 @@ push.default::
 * `simple` - pushes the current branch with the same name on the remote.
 +
 If you are working on a centralized workflow (pushing to the same repository you
-pull from, which is typically `origin`), then you need to configure an upstream
-branch with the same name.
+pull from, which is typically `origin`), and you have configured an upstream
+branch, then the name must be the same as the current branch, otherwise this
+action will fail as a precaution.
 +
 This mode is the default since Git 2.0, and is the safest option suited for
 beginners.
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index a953c7c387..58352bbf88 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -39,9 +39,9 @@ what to push (See linkgit:git-config[1] for the meaning of `push.default`).
 
 When neither the command-line nor the configuration specify what to
 push, the default behavior is used, which corresponds to the `simple`
-value for `push.default`: the current branch is pushed to the
-corresponding upstream branch, but as a safety measure, the push is
-aborted if the upstream branch does not have the same name as the
+value for `push.default`: the current branch is pushed to a remote
+branch with the same name, but as a safety measure the push is aborted
+if there's a configured upstream branch with a different name than the
 local one.
 
 
diff --git a/builtin/push.c b/builtin/push.c
index 3ee7d6ada1..64134531de 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -229,16 +229,10 @@ static void setup_default_push_refspecs(struct remote *remote)
 		if (!same_remote)
 			break;
 		dst = get_upstream_ref(branch);
-		if (!dst)
-			die(_("The current branch %s has no upstream branch.\n"
-			    "To push the current branch and set the remote as upstream, use\n"
-			    "\n"
-			    "    git push --set-upstream %s %s\n"),
-			    branch->name,
-			    remote->name,
-			    branch->name);
-		if (strcmp(branch->refname, dst))
+		if (dst && strcmp(branch->refname, dst))
 			die_push_simple(branch, remote);
+		if (!dst)
+			dst = branch->refname;
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index f280e00eb7..ba38256ef4 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -126,7 +126,7 @@ test_expect_success 'push from/to new branch with current creates remote branch'
 test_expect_success 'push to existing branch, with no upstream configured' '
 	test_config branch.main.remote repo1 &&
 	git checkout main &&
-	test_push_failure simple &&
+	test_push_success simple main &&
 	test_push_failure upstream
 '
 
-- 
2.32.0.40.gb9b36f9b52

