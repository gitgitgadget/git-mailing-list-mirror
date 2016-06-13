From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 13/40] builtin/apply: make apply_all_patches() return -1 on error
Date: Mon, 13 Jun 2016 18:09:15 +0200
Message-ID: <20160613160942.1806-14-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
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
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:10:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCURV-0003aP-HI
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424917AbcFMQKV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2016 12:10:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35054 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424871AbcFMQKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:16 -0400
Received: by mail-wm0-f67.google.com with SMTP id k184so16026948wme.2
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OKBUjO82bC3UoD9YLOuS5Be6mlDV5azo5pOmB0r9DTI=;
        b=JSoBTt1ehiob2x8zpp4F/+Ik/ImyXFaJ/gm9iO6v0lWeMfIKEj47QvfQthpzkVLHPc
         iudbHwfBNa8spZYwkHpZlfbI0X2VI8km63SLcUtfd7cSIn/QoCULJl6xUJGFP+EUmEMF
         GNVp5VybJ00nWLfdJ3gxaGJsAdv+gSzFkmHDKBdIVa3Gr/ziowjbYAVPpEAOaHd0myWY
         rp8gY0Pie896jAHXlJMrlOzyeZWaVMqN+2MExUEVjBgWChAEOoIqUsm14SyerdXAcq4w
         RI7BtyPzT9uQOyFw1j2PmpByoVOU0xCeB/VSgLI2ciY2Nw2KxjQOgxxjeMQBfDaMas33
         mQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OKBUjO82bC3UoD9YLOuS5Be6mlDV5azo5pOmB0r9DTI=;
        b=WqGIDTI9ff9M6hROw4vfq787d29KHWkezZ+C7zR4tm1tCoiWDZVcG5n5R6ocKIEk4Y
         4fl5l+naz3RQJERjBfAcpt2c+gp049J0G7BktR+gHmEh+iDhDqId2zgOyTnZyeUGy38n
         VjBL9STocFgtAM1zjgh2CF9poZN/UOwGwywqMq0eFKR4s+QQPqDlVmpfhhiGAFnd2uSa
         2URfkBAhwj/iyHXpNvKXx2R2BRNFP/DvxrNvP7puzIEjM43Y2cszNdb9/5/XcbIFJEh5
         80yq+QH9b0TwlxbzhZt+OgsuUcGNA8vPjJqq4oXD4bIPqJ3v3rTDGfYIwo+h54Xsir05
         PEJQ==
X-Gm-Message-State: ALyK8tL3ZfzfWX0FbhpCSPRZTOk0zZK2fplk8QfBQ9vdQJh2fj8a2+PGlBbOkGMPqPfIzg==
X-Received: by 10.195.9.67 with SMTP id dq3mr2099682wjd.140.1465834214918;
        Mon, 13 Jun 2016 09:10:14 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:14 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297198>

To finish libifying the apply functionality, apply_all_patches() should=
 not
die() or exit() in case of error, but return -1.

While doing that we must take care that file descriptors are properly c=
losed
and, if needed, reset a sensible value.

Also, according to the lockfile API, when finished with a lockfile, one
should either commit it or roll it back.

This is even more important now that the same lockfile can be passed
to init_apply_state() many times to be reused by series of calls to
the apply lib functions.

Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index a27fdd3..c27be35 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4558,7 +4558,7 @@ static int apply_all_patches(struct apply_state *=
state,
 		if (!strcmp(arg, "-")) {
 			res =3D apply_patch(state, 0, "<stdin>", options);
 			if (res < 0)
-				exit(1);
+				goto rollback_end;
 			errs |=3D res;
 			read_stdin =3D 0;
 			continue;
@@ -4568,21 +4568,23 @@ static int apply_all_patches(struct apply_state=
 *state,
 					      arg);
=20
 		fd =3D open(arg, O_RDONLY);
-		if (fd < 0)
-			die_errno(_("can't open patch '%s'"), arg);
+		if (fd < 0) {
+			error(_("can't open patch '%s': %s"), arg, strerror(errno));
+			goto rollback_end;
+		}
 		read_stdin =3D 0;
 		set_default_whitespace_mode(state);
 		res =3D apply_patch(state, fd, arg, options);
+		close(fd);
 		if (res < 0)
-			exit(1);
+			goto rollback_end;
 		errs |=3D res;
-		close(fd);
 	}
 	set_default_whitespace_mode(state);
 	if (read_stdin) {
 		res =3D apply_patch(state, 0, "<stdin>", options);
 		if (res < 0)
-			exit(1);
+			goto rollback_end;
 		errs |=3D res;
 	}
=20
@@ -4596,11 +4598,13 @@ static int apply_all_patches(struct apply_state=
 *state,
 				   squelched),
 				squelched);
 		}
-		if (state->ws_error_action =3D=3D die_on_ws_error)
-			die(Q_("%d line adds whitespace errors.",
-			       "%d lines add whitespace errors.",
-			       state->whitespace_error),
-			    state->whitespace_error);
+		if (state->ws_error_action =3D=3D die_on_ws_error) {
+			error(Q_("%d line adds whitespace errors.",
+				 "%d lines add whitespace errors.",
+				 state->whitespace_error),
+			      state->whitespace_error);
+			goto rollback_end;
+		}
 		if (state->applied_after_fixing_ws && state->apply)
 			warning("%d line%s applied after"
 				" fixing whitespace errors.",
@@ -4614,12 +4618,22 @@ static int apply_all_patches(struct apply_state=
 *state,
 	}
=20
 	if (state->update_index) {
-		if (write_locked_index(&the_index, state->lock_file, COMMIT_LOCK))
-			die(_("Unable to write new index file"));
+		res =3D write_locked_index(&the_index, state->lock_file, COMMIT_LOCK=
);
+		if (res) {
+			error(_("Unable to write new index file"));
+			goto rollback_end;
+		}
 		state->newfd =3D -1;
 	}
=20
 	return !!errs;
+
+rollback_end:
+	if (state->newfd >=3D 0) {
+		rollback_lock_file(state->lock_file);
+		state->newfd =3D -1;
+	}
+	return -1;
 }
=20
 int cmd_apply(int argc, const char **argv, const char *prefix)
--=20
2.9.0.rc2.411.g3e2ca28
