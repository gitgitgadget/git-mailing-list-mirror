From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [PATCH JGIT] Method invokes inefficient new String(String) constructor
Date: Thu, 19 Mar 2009 10:15:58 +0100
Message-ID: <49C20D4E.5020203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 10:17:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkENb-0002Nf-FU
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 10:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbZCSJQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 05:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753355AbZCSJQE
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 05:16:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:43574 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbZCSJQC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 05:16:02 -0400
Received: by nf-out-0910.google.com with SMTP id d21so74656nfb.21
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 02:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=n8kBdBL20nYMfaak5ZDz3+wrpzVGV4dsRn3Lt0u79LA=;
        b=Yyju80Ks3Y5Srk7ZZqs9DnKK+zxt49wGxGPqvGJzZ/u/7wPOuef0FmcdvbUGJHn/c2
         SUaHkQE+Kx/kbgHWXv5UnWxFVK6DwlUShigyjb4vrr9/BbO9eFPe5sgwYRViXdOX3aiF
         HFlmoUb0+CaA6mP3jQW3Kzdt/k68jQH28Njxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=UiTbXKhVJP0UML5KuokEu5PjIahkSwnFqVqEBs+bnxK5iyTMXl/99LBvP4OU+qwTQs
         RXtnE0no1wt3Lf0tw809dD5ZFIMPbdcjZ/z9ZHCgGAoU1Y2dsfRG66d2vVFa1pGUK3os
         FHl5yITxsz5Un9g5XxfZgIfFaHvqZ9PfgQA2E=
Received: by 10.210.17.14 with SMTP id 14mr6211581ebq.49.1237454159596;
        Thu, 19 Mar 2009 02:15:59 -0700 (PDT)
Received: from ?10.11.2.21? (port-87-193-216-74.static.qsc.de [87.193.216.74])
        by mx.google.com with ESMTPS id 10sm947879eyd.43.2009.03.19.02.15.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Mar 2009 02:15:59 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113739>

>From FindBugs:
Using the java.lang.String(String) constructor wastes memory because
the object so constructed will be functionally indistinguishable from
the String passed as a parameter. Just use the argument String directly.

Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
---
 .../src/org/spearce/jgit/lib/RefDatabase.java      |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 87f26bf..49da538 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -447,7 +447,7 @@ private synchronized void refreshPackedRefs() {
 
 					final int sp = p.indexOf(' ');
 					final ObjectId id = ObjectId.fromString(p.substring(0, sp));
-					final String name = new String(p.substring(sp + 1));
+					final String name = p.substring(sp + 1);
 					last = new Ref(Ref.Storage.PACKED, name, name, id);
 					newPackedRefs.put(last.getName(), last);
 				}
-- 
1.6.1.2
