Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15A931F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 19:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934145AbcIFS7z (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 14:59:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34393 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934756AbcIFS7X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 14:59:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id w12so10551525wmf.1
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 11:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3rp8rXCaZ0N1J2aQ10bWnFBSWy8/rp60a7NnXKIzIsc=;
        b=ZYSUK+4fZrp3cU6K3eqSSUtPGUxo6xLFVE5O1KrN0SIiHp46nfIL27LZcymXS8hbvB
         H7ZOjpYfoNefGP/hH22pMXlPRQYMpg4Wlt69+OKVJGqcwv4UW1I36MyIsr3w5ephpxHy
         Ykj+dhUgau+6zss5jiENX93yl35/6meF+/qCf/FwWkwHDswevoo1A33fe9ZcTVBvKB5O
         9eyt8tDM/qUt+iMPZnRHUZenXqR8Ej0tou+5M673y4q60CHE5UH20r41wehovmArwaV9
         o0gDuTUEn3kVxZwy6GmNKMI2Rkm4JkahxODVyc8izamCEbo8RQfdbowZhvIqk80TxjI2
         MYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3rp8rXCaZ0N1J2aQ10bWnFBSWy8/rp60a7NnXKIzIsc=;
        b=HUTCYNco8P90/4kvXbZtTXVJyUEJXCI64iGWvnWIuf/3tNVMigdFCnjO90RXtpwwrU
         CxAMhxPtjUUYmz58nmdk2QZfdQGxNd28S5SNuVnaXEYXUzlmchijBiNR2UOafSg2R0pQ
         hmkdBRGatvG6OGHu1RYgBRxRLHztMgo9+QobzdjxV8TBO6Ngt637noYqLr8euYZazp7a
         8eO+x6i49hjeRYScHs3+zyvHbaip9JTiNynW2GnvbA6I8fcj9LmyBdmi/FRsvO5k41ic
         mDfTP3lPBR5xPZL8qL/F0m8978jZPPsk4t5RWE5dGv88Fips5+FXd7iVnLsdjvGvY+Y6
         AqyQ==
X-Gm-Message-State: AE9vXwNj96Z6nS0SqWu5gUF4LGkxEqNMn2RN7PMUYbmkfyZhLOclZk4Vep0lTfK1sB7eew==
X-Received: by 10.194.102.227 with SMTP id fr3mr12789486wjb.147.1473188361400;
        Tue, 06 Sep 2016 11:59:21 -0700 (PDT)
Received: from localhost (cable-62-117-29-79.cust.telecolumbus.net. [62.117.29.79])
        by smtp.gmail.com with ESMTPSA id ml1sm20275315wjb.46.2016.09.06.11.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Sep 2016 11:59:20 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v2] rebase -i: improve advice on bad instruction lines
Date:   Tue,  6 Sep 2016 20:59:18 +0200
Message-Id: <20160906185918.21286-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.10.0.304.gf2ff484.dirty
In-Reply-To: <20160906180838.865-1-ralf.thielow@gmail.com>
References: <20160906180838.865-1-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we found bad instruction lines in the instruction sheet
of interactive rebase, we give the user advice on how to
fix it.  However, we don't tell the user what to do afterwards.
Give the user advice to run 'git rebase --continue' after
the fix.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
Changes in v2:
- adjust tests

 git-rebase--interactive.sh    | 2 +-
 t/t3404-rebase-interactive.sh | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b1ba21c..029594e 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1041,7 +1041,7 @@ The possible behaviours are: ignore, warn, error.")"
 		# placed before the commit of the next action
 		checkout_onto
 
-		warn "$(gettext "You can fix this with 'git rebase --edit-todo'.")"
+		warn "$(gettext "You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.")"
 		die "$(gettext "Or you can abort the rebase with 'git rebase --abort'.")"
 	fi
 }
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 597e94e..e38e296 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1195,7 +1195,7 @@ To avoid this message, use "drop" to explicitly remove a commit.
 Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
 The possible behaviours are: ignore, warn, error.
 
-You can fix this with 'git rebase --edit-todo'.
+You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
 Or you can abort the rebase with 'git rebase --abort'.
 EOF
 
@@ -1219,7 +1219,7 @@ cat >expect <<EOF
 Warning: the command isn't recognized in the following line:
  - badcmd $(git rev-list --oneline -1 master~1)
 
-You can fix this with 'git rebase --edit-todo'.
+You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
 Or you can abort the rebase with 'git rebase --abort'.
 EOF
 
@@ -1254,7 +1254,7 @@ cat >expect <<EOF
 Warning: the SHA-1 is missing or isn't a commit in the following line:
  - edit XXXXXXX False commit
 
-You can fix this with 'git rebase --edit-todo'.
+You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
 Or you can abort the rebase with 'git rebase --abort'.
 EOF
 
-- 
2.10.0.304.gf2ff484.dirty

