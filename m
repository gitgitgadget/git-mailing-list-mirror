Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756FC525F
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="rHtVctQP"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE5EE1
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 04:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1698494264; x=1699099064; i=l.s.r@web.de;
	bh=H8XrgXj2Ns8sHH+fJjQnWPXQ3+sYiCY35nPPIASi08g=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=rHtVctQPGeVoTRAFfp+hp/N6F3dEctESJwXcm2QG3Rpd7rstIVaAdOU+fYLQZVqO
	 5HjQHlv5vkzdB2bAkZKBI0znIYm/u8ftLnSB+St4JtLtZ/VzOPtHky376Gnev+p99
	 2k3JaTu7cH7GpoFVtRiSJue2aepWUgR1ZZeY5TiqI278sm4x78VzwJbB/FACXuKku
	 +lX0b3DR7S/COgi3WFZprxQe2uZ3/P1Ya+A3RN+TaaOsmET4aPyOMS5gKbaRtZtQQ
	 XYGscYrIwhtyMlSyc9EYS6vd9J2hRCvOspPnJUgTjNn3ptt2dbEfGwHaIopCRgaz9
	 LfgboRIcycKKhjuQpA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.159.209]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5QmF-1qvsT73Hmv-001YBn; Sat, 28
 Oct 2023 13:57:44 +0200
Message-ID: <4520156b-9418-493c-a50c-e61b42e805b3@web.de>
Date: Sat, 28 Oct 2023 13:57:44 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] am: simplify --show-current-patch handling
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
References: <cefdba32-db0b-4f68-954e-9d31fc12b1a0@web.de>
In-Reply-To: <cefdba32-db0b-4f68-954e-9d31fc12b1a0@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qc6Jzn5+CjF+9jTUBZ6unah17NPXbio5Oq2KBQO5jUTEWVhv7O7
 15AdzhHxaoRlDeRzwalCejfAXahkQJlpMRDxoKk+VNNbCufkAXZxmZNQusooGo7jrbdtQRF
 f21JENORw9jxAFGONu+iAro04keFHpvGbpH3qDtKtwrxLosHk1HEkwF85rBwvXniJ7rEBVf
 z3MEd9QwYoLEalJ5phmfQ==
UI-OutboundReport: notjunk:1;M01:P0:cIWOPPgIM0s=;PwDWeKIJpmgsQF4UkDfC3vLqjOS
 TVRpsrDTkeX1fwJVOPczRIXabz25+5Hd0uaDI+sgJAZzyX2M+CSv8gFFaSEAIQqsyFeeTPlcT
 YyPA6jIIl1Ybm86AkGNFJAZbOWk4bLBWQxMdm2Syb3DwvGL+tozOEq1RfbTWDunaE8wWWFjFM
 vp6L00FyGUTZ9jdbBPaar+HEY6WT8d8PzAHsQZ0vtV05ehHFzi+ZfM3ZshvgJ+Yn0S+A4YTER
 kMpwAtnpJKSFwW7pUcVhqb5JXlNHXzyJG1y7xS5vgBIcwPOxTRx2QL4Sg/wtPSJGfmM4FoQpn
 FAhUe1xnFCJJeB5Zd4Gp/zUprKwNazhO7XMNhG272ZwdxHqAXa5MzB1zbi809y+6hVVw3ewYn
 FikN/0AahwwBdQSFpFISAdtcYYcidEkC7pzFrJVvQIO7fuXlaGWmjeRyCPeBLaYshVGSyHno/
 g2IBspnMxMeXcKKQ7v/QLKzkOltvRJoltkKiCUu51wUR7S2nlQcKu0ox87YP98LmA9FENIEK+
 iJrM0MnROkHqDRBKYBp8I74mnVEo/6mSlQ36Ls6WI4w/7N93srMD0AoXjNEZSLxUY/RBbePXs
 xjx1wy3xGMPQr0kJLa98ZlwRxtm0eFn0kKwgqCWB+AVVhf3voONG+bnxBATK2aOXPgL3/5gpM
 kGnjTmELkWoF2Lot8EimsGy0Fk1h02V5d2PsFbdEka+HP+UYe9lW9cfh2UbC6zOsMw6OeU/4A
 riMhsfdi2M8X5t4fmwIKiYzqlooeG64qVJ7e5xFyyaTNhL4dme06FxyOBo77tjxQsLdZjxHfN
 fLGkhuGx2IJHn6bK+j6+Jz0p8xt9/ygTQEm6HjLzr6DNXvP6/PTdIDVTV8ovkXXnaKa2kWeFz
 5NSDCEw0tIiv2hgqM6mirVGfy3zXLrjA+qmS/P07T/MsZMLDz9jMvWqOCIxQXjYgSpQTs1OBd
 UVCL9K1mlqCoh+RJNEdr9awv/TM=

