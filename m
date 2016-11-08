Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 132D62022D
	for <e@80x24.org>; Tue,  8 Nov 2016 00:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbcKHAxI (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 19:53:08 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:46583 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751732AbcKHAxG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 19:53:06 -0500
Received: from [172.18.45.5] (helo=zealot.relativity.greenend.org.uk)
        by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with esmtp
        (return-path ijackson@chiark.greenend.org.uk)
        id 1c3ueu-0003Jx-Am; Tue, 08 Nov 2016 00:53:04 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
To:     git@vger.kernel.org
Cc:     Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH GITK 2/6] gitk: Internal: drawtags: Idempotently reset "ntags"
Date:   Tue,  8 Nov 2016 00:52:38 +0000
Message-Id: <20161108005241.19888-3-ijackson@chiark.greenend.org.uk>
X-Mailer: git-send-email 2.10.1
In-Reply-To: <20161108005241.19888-1-ijackson@chiark.greenend.org.uk>
References: <20161108005241.19888-1-ijackson@chiark.greenend.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous code tracked its change to the length of `marks' by
updateing the variable `ntags'.  This is a bit fragile and cumbersome,
and we are going to want to modify `marks' some more in a moment.

Instead, simply reset ntags to the length of marks, after we have
possibly done any needed abbreviation.

No functional change.

Signed-off-by: Ian Jackson <ijackson@chiark.greenend.org.uk>
---
 gitk | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 42fa41a..31aecda 100755
--- a/gitk
+++ b/gitk
@@ -6575,9 +6575,10 @@ proc drawtags {id x xt y1} {
 	    } else {
 		set marks [list [format "%d tags..." $ntags]]
 	    }
-	    set ntags 1
 	}
     }
+    set ntags [llength $marks]
+
     if {[info exists idheads($id)]} {
 	set marks [concat $marks $idheads($id)]
 	set nheads [llength $idheads($id)]
-- 
2.10.1

