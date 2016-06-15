From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 15/25] fetch: define shallow boundary with --shallow-since
Date: Tue, 23 Feb 2016 20:44:53 +0700
Message-ID: <1456235103-26317-16-git-send-email-pclouds@gmail.com>
References: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 14:46:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYDIM-0000k6-3N
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 14:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbcBWNqZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 08:46:25 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35371 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbcBWNqV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 08:46:21 -0500
Received: by mail-pf0-f177.google.com with SMTP id c10so116391541pfc.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 05:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vlLiOD1K8fWPVZUUc78IpkOye0XzJrd4ImplVbzwUkw=;
        b=NTGraAGstKm1ntdjuYg6J/8M66b8gEG4y7dxQ15SwgqDXbwKo2qv6KhYxpY8FIHbZt
         XLA4vC2D+CLdoY9rFgVjnSQrG3YSRhI91J1FSH4shSM1UJGfe7JWb9VUwWxp46b3gQjp
         MSqb6G84iCxROQva2cS9TsmIHB56eGPGDWB5K7jQIhdS3Y0rqtW2XSShZ26U5BG9Yg/D
         24LHW43O2W5/vfrriQCiSKRnjMVUhPVVejYzuPKrdvfhfyjYAR2e8K7r2I5x6G/C35pl
         Zi1yRkVs8kbOWgX3vufa6rkIRfF5P+UikEW/U2xd99egx0zLJYfFxwTnQt/FYWK5B0RF
         MG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=vlLiOD1K8fWPVZUUc78IpkOye0XzJrd4ImplVbzwUkw=;
        b=izy5jDFJbX5kl+FRThbk5TpqyAyjG75HQ1Zp92gi2qWIsQnRxyxKk/yPLLVtzAl5a5
         E2nCI2rwoBdftwRhjO/dIWUJZtI+HbzuF3hCHrxoqiYx0Jklk03QP68ZlTacr2hyX9a0
         Nv5J+OjJp6i2ONTy1K8/Ed/dJocRO3EHv2KMFJz1Evjqu0Q2IP67jXeZGKKwzj6j/9th
         Xj3u8FVW0Sd2V5n5FZGt0vU4PGthRjrH2jIT7n5Oz4TUt+4MNRj31UKd+t/m0n4MjMSN
         DaZSV8RFLR6kGPSNWvN/kN+HD+awSk1bPOtIARZyJM3YuBqo/t668JHU5fiEOnDsyfsR
         S/OQ==
X-Gm-Message-State: AG10YORqQC5Q1TYhcUd3FhAQuSsrqPHyrfSNUWJyAXLXlwPPFl8ZcZDo2upoFjmChjSTrw==
X-Received: by 10.98.0.11 with SMTP id 11mr46401159pfa.5.1456235181556;
        Tue, 23 Feb 2016 05:46:21 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id kw10sm44796235pab.0.2016.02.23.05.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 05:46:19 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 23 Feb 2016 20:46:50 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
In-Reply-To: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287065>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/fetch-options.txt     |  4 ++++
 Documentation/git-fetch-pack.txt    |  4 ++++
 Documentation/gitremote-helpers.txt |  3 +++
 builtin/fetch-pack.c                |  4 ++++
 builtin/fetch.c                     | 29 +++++++++++++++++++++++------
 fetch-pack.c                        | 12 +++++++++++-
 fetch-pack.h                        |  1 +
 remote-curl.c                       | 11 +++++++++--
 transport.c                         |  4 ++++
 transport.h                         |  4 ++++
 10 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index 952dfdf..8738d3d 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -14,6 +14,10 @@
 	linkgit:git-clone[1]), deepen or shorten the history to the specified
 	number of commits. Tags for the deepened commits are not fetched.
=20
+--shallow-since=3D<date>::
+	Deepen or shorten the history of a shallow repository to
+	include all reachable commits after <date>.
+
 --unshallow::
 	If the source repository is complete, convert a shallow
 	repository to a complete one, removing all the limitations
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch=
-pack.txt
index 8680f45..99e6257 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -87,6 +87,10 @@ be in a separate packet, and the list must end with =
a flush packet.
 	'git-upload-pack' treats the special depth 2147483647 as
 	infinite even if there is an ancestor-chain that long.
