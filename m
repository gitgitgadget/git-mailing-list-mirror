Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A8EC433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 20:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4391E2064B
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 20:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vFphdfYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgIIUnX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:43:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55892 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIIUnW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 16:43:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA3CA8B89C;
        Wed,  9 Sep 2020 16:43:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dSvGywLKCEod
        wi4zoqwdH4elAjg=; b=vFphdfYrXCAqRInXDbOooMrfdjCmp5fLUR/rkPMDNIiQ
        lBTE98E0H7kbSZnLi7jJXTyEiks8h5cW7PUIVKMqu4kj3TNNRKYHYNCpS6nArzJ/
        wM/tsBFY2VDejzN+MQO9LCj4LTkCPb9JlIGMuwlUSLzY0+gN5hAmHjkMpFJv+zw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nkjM3w
        Zhu8XdbxN7pFuCx1ImobzUBFkICa8FPYM85yLOuvZQ2rZJPZj14/ev3fB96J+rO4
        k3DwMzRlQphMXDAK7pl9tYjgSZh2cwXv57rjCLfSCljFntj0Fa5ygmNByJ0m4nX3
        +jx02yBMbWMdN8i4Bl4FMX0NNvuXrablU2SWI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1B6F8B89B;
        Wed,  9 Sep 2020 16:43:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3A6CF8B89A;
        Wed,  9 Sep 2020 16:43:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lin Sun <lin.sun@zoom.us>
Cc:     sunlin via GitGitGadget <gitgitgadget@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        sunlin <sunlin7@yahoo.com>
Subject: Re: [PATCH v17] Support auto-merge for meld to follow the vim-diff behavior
References: <pull.781.v16.git.git.1594544903477.gitgitgadget@gmail.com>
        <pull.781.v17.git.git.1594596738929.gitgitgadget@gmail.com>
        <xmqqv9idn2yr.fsf@gitster.c.googlers.com>
        <xmqq4koe8rav.fsf@gitster.c.googlers.com>
        <C35AC799-B4F6-4A5E-92FA-21065310B379@hxcore.ol>
        <CAKu6+JEctLopX2O2MmPNnSxqMPXjAqeXjpMPdrtY0J8AWd9L_A@mail.gmail.com>
