From: Elijah Newren <newren@gmail.com>
Subject: [RFC/PATCH 16/18] git-merge-one-file.sh: support --index-only option
Date: Thu,  7 Apr 2016 23:58:44 -0700
Message-ID: <1460098726-5958-17-git-send-email-newren@gmail.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 08:59:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoQO9-0002VL-BV
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 08:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbcDHG7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 02:59:20 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33407 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932644AbcDHG7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 02:59:16 -0400
Received: by mail-pf0-f193.google.com with SMTP id e190so8853751pfe.0
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 23:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R8FF0wldFycD/6QGHnI8AZM+jFOaj90DZZKkSzTyewQ=;
        b=LCQvHD4Qm7C6TGcu7vo2MB1czszQIHqwu+ut87AdVRLSLqyG1YV05uwcXUNgL5wXWZ
         GufAIehG3y9hLBpN9m1s7fem1J83Z8JAzwsMiwjpoOEWYKD1Nn9gvMs+Evqqs5QCTAnP
         IQ2aApJ8VEysDqiNLH1Wl5mbmIpIT779tAMTNSLcPhtQOgDKZ8n27jvgng4KWHKE6FdZ
         nS+F2X9eZVpT75eCsvZmX916+Jg4FQ5E+wPKRIhgfi1GqPK01D1QnsRYTtzPClKq55jH
         saROJuc6Fe7dYoRjWD5Ryp7d5wO9qAoVMK3OH07ZlxLF1Yv3YnBqWXSrnJXeRqfbEukA
         hioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R8FF0wldFycD/6QGHnI8AZM+jFOaj90DZZKkSzTyewQ=;
        b=mFaNLZ9oHlpEGFYHdi1QFxSy7AgAbf1FcVBgbO7+G3z8QLgUcTJy55stuiEJgUDCA2
         7OUanXgVusP8h+uql7XPEPvJCzb++yGlhQQ1+WFVcIC86heYE7dlLoDTg6tbcW274tR5
         U/Im2AKBOVFXSLwd5Jg3DZbduXmu9rqYbOyA1uWbXVZvirAv54W/M99wad4datRqFv+v
         OrtlegixCorrO0anxzR9v486K1pkET01O5lfglPEOIzOgsC6C6oz+OluQDLVcjnKUG36
         N/E5lb4+Ux0b5Z8XFiIT1VFNhCkITwYX4E67UGjU48GoFZLjqnteaFXeI/4ql5Btscik
         fZcA==
X-Gm-Message-State: AD7BkJKjB/WqPgFK6idUa+se6ZjMCxnA0i16yyOLg8f+R++PQzMPuwQu+8CeqlrZtfvxqA==
X-Received: by 10.98.73.221 with SMTP id r90mr10528237pfi.70.1460098755248;
        Thu, 07 Apr 2016 23:59:15 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id w62sm16371973pfa.79.2016.04.07.23.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Apr 2016 23:59:14 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.18.gc685494
In-Reply-To: <1460098726-5958-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291005>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 git-merge-one-file.sh | 44 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 424b034..78efa00 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -18,16 +18,25 @@
 
 USAGE='<orig blob> <our blob> <their blob> <path>'
 USAGE="$USAGE <orig mode> <our mode> <their mode>"
-LONG_USAGE="usage: git merge-one-file $USAGE
+LONG_USAGE="usage: git merge-one-file $USAGE [--index-only]
 
 Blob ids and modes should be empty for missing files."
 
+update_worktree=t
+expected_argcount=7
+if test "$8" = "--index-only"; then
+	update_worktree=
+	expected_argcount=8
+fi
+
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 cd_to_toplevel
-require_work_tree
+if test -n "$update_worktree"; then
+	require_work_tree
+fi
 
-if test $# != 7
+if test $# != $expected_argcount
 then
 	echo "$LONG_USAGE"
 	exit 1
@@ -59,8 +68,10 @@ case "${1:-.}${2:-.}${3:-.}" in
 	fi
 	if test -f "$4"
 	then
-		rm -f -- "$4" &&
-		rmdir -p "$(expr "z$4" : 'z\(.*\)/')" 2>/dev/null || :
+		if test -n "$update_worktree"; then
+			rm -f -- "$4" &&
+			rmdir -p "$(expr "z$4" : 'z\(.*\)/')" 2>/dev/null || :
+		fi
 	fi &&
 		exec git update-index --remove -- "$4"
 	;;
@@ -80,8 +91,11 @@ case "${1:-.}${2:-.}${3:-.}" in
 		echo "ERROR: untracked $4 is overwritten by the merge." >&2
 		exit 1
 	fi
-	git update-index --add --cacheinfo "$7" "$3" "$4" &&
+	git update-index --add --cacheinfo "$7" "$3" "$4"
+	if test -n "$update_worktree"; then
 		exec git checkout-index -u -f -- "$4"
+	fi
+	exit 0
 	;;
 
 #
@@ -95,8 +109,11 @@ case "${1:-.}${2:-.}${3:-.}" in
 		exit 1
 	fi
 	echo "Adding $4"
-	git update-index --add --cacheinfo "$6" "$2" "$4" &&
+	git update-index --add --cacheinfo "$6" "$2" "$4"
+	if test -n "$update_worktree"; then
 		exec git checkout-index -u -f -- "$4"
+	fi
+	exit 0
 	;;
 
 #
@@ -139,7 +156,11 @@ case "${1:-.}${2:-.}${3:-.}" in
 
 	# Create the working tree file, using "our tree" version from the
 	# index, and then store the result of the merge.
-	git checkout-index -f --stage=2 -- "$4" && cat "$src1" >"$4" || exit 1
+	if test -n "$update_worktree"; then
+		git checkout-index -f --stage=2 -- "$4" && cat "$src1" >"$4" || exit 1
+	else
+		sha1=$(git hash-object -w -- "$src1")
+	fi
 	rm -f -- "$orig" "$src1" "$src2"
 
 	if test "$6" != "$7"
@@ -157,7 +178,12 @@ case "${1:-.}${2:-.}${3:-.}" in
 		echo "ERROR: $msg in $4" >&2
 		exit 1
 	fi
-	exec git update-index -- "$4"
+	if test -n "$update_worktree"; then
+		exec git update-index -- "$4"
+	else
+		printf "$6 $sha1\t$4" | git update-index --index-info
+		exit $?
+	fi
 	;;
 
 *)
-- 
2.8.0.18.gc685494
