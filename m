From: Nicholas Campbell <nicholas.j.campbell@gmail.com>
Subject: [JGIT PATCH 1/1] Generate javadoc when making jgit. Also, package 
	docs into a zip for distribution.
Date: Mon, 10 Aug 2009 00:32:27 -0400
Message-ID: <76596580908092132h1aab0c22qb364914ce9e827b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 06:32:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaMZ5-0000rm-K2
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 06:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbZHJEcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 00:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbZHJEcr
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 00:32:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:46135 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbZHJEcr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 00:32:47 -0400
Received: by fg-out-1718.google.com with SMTP id e12so379187fga.17
        for <git@vger.kernel.org>; Sun, 09 Aug 2009 21:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=kTN0zFlO5wQmBSKG3RPM/hXTLMZzBuKAjLBuO6a6dp4=;
        b=JPP3Uvn/sghSrCzBc7EYHOLa8UHFwLD1V3BEdqd2UtrBPOKvHuVyxtPNplLyzda7sP
         rSKfAI4YYkCuVtfveLBJ7BhUfrLzmNB0NH19i4YyVksh2kwdLVnQxcmKuWZTK0JUlKM1
         RTktbGG2o9HQOpKAJG20jog57wNZVAmK1Ee/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=l30K2TDNoe3epWpOIRdTDA1bZb2pj20V2sNkpmEdr0R5AsItxjeRpzpyng1NS6AKe+
         kugRKu1xJBD+CY6Vz3JMfrvu/cFgU+vSjcdpmo25tiMSFl5a8Qj5OiijHo490iqKC9Ft
         0Q1hK2l5t/srw0Gfyut8D+vl9zGJ173WbP4Uo=
Received: by 10.239.136.143 with SMTP id h15mr394506hbh.106.1249878767113; 
	Sun, 09 Aug 2009 21:32:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125400>

Runs through defined "PLUGINS" and creates Javadoc. Assumes src is a subdir.

Signed-off-by: Nick Campbell <nicholas.j.campbell@gmail.com>
---
 make_jgit.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/make_jgit.sh b/make_jgit.sh
index baaa3af..25ac15c 100755
--- a/make_jgit.sh
+++ b/make_jgit.sh
@@ -3,6 +3,7 @@
 O_CLI=jgit
 O_JAR=jgit.jar
 O_SRC=jgit_src.zip
+O_DOC=jgit_docs.zip

 PLUGINS="
        org.spearce.jgit
@@ -119,3 +120,12 @@ mv $O_CLI+ $O_CLI &&
 echo "Created $O_CLI." || die "Build failed."

 cleanup_bin
+
+echo "Build Docs"
+for p in $PLUGINS; do
+    javadoc -sourcepath "$p/src/" -d "docs/$p/" `find "$p/src" -name "*.java"`
+done
+
+jar cf "$O_DOC" docs/
+echo "Created $O_DOC."
+
--
1.6.0.4
