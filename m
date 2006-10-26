X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH qgit] Remove obsoleted includes
Date: Thu, 26 Oct 2006 20:47:08 +0200
Message-ID: <e5bfff550610261147t61de387bqc591624aaa3b1282@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 18:47:59 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=THMyxIl/Kv4Ko2e7YI3birePTRPXDTOGqnw9vytAgNWjpxBCUMaopBLYeS1wfjYdf8cBeSvcMi/S6DntFBedQy2ZW8jSuR3QRF0zsqwu1fsdi/qokQg2NNXiNgX6zM1N1t1iBSCebYtXRVt8RERT/Fz4XyjnFxq/yG2j2Td2lJU=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30256>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdAG2-0001pc-Sz for gcvg-git@gmane.org; Thu, 26 Oct
 2006 20:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423723AbWJZSrL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 14:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423724AbWJZSrL
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 14:47:11 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:54292 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1423723AbWJZSrJ
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 14:47:09 -0400
Received: by nz-out-0102.google.com with SMTP id z3so390841nzf for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 11:47:09 -0700 (PDT)
Received: by 10.35.66.13 with SMTP id t13mr3861545pyk; Thu, 26 Oct 2006
 11:47:08 -0700 (PDT)
Received: by 10.35.42.4 with HTTP; Thu, 26 Oct 2006 11:47:08 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

Also small code cleanup

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---

