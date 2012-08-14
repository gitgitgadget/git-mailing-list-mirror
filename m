From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH/RFC v3 05/16] Add documentation for the 'bidi-import' capability of remote-helpers.
Date: Tue, 14 Aug 2012 21:13:07 +0200
Message-ID: <1344971598-8213-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 21:17:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1McA-0003IV-Kb
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 21:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756208Ab2HNTRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 15:17:11 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44490 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756519Ab2HNTRH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 15:17:07 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so265503bkw.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 12:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NSUfOzkXV+6s6swqS4Po+ZJit6lDK0Rqb/7KIpvm8qo=;
        b=iKLiFuz82l6synxdlGvp8u99IsgaIvo0YkXbunzslz0xKG/TLxLLxBDHOFL612KlCi
         6tPyvs1AHZVFQmlMtmYIzuQbWukeGz9T260+GmbQlE4OC4dG42SpYoL74eYTcQDlG6we
         cLcEEn2X34RvzvJ4BlWgejrkZHFPmNV4G98crdr3GBIX5i6pl1V5EYpWu9+S7bzI77/X
         hJbRoClvLIt5AtJwL4U87HJ1yOqBSZEUGTmWzsoF2qM+eUJkql7RPyyJ6025NdsFmjwN
         4WJW2d9D524EVUZFTk2tcH36Llh5XA//J7ZZ/Cq+CRkQJqZW0Ec7Njjkd9SyU4I/Wv+A
         E1lg==
Received: by 10.204.128.68 with SMTP id j4mr6665918bks.122.1344971826750;
        Tue, 14 Aug 2012 12:17:06 -0700 (PDT)
Received: from localhost.localdomain (089144206125.atnat0015.highway.a1.net. [89.144.206.125])
        by mx.google.com with ESMTPS id fu8sm1681583bkc.5.2012.08.14.12.17.04
        (version=SSLv3 cipher=OTHER);
        Tue, 14 Aug 2012 12:17:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1344971598-8213-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203429>

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 Documentation/git-remote-helpers.txt |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index f5836e4..5faa48e 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -98,6 +98,20 @@ advertised with this capability must cover all refs reported by
 the list command.  If no 'refspec' capability is advertised,
 there is an implied `refspec *:*`.
 
+'bidi-import'::
+	The fast-import commands 'cat-blob' and 'ls' can be used by remote-helpers
+    to retrieve information about blobs and trees that already exist in
+    fast-import's memory. This requires a channel from fast-import to the
+    remote-helper.
+    If it is advertised in addition to "import", git establishes a pipe from
+	fast-import to the remote-helper's stdin.
+	It follows that git and fast-import are both connected to the
+	remote-helper's stdin. Because git can send multiple commands to
+	the remote-helper it is required that helpers that use 'bidi-import'
+	buffer all 'import' commands of a batch before sending data to fast-import.
+    This is to prevent mixing commands and fast-import responses on the
+    helper's stdin.
+
 Capabilities for Pushing
 ~~~~~~~~~~~~~~~~~~~~~~~~
 'connect'::
@@ -286,7 +300,12 @@ terminated with a blank line. For each batch of 'import', the remote
 helper should produce a fast-import stream terminated by a 'done'
 command.
 +
-Supported if the helper has the "import" capability.
+Note that if the 'bidi-import' capability is used the complete batch
+sequence has to be buffered before starting to send data to fast-import
+to prevent mixing of commands and fast-import responses on the helper's
+stdin.
++
+Supported if the helper has the 'import' capability.
 
 'connect' <service>::
 	Connects to given service. Standard input and standard output
-- 
1.7.9.5
