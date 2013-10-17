From: Hemmo Nieminen <hemmo.nieminen@iki.fi>
Subject: [PATCH] graph: Fix log's graph's colors when merging branches.
Date: Thu, 17 Oct 2013 09:52:09 +0300
Message-ID: <20131017064853.GA7419@duunidell>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gE7i1rD7pdK0Ng3j"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 17 08:53:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWhSR-0001pe-GM
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 08:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835Ab3JQGxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 02:53:15 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:54616 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124Ab3JQGxO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 02:53:14 -0400
Received: by mail-lb0-f169.google.com with SMTP id z5so1535015lbh.0
        for <git@vger.kernel.org>; Wed, 16 Oct 2013 23:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-type:content-disposition;
        bh=j4pF1/RnHKTnFI4CJ7HWtpV0H7umctKR45oXY1r2PjE=;
        b=sIWy2ygWSWa7+USaqWr2/eg4yCEbEnaCeK7lUhqNJVaegU8Y8bGfMs0t1Q9KDp4U8M
         1bvMec8nr31o+KjjGO+28TDrQ+FJefkuv8OVHM4ttHFxJVpfHA2girXW0Ljak/QcqS3N
         20tAJDpiuj3t0bhM45HgEB6Pp0jUFN6KAzlIybX2eLUmEP/GlqdlM7Wy4jMdcpKEAptF
         qBSLARODhznndjTs5T1NhzGIATpaXqP8L1rIF6s2eAeyVwx8+5qo4OMAV5sP8jkoDZbU
         2+nAItX9dHLU0yjAn+cVoOz6eVG5uSI+D/5N5RvAMl4Uc1SKNA4Z2v40OH1xsZDAytQU
         MWLA==
X-Received: by 10.152.7.105 with SMTP id i9mr6022806laa.9.1381992793069;
        Wed, 16 Oct 2013 23:53:13 -0700 (PDT)
Received: from duunidell (cs27053018.pp.htv.fi. [89.27.53.18])
        by mx.google.com with ESMTPSA id b1sm73385466lah.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Oct 2013 23:53:12 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236288>


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline



--gE7i1rD7pdK0Ng3j
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: inline; filename="0001-graph-Fix-log-s-graph-s-colors-when-merging-branches.patch"

>From bdbefc100ceba66a70f540dfe2b1b09b0869f7ab Mon Sep 17 00:00:00 2001
From: Hemmo Nieminen <hemmo.nieminen@iki.fi>
Date: Wed, 16 Oct 2013 11:28:50 +0300
Subject: [PATCH] graph: Fix log's graph's colors when merging branches.

The log's graph's colors were off sometimes when merging several
branches. For example in the graph depicted below, the '-----.' part
following the asterisk was colored with incorrect colors. This was
caused by the fact that the leftmost branches, not part of the merge,
were not taken into account when calculating the column numbers
(colors).

  | |     Merge of http://members.cox.net/junkio/git-jc.git
  | |
  | *-----.   commit 211232bae64bcc60bbf5d1b5e5b2344c22ed767e
  | |\ \ \ \  Merge: fc54a9c 9e30dd7 c4b83e6 6602659 b28858b
  | | | | | | Author: Junio C Hamano <junkio@cox.net>

Signed-off-by: Hemmo Nieminen <hemmo.nieminen@iki.fi>
---
 graph.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/graph.c b/graph.c
index b24d04c..6404331 100644
--- a/graph.c
+++ b/graph.c
@@ -801,10 +801,10 @@ static int graph_draw_octopus_merge(struct git_graph *graph,
 	int num_dashes =
 		((graph->num_parents - dashless_commits) * 2) - 1;
 	for (i = 0; i < num_dashes; i++) {
-		col_num = (i / 2) + dashless_commits;
+		col_num = (i / 2) + dashless_commits + graph->commit_index;
 		strbuf_write_column(sb, &graph->new_columns[col_num], '-');
 	}
-	col_num = (i / 2) + dashless_commits;
+	col_num = (i / 2) + dashless_commits + graph->commit_index;
 	strbuf_write_column(sb, &graph->new_columns[col_num], '.');
 	return num_dashes + 1;
 }
-- 
1.8.4.1


--gE7i1rD7pdK0Ng3j--
