Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F0EEB64D9
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 18:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjGGSej (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 14:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjGGSei (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 14:34:38 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3255A268D
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 11:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688754872; x=1689359672; i=l.s.r@web.de;
 bh=oiSE+SCmwe/pvTNi8eChXkdVEiO1enTp3Ull/aQoh58=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=LVEo/qksr9xUqOD9NZamo/IItz6GlnRUF2vP3ttmMIPuk4wRjBpvwwr60hmoLVUWa7poLN/
 dU1YgBkfauiNIzaLgeTthasN087zx0NeSeVymeB4Bg3Ors3w1HULj/SzRUfg+Rx/ToGhwP01+
 ms9SrH+BmfWzLXX/4FMmWVvqS96wb9G1wBPQ0rQQWJkGYa+ZekMgueyQA8klUAAmrU5jLuiVA
 T/v2ha8HLEffxsofGKh/SpSN2bNjwN7+mIa2olzAISIkYEuw7nmcsWEOlp2vwsYiByg9ElYWi
 wAtxZEPeY2TzSDj22MyYeMOar7gz+BWakdakJhLeZwXy3hlUGBRQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.158.134]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGxQV-1qEHdb15wR-00DqjQ for
 <git@vger.kernel.org>; Fri, 07 Jul 2023 20:34:32 +0200
Message-ID: <b34aa99b-2bf1-c645-bdf5-03ac258b4bf5@web.de>
Date:   Fri, 7 Jul 2023 20:34:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] ls-tree: simplify prefix handling
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BHLJC7NZU7YHopOJxvaT7omRs+D3HYudhd1ZLtiKfiMhzcUiHbZ
 dnDFOJtsSHjrobghqR60xGMdF5GvinZ0G7lKNZTuOHzxgEbUfGESmbGocTh4z+pCCQk/EF9
 4jC6eRWMvSdS3OcC7dShni2BH6SW6FxLUIbtQzUJVW+22Ft7vgRmhg1ILIJ4Z3cRfI1eGuA
 l8gI1uuhVaxkCHenYKnfA==
UI-OutboundReport: notjunk:1;M01:P0:P3GIjqyH0Pc=;rjiM2Rg4s4m0bA8KNjO8/ntAsx/
 RYmcL1RIm77vSxwg8UE2H53i8jabYeVdfuog8iPBPyIEXUUIqk9BT+h2R14qrhpob+mCcWzwE
 XWxwjIurQvF2ossEgrsxkODAZyJb1w1u6g/G82IBtfQc+D+pBb+g+iIH4jTBj+FucmJooSaOI
 HyOcWggWfNxtFqO7IOrt4OQ/bzGYjN9u/lDrmWoaSOc+pnZTBX/B66jlgpegYoGkfM3e2iXh2
 qhSbr76EmTfo+oKP0B+WdJVtHRMIyJkhQAG5TVHb6tJlkz9o+IIxKHpKbu0B+IpC1ffXH8qG3
 TMeopOsJntJdSFBXB62tyGTaXBcYB0dalgw0iBCDhXJB1RmPXxYSoYXqQcbs2zCfEUnJjrb/r
 8cYi06fhDWCrv/RQYxboWBGh4pUGlRBX9EwGjKUhBWl0m2XyQVkBTwJuIetvlf03HofLJRpfE
 DxG0yqIKDYBU/w7sf/71MvyRYrOzZRYH8hN6chOc+imlcJ8rwoU3L9p5V+RCbitQ4frcz046/
 ieuHtSyvUpkevr6jW18uFcc5+xoWLXv9n7xUN7gdbTn+D0yLW7kOosEa91urc5+Qo3jzQ7/h8
 BDJJ0rGgsSc5ice+taX1NehEml5ilolHenm6OLcM4yUPQSIoMGHi+r0X5tfEf5gsSBDAk90t9
 r/Dn91CkcCYfzHs3odkPpOxXdiMb4vA0FHzXVyLbQmXmFq1PhY1/VuVz3JpxBxcLIzozXdq2N
 Iu0T4c6j1uPYCv+7oVcczjJs/DASAhv5lP73xU8seZj1jtEj0PqbJt3XSbBF9sYZV7D+VKUEQ
 wq1xUxxEZ7MoEBCDDd1fgQikdup2FLeRJEu9HLWgnadokkHw+AOkxcPqEikltS6DnOS/MhI5c
 H3ul1FfUQL8y0445YtvHn4s2OcnNel9AxEZyVF5gvnTwcpNqQ8QiTwR16v6jsiAuRJ3k6CGuw
 W+D6rQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git ls-tree has two prefixes: The one handed to cmd_ls_tree(), i.e. the
