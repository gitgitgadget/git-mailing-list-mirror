From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 2/6] Fix RefSpecPanel to not display mode column in fetch version
Date: Wed, 27 Aug 2008 20:41:42 +0200
Message-ID: <1219862506-11075-3-git-send-email-marek.zawirski@gmail.com>
References: <1219862506-11075-1-git-send-email-marek.zawirski@gmail.com>
 <1219862506-11075-2-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Aug 27 20:43:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYPzO-0005iW-HX
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 20:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbYH0SmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 14:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752793AbYH0SmE
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 14:42:04 -0400
Received: from gv-out-0910.google.com ([216.239.58.189]:36375 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbYH0Sl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 14:41:58 -0400
Received: by gv-out-0910.google.com with SMTP id e6so522214gvc.37
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 11:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cvpel/WNPORlEfOfTvJRL20fDi1yM/Ubk3vChqLvi5g=;
        b=P4mR71w9b2xG5kndDl4xC0d18SLxDoNkm9WJ+8l7loXEd/EiTmena5eCOtnWlR/l8F
         kTMxfOja0TKaURVRygA0qqryBJ692l6DNGPJws50X7PSJrnoujj9OxcUxSqUmZ+h3qaD
         woM+1MLDVf8kA079NAzm5NvTkkuc0q8cD8/Tc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JkDZ926rM1bAm8xG/NS4VT2Dth8vh5cUuGEpWXouw3EgLzVlbmQ9jW5SRSt3ZU1sbi
         DxbnpT0Os7H9DPMqZuUlznUZyZOVttA1sDPlXOt4UypjRYKOu/YWNJa55o9M0S+SjkaR
         B2KXou5ZXZEysXJ3+N9PsPSusFCin+2LXTmw4=
Received: by 10.103.176.20 with SMTP id d20mr173531mup.136.1219862516952;
        Wed, 27 Aug 2008 11:41:56 -0700 (PDT)
Received: from localhost ( [62.21.4.140])
        by mx.google.com with ESMTPS id j10sm11072170mue.17.2008.08.27.11.41.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 11:41:56 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219862506-11075-2-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93921>

"Delete" mode is valid only for push, we need only "update/create"
mode for fetch, so there is no need to display this column here.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../egit/ui/internal/components/RefSpecPanel.java  |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java
index 34d37fd..de82480 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java
@@ -951,7 +951,8 @@ private void createTableColumns(final Composite tablePanel) {
 		tablePanel.setLayout(columnLayout);
 
 		createDummyColumn(columnLayout);
-		createModeColumn(columnLayout);
+		if (pushSpecs)
+			createModeColumn(columnLayout);
 		createSrcColumn(columnLayout);
 		createDstColumn(columnLayout);
 		createForceColumn(columnLayout);
@@ -1277,7 +1278,8 @@ private TableViewerColumn createColumn(
 	}
 
 	private void createCellEditors(final Table table) {
-		modeCellEditor = new CheckboxCellEditor(table);
+		if (pushSpecs)
+			modeCellEditor = new CheckboxCellEditor(table);
 		localRefCellEditor = createLocalRefCellEditor(table);
 		remoteRefCellEditor = createRemoteRefCellEditor(table);
 		forceUpdateCellEditor = new CheckboxCellEditor(table);
-- 
1.5.6.3
