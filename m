From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 11/13] git submodule update: cmd_update_clone
Date: Mon, 21 Sep 2015 15:39:17 -0700
Message-ID: <1442875159-13027-12-git-send-email-sbeller@google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 00:39:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze9kT-0006e0-OC
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 00:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbbIUWjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 18:39:41 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33126 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933018AbbIUWji (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 18:39:38 -0400
Received: by pacex6 with SMTP id ex6so128687134pac.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 15:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sERetUaUKGuqQ/ZiFHcZKG8SIBoJH/dGiYws5C3kDTQ=;
        b=e2JHUcqkBNpZ2id1b0pN8rAFKzqawZiFlD1F1gqOWkRkwBXfhf/9Ca4x4eoH0GX3gy
         WdRe9Jljk5gu2GTe5xiGBzBKJyIui+Uflfsq8/qqKCCvOpecFTSxXWaGua6ZXQeOxXKP
         6sRRVfRuxIe85qvDPN1L1JJx7fDnA1jtH11dnbc9Dy2xCjm3fq43L3D/iob4n3mvJZ66
         tsZZEqIic5baYtoir2ipYCIYBxlNT/E3q2O7GSg4Fp3CvpWeaus/6Tb4MZLcdXJfHHfL
         M/Dk1xHYMh/OhhwQUCGKpnFyLgeQwmiNMd95jMqeDg24XZZq5/iNp1VWnByssYzxZQai
         wzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sERetUaUKGuqQ/ZiFHcZKG8SIBoJH/dGiYws5C3kDTQ=;
        b=CeFRenL0+yuJS+FBCAsbOnzsUaltF9Y1Xgb9C80LtUN5brHgi7TMCD+C8N6puMjvZH
         s/R98KqV8b3YB+gO9cI182ZV4n4m4CN80MaegEBoqZjaZXnxqnkVGDzOj/+ARJE7F4gt
         zLP/eSW/f9k7GDbPETOJCxzW0ViIaYOEx1I9RViAleIRusgVHlk3F3c1rdiahyOceUZ+
         G46ICexDrWWbW+YJj0OprRCrVFSXr18+dwTtAxLD3EDCpcRdjRVuyQJt3uunUJqTGscT
         vLVuzGtkr7aJD2TIIsw6Ichu45frRIPKqY0oQjRyiJk7JVAvNkJ2JSmDe/NdKy/kOH0R
         Bt0g==
X-Gm-Message-State: ALoCoQnAm8ZO5bNx0ojZUgagTPNzBSmrK+Ecqt47fsuEVkCgPFvC0ixvhYN26ZTiO3aWWiLRqzo9
X-Received: by 10.68.181.34 with SMTP id dt2mr27183505pbc.7.1442875178119;
        Mon, 21 Sep 2015 15:39:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:a032:5a54:ea65:75ca])
        by smtp.gmail.com with ESMTPSA id gw3sm26490159pbc.46.2015.09.21.15.39.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 21 Sep 2015 15:39:37 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.ge015d2a
In-Reply-To: <1442875159-13027-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278344>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 71385cb..7f11158 100755
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
2.5.0.275.ge015d2a
