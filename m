Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 5369 invoked by uid 111); 3 Oct 2008 10:14:29 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 03 Oct 2008 06:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbYJCKOG (ORCPT <rfc822;peff@peff.net>);
	Fri, 3 Oct 2008 06:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754987AbYJCKOF
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 06:14:05 -0400
Received: from [212.249.11.140] ([212.249.11.140]:38134 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753200AbYJCKOE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 06:14:04 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id D0A9D2AC8DE; Fri,  3 Oct 2008 12:13:46 +0200 (CEST)
From:	Petr Baudis <pasky@suse.cz>
To:	git@vger.kernel.org
Cc:	spearce@spearce.org, Petr Baudis <petr.baudis@novartis.com>
Subject: [PATCH] git-gui: Correctly set up locators in case of preset URL variable
Date:	Fri,  3 Oct 2008 12:13:46 +0200
Message-Id: <1223028826-10306-1-git-send-email-pasky@suse.cz>
X-Mailer: git-send-email 1.5.6.3.392.g292f1
In-Reply-To: <20080930195839.GK21310@spearce.org>
References: <20080930195839.GK21310@spearce.org>
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This patch fixes locators setup in case the URL variable is already set,
e.g. in the clone dialog during 'git gui clone'.

Signed-off-by: Petr Baudis <petr.baudis@novartis.com>

---
 git-gui/lib/transport.tcl |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/git-gui/lib/transport.tcl b/git-gui/lib/transport.tcl
index 277e6b8..02c4eca 100644
--- a/git-gui/lib/transport.tcl
+++ b/git-gui/lib/transport.tcl
@@ -68,8 +68,13 @@ proc location_input {widget urlvar op} {
 
 	global _locator_template _locator_input _locator_var
 	trace remove variable _locator_input write locator_update
-	set _locator_template $default_locator
-	set _locator_input {}
+	if {[set $urlvar] == {}} {
+		set _locator_template $default_locator
+		set _locator_input {}
+	} else {
+		set _locator_template "URL"
+		set _locator_input [set $urlvar]
+	}
 	set _locator_var $urlvar
 	trace add variable _locator_input write locator_update
 
-- 
tg: (3c6c738..) t/git-gui/locator-preset (depends on: git-gui/locators t/git-gui/clonecmd)
