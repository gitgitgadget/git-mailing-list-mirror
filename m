From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation: rerere.enabled overrides [ -d rr-cache ]
Date: Fri, 6 Jan 2012 14:08:02 +0100
Message-ID: <f697b8eff63a8cdd1207c6bfd6b88c532832c6b5.1325855112.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 06 14:08:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rj9Wn-0002k7-MI
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 14:08:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197Ab2AFNIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 08:08:07 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:12657 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090Ab2AFNIG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 08:08:06 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 6 Jan
 2012 14:07:59 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 6 Jan
 2012 14:08:02 +0100
X-Mailer: git-send-email 1.7.8.2.479.g7c686
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188022>

The wording seems to suggest that you can only globally disable rerere
with the rerere.enabled setting.  But the code actually consults the
config first, and even creates rr-cache for the user if needed.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Noticed while discussing rerere on IRC.  "Can be disabled by setting
this option to false" is of course correct, but insinuates that
setting it to 'true' still falls back to rr-cache, which it doesn't.

git-rerere(1) does not mention the rr-cache fallback; I decided not to
touch it as it's a bit of an implementation detail.  OTOH the
auto-creation of rr-cache can cause strange behavior if a user has
rerere.enabled unset and tries it once, as in

  git config rerere.enabled true
  git merge ...
  git config --unset rerere.enabled


 Documentation/config.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 68cf702..04f5e19 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1783,10 +1783,10 @@ rerere.autoupdate::
 
 rerere.enabled::
 	Activate recording of resolved conflicts, so that identical
-	conflict hunks can be resolved automatically, should they
-	be encountered again.  linkgit:git-rerere[1] command is by
-	default enabled if you create `rr-cache` directory under
-	`$GIT_DIR`, but can be disabled by setting this option to false.
+	conflict hunks can be resolved automatically, should they be
+	encountered again.  By default, linkgit:git-rerere[1] is
+	enabled if there is an `rr-cache` directory under the
+	`$GIT_DIR`.
 
 sendemail.identity::
 	A configuration identity. When given, causes values in the
-- 
1.7.8.2.479.g7c686
