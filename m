Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3636420179
	for <e@80x24.org>; Fri, 17 Jun 2016 21:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbcFQVym (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 17:54:42 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:47140 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755653AbcFQVyk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 17:54:40 -0400
Received: (qmail 2706 invoked from network); 17 Jun 2016 21:54:38 -0000
Received: (qmail 30609 invoked from network); 17 Jun 2016 21:54:38 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 21:54:37 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 36/38] i18n: submodule: escape shell variables inside eval_gettext
Date:	Fri, 17 Jun 2016 21:54:13 +0000
Message-Id: <1466200455-16951-7-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
2.6.6

