From: jidanni@jidanni.org
Subject: [PATCH] Documentation/git-bundle.txt: Dumping contents of any bundle
Date: Thu, 01 Jan 2009 12:24:59 +0800
Message-ID: <87prj7mz50.fsf_-_@jidanni.org>
References: <20081219205100.GA26671@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mdl123@verizon.net, spearce@spearce.org, git@vger.kernel.org
To: peff@peff.net, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 01 05:31:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIFDc-0000jp-DJ
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 05:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760AbZAAEZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 23:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754439AbZAAEZH
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 23:25:07 -0500
Received: from mailbigip.dreamhost.com ([208.97.132.5]:49604 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753829AbZAAEZG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Dec 2008 23:25:06 -0500
Received: from jidanni.org (122-127-33-78.dynamic.hinet.net [122.127.33.78])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id 7FE67D25DF;
	Wed, 31 Dec 2008 20:25:01 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104289>

>>>>> "JK" == Jeff King <peff@peff.net> writes:

JK> AFAIK, there is no tool to try salvaging strings from an incomplete pack
JK> (and you can't just run "strings" because the deltas are zlib
JK> compressed). So if I were in the police forensics department, I think I
JK> would read Documentation/technical/pack-format.txt and start hacking a
JK> solution as quickly as possible.

Hogwash. Patch follows. Maybe even better methods are available.

Signed-off-by: jidanni <jidanni@jidanni.org>
---
 Documentation/git-bundle.txt |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 1b66ab7..80248f5 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -164,6 +164,28 @@ $ git pull bundle
 would treat it as if it is talking with a remote side over the
 network.
 
+DUMPING CONTENTS OF ANY BUNDLE
+-----------------------
+
+Even if we cannot unbundle a bundle,
+
+------------
+$ git init
+$ git bundle unbundle mybundle.bun
+error: Repository lacks these prerequisite commits...
+------------
+
+We can still examine all the data contained within,
+
+------------
+$ sed '/^PACK/,$!d' mybundle.bun > mybundle.pack
+$ git unpack-objects < mybundle.pack
+$ cd .git/objects
+$ ls ??/*|tr -d /|git cat-file --batch-check
+$ ls ??/*|tr -d /|git cat-file --batch
+------------
+
+
 Author
 ------
 Written by Mark Levedahl <mdl123@verizon.net>
-- 
1.6.0.6
