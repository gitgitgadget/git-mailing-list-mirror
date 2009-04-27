From: "Sohn, Matthias" <matthias.sohn@sap.com>
Subject: [PATCH JGIT] Method invokes inefficient new String(String) constructor
Date: Tue, 28 Apr 2009 01:05:43 +0200
Message-ID: <366BBB1215D0AB4B8A153AF047A2878002FCE7E8@dewdfe18.wdf.sap.corp>
References: <366BBB1215D0AB4B8A153AF047A2878002FCE7E7@dewdfe18.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	"Robin Rosenberg" <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 06:38:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyf5q-0007bZ-9L
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 06:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359AbZD1Eir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 00:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbZD1Eiq
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 00:38:46 -0400
Received: from smtpde03.sap-ag.de ([155.56.68.140]:57846 "EHLO
	smtpde03.sap-ag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbZD1Eiq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 00:38:46 -0400
Received: from mail.sap.corp
	by smtpde03.sap-ag.de (26) with ESMTP id n3RN5i76012378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 28 Apr 2009 01:05:44 +0200 (MEST)
Received: from dewdfe1i3.wdf.sap.corp (dewdfe1i3.wdf.sap.corp [10.17.149.41])
	by mail.sap.corp (mail03-25) with ESMTP id n3RN5ihH027439;
	Tue, 28 Apr 2009 01:05:44 +0200 (MEST)
Received: from dewdfe18.wdf.sap.corp ([10.21.20.140]) by dewdfe1i3.wdf.sap.corp with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Apr 2009 01:05:44 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <366BBB1215D0AB4B8A153AF047A2878002FCE7E7@dewdfe18.wdf.sap.corp>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH JGIT] Method invokes inefficient new String(String) constructor
Thread-Index: AcnHjEysWP+qTjB1Tm2zGBLNNuNqlAAAC8hQ
X-OriginalArrivalTime: 27 Apr 2009 23:05:44.0304 (UTC) FILETIME=[B1703700:01C9C78C]
X-Scanner: Virus Scanner virwal05
X-SAP: out
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117746>

Using the java.lang.String(String) constructor wastes memory because the
object so constructed will be functionally
indistinguishable from the String passed as a parameter.  Just use the
argument String directly.

Signed-off-by: Matthias Sohn <matthias.sohn@sap.com>
---
 .../src/org/spearce/jgit/lib/RefDatabase.java      |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 87f26bf..49da538 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -447,7 +447,7 @@ private synchronized void refreshPackedRefs() {
 
 					final int sp = p.indexOf(' ');
 					final ObjectId id =
ObjectId.fromString(p.substring(0, sp));
-					final String name = new
String(p.substring(sp + 1));
+					final String name =
p.substring(sp + 1);
 					last = new
Ref(Ref.Storage.PACKED, name, name, id);
 
newPackedRefs.put(last.getName(), last);
 				}
-- 
1.6.2.2.1669.g7eaf8