=20
+--shallow-since=3D<date>::
+	Deepen or shorten the history of a shallow'repository to
+	include all reachable commits after <date>.
+
 --no-progress::
 	Do not show the progress.
=20
diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitrem=
ote-helpers.txt
index 78e0b27..9971d9a 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -415,6 +415,9 @@ set by Git if the remote helper has the 'option' ca=
pability.
 'option depth' <depth>::
 	Deepens the history of a shallow repository.
=20
+'option deepen-since <timestamp>::
+	Deepens the history of a shallow repository based on time.
+
 'option followtags' {'true'|'false'}::
 	If enabled the helper should automatically fetch annotated
 	tag objects if the object the tag points at was transferred
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 8332d3d..0402e27 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -104,6 +104,10 @@ int cmd_fetch_pack(int argc, const char **argv, co=
nst char *prefix)
 			args.depth =3D strtol(arg, NULL, 0);
 			continue;
 		}
+		if (skip_prefix(arg, "--shallow-since=3D", &arg)) {
+			args.deepen_since =3D xstrdup(arg);
+			continue;
+		}
 		if (!strcmp("--no-progress", arg)) {
 			args.no_progress =3D 1;
 			continue;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8e74213..283aa95 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -36,9 +36,10 @@ static int prune =3D -1; /* unspecified */
=20
 static int all, append, dry_run, force, keep, multiple, update_head_ok=
, verbosity;
 static int progress =3D -1, recurse_submodules =3D RECURSE_SUBMODULES_=
DEFAULT;
-static int tags =3D TAGS_DEFAULT, unshallow, update_shallow;
+static int tags =3D TAGS_DEFAULT, unshallow, update_shallow, deepen;
 static int max_children =3D 1;
 static const char *depth;
+static const char *deepen_since;
 static const char *upload_pack;
 static struct strbuf default_rla =3D STRBUF_INIT;
 static struct transport *gtransport;
@@ -115,6 +116,8 @@ static struct option builtin_fetch_options[] =3D {
 	OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
 	OPT_STRING(0, "depth", &depth, N_("depth"),
 		   N_("deepen history of shallow clone")),
+	OPT_STRING(0, "shallow-since", &deepen_since, N_("time"),
+		   N_("deepen history of shallow repository based on time")),
 	{ OPTION_SET_INT, 0, "unshallow", &unshallow, NULL,
 		   N_("convert to a complete repository"),
 		   PARSE_OPT_NONEG | PARSE_OPT_NOARG, NULL, 1 },
@@ -754,7 +757,7 @@ static int quickfetch(struct ref *ref_map)
 	 * really need to perform.  Claiming failure now will ensure
 	 * we perform the network exchange to deepen our history.
 	 */
-	if (depth)
+	if (deepen)
 		return -1;
 	return check_everything_connected(iterate_ref_map, 1, &rm);
 }
@@ -859,7 +862,7 @@ static void set_option(struct transport *transport,=
 const char *name, const char
 			name, transport->url);
 }
