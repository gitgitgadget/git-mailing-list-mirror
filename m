From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 13/27] git-stash: avoid hardcoding $GIT_DIR/logs/....
Date: Sat,  1 Mar 2014 19:12:49 +0700
Message-ID: <1393675983-3232-14-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 13:22:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJivn-0002BG-T9
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 13:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbaCAMWL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 07:22:11 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:63269 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbaCAMWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 07:22:09 -0500
Received: by mail-pb0-f42.google.com with SMTP id rr13so1913184pbb.29
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 04:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YAjx5/kRpMsG5F20H/B+/FskP9vD5k4EuCWDiUDUWe8=;
        b=EGfdcO/lEmwoQ6459NC3ckr/oN8j2q1AT/8jeB41yPhLT3tl964cRTFf59f/WC88lm
         GkS4JtTs2nNNyoFuGy6cb0LlSHF5n//70n2bcLNDYAwjzteWkg1z2BT+R0jQ+wj2Q8ET
         V2M9VN2s88lzGwvZHF164dNRMKdxRO7N0ZxZpI6nxFzsofN2Pg+XvgH6r+KN4OHbvjgy
         w/rabpyHrO1ZSpY8cL3Xw5qgUoJA9li7DS2OY7t4Sgywm2MlDtn41gNnJbaqrrdouJXg
         RdsyfNvEHEZdpEr/r/Z4otJvGLnV+agVQScb1z9DpVYz4M4M0v+PKYvZm0M7QdC+SXZD
         ah1g==
X-Received: by 10.68.133.193 with SMTP id pe1mr9362377pbb.56.1393676529338;
        Sat, 01 Mar 2014 04:22:09 -0800 (PST)
Received: from lanh ([115.73.238.45])
        by mx.google.com with ESMTPSA id dc4sm15881218pbc.34.2014.03.01.04.22.06
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 04:22:08 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 01 Mar 2014 19:22:34 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243078>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-stash.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index ae7d16e..12d9b37 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -183,7 +183,7 @@ store_stash () {
 	fi
=20
 	# Make sure the reflog for stash is kept.
-	: >>"$GIT_DIR/logs/$ref_stash"
+	: >>"`git rev-parse --git-path logs/$ref_stash`"
 	git update-ref -m "$stash_msg" $ref_stash $w_commit
 	ret=3D$?
 	test $ret !=3D 0 && test -z $quiet &&
@@ -258,7 +258,7 @@ save_stash () {
 		say "$(gettext "No local changes to save")"
 		exit 0
 	fi
-	test -f "$GIT_DIR/logs/$ref_stash" ||
+	test -f "`git rev-parse --git-path logs/$ref_stash`" ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
=20
 	create_stash "$stash_msg" $untracked
--=20
1.9.0.40.gaa8c3ea
