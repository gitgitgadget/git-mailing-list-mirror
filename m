From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 26/26] fetch, upload-pack: --deepen=N extends shallow boundary by N commits
Date: Wed, 13 Apr 2016 19:55:10 +0700
Message-ID: <1460552110-5554-27-git-send-email-pclouds@gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Dongcan Jiang <dongcan.jiang@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:57:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKMW-0004n9-O7
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758232AbcDMM5e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 08:57:34 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35031 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757586AbcDMM5c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:57:32 -0400
Received: by mail-pa0-f68.google.com with SMTP id zy2so3924644pac.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BwDsTlHYo+/ouUMluC07Eb1rPwADje2DAzEuk3R/Mw8=;
        b=hAn3TBOHPQ0FTs+e3VsitRpQtInb6+PRkFUhWuEjVJrWR3dYvOa9xrJrVsa6AOWhLN
         6qQHDHs2lFSgp+6WD8ZaCMZVqJy95ob8/DIxFAtSxvaHs7TQRHC6MJpyGenUWxh221B/
         RWNKRH4IOjHE/Ezb95jTQm8jo5MIXlGYEKasEftk4SUpIty3YWuqabn6Rhx292U/4kVd
         XKmdXkwZ9IUhYQQZwYkhCUPyVGnQfB524Z/CgknA8xTVkuEIRsAckDcZi6Yi5JnnSHdf
         JgHAxgm9CvQIDNmNiFxRQ1srp510oSN14MVY5FcHj2woWMS3kWeW5iZlYLld2/sh0b14
         rQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BwDsTlHYo+/ouUMluC07Eb1rPwADje2DAzEuk3R/Mw8=;
        b=UNTA4sDI//R1+a7/CF5PgAgW2kCPSBVzaVq+qG4ges3saSvMxio3qma+jUCtCYLqQ4
         CwIK44/Yb5fagvbbyE7rTqR5q+onMdbTuTSKOvJ8z/6WKGZE6a+Mbpp5ftxeuWAVQ7Z6
         gtxrTWUWsU3a7Uush09vy8JSM3OKV5AJ3ahbzp2juyi7SMZRAVGOZxY38l8xzfHLDg+D
         D8PMx2js77usc+xJ+3taBt/DwC8/66tgd6vs5JlEnLWUR+SFQ3/HHV87Qf+tgIGNn7bP
         xwlitk+/Dl2YzE7YsplIeEkFmWaAMNJoWlqA5F2NDkAzsJao6zwczGNpoAVO07mGbOzu
         elRg==
X-Gm-Message-State: AOPr4FXhAVXlCdH8HWKPa7XR9rN9CM1WCV9H/djeR9Lwf0JrsyNV3zN+9fNTw9oYs2TNpQ==
X-Received: by 10.66.229.1 with SMTP id sm1mr10503670pac.26.1460552252030;
        Wed, 13 Apr 2016 05:57:32 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id l11sm51035345pfb.56.2016.04.13.05.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 05:57:30 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 19:57:37 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291420>

In git-fetch, --depth argument is always relative with the latest
remote refs. This makes it a bit difficult to cover this use case,
where the user wants to make the shallow history, say 3 levels
deeper. It would work if remote refs have not moved yet, but nobody
can guarantee that, especially when that use case is performed a
couple months after the last clone or "git fetch --depth". Also,
modifying shallow boundary using --depth does not work well with
clones created by --since or --not.

This patch fixes that. A new argument --deepen=3D<N> will add <N> more =
(*)
parent commits to the current history regardless of where remote refs
are.

Have/Want negotiation is still respected. So if remote refs move, the
server will send two chunks: one between "have" and "want" and another
to extend shallow history. In theory, the client could send no "want"s
in order to get the second chunk only. But the protocol does not allow
that. Either you send no want lines, which means ls-remote; or you
have to send at least one want line that carries deep-relative to the
server..

The main work was done by Dongcan Jiang. I fixed it up here and there.
And of course all the bugs belong to me.

(*) We could even support --deepen=3D<N> where <N> is negative. In that
case we can cut some history from the shallow clone. This operation
(and --depth=3D<shorter depth>) does not require interaction with remot=
e
side (and more complicated to implement as a result).

