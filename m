From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 13/44] builtin/apply: make apply_all_patches() return -1 on error
Date: Fri, 10 Jun 2016 22:10:47 +0200
Message-ID: <20160610201118.13813-14-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Fri Jun 10 22:13:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSoX-0004eF-Ik
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145AbcFJUNo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 16:13:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34932 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932102AbcFJUL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:11:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id k184so1047953wme.2
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vHkHdGcEtmWEOtt2JDhb2uiNpKwu7MTBh81v5jpyFzg=;
        b=AUz6B9QJjohf6wYZ0kPTcdrK3ybAYMrgiIOvrKmDCDHK3kLkfVjfiSdTXSUHL7pTbG
         slL6ueYH0/Odowj/ox98wc4cs6wSTSVo5kB0AI3KCwy+6C4vdrg2A0cyvJxvt93dIM6H
         koYdsnnVcmeYXFt8OjNOe7akuOk53UtFbM6uGoPT9PsHa0g1YXoi9xLQDcO0s0dUcBsb
         IKG4D0P6ayVv+smzlm34Y8zfvh0N0GdPOFUBKLQmDahqACuy+tTfuC+Xf/lm4nVyhQN9
         hbbBnce0XMcVk7LTba0i2EsNSy8IV4c+v/SCfj1WnBYixNslK7xeW8lJIat2hRtvGg7t
         TDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vHkHdGcEtmWEOtt2JDhb2uiNpKwu7MTBh81v5jpyFzg=;
        b=CFj/hvH9BWRVj7HcVQofETsK6zIPh2NaDK0qJHycvrpyNJdL/IJEnAWztKRw1L7MKW
         k59wmvi5baDU45CRn5FW8KDSZqKN/OmiD6Olo3lrz5g7F+Xkmazz3/4faelTCZHPxp6u
         eMkp95+1pC0Q2aTWY/NaELdwB8Wy6v38EqUavQibq4IJCdVduMqBixLrVevjZkhGA0GB
         EDDLMLzD2dQ8sB7glLueIvWzcHOL1fwMg+U3MNWVBD7O8T5GsOR9z+JGvX2+KdlSLvBB
         6of7Hi1d9rTes7M4HCtWYf1Rd6f7FdHM9u6aFD/o1mGdHSbHQJSPHv6Yz2ZTDcr0kwHL
         ywkA==
X-Gm-Message-State: ALyK8tIlWqaW0/oHFI9ywBjja7o+s/EdGwxZSPTYf/evb9BE2xjHKvAInhqwcYovr4Fq5A==
X-Received: by 10.194.148.46 with SMTP id tp14mr3788478wjb.104.1465589517997;
        Fri, 10 Jun 2016 13:11:57 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:11:57 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297063>

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

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
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
2.9.0.rc2.362.g3cd93d0
