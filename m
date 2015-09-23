From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 13/14] git submodule update: cmd_update_fetch
Date: Tue, 22 Sep 2015 18:45:31 -0700
Message-ID: <1442972732-12118-14-git-send-email-sbeller@google.com>
References: <1442972732-12118-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 03:46:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeZ8M-0007Dx-Qh
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 03:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934146AbbIWBqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 21:46:04 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35823 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759957AbbIWBpw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 21:45:52 -0400
Received: by pacfv12 with SMTP id fv12so25542523pac.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 18:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=64Pz6zLA8Zw45ViH121OGJi/ykzBd29HEPoy0GWzLT4=;
        b=ZOQ3dIhMx7oU5TiS76aejxk2heHBRfC4FlzZGVGiJGCNhyKI5MD93QBJahw9rXk+Or
         BUlhsySowLMvu5ni9567VyBESADxVSrT6voc80GMZZhncYm/FAclxCj/CAPgiLq5JQog
         ou3fyamY8VDETIvIt+tB6YvdIl3B+Gbe+CU1ewQW9DRalN02vaCv0ToZvs1HK3Lkm2Ra
         enulbgdIGp1jjo5QoyBmHHZXXNKyOUlV2UwpsKy4SMHGHkvTQvKE/Fz3+5Ccb2XBJ1g/
         FtCnxMQZFAEEVxoMmQQqnohMNBq1xdFEpsF60oYyPvLqjq12+62NKTlAW57QqyySv+Jy
         3ZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=64Pz6zLA8Zw45ViH121OGJi/ykzBd29HEPoy0GWzLT4=;
        b=gjmeW1g3dzDJ3mG6mA0d2aWvahx1lrwiSy2vH0KdNTachLay8ifnio8+G36baSLxDq
         BxN4lO52dQZLjT/6n+tytAcryzIm/v5+WT6lFDRzELWlksAyjdABDIs8fcM1D5KhmC2c
         JeSPWNNtnMEUpqDu8HVs0AF7IvQDvXP5JCAMh/IZNSWbRrm6FoBmm3ilP7HQXtXPwc3b
         /N05N6NAwQWtktWzCrJ1m1yhLrLqzo0l1Fip79W/wU6rOIhWDqr2dE8d+9E3+0C3m8lE
         AKIYyxpSBSL37mkcvpd9msmToP2uokwhzMeG2Jm6XeVqeFAMFNNeI86mjn2StQQenxZ9
         KzAw==
X-Gm-Message-State: ALoCoQnVozn0gpRqmBJvbqEmmelqZmpLrbN9euPSDyz5vxJZ0EBV0KVsd7V4zbyKZWNVRfN1hUzW
X-Received: by 10.66.253.229 with SMTP id ad5mr34629240pad.101.1442972752450;
        Tue, 22 Sep 2015 18:45:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c149:8175:4df1:ed3a])
        by smtp.gmail.com with ESMTPSA id hx2sm4576927pbc.67.2015.09.22.18.45.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 22 Sep 2015 18:45:51 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.272.ga84127c.dirty
In-Reply-To: <1442972732-12118-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278464>

Split the fetching part out to its own function,
this allow us in a later patch to convert cmd_update in C.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 164 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 84 insertions(+), 80 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 7f11158..a1bc8d5 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -625,6 +625,89 @@ cmd_update_clone()
 	cmd_update_recursive
 }
 
