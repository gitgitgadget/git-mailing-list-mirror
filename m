From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/2] git-request-pull: open-code the only invocation of get_remote_url
Date: Tue,  1 Mar 2011 10:21:37 +0100
Message-ID: <1298971297-20326-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110301084110.GT22310@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kernel@pengutronix.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 10:22:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuLmW-00041W-CH
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 10:22:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756020Ab1CAJWG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2011 04:22:06 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36579 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017Ab1CAJWF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 04:22:05 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1PuLm8-00071k-HD; Tue, 01 Mar 2011 10:21:48 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1PuLm7-0005tN-9X; Tue, 01 Mar 2011 10:21:47 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <20110301084110.GT22310@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168199>

So sh:get_remote_url can go now and git-request-pull
doesn't need to source git-parse-remote. anymore.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 git-parse-remote.sh |    4 ----
 git-request-pull.sh |    3 +--
 2 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 0ab1192..e7013f7 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -4,10 +4,6 @@
 # this would fail in that case and would issue an error message.
 GIT_DIR=3D$(git rev-parse -q --git-dir) || :;
=20
-get_remote_url () {
-	git ls-remote --get-url "$1"
-}
-
 get_default_remote () {
 	curr_branch=3D$(git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
 	origin=3D$(git config --get "branch.$curr_branch.remote")
diff --git a/git-request-pull.sh b/git-request-pull.sh
index 6fdea39..fc080cc 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -15,7 +15,6 @@ p    show patch text as well
 '
=20
 . git-sh-setup
-. git-parse-remote
=20
 GIT_PAGER=3D
 export GIT_PAGER
@@ -55,7 +54,7 @@ branch=3D$(git ls-remote "$url" \
 		p
 		q
 	}")
-url=3D$(get_remote_url "$url")
+url=3D$(git ls-remote --get-url "$url")
 if [ -z "$branch" ]; then
 	echo "warn: No branch of $url is at:" >&2
 	git log --max-count=3D1 --pretty=3D'tformat:warn:   %h: %s' $headrev =
>&2
--=20
1.7.2.3
