Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40E3120D13
	for <e@80x24.org>; Fri,  2 Jun 2017 20:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbdFBUXL (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 16:23:11 -0400
Received: from host24.ssl-gesichert.at ([213.145.225.190]:54165 "EHLO
        host24.ssl-gesichert.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbdFBUXL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 16:23:11 -0400
Received: (qmail 10307 invoked by uid 7799); 2 Jun 2017 22:23:09 +0200
Received: by simscan 1.4.0 ppid: 10145, pid: 10298, t: 0.5632s
         scanners: clamav: 0.99.2/m:57/d:23441
Received: from 80-109-4-187.cable.dynamic.surfer.at (HELO archie.gortan.local) (philipp@gortan.org@80.109.4.187)
  by host24.ssl-gesichert.at with SMTP; 2 Jun 2017 22:23:08 +0200
From:   Philipp Gortan <philipp@gortan.org>
To:     philipoakley@iee.org
Cc:     avarab@gmail.com, git@vger.kernel.org,
        matthias.serfling@googlemail.com, philipp@gortan.org
Subject: [PATCH] respect core.hooksPath, falling back to .git/hooks
Date:   Fri,  2 Jun 2017 22:23:01 +0200
Message-Id: <20170602202301.6413-1-philipp@gortan.org>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <CACBZZX6H4wxQ7hrO1Y1u6Qyr5gpK9GeCxpv-x2q3Eq2WCbkK8Q@mail.gmail.com>
References: <CACBZZX6H4wxQ7hrO1Y1u6Qyr5gpK9GeCxpv-x2q3Eq2WCbkK8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Philipp Gortan <philipp@gortan.org>
---

The following patch tries to fix git-gui to respect the core.hooksPath config
variable, falling back to the old behavior.

git-gui.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/git-gui.sh b/git-gui.sh
index 5bc21b8..a5335b1 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -624,7 +624,10 @@ proc git_write {args} {
 }
 
 proc githook_read {hook_name args} {
-	set pchook [gitdir hooks $hook_name]
+	if {[catch {set hooksdir [git config core.hooksPath]}]} {
+		set hooksdir [gitdir hooks]
+	}
+	set pchook [file join $hooksdir $hook_name]
 	lappend args 2>@1
 
 	# On Windows [file executable] might lie so we need to ask
-- 
2.13.0