Let the parse-options code detect and handle the use of options that are
incompatible with --show-current-patch.  This requires exposing the
distinction between the "raw" and "diff" sub-modes.  Do that by
splitting the mode RESUME_SHOW_PATCH into RESUME_SHOW_PATCH_RAW and
RESUME_SHOW_PATCH_DIFF and stop tracking sub-modes in a separate struct.

The result is a simpler callback function and more precise error
messages.  The original reports a spurious argument or a NULL pointer:

   $ git am --show-current-patch --show-current-patch=3Ddiff
   error: options '--show-current-patch=3Ddiff' and '--show-current-patch=
=3Draw' cannot be used together
   $ git am --show-current-patch=3Ddiff --show-current-patch
   error: options '--show-current-patch=3D(null)' and '--show-current-patc=
h=3Ddiff' cannot be used together

With this patch we get the more precise:

   $ git am --show-current-patch --show-current-patch=3Ddiff
   error: --show-current-patch=3Ddiff is incompatible with --show-current-=
patch
   $ git am --show-current-patch=3Ddiff --show-current-patch
   error: --show-current-patch is incompatible with --show-current-patch=
=3Ddiff

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/am.c | 112 ++++++++++++++++++++-------------------------------
 1 file changed, 44 insertions(+), 68 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 6655059a57..ef5b9459af 100644
=2D-- a/builtin/am.c
+++ b/builtin/am.c
@@ -92,9 +92,16 @@ enum signoff_type {
 	SIGNOFF_EXPLICIT /* --signoff was set on the command-line */
 };

