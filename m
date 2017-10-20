Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7621E202DD
	for <e@80x24.org>; Fri, 20 Oct 2017 01:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbdJTBL6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 21:11:58 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:55174 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbdJTBLy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 21:11:54 -0400
Received: by mail-pf0-f194.google.com with SMTP id n89so8558941pfk.11
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 18:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tn4Bo4Di28eRCKQnoxqQ9DcwGqDfoG+aB64XqhQ7nbk=;
        b=cZU1IqfoHdfP4FHcW3LJ7n59GgmHdhDVDbcCb/AlhL5nvi57lSletpb+WM6H6rGoaB
         eO0A0kgPBT/a+5qzM/jqP/4i7sZKfJgJcRQ3/sGZ/Aqn7kN60eHjG2YLlCyl//pOPnKS
         mveB8kNtZxV1FjCeZZ4PCJMc6T+0ezpiUNQLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tn4Bo4Di28eRCKQnoxqQ9DcwGqDfoG+aB64XqhQ7nbk=;
        b=q2Nfgm11S/VOgQsBQCOHGcN5EIwtrLHwHi/dKftpnjnBmY3WbeqdujXNmaQsohM2dB
         yD7uutU1U5UXcDPqZwwWvsAATOymlL+1HxOSfGHyqGax0nIT/72aOdGdasmx6Tzpe+2v
         IbRfMlawaysbpf22Nk/euniz8LZAWqmgpSzheY3r9WDstdVECIgjVUSlj3R2aRB4zulF
         BBpFHavrxty0GWnbs828INv5OrW2DO0OWo6u1LI4dC1oz30flyM9P+dd094EXFasNEOH
         ki2bz6CJ/8BNLwuUAAWGVDeEVe03NPBe52z6SiewyLmOr9JzE0ivJb5faOKQNaMOQZ+R
         q2hw==
X-Gm-Message-State: AMCzsaXzmcUc2Xi5389b7mVm3/eWJtNVKw7q6THZtRfyEwksBCNHrb6K
        zYK6AS7Yd+h4tijaymREcNTrXNCaLxQ=
X-Google-Smtp-Source: ABhQp+ShMcGv8S0MPJzTAX3BdW+LY4AiDBBn8MDuKfNZB1XVddv5OhqjlwPjj2sgExS6dXpnfgYfEw==
X-Received: by 10.84.128.227 with SMTP id a90mr2903041pla.224.1508461913641;
        Thu, 19 Oct 2017 18:11:53 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (V160-vrrp.corp.dropbox.com. [205.189.0.161])
        by smtp.gmail.com with ESMTPSA id x19sm403583pgc.60.2017.10.19.18.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Oct 2017 18:11:52 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Ben Peart <peartben@gmail.com>, Alex Vandiver <alexmv@dropbox.com>
Subject: [PATCH 1/4] fsmonitor: Watch, and ask about, the top of the repo, not the CWD
Date:   Thu, 19 Oct 2017 18:11:33 -0700
Message-Id: <4f8e3dab26cf50cc6aa055605784680f5c33fcfa.1508461850.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.0.rc1.417.g05670bb6e
In-Reply-To: <20171020011136.14170-1-alexmv@dropbox.com>
References: <20171020011136.14170-1-alexmv@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
---
 t/t7519/fsmonitor-watchman                 | 3 ++-
 templates/hooks--fsmonitor-watchman.sample | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
index a3e30bf54..377edc7be 100755
--- a/t/t7519/fsmonitor-watchman
+++ b/t/t7519/fsmonitor-watchman
@@ -41,7 +41,8 @@ if ($system =~ m/^MSYS_NT/ || $system =~ m/^MINGW/) {
 	$git_work_tree =~ s/[\r\n]+//g;
 	$git_work_tree =~ s,\\,/,g;
 } else {
-	$git_work_tree = $ENV{'PWD'};
+	$git_work_tree = `git rev-parse --show-toplevel`;
+	chomp $git_work_tree;
 }
 
 my $retry = 1;
diff --git a/templates/hooks--fsmonitor-watchman.sample b/templates/hooks--fsmonitor-watchman.sample
index 9eba8a740..7df590d29 100755
--- a/templates/hooks--fsmonitor-watchman.sample
+++ b/templates/hooks--fsmonitor-watchman.sample
@@ -40,7 +40,8 @@ if ($system =~ m/^MSYS_NT/ || $system =~ m/^MINGW/) {
 	$git_work_tree =~ s/[\r\n]+//g;
 	$git_work_tree =~ s,\\,/,g;
 } else {
-	$git_work_tree = $ENV{'PWD'};
+	$git_work_tree = `git rev-parse --show-toplevel`;
+	chomp $git_work_tree;
 }
 
 my $retry = 1;
-- 
2.15.0.rc1.417.g05670bb6e