Still unable to push to public repo :(

 src/listview.cpp |  239 ++++++++++++++++++++++++++----------------------------
 src/listview.h   |    4 +-
 2 files changed, 115 insertions(+), 128 deletions(-)

diff --git a/src/listview.cpp b/src/listview.cpp
index 1e33ac0..84a2b4c 100644
--- a/src/listview.cpp
+++ b/src/listview.cpp
@@ -6,13 +6,9 @@
 	Copyright: See COPYING file that comes with this distribution

 */
-#include <qlistview.h>
 #include <qpainter.h>
-#include <qbitmap.h>
 #include <qapplication.h>
-#include <qstatusbar.h>
 #include <qheader.h>
-#include <qpopupmenu.h>
 #include <qdragobject.h>
 #include "common.h"
 #include "domain.h"
@@ -406,145 +402,138 @@ void ListViewItem::setDiffTarget(bool b)
 /* Draw graph part for a lane
  */
 void ListViewItem::paintGraphLane(QPainter* p, int type, int x1, int x2,
-				  const QColor& col, const QBrush& back) {
+                                  const QColor& col, const QBrush& back) {

-        int h = height();
-	int r = (x2-x1)/3;
+	int h =  height() / 2;
+	int m = (x1 + x2) / 2;
+	int r = (x2 - x1) / 3;
+	int d =  2 * r;

-#define P_CENTER  (x1+x2)/2, h/2
-#define P_0       x2,        h/2
-#define P_90      (x1+x2)/2, 0
-#define P_180     x1,        h/2
-#define P_270     (x1+x2)/2, h
-#define R_CENTER  (x1+x2)/2-r, h/2-r, 2*r, 2*r
+	#define P_CENTER m , h
+	#define P_0      x2, h
+	#define P_90     m , 0
+	#define P_180    x1, h
+	#define P_270    m , 2 * h
+	#define R_CENTER m - r, h - r, d, d

-        p->setPen(QPen(col, 2));
+	p->setPen(QPen(col, 2));

 	// vertical line
 	switch (type) {
-		case ACTIVE:
-		case NOT_ACTIVE:
-		case MERGE_FORK:
-		case MERGE_FORK_R:
-		case MERGE_FORK_L:
-		case JOIN:
-		case JOIN_R:
-		case JOIN_L:
-			p->drawLine(P_90, P_270);
-			break;
-		case HEAD:
-		case HEAD_R:
-		case HEAD_L:
-		case BRANCH:
-			p->drawLine(P_CENTER, P_270);
-			break;
-		case TAIL:
-		case TAIL_R:
-		case TAIL_L:
-		case INITIAL:
-		case BOUNDARY:
-		case BOUNDARY_C:
-		case BOUNDARY_R:
-		case BOUNDARY_L:
-			p->drawLine(P_90, P_CENTER);
-			break;
-	        default:
-		        break;
+	case ACTIVE:
+	case NOT_ACTIVE:
+	case MERGE_FORK:
+	case MERGE_FORK_R:
+	case MERGE_FORK_L:
+	case JOIN:
+	case JOIN_R:
+	case JOIN_L:
+		p->drawLine(P_90, P_270);
+		break;
+	case HEAD:
+	case HEAD_R:
+	case HEAD_L:
+	case BRANCH:
+		p->drawLine(P_CENTER, P_270);
+		break;
+	case TAIL:
+	case TAIL_R:
+	case TAIL_L:
+	case INITIAL:
+	case BOUNDARY:
+	case BOUNDARY_C:
+	case BOUNDARY_R:
+	case BOUNDARY_L:
+		p->drawLine(P_90, P_CENTER);
+		break;
+        default:
+		break;
 	}

 	// horizontal line
 	switch (type) {
-		case MERGE_FORK:
-		case JOIN:
-		case HEAD:
-	        case TAIL:
-		case CROSS:
-		case CROSS_EMPTY:
-		case BOUNDARY_C:
-			p->drawLine(P_180, P_0);
-			break;
-		case MERGE_FORK_R:
-		case JOIN_R:
-		case HEAD_R:
-	        case TAIL_R:
-		case BOUNDARY_R:
-			p->drawLine(P_180, P_CENTER);
-			break;
-		case MERGE_FORK_L:
-		case JOIN_L:
-		case HEAD_L:
-	        case TAIL_L:
-		case BOUNDARY_L:
-			p->drawLine(P_CENTER, P_0);
-			break;
-	        default:
-		        break;
+	case MERGE_FORK:
+	case JOIN:
+	case HEAD:
+	case TAIL:
+	case CROSS:
+	case CROSS_EMPTY:
+	case BOUNDARY_C:
+		p->drawLine(P_180, P_0);
+		break;
+	case MERGE_FORK_R:
+	case JOIN_R:
+	case HEAD_R:
+	case TAIL_R:
+	case BOUNDARY_R:
+		p->drawLine(P_180, P_CENTER);
+		break;
+	case MERGE_FORK_L:
+	case JOIN_L:
+	case HEAD_L:
+	case TAIL_L:
+	case BOUNDARY_L:
+		p->drawLine(P_CENTER, P_0);
+		break;
+	default:
+		break;
 	}

 	// center symbol, e.g. rect or ellipse
 	switch (type) {
-		case ACTIVE:
-		case INITIAL:
-		case BRANCH:
-			p->setPen(Qt::NoPen);
-			p->setBrush(col);
-			p->drawEllipse(R_CENTER);
-			break;
-		case MERGE_FORK:
-		case MERGE_FORK_R:
-		case MERGE_FORK_L:
-			p->setPen(Qt::NoPen);
-			p->setBrush(col);
-			p->drawRect(R_CENTER);
-			break;
-
-		case UNAPPLIED:
-			// Red minus sign
-			p->setPen(Qt::NoPen);
-			p->setBrush(red);
-			p->drawRect( (x1+x2)/2-r, h/2 - 1, 2*r, 2);
-			break;
-
-		case APPLIED:
-			// Green plus sign
-			p->setPen(Qt::NoPen);
-			p->setBrush(DARK_GREEN);
-			p->drawRect( (x1+x2)/2-r, h/2 - 1, 2*r, 2);
-			p->drawRect( (x1+x2)/2-1, h/2-r, 2, 2*r);
-			break;
-
-		case BOUNDARY:
-			p->setBrush(back);
-			p->drawEllipse(R_CENTER);
-			break;
-
-		case BOUNDARY_C:
-		case BOUNDARY_R:
-		case BOUNDARY_L:
-			p->setBrush(back);
-			p->drawRect(R_CENTER);
-			break;
-
-	        default:
-		        break;
+	case ACTIVE:
+	case INITIAL:
+	case BRANCH:
+		p->setPen(Qt::NoPen);
+		p->setBrush(col);
+		p->drawEllipse(R_CENTER);
+		break;
+	case MERGE_FORK:
+	case MERGE_FORK_R:
+	case MERGE_FORK_L:
+		p->setPen(Qt::NoPen);
+		p->setBrush(col);
+		p->drawRect(R_CENTER);
+		break;
+	case UNAPPLIED:
+		// Red minus sign
+		p->setPen(Qt::NoPen);
+		p->setBrush(red);
+		p->drawRect(m - r, h - 1, d, 2);
+		break;
+	case APPLIED:
+		// Green plus sign
+		p->setPen(Qt::NoPen);
+		p->setBrush(DARK_GREEN);
+		p->drawRect(m - r, h - 1, d, 2);
+		p->drawRect(m - 1, h - r, 2, d);
+		break;
+	case BOUNDARY:
+		p->setBrush(back);
+		p->drawEllipse(R_CENTER);
+		break;
+	case BOUNDARY_C:
+	case BOUNDARY_R:
+	case BOUNDARY_L:
+		p->setBrush(back);
+		p->drawRect(R_CENTER);
+		break;
+	default:
+		break;
 	}
-
-#undef P_CENTER
-#undef P_0
-#undef P_90
-#undef P_180
-#undef P_270
-#undef R_CENTER
-
+	#undef P_CENTER
+	#undef P_0
+	#undef P_90
+	#undef P_180
+	#undef P_270
+	#undef R_CENTER
 }

-void ListViewItem::paintGraph(const Rev& c, QPainter* p,
-                              const QColorGroup& cg, int width) {
-
-	static QColor colors[COLORS_NUM] = { Qt::black, Qt::red, DARK_GREEN,
-	                                     Qt::blue,  Qt::darkGray, BROWN,
-	                                     Qt::magenta, ORANGE };
+void ListViewItem::paintGraph(const Rev& c, QPainter* p, const
QColorGroup& cg, int width) {

+	static const QColor colors[COLORS_NUM] = { Qt::black, Qt::red, DARK_GREEN,
+	                                           Qt::blue,  Qt::darkGray, BROWN,
+	                                           Qt::magenta, ORANGE };
 	QListView* lv = listView();
 	if (!lv)
 		return;
diff --git a/src/listview.h b/src/listview.h
index b1f1011..28d9f60 100644
--- a/src/listview.h
+++ b/src/listview.h
@@ -8,7 +8,6 @@

 #include <qobject.h>
 #include <qlistview.h>
-#include <qptrvector.h>
 #include "common.h"

 class QFont;
@@ -20,7 +19,7 @@ class FileHistory;
 class ListViewItem: public QListViewItem {
 public:
 	ListViewItem(QListView* p, ListViewItem* a, Git* g, SCRef sha,
-		     const int& w, bool e, unsigned long t, FileHistory* f);
+	             const int& w, bool e, unsigned long t, FileHistory* f);

 	SCRef sha() const { return sha_; }
 	int getLaneType(uint pos) const;
@@ -102,4 +101,3 @@ private:
 };

 #endif
-
-- 