current subdirectory in the repository (if any) and the "display" prefix
used by the show_tree_*() functions.  The option --full-name clears the
last one, i.e. it shows full paths, and --full-tree clears both, i.e. it
acts as if the command was started in the root of the repository.

The show_tree_*() functions use the ls_tree_options members chomp_prefix
and ls_tree_prefix to determine their prefix values.  Calculate it once
in cmd_ls_tree() instead, once the main prefix value is finalized.

This allows chomp_prefix to become a local variable.  Stop using
strlen(3) to determine its initial value -- we only care whether we got
a non-empty string, not precisely how long it is.

Rename ls_tree_prefix to prefix to demonstrate that we converted all
users and because the ls_tree_ part is no longer necessary since
030a3d5d9e (ls-tree: use a "struct options", 2023-01-12) turned it from
a global variable to a struct member.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/ls-tree.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 7a062e2b67..53073d64cb 100644
=2D-- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -50,8 +50,7 @@ struct ls_tree_options {
 		LS_SHOW_TREES =3D 1 << 2,
 	} ls_options;
 	struct pathspec pathspec;
-	int chomp_prefix;
-	const char *ls_tree_prefix;
+	const char *prefix;
 	const char *format;
 };

@@ -128,8 +127,7 @@ static int show_tree_fmt(const struct object_id *oid, =
struct strbuf *base,
 			strbuf_add_unique_abbrev(&sb, oid, options->abbrev);
 		else if (skip_prefix(format, "(path)", &format)) {
 			const char *name;
-			const char *prefix =3D options->chomp_prefix ?
-					     options->ls_tree_prefix : NULL;
+			const char *prefix =3D options->prefix;
 			struct strbuf sbuf =3D STRBUF_INIT;
 			size_t baselen =3D base->len;

@@ -173,7 +171,7 @@ static void show_tree_common_default_long(struct ls_tr=
ee_options *options,
 					  const char *pathname,
 					  const size_t baselen)
 {
-	const char *prefix =3D options->chomp_prefix ? options->ls_tree_prefix :=
 NULL;
+	const char *prefix =3D options->prefix;

 	strbuf_addstr(base, pathname);

@@ -258,7 +256,7 @@ static int show_tree_name_only(const struct object_id =
*oid, struct strbuf *base,
 	if (early >=3D 0)
 		return early;

-	prefix =3D options->chomp_prefix ? options->ls_tree_prefix : NULL;
+	prefix =3D options->prefix;
 	strbuf_addstr(base, pathname);
 	if (options->null_termination) {
 		struct strbuf sb =3D STRBUF_INIT;
@@ -345,6 +343,7 @@ int cmd_ls_tree(int argc, const char **argv, const cha=
r *prefix)
 	struct object_id oid;
 	struct tree *tree;
 	int i, full_tree =3D 0;
+	int chomp_prefix =3D prefix && *prefix;
 	read_tree_fn_t fn =3D NULL;
 	enum ls_tree_cmdmode cmdmode =3D MODE_DEFAULT;
 	int null_termination =3D 0;
@@ -366,7 +365,7 @@ int cmd_ls_tree(int argc, const char **argv, const cha=
r *prefix)
 			    MODE_NAME_STATUS),
 		OPT_CMDMODE(0, "object-only", &cmdmode, N_("list only objects"),
 			    MODE_OBJECT_ONLY),
-		OPT_SET_INT(0, "full-name", &options.chomp_prefix,
+		OPT_SET_INT(0, "full-name", &chomp_prefix,
 			    N_("use full path names"), 0),
 		OPT_BOOL(0, "full-tree", &full_tree,
 			 N_("list entire tree; not just current directory "
@@ -381,18 +380,15 @@ int cmd_ls_tree(int argc, const char **argv, const c=
har *prefix)
 	int ret;

 	git_config(git_default_config, NULL);
-	options.ls_tree_prefix =3D prefix;
-	if (prefix)
-		options.chomp_prefix =3D strlen(prefix);

 	argc =3D parse_options(argc, argv, prefix, ls_tree_options,
 			     ls_tree_usage, 0);
 	options.null_termination =3D null_termination;

-	if (full_tree) {
-		options.ls_tree_prefix =3D prefix =3D NULL;
-		options.chomp_prefix =3D 0;
-	}
+	if (full_tree)
+		prefix =3D NULL;
+	options.prefix =3D chomp_prefix ? prefix : NULL;
+
 	/*
 	 * We wanted to detect conflicts between --name-only and
 	 * --name-status, but once we're done with that subsequent
=2D-
2.41.0
