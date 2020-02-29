Return-Path: <SRS0=C4D3=4R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA0CC3F2CD
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 21:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7EE21775
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 21:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLRGSod+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgB2VXi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Feb 2020 16:23:38 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40289 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgB2VXi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Feb 2020 16:23:38 -0500
Received: by mail-io1-f65.google.com with SMTP id m22so1097577ioj.7
        for <git@vger.kernel.org>; Sat, 29 Feb 2020 13:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yzaG2RouIzKS9j+X/cVhJErREgqxH9cp+K9l8b0GVnA=;
        b=mLRGSod+IsbLLJYehcjelqQKgfr1wbEt79ihgGqcYLB/d4jFZ8mnEHijvZnt06mZvK
         Ab8vTrStO9fl9Tq46NYQqcPGrm36F8NU8a2LOOJipfRsmhUazdNvnhyUSSh92dNEAqNS
         KWou+dSNFPurdPnjJw0Il/607i++aFChDpVudpt933Y6AiGvGkRZCWU/N6EMeKON7cT/
         ITXvtRWZPgCKRERwxA7F5sLNmLJoi2fCNcx7uSB4T8rxvQDIC3N0ylO9SUJAB27Z8RNI
         XtG/UKykJs89kblcWZzL2i5+KH6wiTd2YTrLCLZd8pbtrYSY1qLMC/cTV7+Vnhuepeve
         rRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yzaG2RouIzKS9j+X/cVhJErREgqxH9cp+K9l8b0GVnA=;
        b=J+Te0Y3bFDNUpZatGj0++IKpUtWu+2I2ZucFHGKs6mlRWcT22kCF0yIjJ7yFAcyMsY
         yEh6Tsxj48Zzy2xNWutiAb6EMwNlmpciYVdH4klZ8yvah3t8oBt5oei/HlYUHy+RItg8
         bedfjQCJLRX2ZyA7cXRM2NjTGu4PhfsWTn7XWeDstMRUo+Yqp0nwRh6ron5juIYK5C3n
         Kqbha0huUeUALZA0MYBEOOK9ULv0c2Ouh6dQ8aJJ8w1ABazHx+DC0G/2dk9F/Swixq7m
         kJk0vVnxkXj4vGiRqdLXclRITdVflsMZQrIxU9FERF/6ZLrcF8K+JXtFAUYYKemYwsNQ
         gSdw==
X-Gm-Message-State: APjAAAWdMdQAHR9XCoVsmiuCpxDg1Yfo6r8JjpIhSxTd/Y8pboTslxzA
        5QVLNMoWdtI7YlVOIZ0LROcX0FHU
X-Google-Smtp-Source: APXvYqze7bP0QE0+1mjebNLlP3OGcJznzef+W7G2yvsV4PL0bZXtmCkvX1K1n5WJvjNC72IpOYM+Zg==
X-Received: by 2002:a6b:6011:: with SMTP id r17mr2102065iog.220.1583011415254;
        Sat, 29 Feb 2020 13:23:35 -0800 (PST)
Received: from viper.hsd1.ut.comcast.net ([2601:681:4100:375e:c6b3:1ff:fed3:9881])
        by smtp.gmail.com with ESMTPSA id p67sm4609452ili.10.2020.02.29.13.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 13:23:34 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, rcdailey.lists@gmail.com, newren@gmail.com,
        rsbecker@nexbridge.com, gitster@pobox.com, annulen@yandex.ru,
        tytso@mit.edu
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v3] pull: warn if the user didn't say whether to rebase or to merge
Date:   Sat, 29 Feb 2020 14:22:58 -0700
Message-Id: <20200229212258.373891-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Often novice Git users forget to say "pull --rebase" and end up with an
unnecessary merge from upstream. What they usually want is either "pull
--rebase" in the simpler cases, or "pull --ff-only" to update the copy
of main integration branches, and rebase their work separately. The
pull.rebase configuration variable exists to help them in the simpler
cases, but there is no mechanism to make these users aware of it.

Issue a warning message when no --[no-]rebase option from the command
line and no pull.rebase configuration variable is given. This will
inconvenience those who never want to "pull --rebase", who haven't had
to do anything special, but the cost of the inconvenience is paid only
once per user, which should be a reasonable cost to help a number of new
users.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
v3:
- Fix segfault if opt_ff is NULL
- Don't say that the behavior will change in a future version of Git
(that hasn't been decided yet)
- Mention that pull.ff=only is also an option
- Mention git config's --global option
- Make the warning message longer and more clear in general
---
 builtin/pull.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 3e624d1e00..a93ee489f6 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -327,6 +327,20 @@ static enum rebase_type config_get_rebase(void)
 	if (!git_config_get_value("pull.rebase", &value))
 		return parse_config_rebase("pull.rebase", value, 1);
 
+	if (!opt_ff || strcmp(opt_ff, "--ff-only")) {
+		warning(_("Pulling without specifying how to reconcile divergent branches\n"
+			"is discouraged. You can squelch this message by running one of the\n"
+			"following commands sometime before your next pull:\n"
+			"\n"
+			"  git config pull.rebase false  # merge (the default strategy)\n"
+			"  git config pull.rebase true   # rebase\n"
+			"  git config pull.ff only       # fast-forward only\n"
+			"\n"
+			"You can replace \"git config\" with \"git config --global\" to set a default\n"
+			"preference for all repositories. Alternatively, you can pass --rebase,\n"
+			"--no-rebase, or --ff-only on the command line every time you pull.\n"));
+	}
+
 	return REBASE_FALSE;
 }
 
-- 
2.25.1

