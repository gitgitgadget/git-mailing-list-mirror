From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 39/40] builtin/am: use apply api in run_apply()
Date: Mon, 13 Jun 2016 18:09:41 +0200
Message-ID: <20160613160942.1806-40-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Mon Jun 13 18:11:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUSP-0004Hc-Dg
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424993AbcFMQLO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2016 12:11:14 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34664 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424981AbcFMQLH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:11:07 -0400
Received: by mail-wm0-f67.google.com with SMTP id n184so16055996wmn.1
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nUfeAXBUDB6VTv83s0XXH1bSR5R2j58f1mZ98hq6qxE=;
        b=IOu53lBvw7JFfIO8j/9ZHthSi41YkF6SZyZ3OtuubRW9YTwFXgjZTVtrX5xShgjlVY
         HGyCfUHLk8UZ4sYP9cPWYuVIPBXR++HoCK7oLQZH/0S/piEBKhnLeEct5WVyG79q6cOn
         Oiv2pkU6Xb7V4CdO0eXanzhrBjEYr9HNOkzJdlcfszjXnVJM+93rLtsDmGeFOrtL3B+i
         0Oqn7s2zrWRnjxtygkFMZKLLzGF1z5tLpBOCtHmj9KaKBQJIHzWoD1FESLiXg4ChkAxJ
         5JKYkxYpGZ5hHp2YfCLsahco9lfKZHygSPGW1+e0uxK/ZYvfdtbWbJR+KET7VenttHdJ
         aZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nUfeAXBUDB6VTv83s0XXH1bSR5R2j58f1mZ98hq6qxE=;
        b=JTOYjdSzH4HyXSADcFWtLFsi0ReWbZnwYb2VSMRTngU1m9dasCgiklsoSN2Zp2KK/D
         vXD2Q7cQWaWEJdPGA5WMpu5EyYuOQR9FFZFt4jAFxcCVC7OD2pMEh1YJAMY6m7+rotn0
         9rvahk42HzDyBlkf+bOhNd6Bn/nDQelKVn+I6uj+LEuFfisBLy2xkeIzhCZZp1+Qva8W
         dkHHViqANfTuSOOQi4OZ9rVqfrU/c/bYbhSlp60wMxEO+NHabF2fntxLi/An7mfL92VH
         sUKAFyfyFKI5te6uNiyQzPbFR1fgclGQ8oXqg5dZAeKxZDxgTCaZ95ZkJqPJc8QyaQbg
         y8KA==
X-Gm-Message-State: ALyK8tL1oE7S/NBWUlQfVXxS2y+kI3zsUOITznV/330gbUMjsKFzPLDvXds2dIdrQGA4Jg==
X-Received: by 10.28.105.216 with SMTP id z85mr1977659wmh.75.1465834261059;
        Mon, 13 Jun 2016 09:11:01 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:11:00 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297213>

This replaces run_apply() implementation with a new one that
uses the apply api that has been previously prepared in
apply.c and apply.h.

This shoud improve performance a lot in certain cases.

As the previous implementation was creating a new `git apply`
process to apply each patch, it could be slow on systems like
Windows where it is costly to create new processes.

Also the new `git apply` process had to read the index from
disk, and when the process was done the calling process
discarded its own index and read back from disk the new
index that had been created by the `git apply` process.

This could be very inefficient with big repositories that
have big index files, especially when the system decided
that it was a good idea to run the `git apply` processes on
a different processor core.

Also eliminating index reads enables further performance
improvements by using:

`git update-index --split-index`

=46or example here is a benchmark of a multi hundred commit
rebase on the Linux kernel on a Debian laptop with SSD:

command: git rebase --onto 1993b17 52bef0c 29dde7c

Vanilla "next" without split index:                1m54.953s
Vanilla "next" with split index:                   1m22.476s
This series on top of "next" without split index:  1m12.034s
This series on top of "next" with split index:     0m15.678s

(using branch "next" from mid April 2016.)

Benchmarked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/am.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++----=
--------
 1 file changed, 73 insertions(+), 18 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 3dfe70b..8647298 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -28,6 +28,7 @@
 #include "rerere.h"
 #include "prompt.h"
 #include "mailinfo.h"