+cmd_update_fetch()
+{
+	subsha1=$(clear_local_git_env; cd "$sm_path" &&
+		git rev-parse --verify HEAD) ||
+	die "$(eval_gettext "Unable to find current revision in submodule path '\$displaypath'")"
+
+	if test -n "$remote"
+	then
+		if test -z "$nofetch"
+		then
+			# Fetch remote before determining tracking $sha1
+			(clear_local_git_env; cd "$sm_path" && git-fetch) ||
+			die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
+		fi
+		remote_name=$(clear_local_git_env; cd "$sm_path" && get_default_remote)
+		sha1=$(clear_local_git_env; cd "$sm_path" &&
+			git rev-parse --verify "${remote_name}/${branch}") ||
+		die "$(eval_gettext "Unable to find current ${remote_name}/${branch} revision in submodule path '\$sm_path'")"
+	fi
+
+	if test "$subsha1" != "$sha1" || test -n "$force"
+	then
+		subforce=$force
+		# If we don't already have a -f flag and the submodule has never been checked out
+		if test -z "$subsha1" && test -z "$force"
+		then
+			subforce="-f"
+		fi
+
+		if test -z "$nofetch"
+		then
+			# Run fetch only if $sha1 isn't present or it
+			# is not reachable from a ref.
+			(clear_local_git_env; cd "$sm_path" &&
+				( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
+				 test -z "$rev") || git-fetch)) ||
+			die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
+		fi
+
+		must_die_on_failure=
+		case "$update_module" in
+		checkout)
+			command="git checkout $subforce -q"
+			die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
+			say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
+			;;
+		rebase)
+			command="git rebase"
+			die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$displaypath'")"
+			say_msg="$(eval_gettext "Submodule path '\$displaypath': rebased into '\$sha1'")"
+			must_die_on_failure=yes
+			;;
+		merge)
+			command="git merge"
+			die_msg="$(eval_gettext "Unable to merge '\$sha1' in submodule path '\$displaypath'")"
+			say_msg="$(eval_gettext "Submodule path '\$displaypath': merged in '\$sha1'")"
+			must_die_on_failure=yes
+			;;
+		!*)
+			command="${update_module#!}"
+			die_msg="$(eval_gettext "Execution of '\$command \$sha1' failed in submodule  path '\$prefix\$sm_path'")"
+			say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': '\$command \$sha1'")"
+			must_die_on_failure=yes
+			;;
+		*)
+			die "$(eval_gettext "Invalid update mode '$update_module' for submodule '$name'")"
+		esac
+
+		if (clear_local_git_env; cd "$sm_path" && $command "$sha1")
+		then
+			say "$say_msg"
+		elif test -n "$must_die_on_failure"
+		then
+			die_with_status 2 "$die_msg"
+		else
+			err="${err};$die_msg"
+			return
+		fi
+	fi
+
+	cmd_update_recursive
+}
+
 #
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
@@ -743,88 +826,9 @@ Maybe you want to use 'update --init'?")"
 		if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
 		then
 			cmd_update_clone
-			continue
 		else
-			subsha1=$(clear_local_git_env; cd "$sm_path" &&
-				git rev-parse --verify HEAD) ||
-			die "$(eval_gettext "Unable to find current revision in submodule path '\$displaypath'")"
+			cmd_update_fetch
 		fi
-
-		if test -n "$remote"
-		then
-			if test -z "$nofetch"
-			then
-				# Fetch remote before determining tracking $sha1
-				(clear_local_git_env; cd "$sm_path" && git-fetch) ||
-				die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
-			fi
-			remote_name=$(clear_local_git_env; cd "$sm_path" && get_default_remote)
-			sha1=$(clear_local_git_env; cd "$sm_path" &&
-				git rev-parse --verify "${remote_name}/${branch}") ||
-			die "$(eval_gettext "Unable to find current ${remote_name}/${branch} revision in submodule path '\$sm_path'")"
-		fi
-
-		if test "$subsha1" != "$sha1" || test -n "$force"
-		then
-			subforce=$force
-			# If we don't already have a -f flag and the submodule has never been checked out
-			if test -z "$subsha1" && test -z "$force"
-			then
-				subforce="-f"
-			fi
-
-			if test -z "$nofetch"
-			then
-				# Run fetch only if $sha1 isn't present or it
-				# is not reachable from a ref.
-				(clear_local_git_env; cd "$sm_path" &&
-					( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
-					 test -z "$rev") || git-fetch)) ||
-				die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
-			fi
-
-			must_die_on_failure=
-			case "$update_module" in
-			checkout)
-				command="git checkout $subforce -q"
-				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
-				say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
-				;;
-			rebase)
-				command="git rebase"
-				die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$displaypath'")"
-				say_msg="$(eval_gettext "Submodule path '\$displaypath': rebased into '\$sha1'")"
-				must_die_on_failure=yes
-				;;
-			merge)
-				command="git merge"
-				die_msg="$(eval_gettext "Unable to merge '\$sha1' in submodule path '\$displaypath'")"
-				say_msg="$(eval_gettext "Submodule path '\$displaypath': merged in '\$sha1'")"
-				must_die_on_failure=yes
-				;;
-			!*)
-				command="${update_module#!}"
-				die_msg="$(eval_gettext "Execution of '\$command \$sha1' failed in submodule  path '\$prefix\$sm_path'")"
-				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': '\$command \$sha1'")"
-				must_die_on_failure=yes
-				;;
-			*)
-				die "$(eval_gettext "Invalid update mode '$update_module' for submodule '$name'")"
-			esac
-
-			if (clear_local_git_env; cd "$sm_path" && $command "$sha1")
-			then
-				say "$say_msg"
-			elif test -n "$must_die_on_failure"
-			then
-				die_with_status 2 "$die_msg"
-			else
-				err="${err};$die_msg"
-				continue
-			fi
-		fi
-
-		cmd_update_recursive
 	done
 
 	if test -n "$err"
-- 
2.5.0.272.ga84127c.dirty