-enum show_patch_type {
-	SHOW_PATCH_RAW =3D 0,
-	SHOW_PATCH_DIFF =3D 1,
+enum resume_type {
+	RESUME_FALSE =3D 0,
+	RESUME_APPLY,
+	RESUME_RESOLVED,
+	RESUME_SKIP,
+	RESUME_ABORT,
+	RESUME_QUIT,
+	RESUME_SHOW_PATCH_RAW,
+	RESUME_SHOW_PATCH_DIFF,
+	RESUME_ALLOW_EMPTY,
 };

 enum empty_action {
@@ -2191,7 +2198,7 @@ static void am_abort(struct am_state *state)
 	am_destroy(state);
 }

-static int show_patch(struct am_state *state, enum show_patch_type sub_mo=
de)
+static int show_patch(struct am_state *state, enum resume_type resume_mod=
e)
 {
 	struct strbuf sb =3D STRBUF_INIT;
 	const char *patch_path;
@@ -2206,11 +2213,11 @@ static int show_patch(struct am_state *state, enum=
 show_patch_type sub_mode)
 		return run_command(&cmd);
 	}

-	switch (sub_mode) {
-	case SHOW_PATCH_RAW:
+	switch (resume_mode) {
+	case RESUME_SHOW_PATCH_RAW:
 		patch_path =3D am_path(state, msgnum(state));
 		break;
-	case SHOW_PATCH_DIFF:
+	case RESUME_SHOW_PATCH_DIFF:
 		patch_path =3D am_path(state, "patch");
 		break;
 	default:
@@ -2257,57 +2264,25 @@ static int parse_opt_patchformat(const struct opti=
on *opt, const char *arg, int
 	return 0;
 }

-enum resume_type {
-	RESUME_FALSE =3D 0,
-	RESUME_APPLY,
-	RESUME_RESOLVED,
-	RESUME_SKIP,
-	RESUME_ABORT,
-	RESUME_QUIT,
-	RESUME_SHOW_PATCH,
-	RESUME_ALLOW_EMPTY,
-};
-
-struct resume_mode {
-	enum resume_type mode;
-	enum show_patch_type sub_mode;
-};
-
 static int parse_opt_show_current_patch(const struct option *opt, const c=
har *arg, int unset)
 {
 	int *opt_value =3D opt->value;
-	struct resume_mode *resume =3D container_of(opt_value, struct resume_mod=
e, mode);

+	BUG_ON_OPT_NEG(unset);
+
+	if (!arg)
+		*opt_value =3D opt->defval;
+	else if (!strcmp(arg, "raw"))
+		*opt_value =3D RESUME_SHOW_PATCH_RAW;
+	else if (!strcmp(arg, "diff"))
+		*opt_value =3D RESUME_SHOW_PATCH_DIFF;
 	/*
 	 * Please update $__git_showcurrentpatch in git-completion.bash
 	 * when you add new options
 	 */
-	const char *valid_modes[] =3D {
-		[SHOW_PATCH_DIFF] =3D "diff",
-		[SHOW_PATCH_RAW] =3D "raw"
-	};
-	int new_value =3D SHOW_PATCH_RAW;
-
-	BUG_ON_OPT_NEG(unset);
-
-	if (arg) {
-		for (new_value =3D 0; new_value < ARRAY_SIZE(valid_modes); new_value++)=
 {
-			if (!strcmp(arg, valid_modes[new_value]))
-				break;
-		}
-		if (new_value >=3D ARRAY_SIZE(valid_modes))
-			return error(_("invalid value for '%s': '%s'"),
-				     "--show-current-patch", arg);
-	}
-
-	if (resume->mode =3D=3D RESUME_SHOW_PATCH && new_value !=3D resume->sub_=
mode)
-		return error(_("options '%s=3D%s' and '%s=3D%s' "
-					   "cannot be used together"),
-			     "--show-current-patch", arg,
-			     "--show-current-patch", valid_modes[resume->sub_mode]);
-
-	resume->mode =3D RESUME_SHOW_PATCH;
-	resume->sub_mode =3D new_value;
+	else
+		return error(_("invalid value for '%s': '%s'"),
+			     "--show-current-patch", arg);
 	return 0;
 }

@@ -2317,7 +2292,7 @@ int cmd_am(int argc, const char **argv, const char *=
prefix)
 	int binary =3D -1;
 	int keep_cr =3D -1;
 	int patch_format =3D PATCH_FORMAT_UNKNOWN;
-	struct resume_mode resume =3D { .mode =3D RESUME_FALSE };
+	enum resume_type resume_mode =3D RESUME_FALSE;
 	int in_progress;
 	int ret =3D 0;

@@ -2388,27 +2363,27 @@ int cmd_am(int argc, const char **argv, const char=
 *prefix)
 			PARSE_OPT_NOARG),
 		OPT_STRING(0, "resolvemsg", &state.resolvemsg, NULL,
 			N_("override error message when patch failure occurs")),
-		OPT_CMDMODE(0, "continue", &resume.mode,
+		OPT_CMDMODE(0, "continue", &resume_mode,
 			N_("continue applying patches after resolving a conflict"),
 			RESUME_RESOLVED),
-		OPT_CMDMODE('r', "resolved", &resume.mode,
+		OPT_CMDMODE('r', "resolved", &resume_mode,
 			N_("synonyms for --continue"),
 			RESUME_RESOLVED),
-		OPT_CMDMODE(0, "skip", &resume.mode,
+		OPT_CMDMODE(0, "skip", &resume_mode,
 			N_("skip the current patch"),
 			RESUME_SKIP),
-		OPT_CMDMODE(0, "abort", &resume.mode,
+		OPT_CMDMODE(0, "abort", &resume_mode,
 			N_("restore the original branch and abort the patching operation"),
 			RESUME_ABORT),
-		OPT_CMDMODE(0, "quit", &resume.mode,
+		OPT_CMDMODE(0, "quit", &resume_mode,
 			N_("abort the patching operation but keep HEAD where it is"),
 			RESUME_QUIT),
-		{ OPTION_CALLBACK, 0, "show-current-patch", &resume.mode,
+		{ OPTION_CALLBACK, 0, "show-current-patch", &resume_mode,
 		  "(diff|raw)",
 		  N_("show the patch being applied"),
 		  PARSE_OPT_CMDMODE | PARSE_OPT_OPTARG | PARSE_OPT_NONEG | PARSE_OPT_LI=
TERAL_ARGHELP,
-		  parse_opt_show_current_patch, RESUME_SHOW_PATCH },
-		OPT_CMDMODE(0, "allow-empty", &resume.mode,
+		  parse_opt_show_current_patch, RESUME_SHOW_PATCH_RAW },
+		OPT_CMDMODE(0, "allow-empty", &resume_mode,
 			N_("record the empty patch as an empty commit"),
 			RESUME_ALLOW_EMPTY),
 		OPT_BOOL(0, "committer-date-is-author-date",
@@ -2463,12 +2438,12 @@ int cmd_am(int argc, const char **argv, const char=
 *prefix)
 		 *    intend to feed us a patch but wanted to continue
 		 *    unattended.
 		 */
-		if (argc || (resume.mode =3D=3D RESUME_FALSE && !isatty(0)))
+		if (argc || (resume_mode =3D=3D RESUME_FALSE && !isatty(0)))
 			die(_("previous rebase directory %s still exists but mbox given."),
 				state.dir);

-		if (resume.mode =3D=3D RESUME_FALSE)
-			resume.mode =3D RESUME_APPLY;
+		if (resume_mode =3D=3D RESUME_FALSE)
+			resume_mode =3D RESUME_APPLY;

 		if (state.signoff =3D=3D SIGNOFF_EXPLICIT)
 			am_append_signoff(&state);
@@ -2482,7 +2457,7 @@ int cmd_am(int argc, const char **argv, const char *=
prefix)
 		 * stray directories.
 		 */
 		if (file_exists(state.dir) && !state.rebasing) {
-			if (resume.mode =3D=3D RESUME_ABORT || resume.mode =3D=3D RESUME_QUIT)=
 {
+			if (resume_mode =3D=3D RESUME_ABORT || resume_mode =3D=3D RESUME_QUIT)=
 {
 				am_destroy(&state);
 				am_state_release(&state);
 				return 0;
@@ -2493,7 +2468,7 @@ int cmd_am(int argc, const char **argv, const char *=
prefix)
 				state.dir);
 		}

-		if (resume.mode)
+		if (resume_mode)
 			die(_("Resolve operation not in progress, we are not resuming."));

 		for (i =3D 0; i < argc; i++) {
@@ -2511,7 +2486,7 @@ int cmd_am(int argc, const char **argv, const char *=
prefix)
 		strvec_clear(&paths);
 	}

-	switch (resume.mode) {
+	switch (resume_mode) {
 	case RESUME_FALSE:
 		am_run(&state, 0);
 		break;
@@ -2520,7 +2495,7 @@ int cmd_am(int argc, const char **argv, const char *=
prefix)
 		break;
 	case RESUME_RESOLVED:
 	case RESUME_ALLOW_EMPTY:
-		am_resolve(&state, resume.mode =3D=3D RESUME_ALLOW_EMPTY ? 1 : 0);
+		am_resolve(&state, resume_mode =3D=3D RESUME_ALLOW_EMPTY ? 1 : 0);
 		break;
 	case RESUME_SKIP:
 		am_skip(&state);
@@ -2532,8 +2507,9 @@ int cmd_am(int argc, const char **argv, const char *=
prefix)
 		am_rerere_clear();
 		am_destroy(&state);
 		break;
-	case RESUME_SHOW_PATCH:
-		ret =3D show_patch(&state, resume.sub_mode);
+	case RESUME_SHOW_PATCH_RAW:
+	case RESUME_SHOW_PATCH_DIFF:
+		ret =3D show_patch(&state, resume_mode);
 		break;
 	default:
 		BUG("invalid resume value");
=2D-
2.42.0
