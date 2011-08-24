From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] Mark http-fetch without -a as deprecated
Date: Tue, 23 Aug 2011 20:29:51 -0400
Message-ID: <1314145791-23216-1-git-send-email-bwalton@artsci.utoronto.ca>
References: <vpqvcto391x.fsf@bauges.imag.fr>
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 24 02:30:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qw1MU-00083W-7Z
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 02:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755404Ab1HXAaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 20:30:23 -0400
Received: from jerry.cquest.utoronto.ca ([192.82.128.5]:36928 "EHLO
	jerry.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab1HXAaW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 20:30:22 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:56795 ident=93)
	by jerry.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Qw1MF-0000cz-1K; Tue, 23 Aug 2011 20:30:15 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Qw1MF-00062y-0F; Tue, 23 Aug 2011 20:30:15 -0400
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <vpqvcto391x.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179982>

As the use of http-fetch without -a can create an object store that is
invalid to the point where it cannot even be fsck'd, mark it as
deprecated.  A future release should change the default and then
remove the option entirely.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 Documentation/git-http-fetch.txt |    3 +++
 http-fetch.c                     |    4 ++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index 4d42073..070cd1e 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -15,6 +15,9 @@ DESCRIPTION
 -----------
 Downloads a remote git repository via HTTP.
 
+*NOTE*: use of this command without -a is deprecated.  The -a
+behaviour will become the default in a future release.
+
 OPTIONS
 -------
 commit-id::
diff --git a/http-fetch.c b/http-fetch.c
index 3af4c71..8c4c5d2 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -56,6 +56,10 @@ int main(int argc, const char **argv)
 		commits = 1;
 	}
 
+	if (get_all == 0)
+		warning("http-fetch: use without -a is deprecated.\n"
+			"In a future release, -a will become the default.");
+
 	if (argv[arg])
 		str_end_url_with_slash(argv[arg], &url);
 
-- 
1.7.4.1
