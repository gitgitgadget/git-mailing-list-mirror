From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 16/44] builtin/apply: make gitdiff_*() return -1 on error
Date: Fri, 10 Jun 2016 22:10:50 +0200
Message-ID: <20160610201118.13813-17-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:12:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSmo-0003HY-6r
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbcFJUMF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 16:12:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35876 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932294AbcFJUMD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id m124so1034498wme.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wIaFtrZ52DTP4NU/J+ZRLSZ5F91HeBmIdjBD2u6AjfI=;
        b=r7cmma6Bc/aHTDsBAF3eQbSGkKQBp6Wak2f62lq+b80ITHnAidinV3HrqxFQxPRzue
         OVqPwwioVyHifdfJjwFebXNuNbpP/r6vqnH+OecuGL2jabH2iP39HUSO1MZI2O68dM3q
         JNUcp0keT+WlPwYZocr6LHi0LPNWv8IkZ07XakeUV/7XueFC/VRrLePr1iRQwyBTVu/M
         EVXXH5RVOQHk9SHGrhIHVDX0xP/dBYSfFWuO9eAPEJjC4hBg+pD6Bksv+OwVrk4v+oBn
         x49XwjcPgQwA0Aiwcx9RLaxEXDkFdhU8DIRXlvoSN8bKC+TkD69HpYheosbbmZqKjkK+
         WtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wIaFtrZ52DTP4NU/J+ZRLSZ5F91HeBmIdjBD2u6AjfI=;
        b=Vbyi71Jfhgu+tu/XYWksCnQ75WLxlFegjh9EYpFr2oZQlljp0GC1UkTHswL2MhUsLs
         oN2C+j8bfISnRcPpfjYJ+2uw/Iq++jrTcLIWlv7K7PheFV54AN5K0rD7Nm2zQHyOiZ1a
         tfsh+Rl+hMwdzLUmMvdDfl5+3VmcfSD0VACOSqL5macdpwmVy17TTlamQWLWP6gCTQ6W
         cOMiN11qpyh2ieDcfmOpOfnsWAPFS17UHBqLy3t7w9B7BF3mRw1uKfFa+biNn/lRnWGk
         61D+UyQlfNS+LOHGGshz7S6W4qSSmZQTVS1ggMJ2up0QsdUDTRyeD1CDD+p6Filu4ux2
         MbIQ==
X-Gm-Message-State: ALyK8tLDSBtDjmjzxhK8cEeF+D/7LBgU4LBRgnPCBojfuMZALw/HfW/Jhi3NPtb7+ZvISw==
X-Received: by 10.28.128.67 with SMTP id b64mr704148wmd.2.1465589521900;
        Fri, 10 Jun 2016 13:12:01 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:01 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297030>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", gitdiff_*() functions should return -1 instead
of calling die().

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
index 1142514..b506369 100644
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
2.9.0.rc2.362.g3cd93d0