Helped-by: Duy Nguyen <pclouds@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Dongcan Jiang <dongcan.jiang@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/fetch-options.txt                   |  5 +++++
 Documentation/git-fetch-pack.txt                  |  5 +++++
 Documentation/gitremote-helpers.txt               |  4 ++++
 Documentation/technical/protocol-capabilities.txt |  7 ++++++
 builtin/fetch-pack.c                              |  4 ++++
 builtin/fetch.c                                   | 14 +++++++++++-
 fetch-pack.c                                      |  3 +++
 fetch-pack.h                                      |  1 +
 remote-curl.c                                     | 14 +++++++++++-
 t/t5500-fetch-pack.sh                             | 23 +++++++++++++++=
+++++
 t/t5539-fetch-http-shallow.sh                     | 26 +++++++++++++++=
++++++++
 transport-helper.c                                |  1 +
 transport.c                                       |  4 ++++
 transport.h                                       |  4 ++++
 upload-pack.c                                     | 21 +++++++++++++--=
---
 15 files changed, 129 insertions(+), 7 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index 7aa1285..3b91f15 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -14,6 +14,11 @@
 	linkgit:git-clone[1]), deepen or shorten the history to the specified
 	number of commits. Tags for the deepened commits are not fetched.
=20
+--deepen=3D<depth>::
+	Similar to --depth, except it specifies the number of commits
+	from the current shallow boundary instead of from the tip of
+	each remote branch history.
+
 --shallow-since=3D<date>::
 	Deepen or shorten the history of a shallow repository to
 	include all reachable commits after <date>.
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch=
-pack.txt
index 4d15b04..c20958f 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -96,6 +96,11 @@ be in a separate packet, and the list must end with =
a flush packet.
 	exclude commits reachable from a specified remote branch or tag.
 	This option can be specified multiple times.
=20
+--deepen-relative::
+	Argument --depth specifies the number of commits from the
+	current shallow boundary instead of from the tip of each
+	remote branch history.
+
 --no-progress::
 	Do not show the progress.
=20
diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitrem=
ote-helpers.txt
index 75bb638..6fca268 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -422,6 +422,10 @@ set by Git if the remote helper has the 'option' c=
apability.
 	Deepens the history of a shallow repository excluding ref.
 	Multiple options add up.
=20
+'option deepen-relative {'true'|'false'}::
+	Deepens the history of a shallow repository relative to
+	current boundary. Only valid when used with "option depth".
+
 'option followtags' {'true'|'false'}::
 	If enabled the helper should automatically fetch annotated
 	tag objects if the object the tag points at was transferred
diff --git a/Documentation/technical/protocol-capabilities.txt b/Docume=
ntation/technical/protocol-capabilities.txt
index 0e6b57d..4fd6dcc 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -197,6 +197,13 @@ specific revision, instead of depth. Internally it=
's equivalent of
 doing "rev-list --not <rev>" on the server side. "deepen-not"
 cannot be used with "deepen", but can be used with "deepen-since".
=20
+deepen-relative
+---------------
+
+If this capability is requested by the client, the semantics of
+"deepen" command is changed. The "depth" argument is the depth from
+the current shallow boundary, instead of the depth from remote refs.
+
 no-progress
 -----------
=20
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 07570be..8265348 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -113,6 +113,10 @@ int cmd_fetch_pack(int argc, const char **argv, co=
nst char *prefix)
 			string_list_append(&deepen_not, arg);
 			continue;
 		}
