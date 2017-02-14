Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35FB81FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 22:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750812AbdBNWqs (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 17:46:48 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:49738 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750731AbdBNWqr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 17:46:47 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 6CFB245694
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 23:46:45 +0100 (CET)
Authentication-Results: spamfilter03.heinlein-hosting.de (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mailbox.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received; s=
        mail20150812; t=1487112404; bh=dFBzXHWdEgTZJEebopEvw3TF5CDiQVKAf
        O9HNtiKbHQ=; b=my6mUCjrpb1DDMTzdEKdoUzR5sLxb3lFYz6hRLcbec1vcFLOo
        H+QhA/7wCiABmkVmtNInBBV8ZiMh8jPNnJweb4gcbkyiHcJn81bhLdS3uXlTzn1f
        DIdIgzosALwsQnjMnMNKdgH6wi2rFZO0yNNJXXbCNvrRJF9DlQgfbAQzkuQAsDUz
        C6ljSjFkRxEskGE+6sN2ohXZl2sYmJ1EZRgYehYLtZ4q5mdCaUorJ5AnfBAPbFtP
        ToEQnHbKWxupgBnoorkYqYvpEinq0PASsK9ii+kjFMc00nE/jF+pJ0C4X/kVM4oo
        hDLu5Ucy0hCjT1EjgBH35IBBqf3n3OSaj7/Cg==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id MtA1DE9Ll26C; Tue, 14 Feb 2017 23:46:44 +0100 (CET)
From:   bernhardu@mailbox.org
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Bernhard=20=C3=9Cbelacker?= <bernhardu@mailbox.org>
Subject: [PATCH/RFC] git-gui: Fix author name encoding in Amend Last Commit.
Date:   Tue, 14 Feb 2017 23:46:31 +0100
Message-Id: <20170214224631.18012-1-bernhardu@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Bernhard Übelacker <bernhardu@mailbox.org>

In "New Commit" author name is set correctly.
But when doing "Amend Last Commit" the encoding gets wrong.

This patch adds in load_last_commit a similar assignment converting
to tcl encoding for commit_author as already exists for msg.
---
 lib/commit.tcl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/commit.tcl b/lib/commit.tcl
index 83620b7..f5357f2 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -46,6 +46,9 @@ You are currently in the middle of a merge that has not been fully completed.  Y
 				set msg [encoding convertfrom $enc $msg]
 			}
 			set msg [string trim $msg]
+			if {$enc ne {}} {
+				set commit_author [encoding convertfrom $enc $commit_author]
+			}
 		} err]} {
 		error_popup [strcat [mc "Error loading commit data for amend:"] "\n\n$err"]
 		return
-- 
2.11.0

