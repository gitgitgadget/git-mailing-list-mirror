From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 66/94] builtin/apply: make gitdiff_*() return -1 on error
Date: Wed, 11 May 2016 15:17:17 +0200
Message-ID: <20160511131745.2914-67-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:22:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U67-00069s-9c
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbcEKNUr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2016 09:20:47 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33787 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932299AbcEKNUo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:44 -0400
Received: by mail-wm0-f68.google.com with SMTP id r12so9415930wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6r6AgvjGUYpRFJfnXEVKCU9k6sftbKCOaZ9VmJUUEQI=;
        b=A+eNqwQGsOWDR5a1uBN1bqyeYIonUwO+IzcMRaMvMxF+OISSryZ+VHk6GkFXD3GUqq
         fCoY9By/AfRJ1mCHClVrDrZKHvC9E6y0OjIWVFVBOmxZ6KXiozNOjp/l1KBTwFJSwCVY
         aSWUtUWiN04/bPkCjC52DfNLgx/qD9kHz4qqrb2j7CNipqX0DXIKtJ8ytdcKB6+9SQkl
         jQ80GCM69wRTzIzw4TsKWzAsAkzDv/o8B7G/CyfC8eKQJO4nlt0jnMXzmeYCEzp4xGts
         6aN8GZtJb8xbePrXd90dy91PE3+xidWczrdtRVs8jLcTLCyXV7PMBgSBNzKsWx/9nOQz
         Cdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6r6AgvjGUYpRFJfnXEVKCU9k6sftbKCOaZ9VmJUUEQI=;
        b=BOTCzsisBxV98boY1MsRS+onx8okYMaGa1omaDP9D7g6xYYdMrBi8pg8oCJEd00XJ9
         Ad0fT3yk61xtTDM+wkYrZOkMDyuPZgsC7EkOVlX1yEXpcuOHtpFtn538Srr/JyyaEJ9R
         bCZVNP+GoB6g5e3PO1Wud/4Z67ODOYB0gU0rvDc4sZGUtplvShDpwaBmxPupdypf6Lkm
         gNiqIgD/jaGfiQ0sTbyPKkyp5eCtRVtZcQ1NhXz31vSm4oqQ8BvP4JiAoLtms7MJuGNh
         kR+FkQimaoFCTDW3Af+MXlbIgmY3CDrxy9dRZXloAW/Z/6d7aNQ/i1kRzY7y8VeW1RmG
         2sCg==
X-Gm-Message-State: AOPr4FWqKsX3/Bqk+8xrqE8S17vucD9UF3I1jV6F2bOSr9PvQYe/gxHGxZ/SBUPHEp6ifQ==
X-Received: by 10.194.66.137 with SMTP id f9mr3799641wjt.74.1462972842868;
        Wed, 11 May 2016 06:20:42 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:42 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294316>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", gitdiff_*() functions should return -1 using
error() instead of calling die().

A previous patch made it possible for gitdiff_*() functions to
return -1 in case of error. Let's take advantage of that to
make gitdiff_verify_name() return -1 on error, and to have
gitdiff_oldname() and gitdiff_newname() directly return
what gitdiff_verify_name() returns.

Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index b3a9c2e..42b0a24 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -827,54 +827,56 @@ static int gitdiff_hdrend(struct apply_state *sta=
te,
 #define DIFF_OLD_NAME 0
 #define DIFF_NEW_NAME 1
=20
-static void gitdiff_verify_name(struct apply_state *state,
-				const char *line,
-				int isnull,
-				char **name,
-				int side)
+static int gitdiff_verify_name(struct apply_state *state,
+			       const char *line,
+			       int isnull,
+			       char **name,
+			       int side)
 {
 	if (!*name && !isnull) {
 		*name =3D find_name(state, line, NULL, state->p_value, TERM_TAB);
-		return;
+		return 0;
 	}
=20
 	if (*name) {
 		int len =3D strlen(*name);
 		char *another;
 		if (isnull)
-			die(_("git apply: bad git-diff - expected /dev/null, got %s on line=
 %d"),
-			    *name, state->linenr);
+			return error(_("git apply: bad git-diff - expected /dev/null, got %=
s on line %d"),
+				     *name, state->linenr);
 		another =3D find_name(state, line, NULL, state->p_value, TERM_TAB);
-		if (!another || memcmp(another, *name, len + 1))
-			die((side =3D=3D DIFF_NEW_NAME) ?
+		if (!another || memcmp(another, *name, len + 1)) {
+			free(another);
+			return error((side =3D=3D DIFF_NEW_NAME) ?
 			    _("git apply: bad git-diff - inconsistent new filename on line =
%d") :
 			    _("git apply: bad git-diff - inconsistent old filename on line =
%d"), state->linenr);
+		}
 		free(another);
 	} else {
 		/* expect "/dev/null" */
 		if (memcmp("/dev/null", line, 9) || line[9] !=3D '\n')
-			die(_("git apply: bad git-diff - expected /dev/null on line %d"), s=
tate->linenr);
+			return error(_("git apply: bad git-diff - expected /dev/null on lin=
e %d"), state->linenr);
 	}
+
+	return 0;
 }
=20
 static int gitdiff_oldname(struct apply_state *state,
 			   const char *line,
 			   struct patch *patch)
 {
-	gitdiff_verify_name(state, line,
-			    patch->is_new, &patch->old_name,
-			    DIFF_OLD_NAME);
-	return 0;
+	return gitdiff_verify_name(state, line,
+				   patch->is_new, &patch->old_name,
+				   DIFF_OLD_NAME);
 }
=20
 static int gitdiff_newname(struct apply_state *state,
 			   const char *line,
 			   struct patch *patch)
 {
-	gitdiff_verify_name(state, line,
-			    patch->is_delete, &patch->new_name,
-			    DIFF_NEW_NAME);
-	return 0;
+	return gitdiff_verify_name(state, line,
+				   patch->is_delete, &patch->new_name,
+				   DIFF_NEW_NAME);
 }
=20
 static int gitdiff_oldmode(struct apply_state *state,
--=20
2.8.2.490.g3dabe57
