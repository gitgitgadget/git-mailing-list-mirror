From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 63/94] builtin/apply: make apply_all_patches() return -1 on error
Date: Wed, 11 May 2016 15:17:14 +0200
Message-ID: <20160511131745.2914-64-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:20:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U4M-00047r-Ge
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbcEKNUt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2016 09:20:49 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36586 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932306AbcEKNUi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id w143so9353209wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p/izvzF5yxXqpgytKQXLpcY4VGV5Yfp5dSe1TGngZm8=;
        b=kZRr+ocxz8e2ZBdxvar9aPZ0LyHP3Hnl7UNNOjiWiaCTfdqWjJ8rKOFMaMdenx/+PL
         qp1hmMrNkjMK+srNKRNJ3PH0YRUOu2G4FBR1+wxddd1Lr44tGlQT1ReelB2b+Oqdjv6s
         qJ9ZGeugTinaUvlEBUCHdQFTKrThnnEcY0hNphUhAGhGBk+DFWRAFE6qbRYPA7IxMFA1
         ERaEeQccKN5BWYnlSIgB3HiS49pwvExx1G520ZdDlFOj/X9Bi+y2xuKY1PLzFHDDnFG1
         UQMect1xpVvSSH7FKVs1PcfkvT64tuxD6kTUUpFTFzpU40N0dtAmyGpcWW7FQXUXb+7T
         E38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p/izvzF5yxXqpgytKQXLpcY4VGV5Yfp5dSe1TGngZm8=;
        b=aNdXjFwmH3QQV/kgW2Q8LuMLBUARxrIztuYCQflKBQclOpe8OYP/vO+1C4HIVMjiCl
         SOBGEJ2s5K2dpjg7n0g4FwnJggvHJ/J1UYpabJpevbkWDciyapABPx7jPuN+0lHoFgyM
         x5Ug2lb69sCpntDX1yjkE67xldABZtr4bbxfC3nIKZW4hTOhliVFaAcwYJloYLZ3tT41
         oC6t0cLU3l6+fPx7XvBQ868qUwH3z13xcwwT4lFDaXRb2/O7zfTMBdgPXAB3/zch+K5R
         3QwShfIAtsLQlWx08zxLFEjW210bvfrWAC+v9NEbBdckftv4AL45GjrUIMaRO/25kFyM
         cU9w==
X-Gm-Message-State: AOPr4FUHBwQAqHTJDaef24Wf2bq0zVEeYPPkpF8L5rDwEWHyFH0pfLIHTwH6Q6e5/I2ZdA==
X-Received: by 10.194.66.137 with SMTP id f9mr3799104wjt.74.1462972836920;
        Wed, 11 May 2016 06:20:36 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:35 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294286>

To finish libifying the apply functionality, apply_all_patches() should=
 not
die() or exit() in case of error, but return -1.

While doing that we must take care that file descriptors are properly c=
losed
and, if needed, reset a sensible value.

Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index ae16f99..dd212c9 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4557,7 +4557,7 @@ static int apply_all_patches(struct apply_state *=
state,
 		if (!strcmp(arg, "-")) {
 			res =3D apply_patch(state, 0, "<stdin>", options);
 			if (res < 0)
-				exit(1);
+				return -1;
 			errs |=3D res;
 			read_stdin =3D 0;
 			continue;
@@ -4568,20 +4568,20 @@ static int apply_all_patches(struct apply_state=
 *state,
=20
 		fd =3D open(arg, O_RDONLY);
 		if (fd < 0)
-			die_errno(_("can't open patch '%s'"), arg);
+			return error(_("can't open patch '%s': %s"), arg, strerror(errno));
 		read_stdin =3D 0;
 		set_default_whitespace_mode(state);
 		res =3D apply_patch(state, fd, arg, options);
+		close(fd);
 		if (res < 0)
-			exit(1);
+			return -1;
 		errs |=3D res;
-		close(fd);
 	}
 	set_default_whitespace_mode(state);
 	if (read_stdin) {
 		res =3D apply_patch(state, 0, "<stdin>", options);
 		if (res < 0)
-			exit(1);
+			return -1;
 		errs |=3D res;
 	}
=20
@@ -4596,10 +4596,10 @@ static int apply_all_patches(struct apply_state=
 *state,
 				squelched);
 		}
 		if (state->ws_error_action =3D=3D die_on_ws_error)
-			die(Q_("%d line adds whitespace errors.",
-			       "%d lines add whitespace errors.",
-			       state->whitespace_error),
-			    state->whitespace_error);
+			return error(Q_("%d line adds whitespace errors.",
+					"%d lines add whitespace errors.",
+					state->whitespace_error),
+				     state->whitespace_error);
 		if (state->applied_after_fixing_ws && state->apply)
 			warning("%d line%s applied after"
 				" fixing whitespace errors.",
@@ -4613,9 +4613,10 @@ static int apply_all_patches(struct apply_state =
*state,
 	}
=20
 	if (state->update_index) {
-		if (write_locked_index(&the_index, state->lock_file, COMMIT_LOCK))
-			die(_("Unable to write new index file"));
+		res =3D write_locked_index(&the_index, state->lock_file, COMMIT_LOCK=
);
 		state->newfd =3D -1;
+		if (res)
+			return error(_("Unable to write new index file"));
 	}
=20
 	return !!errs;
@@ -4705,5 +4706,5 @@ int cmd_apply(int argc, const char **argv, const =
char *prefix)
 	if (check_apply_state(&state, force_apply))
 		exit(1);
=20
-	return apply_all_patches(&state, argc, argv, options);
+	return !!apply_all_patches(&state, argc, argv, options);
 }
--=20
2.8.2.490.g3dabe57
