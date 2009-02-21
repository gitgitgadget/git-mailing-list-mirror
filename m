From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [tig PATCH] Fix previous/next with branch+main view
Date: Sat, 21 Feb 2009 02:07:33 +0100
Message-ID: <1235178453-17785-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 02:09:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LagMf-0002wW-Uy
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 02:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbZBUBHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 20:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753531AbZBUBHk
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 20:07:40 -0500
Received: from fk-out-0910.google.com ([209.85.128.186]:18106 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753434AbZBUBHj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 20:07:39 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1032042fkf.5
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 17:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=jPUdTAEKVmfbX8I6wwTK1DpB0hqdfQNV3/rGKnUn6iU=;
        b=BeSBhqUGZCKlT5JpScnzPYsGpxPDF0adSKVC0Ht2UYr6gRaU/pqo4V/srF/mm51Rkz
         PQwrKD891rhN465K04fj0mx0GpG8FnqiSH98A1RU+l5Ypl/P5r2IY+9ITx2CD+bajBR1
         VOJTPKTZxzNFt+QFuh/bw0nY1pyWHWBEaQwWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=o+1b5DJ37uGu4yaMkCNJvFnIK1ovoCDB776JtcD1+g0dmAdFcOUZYqyIGiy6uCd8Qt
         8+7qV1iZPF+xGa0PDipDYrQHK1KlcgmiWpiYiF1XAPC61jlukDXbsFRckZIMHvrtOUkb
         GsG6yC0GJ/CUXLS6s83TcK5BxecysAdwRYpe0=
Received: by 10.103.6.18 with SMTP id j18mr2144016mui.33.1235178457046;
        Fri, 20 Feb 2009 17:07:37 -0800 (PST)
Received: from localhost (host-78-13-59-64.cust-adsl.tiscali.it [78.13.59.64])
        by mx.google.com with ESMTPS id j2sm972314mue.54.2009.02.20.17.07.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Feb 2009 17:07:36 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.258.g1d592.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110922>

If the main view was opened as a child window of branch view, the
previous/next key would scroll the child window instead of the parent
one, which was not consistent with other dual-window situations.

Fix by checking for a branch+main too when delegating the request.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 tig.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/tig.c b/tig.c
index c22f271..ed2a49c 100644
--- a/tig.c
+++ b/tig.c
@@ -3223,7 +3223,9 @@ view_driver(struct view *view, enum request request)
 		   (view == VIEW(REQ_VIEW_STAGE) &&
 		     view->parent == VIEW(REQ_VIEW_STATUS)) ||
 		   (view == VIEW(REQ_VIEW_BLOB) &&
-		     view->parent == VIEW(REQ_VIEW_TREE))) {
+		     view->parent == VIEW(REQ_VIEW_TREE)) ||
+		   (view == VIEW(REQ_VIEW_MAIN) &&
+		     view->parent == VIEW(REQ_VIEW_BRANCH))) {
 			int line;
 
 			view = view->parent;
-- 
1.6.2.rc1.258.g1d592.dirty
