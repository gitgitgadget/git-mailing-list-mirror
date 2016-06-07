From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v4 36/38] i18n: submodule: escape shell variables inside eval_gettext
Date: Tue,  7 Jun 2016 12:55:39 +0000
Message-ID: <1465304141-9392-7-git-send-email-vascomalmeida@sapo.pt>
References: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 14:56:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAGYK-0007Aa-4A
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 14:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754904AbcFGM4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 08:56:10 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:52206 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754852AbcFGM4J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 08:56:09 -0400
Received: (qmail 19338 invoked from network); 7 Jun 2016 12:56:06 -0000
Received: (qmail 16045 invoked from network); 7 Jun 2016 12:56:06 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 7 Jun 2016 12:56:01 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296672>

According to the gettext manual [1], references to shell variables inside
eval_gettext call must be escaped so that eval_gettext receives the
translatable string before the variable values are substituted into it.

[1] http://www.gnu.org/software/gettext/manual/html_node/Preparing-Shell-Scripts.html

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-submodule.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index f72b237..1ff2f3a 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -618,7 +618,7 @@ cmd_update()
 			remote_name=$(sanitize_submodule_env; cd "$sm_path" && get_default_remote)
 			sha1=$(sanitize_submodule_env; cd "$sm_path" &&
 				git rev-parse --verify "${remote_name}/${branch}") ||
-			die "$(eval_gettext "Unable to find current ${remote_name}/${branch} revision in submodule path '\$sm_path'")"
+			die "$(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
 		fi
 
 		if test "$subsha1" != "$sha1" || test -n "$force"
@@ -642,7 +642,7 @@ cmd_update()
 				# not be reachable from any of the refs
 				is_tip_reachable "$sm_path" "$sha1" ||
 				fetch_in_submodule "$sm_path" "$sha1" ||
-				die "$(eval_gettext "Fetched in submodule path '\$displaypath', but it did not contain $sha1. Direct fetching of that commit failed.")"
+				die "$(eval_gettext "Fetched in submodule path '\$displaypath', but it did not contain \$sha1. Direct fetching of that commit failed.")"
 			fi
 
 			must_die_on_failure=
-- 
2.7.3
