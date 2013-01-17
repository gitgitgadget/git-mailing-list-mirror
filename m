From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 6/8] git-remote-testpy: hash bytes explicitly
Date: Thu, 17 Jan 2013 18:53:59 +0000
Message-ID: <66c42ff65eddde494f40d0a582e89a081b4ab8e8.1358448207.git.john@keeping.me.uk>
References: <cover.1358448207.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Pete Wyckoff <pw@padd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 19:57:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvueF-0005fH-7a
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 19:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756273Ab3AQS4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 13:56:48 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:56607 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756200Ab3AQS4m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 13:56:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 8B772CDA583;
	Thu, 17 Jan 2013 18:56:42 +0000 (GMT)
X-Quarantine-ID: <AQ3wZkPh95xS>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AQ3wZkPh95xS; Thu, 17 Jan 2013 18:56:37 +0000 (GMT)
Received: from aardwolf.aluminati.org (aardwolf.aluminati.org [10.0.7.189])
	by jackal.aluminati.org (Postfix) with ESMTP id B3321CDA5AE;
	Thu, 17 Jan 2013 18:56:37 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by aardwolf.aluminati.org (Postfix) with ESMTP id 922D5276DFE;
	Thu, 17 Jan 2013 18:56:37 +0000 (GMT)
X-Quarantine-ID: <kaVmsl27lKyX>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from aardwolf.aluminati.org ([127.0.0.1])
	by localhost (aardwolf.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kaVmsl27lKyX; Thu, 17 Jan 2013 18:56:37 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by aardwolf.aluminati.org (Postfix) with ESMTPSA id D1D2B276DFB;
	Thu, 17 Jan 2013 18:56:22 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <cover.1358448207.git.john@keeping.me.uk>
In-Reply-To: <cover.1358448207.git.john@keeping.me.uk>
References: <cover.1358018078.git.john@keeping.me.uk> <cover.1358448207.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213868>

Under Python 3 'hasher.update(...)' must take a byte string and not a
unicode string.  Explicitly encode the argument to this method as UTF-8
so that this code works under Python 3.

This moves the required Python version forward to 2.0.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-remote-testpy.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-remote-testpy.py b/git-remote-testpy.py
index d94a66a..f8dc196 100644
--- a/git-remote-testpy.py
+++ b/git-remote-testpy.py
@@ -31,9 +31,9 @@ from git_remote_helpers.git.exporter import GitExporter
 from git_remote_helpers.git.importer import GitImporter
 from git_remote_helpers.git.non_local import NonLocalGit
 
-if sys.hexversion < 0x01050200:
-    # os.makedirs() is the limiter
-    sys.stderr.write("git-remote-testgit: requires Python 1.5.2 or later.\n")
+if sys.hexversion < 0x02000000:
+    # string.encode() is the limiter
+    sys.stderr.write("git-remote-testgit: requires Python 2.0 or later.\n")
     sys.exit(1)
 
 def get_repo(alias, url):
@@ -45,7 +45,7 @@ def get_repo(alias, url):
     repo.get_head()
 
     hasher = _digest()
-    hasher.update(repo.path)
+    hasher.update(repo.path.encode('utf-8'))
     repo.hash = hasher.hexdigest()
 
     repo.get_base_path = lambda base: os.path.join(
-- 
1.8.1.1.260.g99b33f4.dirty