=20
-static struct transport *prepare_transport(struct remote *remote)
+static struct transport *prepare_transport(struct remote *remote, int =
deepen)
 {
 	struct transport *transport;
 	transport =3D transport_get(remote, NULL);
@@ -870,6 +873,8 @@ static struct transport *prepare_transport(struct r=
emote *remote)
 		set_option(transport, TRANS_OPT_KEEP, "yes");
 	if (depth)
 		set_option(transport, TRANS_OPT_DEPTH, depth);
+	if (deepen && deepen_since)
+		set_option(transport, TRANS_OPT_DEEPEN_SINCE, deepen_since);
 	if (update_shallow)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
 	return transport;
@@ -877,8 +882,18 @@ static struct transport *prepare_transport(struct =
remote *remote)
=20
 static void backfill_tags(struct transport *transport, struct ref *ref=
_map)
 {
-	if (transport->cannot_reuse) {
-		gsecondary =3D prepare_transport(transport->remote);
+	int cannot_reuse;
+
+	/*
+	 * Once we have set TRANS_OPT_DEEPEN_SINCE, we can't unset it
+	 * when remote helper is used (setting it to an empty string
+	 * is not unsetting). We could extend the remote helper
+	 * protocol for that, but for now, just force a new connection
+	 * without deepen-since.
+	 */
+	cannot_reuse =3D transport->cannot_reuse || deepen_since;
+	if (cannot_reuse) {
+		gsecondary =3D prepare_transport(transport->remote, 0);
 		transport =3D gsecondary;
 	}
=20
@@ -1095,7 +1110,7 @@ static int fetch_one(struct remote *remote, int a=
rgc, const char **argv)
 		die(_("No remote repository specified.  Please, specify either a URL=
 or a\n"
 		    "remote name from which new revisions should be fetched."));
=20
-	gtransport =3D prepare_transport(remote);
+	gtransport =3D prepare_transport(remote, 1);
=20
 	if (prune < 0) {
 		/* no command line request */
@@ -1167,6 +1182,8 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
 	/* no need to be strict, transport_set_option() will validate it agai=
n */
 	if (depth && atoi(depth) < 1)
 		die(_("depth %s is not a positive number"), depth);
+	if (depth || deepen_since)
+		deepen =3D 1;
=20
 	if (recurse_submodules !=3D RECURSE_SUBMODULES_OFF) {
 		if (recurse_submodules_default) {
diff --git a/fetch-pack.c b/fetch-pack.c
index 8c37e5f..c57231b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -21,6 +21,7 @@ static int fetch_unpack_limit =3D -1;
 static int unpack_limit =3D 100;
 static int prefer_ofs_delta =3D 1;
 static int no_done;
+static int deepen_since_ok;
 static int fetch_fsck_objects =3D -1;
 static int transfer_fsck_objects =3D -1;
 static int agent_supported;
@@ -326,6 +327,7 @@ static int find_common(struct fetch_pack_args *args=
,
 			if (args->no_progress)   strbuf_addstr(&c, " no-progress");
 			if (args->include_tag)   strbuf_addstr(&c, " include-tag");
 			if (prefer_ofs_delta)   strbuf_addstr(&c, " ofs-delta");
+			if (deepen_since_ok)    strbuf_addstr(&c, " deepen-since");
 			if (agent_supported)    strbuf_addf(&c, " agent=3D%s",
 							    git_user_agent_sanitized());
 			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
@@ -345,6 +347,10 @@ static int find_common(struct fetch_pack_args *arg=
s,
 		write_shallow_commits(&req_buf, 1, NULL);
 	if (args->depth > 0)
 		packet_buf_write(&req_buf, "deepen %d", args->depth);
+	if (args->deepen_since) {
+		unsigned long max_age =3D approxidate(args->deepen_since);
+		packet_buf_write(&req_buf, "deepen-since %lu", max_age);
+	}
 	packet_buf_flush(&req_buf);
 	state_len =3D req_buf.len;
=20
@@ -813,7 +819,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
=20
 	if ((args->depth > 0 || is_repository_shallow()) && !server_supports(=
"shallow"))
 		die("Server does not support shallow clients");
-	if (args->depth > 0)
+	if (args->depth > 0 || args->deepen_since)
 		args->deepen =3D 1;
 	if (server_supports("multi_ack_detailed")) {
 		print_verbose(args, "Server supports multi_ack_detailed");
@@ -861,6 +867,10 @@ static struct ref *do_fetch_pack(struct fetch_pack=
_args *args,
 			print_verbose(args, "Server version is %.*s",
 				      agent_len, agent_feature);
 	}
+	if (server_supports("deepen-since"))
+		deepen_since_ok =3D 1;
+	else if (args->deepen_since)
+		die("Server does not support --shallow-since");
=20
 	if (everything_local(args, &ref, sought, nr_sought)) {
 		packet_flush(fd[1]);
diff --git a/fetch-pack.h b/fetch-pack.h
index 4d0adb0..f7eadb2 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -10,6 +10,7 @@ struct fetch_pack_args {
 	const char *uploadpack;
 	int unpacklimit;
 	int depth;
+	const char *deepen_since;
 	unsigned quiet:1;
 	unsigned keep_pack:1;
 	unsigned lock_pack:1;
diff --git a/remote-curl.c b/remote-curl.c
index 4289c20..ffa4faa 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -20,6 +20,7 @@ static struct strbuf url =3D STRBUF_INIT;
 struct options {
 	int verbosity;
 	unsigned long depth;
+	char *deepen_since;
 	unsigned progress : 1,
 		check_self_contained_and_connected : 1,
 		cloning : 1,
@@ -60,6 +61,10 @@ static int set_option(const char *name, const char *=
value)
 		options.depth =3D v;
 		return 0;
 	}
+	else if (!strcmp(name, "deepen-since")) {
+		options.deepen_since =3D xstrdup(value);
+		return 0;
+	}
 	else if (!strcmp(name, "followtags")) {
 		if (!strcmp(value, "true"))
 			options.followtags =3D 1;
@@ -699,8 +704,8 @@ static int fetch_dumb(int nr_heads, struct ref **to=
_fetch)
 	char **targets =3D xmalloc(nr_heads * sizeof(char*));
 	int ret, i;
=20
-	if (options.depth)
-		die("dumb http transport does not support --depth");
+	if (options.depth || options.deepen_since)
+		die("dumb http transport does not support shallow capabilities");
 	for (i =3D 0; i < nr_heads; i++)
 		targets[i] =3D xstrdup(oid_to_hex(&to_fetch[i]->old_oid));
=20
@@ -749,6 +754,8 @@ static int fetch_git(struct discovery *heads,
 		argv_array_push(&args, "--no-progress");
 	if (options.depth)
 		argv_array_pushf(&args, "--depth=3D%lu", options.depth);
+	if (options.deepen_since)
+		argv_array_pushf(&args, "--shallow-since=3D%s", options.deepen_since=
);
 	argv_array_push(&args, url.buf);
=20
 	for (i =3D 0; i < nr_heads; i++) {
diff --git a/transport.c b/transport.c
index c92f8ae..f04a302 100644
--- a/transport.c
+++ b/transport.c
@@ -151,6 +151,9 @@ static int set_git_option(struct git_transport_opti=
ons *opts,
 				die("transport: invalid depth option '%s'", value);
 		}
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_DEEPEN_SINCE)) {
+		opts->deepen_since =3D value;
+		return 0;
 	}
 	return 1;
 }
@@ -205,6 +208,7 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
 	args.quiet =3D (transport->verbose < 0);
 	args.no_progress =3D !transport->progress;
 	args.depth =3D data->options.depth;
+	args.deepen_since =3D data->options.deepen_since;
 	args.check_self_contained_and_connected =3D
 		data->options.check_self_contained_and_connected;
 	args.cloning =3D transport->cloning;
diff --git a/transport.h b/transport.h
index 8ebaaf2..9c10a44 100644
--- a/transport.h
+++ b/transport.h
@@ -13,6 +13,7 @@ struct git_transport_options {
 	unsigned self_contained_and_connected : 1;
 	unsigned update_shallow : 1;
 	int depth;
+	const char *deepen_since;
 	const char *uploadpack;
 	const char *receivepack;
 	struct push_cas_option *cas;
@@ -171,6 +172,9 @@ int transport_restrict_protocols(void);
 /* Limit the depth of the fetch if not null */
 #define TRANS_OPT_DEPTH "depth"
=20
+/* Limit the depth of the fetch based on time if not null */
+#define TRANS_OPT_DEEPEN_SINCE "deepen-since"
+
 /* Aggressively fetch annotated tags if possible */
 #define TRANS_OPT_FOLLOWTAGS "followtags"
=20
--=20
2.7.1.532.gd9e3aaa