+		if (!strcmp(arg, "--deepen-relative")) {
+			args.deepen_relative =3D 1;
+			continue;
+		}
 		if (!strcmp("--no-progress", arg)) {
 			args.no_progress =3D 1;
 			continue;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 154b9ad..68b44ba 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -34,7 +34,7 @@ static int fetch_prune_config =3D -1; /* unspecified =
*/
 static int prune =3D -1; /* unspecified */
 #define PRUNE_BY_DEFAULT 0 /* do we prune by default? */
=20
-static int all, append, dry_run, force, keep, multiple, update_head_ok=
, verbosity;
+static int all, append, dry_run, force, keep, multiple, update_head_ok=
, verbosity, deepen_relative;
 static int progress =3D -1, recurse_submodules =3D RECURSE_SUBMODULES_=
DEFAULT;
 static int tags =3D TAGS_DEFAULT, unshallow, update_shallow, deepen;
 static int max_children =3D 1;
@@ -129,6 +129,8 @@ static struct option builtin_fetch_options[] =3D {
 	{ OPTION_CALLBACK, 0, "shallow-exclude", NULL, N_("revision"),
 		    N_("deepen history of shallow clone by excluding rev"),
 		    PARSE_OPT_NONEG, option_parse_deepen_not },
+	OPT_INTEGER(0, "deepen", &deepen_relative,
+		    N_("deepen history of shallow clone")),
 	{ OPTION_SET_INT, 0, "unshallow", &unshallow, NULL,
 		   N_("convert to a complete repository"),
 		   PARSE_OPT_NONEG | PARSE_OPT_NOARG, NULL, 1 },
@@ -889,6 +891,8 @@ static struct transport *prepare_transport(struct r=
emote *remote, int deepen)
 	if (deepen && deepen_not.nr)
 		set_option(transport, TRANS_OPT_DEEPEN_NOT,
 			   (const char *)&deepen_not);
+	if (deepen_relative)
+		set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, "yes");
 	if (update_shallow)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
 	return transport;
@@ -914,6 +918,7 @@ static void backfill_tags(struct transport *transpo=
rt, struct ref *ref_map)
=20
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
+	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
 	fetch_refs(transport, ref_map);
=20
 	if (gsecondary) {
@@ -1185,6 +1190,13 @@ int cmd_fetch(int argc, const char **argv, const=
 char *prefix)
 	argc =3D parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
=20
+	if (deepen_relative) {
+		if (deepen_relative < 0)
+			die(_("Negative depth in --deepen is not supported"));
+		if (depth)
+			die(_("--deepen and --depth are mutually exclusive"));
+		depth =3D xstrfmt("%d", deepen_relative);
+	}
 	if (unshallow) {
 		if (depth)
 			die(_("--depth and --unshallow cannot be used together"));
diff --git a/fetch-pack.c b/fetch-pack.c
index ad7d00f..e2a235f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -324,6 +324,7 @@ static int find_common(struct fetch_pack_args *args=
,
 			if (no_done)            strbuf_addstr(&c, " no-done");
 			if (use_sideband =3D=3D 2)  strbuf_addstr(&c, " side-band-64k");
 			if (use_sideband =3D=3D 1)  strbuf_addstr(&c, " side-band");
+			if (args->deepen_relative) strbuf_addstr(&c, " deepen-relative");
 			if (args->use_thin_pack) strbuf_addstr(&c, " thin-pack");
 			if (args->no_progress)   strbuf_addstr(&c, " no-progress");
 			if (args->include_tag)   strbuf_addstr(&c, " include-tag");
@@ -883,6 +884,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
 		deepen_not_ok =3D 1;
 	else if (args->deepen_not)
 		die(_("Server does not support --shallow-exclude"));
+	if (!server_supports("deepen-relative") && args->deepen_relative)
+		die(_("Server does not support --deepen"));
=20
 	if (everything_local(args, &ref, sought, nr_sought)) {
 		packet_flush(fd[1]);
diff --git a/fetch-pack.h b/fetch-pack.h
index 144301f..c912e3d 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -12,6 +12,7 @@ struct fetch_pack_args {
 	int depth;
 	const char *deepen_since;
 	const struct string_list *deepen_not;
+	unsigned deepen_relative:1;
 	unsigned quiet:1;
 	unsigned keep_pack:1;
 	unsigned lock_pack:1;
diff --git a/remote-curl.c b/remote-curl.c
index 71122ac..3f1a8f5 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -30,7 +30,8 @@ struct options {
 		dry_run : 1,
 		thin : 1,
 		/* One of the SEND_PACK_PUSH_CERT_* constants. */
-		push_cert : 2;
+		push_cert : 2,
+		deepen_relative : 1;
 };
 static struct options options;
 static struct string_list cas_options =3D STRING_LIST_INIT_DUP;
@@ -70,6 +71,15 @@ static int set_option(const char *name, const char *=
value)
 		string_list_append(&options.deepen_not, value);
 		return 0;
 	}
+	else if (!strcmp(name, "deepen-relative")) {
+		if (!strcmp(value, "true"))
+			options.deepen_relative =3D 1;
+		else if (!strcmp(value, "false"))
+			options.deepen_relative =3D 0;
+		else
+			return -1;
+		return 0;
+	}
 	else if (!strcmp(name, "followtags")) {
 		if (!strcmp(value, "true"))
 			options.followtags =3D 1;
@@ -764,6 +774,8 @@ static int fetch_git(struct discovery *heads,
 	for (i =3D 0; i < options.deepen_not.nr; i++)
 		argv_array_pushf(&args, "--shallow-exclude=3D%s",
 				 options.deepen_not.items[i].string);
+	if (options.deepen_relative && options.depth)
+		argv_array_push(&args, "--deepen-relative");
 	argv_array_push(&args, url.buf);
=20
 	for (i =3D 0; i < nr_heads; i++) {
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index a3fe5ca..f512098 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -683,4 +683,27 @@ test_expect_success 'fetch exclude tag one' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'fetching deepen' '
+	test_create_repo shallow-deepen &&
+	(
+	cd shallow-deepen &&
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+	git clone --depth 1 "file://$(pwd)/." deepen &&
+	test_commit four &&
+	git -C deepen log --pretty=3Dtformat:%s master >actual &&
+	echo three >expected &&
+	test_cmp expected actual &&
+	git -C deepen fetch --deepen=3D1 &&
+	git -C deepen log --pretty=3Dtformat:%s origin/master >actual &&
+	cat >expected <<-\EOF &&
+	four
+	three
+	two
+	EOF
+	test_cmp expected actual
+	)
+'
+
 test_done
diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow=
=2Esh
index f71573d..25f8968 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -121,5 +121,31 @@ test_expect_success 'fetch exclude tag one' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'fetching deepen' '
+	test_create_repo shallow-deepen &&
+	(
+	cd shallow-deepen &&
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+	mv .git "$HTTPD_DOCUMENT_ROOT_PATH/shallow-deepen.git" &&
+	git clone --depth 1 $HTTPD_URL/smart/shallow-deepen.git deepen &&
+	mv "$HTTPD_DOCUMENT_ROOT_PATH/shallow-deepen.git" .git &&
+	test_commit four &&
+	git -C deepen log --pretty=3Dtformat:%s master >actual &&
+	echo three >expected &&
+	test_cmp expected actual &&
+	mv .git "$HTTPD_DOCUMENT_ROOT_PATH/shallow-deepen.git" &&
+	git -C deepen fetch --deepen=3D1 &&
+	git -C deepen log --pretty=3Dtformat:%s origin/master >actual &&
+	cat >expected <<-\EOF &&
+	four
+	three
+	two
+	EOF
+	test_cmp expected actual
+	)
+'
+
 stop_httpd
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index d644568..b894b60 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -258,6 +258,7 @@ static const char *boolean_options[] =3D {
 	TRANS_OPT_THIN,
 	TRANS_OPT_KEEP,
 	TRANS_OPT_FOLLOWTAGS,
+	TRANS_OPT_DEEPEN_RELATIVE
 	};
=20
 static int strbuf_set_helper_option(struct helper_data *data,
diff --git a/transport.c b/transport.c
index 3e6f3aa..3e76a9a 100644
--- a/transport.c
+++ b/transport.c
@@ -157,6 +157,9 @@ static int set_git_option(struct git_transport_opti=
ons *opts,
 	} else if (!strcmp(name, TRANS_OPT_DEEPEN_NOT)) {
 		opts->deepen_not =3D (const struct string_list *)value;
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_DEEPEN_RELATIVE)) {
+		opts->deepen_relative =3D !!value;
+		return 0;
 	}
 	return 1;
 }
@@ -213,6 +216,7 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
 	args.depth =3D data->options.depth;
 	args.deepen_since =3D data->options.deepen_since;
 	args.deepen_not =3D data->options.deepen_not;
+	args.deepen_relative =3D data->options.deepen_relative;
 	args.check_self_contained_and_connected =3D
 		data->options.check_self_contained_and_connected;
 	args.cloning =3D transport->cloning;
diff --git a/transport.h b/transport.h
index ab61932..bdc3518 100644
--- a/transport.h
+++ b/transport.h
@@ -14,6 +14,7 @@ struct git_transport_options {
 	unsigned check_self_contained_and_connected : 1;
 	unsigned self_contained_and_connected : 1;
 	unsigned update_shallow : 1;
+	unsigned deepen_relative : 1;
 	int depth;
 	const char *deepen_since;
 	const struct string_list *deepen_not;
@@ -181,6 +182,9 @@ int transport_restrict_protocols(void);
 /* Limit the depth of the fetch based on revs if not null */
 #define TRANS_OPT_DEEPEN_NOT "deepen-not"
=20
+/* Limit the deepen of the fetch if not null */
+#define TRANS_OPT_DEEPEN_RELATIVE "deepen-relative"
+
 /* Aggressively fetch annotated tags if possible */
 #define TRANS_OPT_FOLLOWTAGS "followtags"
=20
diff --git a/upload-pack.c b/upload-pack.c
index 9bd590c..18b914a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -32,6 +32,7 @@ static const char upload_pack_usage[] =3D "git upload=
-pack [--strict] [--timeout=3D<
=20
 static unsigned long oldest_have;
=20
+static int deepen_relative;
 static int multi_ack;
 static int no_done;
 static int use_thin_pack, use_ofs_delta, use_include_tag;
@@ -652,7 +653,8 @@ static void send_unshallow(const struct object_arra=
y *shallows)
 	}
 }
=20
-static void deepen(int depth, const struct object_array *shallows)
+static void deepen(int depth, int deepen_relative,
+		   struct object_array *shallows)
 {
 	struct commit_list *result =3D NULL;
 	int i;
@@ -661,7 +663,14 @@ static void deepen(int depth, const struct object_=
array *shallows)
 			struct object *object =3D shallows->objects[i].item;
 			object->flags |=3D NOT_SHALLOW;
 		}
-	else
+	else if (deepen_relative) {
+		struct object_array reachable_shallows =3D OBJECT_ARRAY_INIT;
+		get_reachable_list(shallows, &reachable_shallows);
+		result =3D get_shallow_commits(&reachable_shallows,
+					     depth + 1,
+					     SHALLOW, NOT_SHALLOW);
+		object_array_clear(&reachable_shallows);
+	} else
 		result =3D get_shallow_commits(&want_obj, depth,
 					     SHALLOW, NOT_SHALLOW);
 	send_shallow(result);
@@ -753,6 +762,8 @@ static void receive_needs(void)
=20
 		features =3D arg + 40;
=20
+		if (parse_feature_request(features, "deepen-relative"))
+			deepen_relative =3D 1;
 		if (parse_feature_request(features, "multi_ack_detailed"))
 			multi_ack =3D 2;
 		else if (parse_feature_request(features, "multi_ack"))
@@ -802,7 +813,7 @@ static void receive_needs(void)
 	if (depth > 0 && deepen_rev_list)
 		die("git upload-pack: deepen and deepen-since (or deepen-not) cannot=
 be used together");
 	if (depth > 0)
-		deepen(depth, &shallows);
+		deepen(depth, deepen_relative, &shallows);
 	else if (deepen_rev_list) {
 		struct argv_array av =3D ARGV_ARRAY_INIT;
 		int i;
@@ -873,8 +884,8 @@ static int send_ref(const char *refname, const stru=
ct object_id *oid,
 		    int flag, void *cb_data)
 {
 	static const char *capabilities =3D "multi_ack thin-pack side-band"
-		" side-band-64k ofs-delta shallow deepen-since deepen-not no-progres=
s"
-		" include-tag multi_ack_detailed";
+		" side-band-64k ofs-delta shallow deepen-since deepen-not"
+		" deepen-relative no-progress include-tag multi_ack_detailed";
 	const char *refname_nons =3D strip_namespace(refname);
 	struct object_id peeled;
=20
--=20
2.8.0.rc0.210.gd302cd2
