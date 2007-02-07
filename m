From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] qgit: Improve default column widths by changing resize modes
Date: Wed, 7 Feb 2007 21:39:22 +0000
Message-ID: <200702072139.22272.andyparkins@gmail.com>
References: <75ebbfaed42a61c54ec6a38bc60d5e777a074dc5.1170884269.git.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 22:42:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEuYW-0003Vd-53
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 22:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161291AbXBGVmR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 16:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161436AbXBGVmR
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 16:42:17 -0500
Received: from nz-out-0506.google.com ([64.233.162.228]:28457 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161291AbXBGVmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 16:42:16 -0500
Received: by nz-out-0506.google.com with SMTP id s1so297211nze
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 13:42:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition;
        b=mqKp26wv+BPaDeGE6LCPVb1FbapmmLXLBAH6mveelB7HbCX6jhsBgLF73j/mziyWcixsZx9SIylitMYtbEZ2Y5E08CF/L7Qj+fZIVBnDzV/Mk2dYHCEzllFPnKo/NS+6d0YqcaJ4VzJHg1CL6O2fazfpaVr3Hd5SoPNN2JtKuys=
Received: by 10.114.161.11 with SMTP id j11mr2494291wae.1170884535323;
        Wed, 07 Feb 2007 13:42:15 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 1sm1302339qbh.2007.02.07.13.42.12;
        Wed, 07 Feb 2007 13:42:13 -0800 (PST)
In-Reply-To: <75ebbfaed42a61c54ec6a38bc60d5e777a074dc5.1170884269.git.andyparkins@gmail.com>
X-TUID: 08991bd92e15a939
X-UID: 227
X-Length: 2161
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38975>

The time column is not the best column to be auto stretched, it's
probably a fixed width because it's only showing dates.  The log column
is more typically variable, so have that one be the one that takes up
whatever space is left.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 src/common.h     |    2 +-
 src/listview.cpp |    6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/common.h b/src/common.h
index e3da323..43b5527 100644
--- a/src/common.h
+++ b/src/common.h
@@ -158,7 +158,7 @@ namespace QGit {
 	const int DEF_GRAPH_COL_WIDTH = 80;
 	const int DEF_LOG_COL_WIDTH   = 500;
 	const int DEF_AUTH_COL_WIDTH  = 230;
-	const int DEF_TIME_COL_WIDTH  = 130;
+	const int DEF_TIME_COL_WIDTH  = 160;
 
 	// colors
 	extern const QColor BROWN;
diff --git a/src/listview.cpp b/src/listview.cpp
index d5f8daf..91be60a 100644
--- a/src/listview.cpp
+++ b/src/listview.cpp
@@ -64,12 +64,16 @@ void ListView::setupGeometry() {
 	setPalette(pl); // does not seem to inherit application 
paletteAnnotate
 
 	QHeaderView* hv = header();
-	hv->resizeSection(GRAPH_COL, DEF_GRAPH_COL_WIDTH);
+	hv->setStretchLastSection( false );
+	hv->setResizeMode( LOG_COL, QHeaderView::Stretch );
+	hv->setResizeMode( TIME_COL, QHeaderView::Interactive);
 	hv->setResizeMode(ANN_ID_COL, QHeaderView::ResizeToContents);
+	hv->resizeSection(GRAPH_COL, DEF_GRAPH_COL_WIDTH);
 	hv->resizeSection(LOG_COL, DEF_LOG_COL_WIDTH);
 	hv->resizeSection(AUTH_COL, DEF_AUTH_COL_WIDTH);
 	hv->resizeSection(TIME_COL, DEF_TIME_COL_WIDTH);
 
+
 	if (git->isMainHistory(fh))
 		hideColumn(ANN_ID_COL);
 }
-- 
1.5.0.rc1.gf4b6c
