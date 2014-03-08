From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 14/28] git-stash: avoid hardcoding $GIT_DIR/logs/....
Date: Sat,  8 Mar 2014 09:48:06 +0700
Message-ID: <1394246900-31535-15-git-send-email-pclouds@gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
 <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 03:49:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM7KI-0005RT-3w
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 03:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450AbaCHCtV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 21:49:21 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:56508 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbaCHCtU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 21:49:20 -0500
Received: by mail-pd0-f174.google.com with SMTP id y13so4757690pdi.5
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 18:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WXp5MECOhmHgXTrPU/KKoWMms94cliWul0CbIqUvSxM=;
        b=DK4MKsSXB+E6Z/hosTkZ1YKtYFI6v+e6dHrGA6bwPzDzQZxUrh5BGhJzf3RGIJCYBo
         vg5Mw5ob1DPT2oAEgusyKtcKUEqe39b92gqX7rc8hL0cAlIUh9FIBdDnku4pESbekb1x
         hrDhUD74LPNTZ/vmR5rm9QC9/oYonXCjUe0Cj068iAAbF1YiMAEqZkH3j43IIDZKGrUp
         7A5WrM5bNvjcaK2MPwQWwzcj5b4k5GjvgAM9sqni7mOvfjnnLeKtfzh0/ZJpPc7dgezs
         h36OeAu5fBSXnkilcJwaXeW9+gT8pGMWjsP5zerK8gWw5E4Mbjn5SXRO48vJycwcMARG
         l/2Q==
X-Received: by 10.66.151.205 with SMTP id us13mr25705954pab.93.1394246960341;
        Fri, 07 Mar 2014 18:49:20 -0800 (PST)
Received: from lanh ([115.73.205.153])
        by mx.google.com with ESMTPSA id cz3sm41713593pbc.9.2014.03.07.18.49.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Mar 2014 18:49:19 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Mar 2014 09:49:53 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243655>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-stash.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 0de9a6c..8093326 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -183,7 +183,7 @@ store_stash () {
 	fi
=20
 	# Make sure the reflog for stash is kept.
-	: >>"$GIT_DIR/logs/$ref_stash"
+	: >>"$(git rev-parse --git-path logs/$ref_stash)"
 	git update-ref -m "$stash_msg" $ref_stash $w_commit
 	ret=3D$?
 	test $ret !=3D 0 && test -z $quiet &&
@@ -258,7 +258,7 @@ save_stash () {
 		say "$(gettext "No local changes to save")"
 		exit 0
 	fi
-	test -f "$GIT_DIR/logs/$ref_stash" ||
+	test -f "$(git rev-parse --git-path logs/$ref_stash)" ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
=20
 	create_stash "$stash_msg" $untracked
--=20
1.9.0.40.gaa8c3ea
