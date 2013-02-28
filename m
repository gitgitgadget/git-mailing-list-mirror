From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v8 2/5] blame: introduce $ as "end of file" in -L syntax
Date: Thu, 28 Feb 2013 17:38:20 +0100
Message-ID: <7973d90cfcd86a3c15776b8718ad6bd84ee7b4ac.1362069310.git.trast@student.ethz.ch>
References: <cover.1362069310.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Will Palmer" <wmpalmer@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 17:38:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UB6VU-0001uK-AV
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 17:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563Ab3B1Qic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2013 11:38:32 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:16844 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932404Ab3B1Qia (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2013 11:38:30 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Feb
 2013 17:38:25 +0100
Received: from pctrast.inf.ethz.ch (213.55.184.243) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Feb
 2013 17:38:27 +0100
X-Mailer: git-send-email 1.8.2.rc1.388.g1bd82c8
In-Reply-To: <cover.1362069310.git.trast@student.ethz.ch>
X-Originating-IP: [213.55.184.243]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217235>

To save the user a lookup of the last line number, introduce $ as a
shorthand for the last line.  This is mostly useful to spell "until
the end of the file" as '-L<begin>,$'.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/line-range-format.txt | 6 ++++++
 line-log.c                          | 8 ++++++++
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
diff --git a/line-log.c b/line-log.c
index a24a86b..b167b00 100644
--- a/line-log.c
+++ b/line-log.c
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
1.8.2.rc1.388.g1bd82c8
