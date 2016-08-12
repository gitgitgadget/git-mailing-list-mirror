Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 106F3203BD
	for <e@80x24.org>; Fri, 12 Aug 2016 23:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbcHLXpg (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 19:45:36 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:18650 "EHLO
	smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbcHLXpd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 19:45:33 -0400
Received: from localhost.localdomain ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id YM8nbWgnZY8RwYM8qbscXt; Sat, 13 Aug 2016 00:45:32 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=b+Xw2ZOx c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8
 a=pGLkceISAAAA:8 a=8q6LdnVOAAAA:8 a=IFH_yTJTXzaC50ORncQA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=xts0dhWdiJbonKbuqhAr:22
 a=6kGIvZw6iX1k4Y-7sg4_:22 a=jNYSTCpFY2gkngftge3H:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH v6 11/12] doc: revisions: show revision expansion in examples
Date:	Sat, 13 Aug 2016 00:45:21 +0100
Message-Id: <20160812234522.7792-4-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160812234522.7792-1-philipoakley@iee.org>
References: <20160811215035.4108-1-philipoakley@iee.org>
 <20160812234522.7792-1-philipoakley@iee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfI31xI8fasbwdZ5X0jwQfLot5XA2ewLxw2XNONpU5w8GOUagBsYBlIP+sbWEE4x1YVM0uuQZpX27KpWpG6vgLEEmIMGRdxtXIQiNwsXyCxqk5cojc4pI
 WYq+/9Goa5HrgF8C7npLGa69v9WoaGx4PNmEPah+gvv0Rmo3kwd7PTNXetVy1B7NxIRtpqOR16QS0pHfsCmq9BaIpG3j758Wh6r/inxzLM2ZHzjg246EwI6c
 cByCwN6FtcvhmXVR+zpvdgTU/8vqQDAhLSwP+VL+Hzg=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The revisions examples show the revison arguments and the selected
commits, but do not show the intermediate step of the expansion of
the special 'range' notations. Extend the examples, including an
all-parents multi-parent merge commit example.

Sort the examples and fix the alignment for those unaffected
in the next commit.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
v6 updated
Cc: Jakub Narębski <jnareb@gmail.com>
Cc: Marc Branchaud <marcnarc@xiplink.com>
---
 Documentation/revisions.txt | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index e9a74fc..f15d5ed 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -326,16 +326,27 @@ Revision Range Summary
   as giving commit '<rev>' and then all its parents prefixed with
   '{caret}' to exclude them (and their ancestors).
 
-Here are a handful of examples:
+Here are a handful of examples using the Loeliger illustration above,
+with each step in the notation's expansion and selection carefully
+spelt out:
 
+   Args   Expanded arguments    Selected commits
    D                G H D
    D F              G H I J D F
    ^G D             H D
    ^D B             E I J F B
-   B..C             C
-   B...C            G H D E B C
+   B..C   = ^B C                C
+   B...C  = B ^F C              G H D E B C
    ^D B C           E I J F B C
    C                I J F C
-   C^@              I J F
-   C^!              C
-   F^! D            G H D F
+   C^@    = C^1
+          = F                   I J F
+   B^@    = B^1 B^2 B^3
+          = D E F               D G H E F I J
+   C^!    = C ^C^@
+          = C ^C^1
+          = C ^F                C
+   B^!    = B ^B^@
+          = B ^B^1 ^B^2 ^B^3
+          = B ^D ^E ^F          B
+   F^! D  = F ^I ^J D           G H D F
-- 
2.9.0.windows.1

