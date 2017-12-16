Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 794661F404
	for <e@80x24.org>; Sat, 16 Dec 2017 09:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752834AbdLPJE0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 04:04:26 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36424 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752388AbdLPJES (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 04:04:18 -0500
Received: by mail-pg0-f68.google.com with SMTP id k134so7245019pga.3
        for <git@vger.kernel.org>; Sat, 16 Dec 2017 01:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=UQQL7kGA29Y7BsmgOaLppRkDLIbAlR9JkZhl6IX0zxc=;
        b=mZekQTpR4DPM7bn4eFcZxJRYi+aARrHV++K94scCw01WZqKByQ+pLTayhwJhmFU8Pr
         cyDqh8DIe7mq9lEG0lmCs6luLrRcAC5fFfAmEaDiV4/KQ0tc/+tI1U7eTiZRIIr/+PGG
         ORtSI46+79JJwGGfYHILufcpnmhn62AT9zADdjxHdf317nkG/27Jboxutt4m4/NlrTPt
         SN+5RSSp0nEx4np0aU6TQJEallmSaUBC+UANFJlky+4r+N4WLfOsOUyMeZel27N65436
         cIhjJFELcxnASrIrp1gtZkj9aVywYIzkI73vjdxJY1ZBUg2WMiH9i12cV9/2c53piM+0
         NRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=UQQL7kGA29Y7BsmgOaLppRkDLIbAlR9JkZhl6IX0zxc=;
        b=WD7XUlZzTzYAEvBtSXU/KGby5UXoXFJTHYJRpOSQu58F2T+/ffaWbVU2hDblyRjyiT
         UqmPGCUSok4dZD6efkYwMAmZimqPvat/Tm+ruZd3fKKXON7xhk6/SrSUg2CFvLjvvrbO
         XwVxGJ6B+AlGVYJjMXdwPUNnQATi7hbpEKuGJt13sd3bNGnYVD+/LMv+9HFHyoMIn9JK
         oekSINdBF9IXdxu/J9KR1e5rN9ryhvrL7XxoD6/KR2m6Bh97Tor7BasHwjgkaGQb7njh
         MGwKaO68klfwR9Mi7afZacwwFh3aHz6H+qgk2vRKHlbjJC6vnSc7cWRG6v2dNbnmaT6K
         N2Nw==
X-Gm-Message-State: AKGB3mJy/nrVf4SCAgiU0CSiYz1cLnGcGnzkB5SUIxmH7kFbpEKlASO+
        Kj5sDvWpUHc8pIaGfheuMwodaLHZ
X-Google-Smtp-Source: ACJfBosEYmiGtMzP6c0OnQKdowPxhr8Rtgv3nxj/6PGZ4xcBSebyGnYQfsCixpTOGpWcilFqEtBiag==
X-Received: by 10.98.147.215 with SMTP id r84mr16174500pfk.17.1513415057794;
        Sat, 16 Dec 2017 01:04:17 -0800 (PST)
Received: from localhost.localdomain ([117.249.248.104])
        by smtp.gmail.com with ESMTPSA id u68sm15775852pfu.17.2017.12.16.01.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Dec 2017 01:04:16 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 1/3] rebase: consistently use branch_name variable
Date:   Sat, 16 Dec 2017 14:33:17 +0530
Message-Id: <20171216090319.11902-2-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.531.g2ccb3012c
In-Reply-To: <20171216090319.11902-1-kaartic.sivaraam@gmail.com>
References: <20171127172104.5796-1-kaartic.sivaraam@gmail.com>
 <20171216090319.11902-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variable "branch_name" holds the <branch> parameter in "git
rebase <upstream> <branch>", but one codepath did not use it after
assigning $1 to it (instead it kept using $1).  Make it use the
variable consistently.

Also, update an error message to say there is no such branch or
commit, as we are expecting either of them, and not limiting
ourselves to a branch name.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 git-rebase.sh | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 60b70f3de..a299bcc52 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -518,7 +518,7 @@ case "$onto_name" in
 esac
 
 # If the branch to rebase is given, that is the branch we will rebase
-# $branch_name -- branch being rebased, or HEAD (already detached)
+# $branch_name -- branch/commit being rebased, or HEAD (already detached)
 # $orig_head -- commit object name of tip of the branch before rebasing
 # $head_name -- refs/heads/<that-branch> or "detached HEAD"
 switch_to=
@@ -528,15 +528,18 @@ case "$#" in
 	branch_name="$1"
 	switch_to="$1"
 
-	if git show-ref --verify --quiet -- "refs/heads/$1" &&
-	   orig_head=$(git rev-parse -q --verify "refs/heads/$1")
+	# Is it a local branch?
+	if git show-ref --verify --quiet -- "refs/heads/$branch_name" &&
+	   orig_head=$(git rev-parse -q --verify "refs/heads/$branch_name")
 	then
-		head_name="refs/heads/$1"
-	elif orig_head=$(git rev-parse -q --verify "$1")
+		head_name="refs/heads/$branch_name"
+	# If not is it a valid ref (branch or commit)?
+	elif orig_head=$(git rev-parse -q --verify "$branch_name")
 	then
 		head_name="detached HEAD"
+
 	else
-		die "$(eval_gettext "fatal: no such branch: \$branch_name")"
+		die "$(eval_gettext "fatal: no such branch/commit: \$branch_name")"
 	fi
 	;;
 0)
@@ -547,7 +550,7 @@ case "$#" in
 		branch_name=$(expr "z$branch_name" : 'zrefs/heads/\(.*\)')
 	else
 		head_name="detached HEAD"
-		branch_name=HEAD ;# detached
+		branch_name=HEAD
 	fi
 	orig_head=$(git rev-parse --verify HEAD) || exit
 	;;
-- 
2.15.0.531.g2ccb3012c

