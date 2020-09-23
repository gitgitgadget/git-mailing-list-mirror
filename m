Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0CAC2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 09:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A41B5214D8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 09:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBnEEMRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgIWJ4n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 05:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgIWJ4n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 05:56:43 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48974C0613CE
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 02:56:41 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u3so2898660pjr.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 02:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jbcsEU+zRkYsIA7l8QvVk3sceNYkJk10Ra2EJR9VLsU=;
        b=BBnEEMRt6dbxo1LIzB0zgSaNT8lnO9rabLJ1pqEArsuyYeYa+nTnfbniiwOhiD8WTg
         E2DWTTzuV9ocuOPUhG7jGn7UB20JUpRkFuWz1JYiw4U4k4A3mev7vTNCbyfkxtfvqYUU
         hJafj3UD40QWwn6BVs78xpgF1paiNJoHpzt7+2VORvT621FrGe4GV9UDaXPTiMSW/fkV
         E//F7bVfBITSXvRsTLCsjDSN/rBVYU91/rQWa39vFxA7f3zF8qNQpFG5NOLUf3O94mdc
         6TcgfVN3J5WTrULqHORpZtdEd7GZ4cMghzja4yhNDqjnQ1eRZTHQYS6vIYvkrqt4abJ2
         SkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jbcsEU+zRkYsIA7l8QvVk3sceNYkJk10Ra2EJR9VLsU=;
        b=uiJqUv4+0YYtPHZe1gcpSzakM/iotRzNsF51cNy8c0y+VsgNjN9uGMsOWdrWrBhp9c
         4abOjqUomfjxCi22Ff+tZuXDV7owVszMRyyN66ksfOhqu9lYluWi+gFpera5Rqi4oD5O
         uwipe7ZcxYzls8TwVtTuMSoFul6spIaIcI8zctaykF8R+PI70tRJXkSEX9wDow/X0Ozy
         zP9zXNRtQo8XijZMUTMGfYXbqj2DLsXKWsdRFVQ8GFtq9sFD+OtW4W2/NSdwRfTYAR/1
         V287izh+eeXdSupoqhPMVF/HbhM/dclRoK9tP5020u/n9S1AFshwYqr6h4fKPpeyRGwg
         rtmw==
X-Gm-Message-State: AOAM532H5eTNVCrV6mRbPZqRVq93KRCr4crMi0EY/iPzaWzaNjRhB5C/
        KKebWkuLJ2hJQ9BOkQFOoBjYgE89pX0=
X-Google-Smtp-Source: ABdhPJy5ZHtCL87Kv/npSeOqpcIJGLkxvIN5iW+xrXbXI4xWF2B1iglzhuTdMf22o0Fn7H9IjpP6/Q==
X-Received: by 2002:a17:90b:611:: with SMTP id gb17mr7398846pjb.71.1600855000531;
        Wed, 23 Sep 2020 02:56:40 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id gj6sm4610695pjb.10.2020.09.23.02.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 02:56:39 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] pull: do not warn when opt_ff is explicitly specified
Date:   Wed, 23 Sep 2020 02:56:31 -0700
Message-Id: <1093128c646b154a14d89321454f5361c0e616b4.1600854717.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.760.g8d73e04208
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In d18c950a69 (pull: warn if the user didn't say whether to rebase or to
merge, 2020-03-09), `git pull` was taught to warn users if they
have `pull.rebase` unset or `pull.ff != "only"`. However, this warning
is a little too eager about happening.

If the warning is silenced by specifying `pull.ff = "only"`, as
instructed, the warning will arise again if the user runs
something like `git pull --no-ff`. However, the warning should not
happen as the user clearly knows what they're doing.

Don't display the warning if opt_ff is explicitly set by a command-line
option given by a user.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/pull.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 015f6ded0b..307b4b5d21 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -83,6 +83,7 @@ static char *opt_commit;
 static char *opt_edit;
 static char *cleanup_arg;
 static char *opt_ff;
+static int opt_ff_explicit;
 static char *opt_verify_signatures;
 static int opt_autostash = -1;
 static int config_autostash;
@@ -344,7 +345,7 @@ static enum rebase_type config_get_rebase(void)
 	if (!git_config_get_value("pull.rebase", &value))
 		return parse_config_rebase("pull.rebase", value, 1);
 
-	if (opt_verbosity >= 0 &&
+	if (!opt_ff_explicit && opt_verbosity >= 0 &&
 	    (!opt_ff || strcmp(opt_ff, "--ff-only"))) {
 		warning(_("Pulling without specifying how to reconcile divergent branches is\n"
 			"discouraged. You can squelch this message by running one of the following\n"
@@ -933,6 +934,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	if (!opt_ff)
 		opt_ff = xstrdup_or_null(config_get_ff());
+	else
+		opt_ff_explicit = 1;
 
 	if (opt_rebase < 0)
 		opt_rebase = config_get_rebase();
-- 
2.28.0.760.g8d73e04208

