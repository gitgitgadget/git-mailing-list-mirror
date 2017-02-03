Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EA071F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 11:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753123AbdBCLC0 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 3 Feb 2017 06:02:26 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:57838 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752931AbdBCLCY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 06:02:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 752C81E383B;
        Fri,  3 Feb 2017 12:02:21 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3YLOb3xWh3jL; Fri,  3 Feb 2017 12:02:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 292BB1E3844;
        Fri,  3 Feb 2017 12:02:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id F807iR361j4O; Fri,  3 Feb 2017 12:02:21 +0100 (CET)
Received: from localhost.localdomain (46.128.140.114.dynamic.cablesurf.de [46.128.140.114])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id C99D11E383B;
        Fri,  3 Feb 2017 12:02:20 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, j6t@kdbg.org,
        Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH v2 3/7] completion: improve bash completion for git-add
Date:   Fri,  3 Feb 2017 12:01:55 +0100
Message-Id: <20170203110159.377-4-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170203110159.377-1-cornelius.weig@tngtech.com>
References: <20170203110159.377-1-cornelius.weig@tngtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

Command completion for git-add did not recognize some long-options.
This commits adds completion for all long-options that are mentioned in
the man-page synopsis. In addition, if the user specified `--update` or
`-u`, path completion will only suggest modified tracked files.

Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
Reviewed-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8329f09..652c7e2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -947,13 +947,17 @@ _git_add ()
 	--*)
 		__gitcomp "
 			--interactive --refresh --patch --update --dry-run
-			--ignore-errors --intent-to-add
+			--ignore-errors --intent-to-add --force --edit --chmod=
 			"
 		return
 	esac
 
-	# XXX should we check for --update and --all options ?
-	__git_complete_index_file "--others --modified --directory --no-empty-directory"
+	local complete_opt="--others --modified --directory --no-empty-directory"
+	if test -n "$(__git_find_on_cmdline "-u --update")"
+	then
+		complete_opt="--modified"
+	fi
+	__git_complete_index_file "$complete_opt"
 }
 
 _git_archive ()
-- 
2.10.2

