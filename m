From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 02/94] builtin/apply: avoid parameter shadowing 'p_value' global
Date: Wed, 11 May 2016 15:16:13 +0200
Message-ID: <20160511131745.2914-3-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:18:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U2F-0001gv-IG
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbcEKNSd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2016 09:18:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34099 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbcEKNSb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:18:31 -0400
Received: by mail-wm0-f67.google.com with SMTP id n129so9408385wmn.1
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zagG96mznk+c8riLADES9NlFVpDck3Ezu5wqs0/lMHY=;
        b=SGLeVy04QZl+AQBAigL9/2QS4oM+N22aMjn0eJBRCY02CMHslXhp/BwvPA4kzmRSmz
         LLo40L9wLNhOq33lEfV/HX0eg1pdrC+5yiLlLsf+Pb1vTXE9jlZPkyrcxUfME/jZ/2aR
         5y4wQazYn/EKdnSBMe2IhyvKYX7VA/hGGwA7FYDkdBULejqhAhLKJvbgul1IUnQ7ke4o
         0fktpBWo2wdvPTbj93qCrWRcrVyH/pdYRBBW1b+8vjuSGH9kaEGj4gVz5cMEGYj2WemZ
         2JRJ/Eeeg89HLeq4naumYPuGPrCeFbojJ3/rrJp76jh1L3j7m0UQ2U7FseqNOSEa3di6
         OmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zagG96mznk+c8riLADES9NlFVpDck3Ezu5wqs0/lMHY=;
        b=msoxp39cVOppCJQW85nslCCudkPGC4k1AGU+2VfimHFdSx+YNcrtFe+WH+USSOs+q4
         ppvzq80DI5HIpairrs88YREL9OQ9Pu84oBEyWcrdPmVHGc/9HLaoFKbXh4LwyWlm5Xt9
         KbQ6XOLEj4Wi94Ocv1fAobJs/dZR5H7h7Fu/lARTiulFqzADvpcN3Jl1oELVBnaOV6Tu
         mxbXs0t/AhoiSeDiPxnQ5jb3t5/WqpP5olnEV8izQ8IfbkiYx5Htmr0mocS07uDs7uVs
         ffk533OJYZC0P8+iuHefaITa8teFmZN2IJW4AhQZMjSvjXVFuFYcpSaFHbo7jZAuCYq8
         ZBaw==
X-Gm-Message-State: AOPr4FVqXgdWBMrAp2BG57kNeXkWh12LeXksJhGNHVMvWwzZraR/5NhmM4mGSYLzCqp3Vg==
X-Received: by 10.28.16.17 with SMTP id 17mr36376wmq.17.1462972709907;
        Wed, 11 May 2016 06:18:29 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:18:28 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294250>

Let's just rename the global 'state_p_value' as it will become
'state->p_value' in a following patch.

This also avoid errors when compiling with -Wshadow and makes
it safer to later move global variables into a "state" struct.

Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index fe5aebd..e133b38 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -35,7 +35,7 @@ static int prefix_length =3D -1;
 static int newfd =3D -1;
=20
 static int unidiff_zero;
-static int p_value =3D 1;
+static int state_p_value =3D 1;
 static int p_value_known;
 static int check_index;
 static int update_index;
