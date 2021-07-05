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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685B0C07E9C
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D98613AB
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhGEMfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbhGEMfo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:44 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C957C061760
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:33:07 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id t3so20601206oic.5
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iiRGE79cD5Fir74ETzs25vEZusqv1C5LQYgatYSNv6s=;
        b=Cdgtk9xUWWqLrGTSYcEOFoW+DLuDEIt+Xvt3H3yTaYXR50U9mWmmNdiZGsZp0ycqVp
         nM/9I2085AfVUtUZrbEsTyDd+LNDHpGixIKXBgKcNOm9+wcoLAJx/kTuwwKQ5mHQKbK0
         9qIQnWiD03ycpF4JiO4c065BLLDkZbs0dLoAIjc7KrGzMWsmZHPVk89pbwfwc2zvVNv5
         qryvggNP1MbKKONKAXHFL4XQikgDGM6WGZl96lYhb8BdD1hzoEGUd/1BhEoWuPSB7hC8
         O7x82AJ/qwa1SvhLGNgUmty5Pqhuf9R4IONr91J/w3HI1TD2ZBixHUBO2r2uPjnfPjrf
         K9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iiRGE79cD5Fir74ETzs25vEZusqv1C5LQYgatYSNv6s=;
        b=oI8dWfiIs691M5SqQH9sVyeE/2nXMj1v4FoE16PjuRgGSmq4N3wfea0yY7Cy83VdEc
         qmoaT8f6AGd6aGpzZABTIZjYNBGgiaMh/j+q41PIkR6dTpyKCkqCuhWIVb5dGqwois26
         dFJd+LOl3N/h9bwKY7xca8+bkHSHtt413D0o7b+5WGEjLMqzbZVGqd3ZUeBTqFLAbVxu
         AhzGgT8vkhaipa5SbEgUFW85uuZCYWgRjC6MUGGd0Xrm4dwWh6yURttjMQlopwjGpkBl
         KSxxwARY/itiinh3NjUJU7xuy5mJrHMjJWwWFFwObAR8Epi+oGzRwhnGCavE56ruDDuD
         wsNg==
X-Gm-Message-State: AOAM533tZEqcSxwZJQUvbyLo96Bd/doxTHKY3f4Y9vfReL8L9Lm5CQVG
        jilEWmryrZLER1OqcCRtPxt8FNK0Drb5tA==
X-Google-Smtp-Source: ABdhPJwaSpO3e6HIYyBm5MolK9+ZlTBGqqyjrWczYkQHaJSCBBJWz9tbQdUolnpRb0Zn364r6XCLgQ==
X-Received: by 2002:aca:2806:: with SMTP id 6mr9724811oix.2.1625488386487;
        Mon, 05 Jul 2021 05:33:06 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id p9sm2543210otl.64.2021.07.05.05.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:33:05 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 32/35] pull: improve default warning
Date:   Mon,  5 Jul 2021 07:32:06 -0500
Message-Id: <20210705123209.1808663-33-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't want to start by recommending a permanent configuration, but a
temporary solution so they start training their fingers and maybe learn
how to do a rebase. So we start with the commands.

Also, we need to be clear about what we mean by "specifying"; merge, or
rebase.

Moreover, it's better use --global in the configuration commands like we
did with push.default.

And finally, point to the documentation that explains what is a
non-fast-forward, and how to solve it:

  git help fast-forward

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index e304b22bd8..27ce2f2183 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -979,18 +979,19 @@ static int get_can_ff(struct object_id *orig_head, struct object_id *orig_merge_
 
 static void show_advice_pull_non_ff(void)
 {
-	advise(_("Pulling without specifying how to reconcile divergent branches is\n"
-		 "discouraged. You can squelch this message by running one of the following\n"
-		 "commands sometime before your next pull:\n"
+	advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
+		 "you need to specify if you want a merge, or a rebase.\n"
 		 "\n"
-		 "  git config pull.mode merge  # the default strategy\n"
-		 "  git config pull.mode rebase\n"
-		 "  git config pull.mode fast-forward\n"
+		 "  git pull --merge # the default\n"
+		 "  git pull --rebase\n"
 		 "\n"
-		 "You can replace \"git config\" with \"git config --global\" to set a default\n"
-		 "preference for all repositories. You can also pass --rebase, --merge,\n"
-		 "or --ff-only on the command line to override the configured default per\n"
-		 "invocation.\n"));
+		 "You can quell this message by running one of the following commands:\n"
+		 "\n"
+		 "  git config --global pull.mode merge\n"
+		 "  git config --global pull.mode rebase\n"
+		 "  git config --global pull.mode fast-forward\n"
+		 "\n"
+		 "For more information check \"git help fast-forward\"."));
 }
 
 int cmd_pull(int argc, const char **argv, const char *prefix)
-- 
2.32.0.36.g70aac2b1aa

