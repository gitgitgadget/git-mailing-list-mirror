From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 11/13] wt-status.c: split bisect detection out of wt_status_get_state()
Date: Fri, 22 Apr 2016 20:01:34 +0700
Message-ID: <1461330096-21783-12-git-send-email-pclouds@gmail.com>
References: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
 <1461330096-21783-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 15:02:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atajW-0007fy-Rb
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 15:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbcDVNCt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 09:02:49 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35089 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810AbcDVNCs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 09:02:48 -0400
Received: by mail-pf0-f196.google.com with SMTP id r187so10137508pfr.2
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 06:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zxDdH98hfGdfVkcWdjJR0qJxApL+ufB3W2WOAT4gGek=;
        b=Kv+Se7SK2KVVgEH4sVHg2PsIfmmVe2XoUynPGRPkZEICVhGUIrydbZVCpDx5ywPWr0
         qgtUfaRsW4Xvm8j0/KO7k5OhUJ19Q2DqmVSIccPyQ13wPyEno/fKg2DtZlvryxsvK6Jw
         OxJcSf8BxYhzh7kxOZooOX92iu6NfBJaiWrJ9ihTnKWFHvOSrug/cdUEYBohnM9axUUb
         iqgQsyLPWR3kvwB6n6fTVYJVMKeUtX2JG/LUf9XX/iv/UpI6q56g24HH3mtwRWLgyUlL
         oW6trLmORpM84jF1m7h4AUmt20b9Ixx7NUMqZno3WRRvE+WrLx35bcczX0MyUfXoyWQx
         38Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zxDdH98hfGdfVkcWdjJR0qJxApL+ufB3W2WOAT4gGek=;
        b=Iu8MHwT7NLxbmVMx96qM70G3mElhTspur6afL34UJHtoPmeemxECYNjpxk7UnwzGbH
         koPuJ9yT0UmYGbxusW6x+v58xYXcGcsZbPOdoxXBJ72tfKZJMyZC2yrMgrqRoN/+BPtv
         ip9K3gYEFhsx0B4/gyO4/n0jITGGmPA9q5mskVIMXwcG3E0bRrIpOh8GWnHT3Io+67ZA
         3905OblbuoH8Vh1T/SR10VUAnRGep7uQI1PYrs2T01fRdJCZndC1oPNfN17bAynLzCbH
         AEl1Et63QzOdVcV7CIckAQWhXXpDT+Syv11VROCTBYgukp2ovbwYjTBkkzZ9ityxFP9D
         pMYg==
X-Gm-Message-State: AOPr4FWt/IZYWGfwhZPUyVqXZlY+Ta+Av+bDP/vtyqVSbZpQu9/FIzlsgvO4AKqj7midiQ==
X-Received: by 10.98.92.71 with SMTP id q68mr28423235pfb.70.1461330167772;
        Fri, 22 Apr 2016 06:02:47 -0700 (PDT)
Received: from lanh ([171.232.186.157])
        by smtp.gmail.com with ESMTPSA id i7sm8453739pfc.47.2016.04.22.06.02.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2016 06:02:46 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 22 Apr 2016 20:03:01 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1461330096-21783-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292200>

And make it work with any given worktree, in preparation for (again)
find_shared_symref(). read_and_strip_branch() is deleted because it's
no longer used.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wt-status.c | 23 ++++++++++++++---------
 wt-status.h |  2 ++
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index ce5080c..0032ef5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1296,11 +1296,6 @@ got_nothing:
 	return NULL;
 }
=20
-static char *read_and_strip_branch(const char *path)
-{
-	return get_branch(NULL, path);
-}
-
 struct grab_1st_switch_cbdata {
 	struct strbuf buf;
 	unsigned char nsha1[20];
@@ -1393,6 +1388,19 @@ int wt_status_check_rebase(const struct worktree=
 *wt,
 	return 1;
 }
=20
+int wt_status_check_bisect(const struct worktree *wt,
+			   struct wt_status_state *state)
+{
+	struct stat st;
+
+	if (!stat(worktree_git_path(wt, "BISECT_LOG"), &st)) {
+		state->bisect_in_progress =3D 1;
+		state->branch =3D get_branch(wt, "BISECT_START");
+		return 1;
+	}
+	return 0;
+}
+
 void wt_status_get_state(struct wt_status_state *state,
 			 int get_detached_from)
 {
@@ -1408,10 +1416,7 @@ void wt_status_get_state(struct wt_status_state =
*state,
 		state->cherry_pick_in_progress =3D 1;
 		hashcpy(state->cherry_pick_head_sha1, sha1);
 	}
-	if (!stat(git_path("BISECT_LOG"), &st)) {
-		state->bisect_in_progress =3D 1;
-		state->branch =3D read_and_strip_branch("BISECT_START");
-	}
+	wt_status_check_bisect(NULL, state);
 	if (!stat(git_path_revert_head(), &st) &&
 	    !get_sha1("REVERT_HEAD", sha1)) {
 		state->revert_in_progress =3D 1;
diff --git a/wt-status.h b/wt-status.h
index c4ddcad..2ca93f6 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -104,6 +104,8 @@ void wt_status_collect(struct wt_status *s);
 void wt_status_get_state(struct wt_status_state *state, int get_detach=
ed_from);
 int wt_status_check_rebase(const struct worktree *wt,
 			   struct wt_status_state *state);
+int wt_status_check_bisect(const struct worktree *wt,
+			   struct wt_status_state *state);
=20
 void wt_shortstatus_print(struct wt_status *s);
 void wt_porcelain_print(struct wt_status *s);
--=20
2.8.0.rc0.210.gd302cd2