@@ -872,24 +872,24 @@ static void parse_traditional_patch(const char *f=
irst, const char *second, struc
 		q =3D guess_p_value(second);
 		if (p < 0) p =3D q;
 		if (0 <=3D p && p =3D=3D q) {
-			p_value =3D p;
+			state_p_value =3D p;
 			p_value_known =3D 1;
 		}
 	}
 	if (is_dev_null(first)) {
 		patch->is_new =3D 1;
 		patch->is_delete =3D 0;
-		name =3D find_name_traditional(second, NULL, p_value);
+		name =3D find_name_traditional(second, NULL, state_p_value);
 		patch->new_name =3D name;
 	} else if (is_dev_null(second)) {
 		patch->is_new =3D 0;
 		patch->is_delete =3D 1;
-		name =3D find_name_traditional(first, NULL, p_value);
+		name =3D find_name_traditional(first, NULL, state_p_value);
 		patch->old_name =3D name;
 	} else {
 		char *first_name;
-		first_name =3D find_name_traditional(first, NULL, p_value);
-		name =3D find_name_traditional(second, first_name, p_value);
+		first_name =3D find_name_traditional(first, NULL, state_p_value);
+		name =3D find_name_traditional(second, first_name, state_p_value);
 		free(first_name);
 		if (has_epoch_timestamp(first)) {
 			patch->is_new =3D 1;
@@ -928,7 +928,7 @@ static int gitdiff_hdrend(const char *line, struct =
patch *patch)
 static void gitdiff_verify_name(const char *line, int isnull, char **n=
ame, int side)
 {
 	if (!*name && !isnull) {
-		*name =3D find_name(line, NULL, p_value, TERM_TAB);
+		*name =3D find_name(line, NULL, state_p_value, TERM_TAB);
 		return;
 	}
=20
@@ -938,7 +938,7 @@ static void gitdiff_verify_name(const char *line, i=
nt isnull, char **name, int s
 		if (isnull)
 			die(_("git apply: bad git-diff - expected /dev/null, got %s on line=
 %d"),
 			    *name, linenr);
-		another =3D find_name(line, NULL, p_value, TERM_TAB);
+		another =3D find_name(line, NULL, state_p_value, TERM_TAB);
 		if (!another || memcmp(another, *name, len + 1))
 			die((side =3D=3D DIFF_NEW_NAME) ?
 			    _("git apply: bad git-diff - inconsistent new filename on line =
%d") :
@@ -997,7 +997,7 @@ static int gitdiff_copysrc(const char *line, struct=
 patch *patch)
 {
 	patch->is_copy =3D 1;
 	free(patch->old_name);
-	patch->old_name =3D find_name(line, NULL, p_value ? p_value - 1 : 0, =
0);
+	patch->old_name =3D find_name(line, NULL, state_p_value ? state_p_val=
ue - 1 : 0, 0);
 	return 0;
 }
=20
@@ -1005,7 +1005,7 @@ static int gitdiff_copydst(const char *line, stru=
ct patch *patch)
 {
 	patch->is_copy =3D 1;
 	free(patch->new_name);
-	patch->new_name =3D find_name(line, NULL, p_value ? p_value - 1 : 0, =
0);
+	patch->new_name =3D find_name(line, NULL, state_p_value ? state_p_val=
ue - 1 : 0, 0);
 	return 0;
 }
=20
@@ -1013,7 +1013,7 @@ static int gitdiff_renamesrc(const char *line, st=
ruct patch *patch)
 {
 	patch->is_rename =3D 1;
 	free(patch->old_name);
-	patch->old_name =3D find_name(line, NULL, p_value ? p_value - 1 : 0, =
0);
+	patch->old_name =3D find_name(line, NULL, state_p_value ? state_p_val=
ue - 1 : 0, 0);
 	return 0;
 }
=20
@@ -1021,7 +1021,7 @@ static int gitdiff_renamedst(const char *line, st=
ruct patch *patch)
 {
 	patch->is_rename =3D 1;
 	free(patch->new_name);
-	patch->new_name =3D find_name(line, NULL, p_value ? p_value - 1 : 0, =
0);
+	patch->new_name =3D find_name(line, NULL, state_p_value ? state_p_val=
ue - 1 : 0, 0);
 	return 0;
 }
=20
@@ -1092,10 +1092,10 @@ static const char *skip_tree_prefix(const char =
*line, int llen)
 	int nslash;
 	int i;
=20
-	if (!p_value)
+	if (!state_p_value)
 		return (llen && line[0] =3D=3D '/') ? NULL : line;
=20
-	nslash =3D p_value;
+	nslash =3D state_p_value;
 	for (i =3D 0; i < llen; i++) {
 		int ch =3D line[i];
 		if (ch =3D=3D '/' && --nslash <=3D 0)
@@ -1481,8 +1481,8 @@ static int find_header(const char *line, unsigned=
 long size, int *hdrsize, struc
 					       "%d leading pathname component (line %d)",
 					       "git diff header lacks filename information when removing =
"
 					       "%d leading pathname components (line %d)",
-					       p_value),
-					    p_value, linenr);
+					       state_p_value),
+					    state_p_value, linenr);
 				patch->old_name =3D xstrdup(patch->def_name);
 				patch->new_name =3D xstrdup(patch->def_name);
 			}
@@ -4461,7 +4461,7 @@ static int option_parse_include(const struct opti=
on *opt,
 static int option_parse_p(const struct option *opt,
 			  const char *arg, int unset)
 {
-	p_value =3D atoi(arg);
+	state_p_value =3D atoi(arg);
 	p_value_known =3D 1;
 	return 0;
 }
--=20
2.8.2.490.g3dabe57
