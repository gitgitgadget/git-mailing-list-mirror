Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AE62206FB
	for <e@80x24.org>; Sat,  9 Jul 2016 00:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932758AbcGIAbq (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 20:31:46 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35255 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756338AbcGIAbe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 20:31:34 -0400
Received: by mail-pf0-f174.google.com with SMTP id c2so17299088pfa.2
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 17:31:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rx5lO0n/b0im0lF8maytGxPmZxJqnC/Nr87ashI6+sk=;
        b=dHaGlo00KB5ZcFoR8jo+Tzq3DW0XPQ6xs4upEylRTeNrUiyreEURoUTQJWwpTdXT99
         FfgXCkc5jE/1T+uyFNmj300aDQWaAoCJTw9qjIe7wMKqN8q+fGIf4n+hlSenH/PJDHNA
         83XgNa8e/LvhApDL2fiZzs3LwiuI8jKfYpMs4orZgR545aETtxvy/olUkddvbWAkARQN
         PKuUKis+cFx4Oo+h4U87ShL9htOPoE6Fwx7YwnN/voUqbB796pu2uZ/H0+q0TOnR83dw
         Q6lNZV2ERTiLwM5+MfAjwmokvZVBNqTgt0VeocA09jflfx+VTKslI4/ebgDHvb59TWtk
         Myog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rx5lO0n/b0im0lF8maytGxPmZxJqnC/Nr87ashI6+sk=;
        b=hQdYiZNHP7KPhUEjZU1hP7p3bQmJGdegND3xX3McqNfBJMNFSAUDr49kvgplvKJk/6
         x0yf9dsXczyqwH9/IulDU9xtz2ZPlVUCUlBXI1nC9jQhsF3/xuZ4cueioYeloAL7QTHj
         V8W87tjL9jd/j0JW1RKAfPihtIPm+YUqbJM8kT4EqaTuPYvVhlNkBcwUQ/bd7UmJhgTN
         355Boe01KYtHL4DLflugc9h9lJyNsV/rkXsNIFD3jRwq2yNaouFVrvPZr+qTo6XA6/HH
         tLrg49jPNkLRUcgn69rjowHg55JQGXhEivDseRIosPERtrmizR+/v/UWCON+aOj/ycU7
         9SBQ==
X-Gm-Message-State: ALyK8tKDHSyls+QJZI1/zpI3kVXcRQ1Gs8sAomriPthxR3SkugbH1DYI4AA6XjRJ98SpJYKS
X-Received: by 10.98.64.4 with SMTP id n4mr12191923pfa.30.1468024287747;
        Fri, 08 Jul 2016 17:31:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ccd7:b4ac:db99:b698])
        by smtp.gmail.com with ESMTPSA id lf11sm6145439pab.17.2016.07.08.17.31.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 08 Jul 2016 17:31:27 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, e@80x24.org, peff@peff.net, dwwang@google.com,
	dennis@kaarsemaker.net, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/4] push: accept push options
Date:	Fri,  8 Jul 2016 17:31:12 -0700
Message-Id: <20160709003113.26930-4-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.247.g176c4f7
In-Reply-To: <20160709003113.26930-1-sbeller@google.com>
References: <20160709003113.26930-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This implements everything that is required on the client side to make use
of push options from the porcelain push command.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-push.txt |  8 +++++++-
 builtin/push.c             | 21 ++++++++++++++++++---
 send-pack.c                | 27 +++++++++++++++++++++++++++
 send-pack.h                |  3 +++
 transport.c                |  1 +
 transport.h                |  7 +++++++
 6 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 19f46b6..e960258 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git push' [--all | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [-d | --delete] [--prune] [-v | --verbose]
-	   [-u | --set-upstream]
+	   [-u | --set-upstream] [--push-option=<string>]
 	   [--[no-]signed|--sign=(true|false|if-asked)]
 	   [--force-with-lease[=<refname>[:<expect>]]]
 	   [--no-verify] [<repository> [<refspec>...]]
@@ -156,6 +156,12 @@ already exists on the remote side.
 	Either all refs are updated, or on error, no refs are updated.
 	If the server does not support atomic pushes the push will fail.
 
