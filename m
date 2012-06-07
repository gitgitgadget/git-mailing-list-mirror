From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v7 2/5] blame: introduce $ as "end of file" in -L syntax
Date: Thu, 7 Jun 2012 12:23:26 +0200
Message-ID: <d9e1235303c949849b9acfa37fc9e9a780d93873.1339063659.git.trast@student.ethz.ch>
References: <cover.1339063659.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Bo Yang <struggleyb.nku@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 07 12:24:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScZsn-0000jN-H5
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 12:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758644Ab2FGKXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 06:23:51 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:19074 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753710Ab2FGKXe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 06:23:34 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 7 Jun
 2012 12:23:28 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 7 Jun
 2012 12:23:29 +0200
X-Mailer: git-send-email 1.7.11.rc1.243.gbf4713c
In-Reply-To: <cover.1339063659.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199390>

To save the user a lookup of the last line number, introduce $ as a
shorthand for the last line.  This is mostly useful to spell "until
the end of the file" as '-L<begin>,$'.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/line-range-format.txt | 6 ++++++
 line.c                              | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/line-range-format.txt b/Documentation/line-range-format.txt
index 265bc23..9ce0688 100644
--- a/Documentation/line-range-format.txt
+++ b/Documentation/line-range-format.txt
@@ -16,3 +16,9 @@ starting at the line given by <start>.
 This is only valid for <end> and will specify a number
 of lines before or after the line given by <start>.
 +
+
+- `$`
++
+A literal dollar sign can be used as a shorthand for the last line in
+the file.
++
diff --git a/line.c b/line.c
index afd2e3b..a7f33ed 100644
--- a/line.c
+++ b/line.c
@@ -15,6 +15,14 @@ const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
 	regmatch_t match[1];
 
 	/*
+	 * $ is a synonym for "the end of the file".
+	 */
+	if (spec[0] == '$') {
+		*ret = lines;
+		return spec + 1;
+	}
+
+	/*
 	 * Allow "-L <something>,+20" to mean starting at <something>
 	 * for 20 lines, or "-L <something>,-5" for 5 lines ending at
 	 * <something>.
-- 
1.7.11.rc1.243.gbf4713c