Date:   Wed, 09 Sep 2020 13:43:14 -0700
In-Reply-To: <CAKu6+JEctLopX2O2MmPNnSxqMPXjAqeXjpMPdrtY0J8AWd9L_A@mail.gmail.com>
        (Lin Sun's message of "Wed, 9 Sep 2020 09:31:38 +0800")
Message-ID: <xmqqo8meu1el.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 159D6CE2-F2DD-11EA-9F34-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.  Will replace.

For those who are watching from the sideline, here is the patch inline.

-- >8 --
From: Lin Sun <lin.sun@zoom.us>
Date: Thu, 7 May 2020 07:31:14 +0800
Subject: [PATCH] Support auto-merge for meld to follow the vim-diff behav=
ior
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Make the mergetool used with "meld" backend behave similarly to "vimdiff"=
 by
telling it to auto-merge non-conflicting parts and highlight the conflict=
ing
parts when `mergetool.meld.useAutoMerge` is configured with `true`, or `a=
uto`
for detecting the `--auto-merge` option automatically.

Helped-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail.c=
om>
Helped-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Lin Sun <lin.sun@zoom.us>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/mergetool.txt | 10 ++++
 builtin/config.c                   | 17 ++++++
 mergetools/meld                    | 85 ++++++++++++++++++++++++------
 3 files changed, 96 insertions(+), 16 deletions(-)

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/me=
rgetool.txt
index 09ed31dbfa..16a27443a3 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -30,6 +30,16 @@ mergetool.meld.hasOutput::
 	to `true` tells Git to unconditionally use the `--output` option,
 	and `false` avoids using `--output`.
=20
+mergetool.meld.useAutoMerge::
+	When the `--auto-merge` is given, meld will merge all non-conflicting
+	parts automatically, highlight the conflicting parts and wait for
+	user decision.  Setting `mergetool.meld.useAutoMerge` to `true` tells
+	Git to unconditionally use the `--auto-merge` option with `meld`.
+	Setting this value to `auto` makes git detect whether `--auto-merge`
+	is supported and will only use `--auto-merge` when available.  A
+	value of `false` avoids using `--auto-merge` altogether, and is the
+	default value.
+
 mergetool.keepBackup::
 	After performing a merge, the original file with conflict markers
 	can be saved as a file with a `.orig` extension.  If this variable
diff --git a/builtin/config.c b/builtin/config.c
index ee4aef6a35..7891e070a4 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -65,6 +65,7 @@ static int show_scope;
 #define TYPE_PATH		4
 #define TYPE_EXPIRY_DATE	5
 #define TYPE_COLOR		6
+#define TYPE_BOOL_OR_STR	7
=20
 #define OPT_CALLBACK_VALUE(s, l, v, h, i) \
 	{ OPTION_CALLBACK, (s), (l), (v), NULL, (h), PARSE_OPT_NOARG | \
@@ -94,6 +95,8 @@ static int option_parse_type(const struct option *opt, =
const char *arg,
 			new_type =3D TYPE_INT;
 		else if (!strcmp(arg, "bool-or-int"))
 			new_type =3D TYPE_BOOL_OR_INT;
+		else if (!strcmp(arg, "bool-or-str"))
+			new_type =3D TYPE_BOOL_OR_STR;
 		else if (!strcmp(arg, "path"))
 			new_type =3D TYPE_PATH;
 		else if (!strcmp(arg, "expiry-date"))
@@ -149,6 +152,7 @@ static struct option builtin_config_options[] =3D {
 	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\"=
"), TYPE_BOOL),
 	OPT_CALLBACK_VALUE(0, "int", &type, N_("value is decimal number"), TYPE=
_INT),
 	OPT_CALLBACK_VALUE(0, "bool-or-int", &type, N_("value is --bool or --in=
t"), TYPE_BOOL_OR_INT),
+	OPT_CALLBACK_VALUE(0, "bool-or-str", &type, N_("value is --bool or stri=
ng"), TYPE_BOOL_OR_STR),
 	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or direc=
tory name)"), TYPE_PATH),
 	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date=
"), TYPE_EXPIRY_DATE),
 	OPT_GROUP(N_("Other")),
@@ -250,6 +254,12 @@ static int format_config(struct strbuf *buf, const c=
har *key_, const char *value
 				strbuf_addstr(buf, v ? "true" : "false");
 			else
 				strbuf_addf(buf, "%d", v);
+		} else if (type =3D=3D TYPE_BOOL_OR_STR) {
+			int v =3D git_parse_maybe_bool(value_);
+			if (v < 0)
+				strbuf_addstr(buf, value_);
+			else
+				strbuf_addstr(buf, v ? "true" : "false");
 		} else if (type =3D=3D TYPE_PATH) {
 			const char *v;
 			if (git_config_pathname(&v, key_, value_) < 0)
@@ -411,6 +421,13 @@ static char *normalize_value(const char *key, const =
char *value)
 		else
 			return xstrdup(v ? "true" : "false");
 	}
+	if (type =3D=3D TYPE_BOOL_OR_STR) {
+		int v =3D git_parse_maybe_bool(value);
+		if (v < 0)
+			return xstrdup(value);
+		else
+			return xstrdup(v ? "true" : "false");
+	}
 	if (type =3D=3D TYPE_COLOR) {
 		char v[COLOR_MAXLEN];
 		if (git_config_color(v, key, value))
diff --git a/mergetools/meld b/mergetools/meld
index 7a08470f88..aab4ebb935 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -3,34 +3,87 @@ diff_cmd () {
 }
=20
 merge_cmd () {
-	if test -z "${meld_has_output_option:+set}"
+	check_meld_for_features
+
+	option_auto_merge=3D
+	if test "$meld_use_auto_merge_option" =3D true
 	then
-		check_meld_for_output_version
+		option_auto_merge=3D"--auto-merge"
 	fi
=20
 	if test "$meld_has_output_option" =3D true
 	then
-		"$merge_tool_path" --output=3D"$MERGED" \
+		"$merge_tool_path" $option_auto_merge --output=3D"$MERGED" \
 			"$LOCAL" "$BASE" "$REMOTE"
 	else
-		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
+		"$merge_tool_path" $option_auto_merge "$LOCAL" "$MERGED" "$REMOTE"
 	fi
 }
=20
-# Check whether we should use 'meld --output <file>'
-check_meld_for_output_version () {
-	meld_path=3D"$(git config mergetool.meld.path)"
-	meld_path=3D"${meld_path:-meld}"
+# Get meld help message
+init_meld_help_msg () {
+	if test -z "$meld_help_msg"
+	then
+		meld_path=3D"$(git config mergetool.meld.path || echo meld)"
+		meld_help_msg=3D$("$meld_path" --help 2>&1)
+	fi
+}
=20
-	if meld_has_output_option=3D$(git config --bool mergetool.meld.hasOutpu=
t)
+# Check the features and set flags
+check_meld_for_features () {
+	# Check whether we should use 'meld --output <file>'
+	if test -z "$meld_has_output_option"
 	then
-		: use configured value
-	elif "$meld_path" --help 2>&1 |
-		grep -e '--output=3D' -e '\[OPTION\.\.\.\]' >/dev/null
+		meld_has_output_option=3D$(git config --bool mergetool.meld.hasOutput)
+		case "$meld_has_output_option" in
+		true | false)
+			: use configured value
+			;;
+		*)
+			: empty or invalid configured value, detecting "--output" automatical=
ly
+			init_meld_help_msg
+
+			case "$meld_help_msg" in
+			*"--output=3D"* | *'[OPTION...]'*)
+				# All version that has [OPTION...] supports --output
+				meld_has_output_option=3Dtrue
+				;;
+			*)
+				meld_has_output_option=3Dfalse
+				;;
+			esac
+			;;
+		esac
+	fi
+	# Check whether we should use 'meld --auto-merge ...'
+	if test -z "$meld_use_auto_merge_option"
 	then
-		: old ones mention --output and new ones just say OPTION...
-		meld_has_output_option=3Dtrue
-	else
-		meld_has_output_option=3Dfalse
+		meld_use_auto_merge_option=3D$(
+			git config --bool-or-str mergetool.meld.useAutoMerge
+		)
+		case "$meld_use_auto_merge_option" in
+		true | false)
+			: use well formatted boolean value
+			;;
+		auto)
+			# testing the "--auto-merge" option only if config is "auto"
+			init_meld_help_msg
+
+			case "$meld_help_msg" in
+			*"--auto-merge"* | *'[OPTION...]'*)
+				meld_use_auto_merge_option=3Dtrue
+				;;
+			*)
+				meld_use_auto_merge_option=3Dfalse
+				;;
+			esac
+			;;
+		"")
+			meld_use_auto_merge_option=3Dfalse
+			;;
+		*)
+			die "unknown mergetool.meld.useAutoMerge: $meld_use_auto_merge_option=
"
+			;;
+		esac
 	fi
 }
--=20
2.28.0-558-g7a0184fd7b