+-o::
+--push-option::
+	Transmit the given string to the server, which passes them to
+	the pre-receive as well as the post-receive hook. The given string
+	must not contain a NUL or LF character.
+
 --receive-pack=<git-receive-pack>::
 --exec=<git-receive-pack>::
 	Path to the 'git-receive-pack' program on the remote
diff --git a/builtin/push.c b/builtin/push.c
index 4e9e4db..3bb9d6b 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -353,7 +353,8 @@ static int push_with_options(struct transport *transport, int flags)
 	return 1;
 }
 
-static int do_push(const char *repo, int flags)
+static int do_push(const char *repo, int flags,
+		   const struct string_list *push_options)
 {
 	int i, errs;
 	struct remote *remote = pushremote_get(repo);
@@ -376,6 +377,9 @@ static int do_push(const char *repo, int flags)
 	if (remote->mirror)
 		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
 
+	if (push_options->nr)
+		flags |= TRANSPORT_PUSH_OPTIONS;
+
 	if ((flags & TRANSPORT_PUSH_ALL) && refspec) {
 		if (!strcmp(*refspec, "refs/tags/*"))
 			return error(_("--all and --tags are incompatible"));
@@ -406,13 +410,16 @@ static int do_push(const char *repo, int flags)
 		for (i = 0; i < url_nr; i++) {
 			struct transport *transport =
 				transport_get(remote, url[i]);
+			if (flags & TRANSPORT_PUSH_OPTIONS)
+				transport->push_options = push_options;
 			if (push_with_options(transport, flags))
 				errs++;
 		}
 	} else {
 		struct transport *transport =
 			transport_get(remote, NULL);
-
+		if (flags & TRANSPORT_PUSH_OPTIONS)
+			transport->push_options = push_options;
 		if (push_with_options(transport, flags))
 			errs++;
 	}
@@ -500,6 +507,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int push_cert = -1;
 	int rc;
 	const char *repo = NULL;	/* default repository */
+	static struct string_list push_options = STRING_LIST_INIT_DUP;
+	static struct string_list_item *item;
+
 	struct option options[] = {
 		OPT__VERBOSITY(&verbosity),
 		OPT_STRING( 0 , "repo", &repo, N_("repository"), N_("repository")),
@@ -533,6 +543,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		  0, "signed", &push_cert, "yes|no|if-asked", N_("GPG sign the push"),
 		  PARSE_OPT_OPTARG, option_parse_push_signed },
 		OPT_BIT(0, "atomic", &flags, N_("request atomic transaction on remote side"), TRANSPORT_PUSH_ATOMIC),
+		OPT_STRING_LIST('o', "push-option", &push_options, N_("server-specific"), N_("option to transmit")),
 		OPT_SET_INT('4', "ipv4", &family, N_("use IPv4 addresses only"),
 				TRANSPORT_FAMILY_IPV4),
 		OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
@@ -563,7 +574,11 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		set_refspecs(argv + 1, argc - 1, repo);
 	}
 
-	rc = do_push(repo, flags);
+	for_each_string_list_item(item, &push_options)
+		if (strchr(item->string, '\n'))
+			die(_("push options must not have new line characters"));
+
+	rc = do_push(repo, flags, &push_options);
 	if (rc == -1)
 		usage_with_options(push_usage, options);
 	else