+#include "apply.h"
=20
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -1521,39 +1522,93 @@ static int parse_mail_rebase(struct am_state *s=
tate, const char *mail)
  */
 static int run_apply(const struct am_state *state, const char *index_f=
ile)
 {
-	struct child_process cp =3D CHILD_PROCESS_INIT;
+	struct argv_array apply_paths =3D ARGV_ARRAY_INIT;
+	struct argv_array apply_opts =3D ARGV_ARRAY_INIT;
+	struct apply_state apply_state;
+	int res, opts_left;
+	char *save_index_file;
+	static struct lock_file lock_file;
+
+	struct option am_apply_options[] =3D {
+		{ OPTION_CALLBACK, 0, "whitespace", &apply_state, N_("action"),
+			N_("detect new or modified lines that have whitespace errors"),
+			0, apply_option_parse_whitespace },
+		{ OPTION_CALLBACK, 0, "ignore-space-change", &apply_state, NULL,
+			N_("ignore changes in whitespace when finding context"),
+			PARSE_OPT_NOARG, apply_option_parse_space_change },
+		{ OPTION_CALLBACK, 0, "ignore-whitespace", &apply_state, NULL,
+			N_("ignore changes in whitespace when finding context"),
+			PARSE_OPT_NOARG, apply_option_parse_space_change },
+		{ OPTION_CALLBACK, 0, "directory", &apply_state, N_("root"),
+			N_("prepend <root> to all filenames"),
+			0, apply_option_parse_directory },
+		{ OPTION_CALLBACK, 0, "exclude", &apply_state, N_("path"),
+			N_("don't apply changes matching the given path"),
+			0, apply_option_parse_exclude },
+		{ OPTION_CALLBACK, 0, "include", &apply_state, N_("path"),
+			N_("apply changes matching the given path"),
+			0, apply_option_parse_include },
+		OPT_INTEGER('C', NULL, &apply_state.p_context,
+				N_("ensure at least <n> lines of context match")),
+		{ OPTION_CALLBACK, 'p', NULL, &apply_state, N_("num"),
+			N_("remove <num> leading slashes from traditional diff paths"),
+			0, apply_option_parse_p },
+		OPT_BOOL(0, "reject", &apply_state.apply_with_reject,
+			N_("leave the rejected hunks in corresponding *.rej files")),
+		OPT_END()
+	};
=20
-	cp.git_cmd =3D 1;
+	if (index_file) {
+		save_index_file =3D get_index_file();
+		set_index_file((char *)index_file);
+	}
+
+	if (init_apply_state(&apply_state, NULL, &lock_file))
+		die("init_apply_state() failed");
+
+	argv_array_push(&apply_opts, "apply");
+	argv_array_pushv(&apply_opts, state->git_apply_opts.argv);
+
+	opts_left =3D parse_options(apply_opts.argc, apply_opts.argv,
+				  NULL, am_apply_options, NULL, 0);
+
+	if (opts_left !=3D 0)
+		die("unknown option passed thru to git apply");
=20
 	if (index_file)
-		argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=3D%s", index_file);
+		apply_state.cached =3D 1;
+	else
+		apply_state.check_index =3D 1;
=20
 	/*
 	 * If we are allowed to fall back on 3-way merge, don't give false
 	 * errors during the initial attempt.
 	 */
-	if (state->threeway && !index_file) {
-		cp.no_stdout =3D 1;
-		cp.no_stderr =3D 1;
-	}
+	if (state->threeway && !index_file)
+		apply_state.be_silent =3D 1;
=20
-	argv_array_push(&cp.args, "apply");
+	if (check_apply_state(&apply_state, 0))
+		die("check_apply_state() failed");
=20
-	argv_array_pushv(&cp.args, state->git_apply_opts.argv);
+	argv_array_push(&apply_paths, am_path(state, "patch"));
+
+	res =3D apply_all_patches(&apply_state, apply_paths.argc, apply_paths=
=2Eargv, 0);
=20
 	if (index_file)
-		argv_array_push(&cp.args, "--cached");
-	else
-		argv_array_push(&cp.args, "--index");
+		set_index_file(save_index_file);
=20
-	argv_array_push(&cp.args, am_path(state, "patch"));
+	argv_array_clear(&apply_paths);
+	argv_array_clear(&apply_opts);
+	clear_apply_state(&apply_state);
=20
-	if (run_command(&cp))
-		return -1;
+	if (res)
+		return res;
=20
-	/* Reload index as git-apply will have modified it. */
-	discard_cache();
-	read_cache_from(index_file ? index_file : get_index_file());
+	if (index_file) {
+		/* Reload index as apply_all_patches() will have modified it. */
+		discard_cache();
+		read_cache_from(index_file);
+	}
=20
 	return 0;
 }
--=20
2.9.0.rc2.411.g3e2ca28
