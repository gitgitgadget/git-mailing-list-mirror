From: Mark Struberg <struberg@yahoo.de>
Subject: [JGIT PATCH] move the 'empty-line' check in RefDatabase#readLine down a bit to after we removed all the whitespaces.
Date: Tue, 1 Sep 2009 21:41:35 +0000 (GMT)
Message-ID: <358677.62716.qm@web27808.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shawn Spearce <spearce@spearce.org>, robin.rosenberg@dewire.com
X-From: git-owner@vger.kernel.org Tue Sep 01 23:41:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mib6m-0002hV-C6
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 23:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755228AbZIAVle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 17:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755221AbZIAVle
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 17:41:34 -0400
Received: from web27808.mail.ukl.yahoo.com ([217.146.182.13]:43165 "HELO
	web27808.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755220AbZIAVle (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Sep 2009 17:41:34 -0400
Received: (qmail 67804 invoked by uid 60001); 1 Sep 2009 21:41:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1251841295; bh=RjKd3pxeNClWzyv71P0iUaeyW0McAf9fcOmzZ1SYh4U=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type; b=YShRpKIgNXsvQCYBBPvtukZNcN0g3uAo97DdYppPQCz1Vg3iKZEFhn1ChgnfVrWbTelwMkH1xu/7TqWp4as3z+tyURV+oMKsW2tECRRJ2/dCTgDrcWdwOMIkAYsyBv3zDQnSNGZTkn01Y95qCSnvEz9ga+7UYl/sT0DVR281ceE=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type;
  b=PC1WAMjmNeCu02rd+zC40u4GcjiaBI42j+LnLj5Hpp/QCauquaTotzz/TN5T9aoWV6YxX/RwZglR4ya0FSMfqs7Vuw0zwkt4aG9zpmz6uoLSVfir5ve13TlzsL7DR3/gc0IVzo0lktLgySsE99f3NWBvWe/MmYmvtvyah10xSig=;
X-YMail-OSG: vIvqEhkVM1kupPA6rx4mVGiOipvR0.f9lQsXU6KQMmvWmJf65ivVQUwn0mPssdvt2ZKkzfuBR0pECiuUL_drY8BrOiLoOnSxo4_gRgYo3R23hx2lYHFi8hvnEupPDsGoW_AwWJOLJYMl6Oj0CwXUyfdWDsoIPnQZEyCrryXvUgQqngqrbfXgZX3vPByGHNwNkIdKicBYQ1V000lkqRRPQfVkvqAn8X3uQkc1DGJmsfsznt_2oGVJkOIBIiSWo.0D7qC9n4wsoFlPjT0s_R_KoIqVsXihX3LutJv8WkzsdAB5RxNfJMUYso24IuT81Q--
Received: from [62.47.156.223] by web27808.mail.ukl.yahoo.com via HTTP; Tue, 01 Sep 2009 21:41:35 GMT
X-Mailer: YahooMailRC/1358.27 YahooMailWebService/0.7.338.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127560>

This way we consistently return null regardless if the line is empty or if it does only contain whitespaces.

Signed-off-by: Mark Struberg <struberg@yahoo.de>
---
 .../src/org/spearce/jgit/lib/RefDatabase.java      |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 477dc62..acc835b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -498,14 +498,15 @@ private static String readLine(final File file)
             throws FileNotFoundException, IOException {
         final byte[] buf = NB.readFully(file, 4096);
         int n = buf.length;
-        if (n == 0)
-            return null;
         
         // remove trailing whitespaces
         while (n > 0 && Character.isWhitespace(buf[n - 1])) {
             n--;
         }
-        
+
+        if (n == 0)
+            return null;
+
         return RawParseUtils.decode(buf, 0, n);
     }
 
-- 
1.6.2.5


      
