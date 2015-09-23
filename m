From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 12/14] git submodule update: cmd_update_clone
Date: Tue, 22 Sep 2015 18:45:30 -0700
Message-ID: <1442972732-12118-13-git-send-email-sbeller@google.com>
References: <1442972732-12118-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 03:46:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeZ8K-0007Dx-8I
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 03:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760004AbbIWBpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 21:45:55 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33947 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933667AbbIWBpv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 21:45:51 -0400
Received: by padhy16 with SMTP id hy16so25286925pad.1
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 18:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AoafvxRS1ezjn7ameu3d6mbdpayIgTLbG4zwv5nvxiY=;
        b=aPqIYfJjYo6Ettm1p+kJee523E7T/1PMu433QgG8tUvw6zOjVSgWl3lgKeEyEnvr5v
         68rNJxpQ83dk+h0Ke0gvoj+lJqcMkg0e3SwxYkreYepQ6uZ0xsffJMIkntSCyGRzz5te
         FeNGKWYSmpB/FQYNlYB4dSNKXKXGAGcgkogevBgeHwHYiH8Rde3ydrIoR83S0mnejQJr
         VL8fplXtCFJgRWzRFjuWD9176cE8GwKTcmqoZAIKXRDj6LtNxYPShP+Amv9Skm7YlG3l
         rcxiEkNiY1p4Uq9c/t9slEa2UwvA7uvS27DAg3CX6sgMuKohfQam1cIifkedCL5yvv7E
         zjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AoafvxRS1ezjn7ameu3d6mbdpayIgTLbG4zwv5nvxiY=;
        b=bpgqi0sgTPBTtQeKhwpV+/VPk4Ws00gT9k9I7l1hXWtiJBL58CoIre/X2B2l6NgQjG
         1U8N1RA6VRPwaJZxl9IzzphwhbZK06m+h9nylUhWV/lgcMheBRzJ0JOQX0wnPj5GVKSg
         cIz+H3U7ZfRKlFL55/3jiTLJmpsDL5qFoMpzPGXNEQLZFQKg+kLr10nNQ903JliV76xU
         EcImuEss5aRh1BIkPbOWimqa98fJUPyscUpoqFlTqazdQs8B2HO+wrZWkieAS41C3z2R
         0ZPUjFP8b9bBXSv0wzqSrXuc4bpfy0OrMVZL7pYVbbmsh7K4usoJJIYkGE5TdYsWwwJS
         98eg==
X-Gm-Message-State: ALoCoQm26Wuq94+U7dU+E3M22O/YCltz4z4UMdygGtT+unkSHTLG17RBy79f87gQmrJbMr4pHkrY
X-Received: by 10.68.113.37 with SMTP id iv5mr34005642pbb.2.1442972751279;
        Tue, 22 Sep 2015 18:45:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c149:8175:4df1:ed3a])
        by smtp.gmail.com with ESMTPSA id ch3sm4642904pbb.18.2015.09.22.18.45.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 22 Sep 2015 18:45:50 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.272.ga84127c.dirty
In-Reply-To: <1442972732-12118-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278460>

Split the cloning part out to its own function,
this allow us in a later patch to convert cmd_update in C.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ea3260e..7f11158 100755
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
-			git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$prefix" --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
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
2.5.0.272.ga84127c.dirty
