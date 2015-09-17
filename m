From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 09/10] git submodule update: cmd_update_recursive
Date: Wed, 16 Sep 2015 18:39:07 -0700
Message-ID: <1442453948-9885-10-git-send-email-sbeller@google.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 03:39:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcOAa-00065I-5p
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 03:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbbIQBj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 21:39:26 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36805 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138AbbIQBjY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 21:39:24 -0400
Received: by padhk3 with SMTP id hk3so4582878pad.3
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 18:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X1o1vswz4CI3HFvYFa8cNn4CPPIEjEqVdQlBpZYiAbc=;
        b=VC7xvGwLpsGO2jfRysdOlaCg6e2g4hPReLrlFOh46edH2ELMxiNabkIGB1bTz7+EGI
         yvh5gwCbCda3PgDedvFNpbWBD3v/JLPVPepy7Ub3E61WjACgsQcJZWHCV2H1vsKISnV5
         m4hNfu+j3hGzjVL9NgimmJeAKZci31dfFkBBBzppwrn6bGzL3zoFRiPtCN97fKSCo2M5
         h3WZ97yD1RlBNWTESmNdVPPHUNdDAxr74Dhpdvdv2IW3cNo4hfHc0/IJhuRTGf3fBM22
         3wegGeRM7E7uHIXRBn7E2mh65m31AYSziNEYbET/sGRvdi9F6Y5Pm+tGkZzF9M6pKMQk
         o0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X1o1vswz4CI3HFvYFa8cNn4CPPIEjEqVdQlBpZYiAbc=;
        b=dlGKgDObJupdcW5gatW9d0C9xxSsYn53cRIdEjIwtdn8FpDuZSfKObONblegWk7tKZ
         UaBpXK972QCnuF4FgtLH6386tMLW93CMsUZBiCV252GTTBCjgzV5tGxVb5tZIHLQUzYp
         8xROojqQZeGbwRybzB7xhQ8Vb8XwfxKkHw1aLQPw1hSMV0zfoKx9bnD5fGUicP8431K+
         5nktw8XHSeG241nRsTzmXmVETIETpamslZ9ilhKfUAz4dEoyeQ92n+F9JQ1virygbV9p
         s5sf8th3DplUGRQu/d/FHj+pluKWEVvEsPWiQGTpPZtyL24JYT9+/7lgqICvp3K2hgTd
         M7mw==
X-Gm-Message-State: ALoCoQmzuGidqmkLnaAAm2VqWFFEHSWa7LJ9kc+PzqeMYPPpkF4nYjOarqhS2XP25MYvtjJZMLL4
X-Received: by 10.68.98.5 with SMTP id ee5mr66096757pbb.95.1442453963800;
        Wed, 16 Sep 2015 18:39:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:bde9:6711:470f:789])
        by smtp.gmail.com with ESMTPSA id pe5sm571280pac.17.2015.09.16.18.39.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 18:39:23 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc0.131.gf624c3d
In-Reply-To: <1442453948-9885-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278094>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 52c2967..c40d60f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -607,6 +607,24 @@ cmd_update_recursive()
 	fi
 }
 
+cmd_update_clone()
+{
+	command="git checkout $subforce -q"
+	die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
+	say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
+
+	git submodule--helper clone ${GIT_QUIET:+--quiet} ${prefix:+--prefix "$prefix"} --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
+
+	if (clear_local_git_env; cd "$sm_path" && $command "$sha1")
+	then
+		say "$say_msg"
+	else
+		err="${err};$die_msg"
+		return
+	fi
+	cmd_update_recursive
+}
+
 #
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
@@ -680,7 +698,6 @@ cmd_update()
 		cmd_init "--" "$@" || return
 	fi
 
-	cloned_modules=
 	git submodule--helper list --prefix "$wt_prefix" "$@" | {
 	err=
 	while read mode sha1 stage sm_path
@@ -725,9 +742,8 @@ Maybe you want to use 'update --init'?")"
 
 		if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
 		then
-			git submodule--helper clone ${GIT_QUIET:+--quiet} ${prefix:+--prefix "$prefix"} --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
-			cloned_modules="$cloned_modules;$name"
-			subsha1=
+			cmd_update_clone
+			continue
 		else
 			subsha1=$(clear_local_git_env; cd "$sm_path" &&
 				git rev-parse --verify HEAD) ||
@@ -767,13 +783,6 @@ Maybe you want to use 'update --init'?")"
 				die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
 			fi
 
-			# Is this something we just cloned?
-			case ";$cloned_modules;" in
-			*";$name;"*)
-				# then there is no local change to integrate
-				update_module=checkout ;;
-			esac
-
 			must_die_on_failure=
 			case "$update_module" in
 			checkout)
-- 
2.6.0.rc0.131.gf624c3d
