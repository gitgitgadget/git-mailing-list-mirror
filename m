Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A3B620966
	for <e@80x24.org>; Sat, 25 Mar 2017 21:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751054AbdCYVSc (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 17:18:32 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36097 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbdCYVSb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 17:18:31 -0400
Received: by mail-vk0-f66.google.com with SMTP id d188so3228846vka.3
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 14:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6te3BevHPCkgnqt37eVEBNwcnaG/Dvl29L9bCKpZD9I=;
        b=SxbPJbmQ2jaoGFasILBgdXs5WCfrFBpmoKpqLg8iefzrQxYEqKg9/fHE8aUjSMXhlX
         9eLGtECg3EfwKxc9aSW5N5LmaxtzPqfXTffHWqpw89frFubwnT5VfQSG/LSvAgl9maaD
         mWOSU7dSa4rodHEHALqTgIV6Kx8hNj8GgSOvJammCEhDWylGVSmAVl9bq66vuw/mrJla
         vyeBl2KC6XmQNaRilizbmO3+Xm5qBtwBPXoynOl7HgUjRXuxgwosTV3xi+aUjSjb9S9z
         N6aQ2Fz2lmpj/cfkotvA7LtfqH3nKBYZ4BhvJD4ySGoHGPSxIVUw8/3FvYiCdM2ar8nj
         CmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6te3BevHPCkgnqt37eVEBNwcnaG/Dvl29L9bCKpZD9I=;
        b=V8MhGZHmAakvt0u7zo4M9IhGoCkO7+kQbZFmedaMNWcB6u3bUznT/B0gZybh67P5KO
         rtkQDEgAbwttdrl1yWMf1iKbNu5+uYrnRlla22xbg/tX0d4NMUC2anV12bT+KVraTsEi
         sZbcn7XcDQBxx+SQxdkSPDyG7WWFaBxCo5cJJF4hyQPO5oqbGlEtLFRJoJwWhkIRcG6a
         ZDzBzJyYkdyLowJRe/SuiHHpi0te4YIZX8RVErG0y720gWIWLFggt3r4DMyOTreDD4L+
         7LQ4IJD0U39t09pU0+ddGV0BAsX1EwZj9EBa6T9VrZdpev6ePVYVTpmTUY7itKbGK7gz
         omOA==
X-Gm-Message-State: AFeK/H0flyTE69PcZptFfKJHfylTyGs6V4nJZDW7O9S3Cj+yuGVnLGJNvIqcFz+AYoCIrA==
X-Received: by 10.176.84.156 with SMTP id p28mr7019185uaa.166.1490476656935;
        Sat, 25 Mar 2017 14:17:36 -0700 (PDT)
Received: from linuxerio.cabletica.com (ip203-162-64-186.ct.co.cr. [186.64.162.203])
        by smtp.gmail.com with ESMTPSA id 93sm1839159uaj.17.2017.03.25.14.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 14:17:36 -0700 (PDT)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     git@vger.kernel.org
Cc:     Matthieu Moy <Matthieu.Moy@imag.fr>,
        Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH] bisect: add quit command
Date:   Sat, 25 Mar 2017 15:17:09 -0600
Message-Id: <20170325211709.21265-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.11.0.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git bisect quit will call git reset HEAD so that the working tree
remains at the current revision
---
 Documentation/git-bisect.txt | 12 ++++++++++++
 git-bisect.sh                | 11 ++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index bdd915a66..de79e9e44 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -23,6 +23,7 @@ on the subcommand:
  git bisect terms [--term-good | --term-bad]
  git bisect skip [(<rev>|<range>)...]
  git bisect reset [<commit>]
+ git bisect quit
  git bisect visualize
  git bisect replay <logfile>
  git bisect log
@@ -120,6 +121,17 @@ bad revision, while `git bisect reset HEAD` will leave you on the
 current bisection commit and avoid switching commits at all.
 
 
+Bisect quit
+~~~~~~~~~~~
+
+It's an equivalent of bisect reset but that stays at the current
+revision instead of taking your working tree to the starting revision.
+
+------------------------------------------------
+$ git bisect quit
+------------------------------------------------
+
+
 Alternate terms
 ~~~~~~~~~~~~~~~
 
diff --git a/git-bisect.sh b/git-bisect.sh
index ae3cb013e..adbff2c69 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-USAGE='[help|start|bad|good|new|old|terms|skip|next|reset|visualize|replay|log|run]'
+USAGE='[help|start|bad|good|new|old|terms|skip|next|quit|reset|visualize|replay|log|run]'
 LONG_USAGE='git bisect help
 	print this long help message.
 git bisect start [--term-{old,good}=<term> --term-{new,bad}=<term>]
@@ -20,6 +20,9 @@ git bisect next
 	find next bisection to test and check it out.
 git bisect reset [<commit>]
 	finish bisection search and go back to commit.
+git bisect quit
+	stop bisection on its tracks and stay on current revision.
+	Equivalent to git bisect reset HEAD
 git bisect visualize
 	show bisect status in gitk.
 git bisect replay <logfile>
@@ -433,6 +436,10 @@ Try 'git bisect reset <commit>'.")"
 	bisect_clean_state
 }
 
+bisect_quit() {
+	bisect_reset "HEAD"
+}
+
 bisect_clean_state() {
 	# There may be some refs packed during bisection.
 	git for-each-ref --format='%(refname) %(objectname)' refs/bisect/\* |
@@ -683,6 +690,8 @@ case "$#" in
 		bisect_visualize "$@" ;;
 	reset)
 		bisect_reset "$@" ;;
+	quit)
+		bisect_quit ;;
 	replay)
 		bisect_replay "$@" ;;
 	log)
-- 
2.11.0.rc1