diff --git a/send-pack.c b/send-pack.c
index 299d303..3a842ac 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -260,6 +260,7 @@ static int generate_push_cert(struct strbuf *req_buf,
 			      const char *push_cert_nonce)
 {
 	const struct ref *ref;
+	struct string_list_item *item;
 	char *signing_key = xstrdup(get_signing_key());
 	const char *cp, *np;
 	struct strbuf cert = STRBUF_INIT;
@@ -276,6 +277,9 @@ static int generate_push_cert(struct strbuf *req_buf,
 	}
 	if (push_cert_nonce[0])
 		strbuf_addf(&cert, "nonce %s\n", push_cert_nonce);
+	if (args->push_options)
+		for_each_string_list_item(item, args->push_options)
+			strbuf_addf(&cert, "push-option %s\n", item->string);
 	strbuf_addstr(&cert, "\n");
 
 	for (ref = remote_refs; ref; ref = ref->next) {
@@ -370,6 +374,8 @@ int send_pack(struct send_pack_args *args,
 	int agent_supported = 0;
 	int use_atomic = 0;
 	int atomic_supported = 0;
+	int use_push_options = 0;
+	int push_options_supported = 0;
 	unsigned cmds_sent = 0;
 	int ret;
 	struct async demux;
@@ -392,6 +398,8 @@ int send_pack(struct send_pack_args *args,
 		args->use_thin_pack = 0;
 	if (server_supports("atomic"))
 		atomic_supported = 1;
+	if (server_supports("push-options"))
+		push_options_supported = 1;
 
 	if (args->push_cert != SEND_PACK_PUSH_CERT_NEVER) {
 		int len;
@@ -418,6 +426,11 @@ int send_pack(struct send_pack_args *args,
 
 	use_atomic = atomic_supported && args->atomic;
 
+	if (args->push_options && !push_options_supported)
+		die(_("the receiving end does not support push options"));
+
+	use_push_options = push_options_supported && args->push_options;
+
 	if (status_report)
 		strbuf_addstr(&cap_buf, " report-status");
 	if (use_sideband)
@@ -426,6 +439,8 @@ int send_pack(struct send_pack_args *args,
 		strbuf_addstr(&cap_buf, " quiet");
 	if (use_atomic)
 		strbuf_addstr(&cap_buf, " atomic");
+	if (use_push_options)
+		strbuf_addstr(&cap_buf, " push-options");
 	if (agent_supported)
 		strbuf_addf(&cap_buf, " agent=%s", git_user_agent_sanitized());
 
@@ -512,6 +527,18 @@ int send_pack(struct send_pack_args *args,
 	strbuf_release(&req_buf);
 	strbuf_release(&cap_buf);
 
+	if (use_push_options) {
+		struct string_list_item *item;
+		struct strbuf sb = STRBUF_INIT;
+
+		for_each_string_list_item(item, args->push_options)
+			packet_buf_write(&sb, "%s", item->string);
+
+		write_or_die(out, sb.buf, sb.len);
+		packet_flush(out);
+		strbuf_release(&sb);
+	}
+
 	if (use_sideband && cmds_sent) {
 		memset(&demux, 0, sizeof(demux));
 		demux.proc = sideband_demux;
diff --git a/send-pack.h b/send-pack.h
index 57f222a..67fc40f 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -1,6 +1,8 @@
 #ifndef SEND_PACK_H
 #define SEND_PACK_H
 
+#include "string-list.h"
+
 /* Possible values for push_cert field in send_pack_args. */
 #define SEND_PACK_PUSH_CERT_NEVER 0
 #define SEND_PACK_PUSH_CERT_IF_ASKED 1
@@ -21,6 +23,7 @@ struct send_pack_args {
 		push_cert:2,
 		stateless_rpc:1,
 		atomic:1;
+	const struct string_list *push_options;
 };
 
 struct option;
diff --git a/transport.c b/transport.c
index 095e61f..0298be1 100644
--- a/transport.c
+++ b/transport.c
@@ -510,6 +510,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
 	args.porcelain = !!(flags & TRANSPORT_PUSH_PORCELAIN);
 	args.atomic = !!(flags & TRANSPORT_PUSH_ATOMIC);
+	args.push_options = transport->push_options;
 	args.url = transport->url;
 
 	if (flags & TRANSPORT_PUSH_CERT_ALWAYS)
diff --git a/transport.h b/transport.h
index c681408..6fe3485 100644
--- a/transport.h
+++ b/transport.h
@@ -48,6 +48,12 @@ struct transport {
 	 */
 	unsigned cloning : 1;
 
+	/*
+	 * These strings will be passed to the {pre, post}-receive hook,
+	 * on the remote side, if both sides support the push options capability.
+	 */
+	const struct string_list *push_options;
+
 	/**
 	 * Returns 0 if successful, positive if the option is not
 	 * recognized or is inapplicable, and negative if the option
@@ -134,6 +140,7 @@ struct transport {
 #define TRANSPORT_PUSH_CERT_ALWAYS 2048
 #define TRANSPORT_PUSH_CERT_IF_ASKED 4096
 #define TRANSPORT_PUSH_ATOMIC 8192
+#define TRANSPORT_PUSH_OPTIONS 16384
 
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 #define TRANSPORT_SUMMARY(x) (int)(TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_width(x)), (x)
-- 
2.9.0.247.g176c4f7

