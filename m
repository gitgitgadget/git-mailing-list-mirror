From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [PATCH JGIT 4/5] Method fails to close stream
Date: Thu, 19 Mar 2009 10:16:43 +0100
Message-ID: <49C20D7B.1060702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 10:18:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkEON-0002fY-5d
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 10:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755972AbZCSJQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 05:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755970AbZCSJQt
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 05:16:49 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:57450 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755617AbZCSJQs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 05:16:48 -0400
Received: by ewy9 with SMTP id 9so323676ewy.37
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 02:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=11IlTeeiYR5BRFR5NmXhe70QBcHONxJo1Bepxbvs5kM=;
        b=fiGLW1pbJromtCRjAcLTggpLG81wmYN/lrz5L+ygOSFLjvy2QEug95g0Up3t3vtvS7
         BZPfS6as1fxwGCWQC6rsYxsGQGY5hXRkgT/fuR8+QiERyKsCuCN97PJ5Uds+XobQAsCx
         Ku1zhX+iOT7sHSONMakYw2npTdPjHJFDkdfqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=k2O1+310/CoeIvprZ5JjaEacmc4JjQJdq/0+N1PSJyajITmWaj5TenW+8V4a5f9Rbk
         dEAoTodGGwKDzTQ91d8zt2ZQeOxl8OSjDzu8qJEDah/JgVEvPgB3XTf/X99Uge5UzDdY
         sTsOGmzz7fVfhTHLjzFjFXZWv9O3Mvh2fJD9k=
Received: by 10.210.37.16 with SMTP id k16mr6244231ebk.0.1237454205448;
        Thu, 19 Mar 2009 02:16:45 -0700 (PDT)
Received: from ?10.11.2.21? (port-87-193-216-74.static.qsc.de [87.193.216.74])
        by mx.google.com with ESMTPS id 28sm976662eye.4.2009.03.19.02.16.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Mar 2009 02:16:45 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113740>

The stream was only closed in case of an error.
Use a finally block instead to ensure that the
stream is closed.

Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
---
 .../src/org/spearce/jgit/lib/Repository.java       |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 8132e27..cfd92b8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -152,7 +152,7 @@ public Repository(final File d) throws IOException {
 				for (String alt=ar.readLine(); alt!=null; alt=ar.readLine()) {
 					readObjectsDirs(FS.resolve(objectsDir, alt), ret);
 				}
-			} catch (Exception e) {
+			} finally {
 				ar.close();
 			}
 		}
-- 
1.6.1.2
