Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C284A2018A
	for <e@80x24.org>; Sat,  2 Jul 2016 00:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbcGBAU1 (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 20:20:27 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33207 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106AbcGBAU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 20:20:26 -0400
Received: by mail-pa0-f43.google.com with SMTP id b13so42809225pat.0
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 17:20:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G3N35jQRUpXPGiMQhRvzEX8DekgXk+anoBlhqJ+k6aw=;
        b=VE/uoi/yoFLJrKXxv4L+ShFBCV390bxIMW/xV+D5KrqC36e40lX+47in/MYD074ykA
         IJqxIwEPbtgMbHkoJepYujw9Mv/ZwHdAUQSv07L8wn3ymUXBNQBLb3bDtOftP2g/Wuww
         5PNPAfgagyV4MbxQdnr6bBy311IEOM6qLaKPcZB4cPOsDeyeMngCpIvqyihrKFH10VzB
         u1z/lWSe2ABvLfRr0VSIkeLHdmp82GKxmS/9VhKG0CEsjpJ+HqAVe+Ix1pgwXTNSBWJ8
         edGmd3qBWMg1dw/Db1li8ic623K932CbSIZi+q+L7b2YMO5D1D2zFJeV54IVxDPzsykp
         c+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G3N35jQRUpXPGiMQhRvzEX8DekgXk+anoBlhqJ+k6aw=;
        b=XXrdkSzHNkEJ52rftNsI16fajYOoFrVUU3hm0Kg5gwtYsIbA+bV+yaOPpvzC7iG4Wo
         gpFtnIDO3W1G+OZuoxZqI811VumKaDAyhOPKDFMj1tuEhizFEVQ66nu1DuXf6bhQv3hn
         17bqJ+nAiDmUiRnaI8JHDJrnocgEMjIZIqkkq62BF6lUVncsBogtPOHcke+hyKWg9krL
         rf1cLAUQn+KC3VNDgArm6n6cFjTpmEvxLaaAjq+peQa2RtnJ2ZLsce/WUIP60Yx830Ro
         Q25/hc05mIEkP38X6XzH96UWiehc0IUrMo9kbgFBQaprcYNmulS8ZPiHVZVWwLJUnrXL
         fKEw==
X-Gm-Message-State: ALyK8tKLbwbnM04E4GBibIKs9n2JE6LXOdq11V1nwZK8bNMPMjkJOZex9LSBhPauA6b7aash
X-Received: by 10.67.7.199 with SMTP id de7mr1640629pad.94.1467418825592;
        Fri, 01 Jul 2016 17:20:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c009:86e6:19a6:486e])
        by smtp.gmail.com with ESMTPSA id o6sm467010pax.9.2016.07.01.17.20.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 01 Jul 2016 17:20:24 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	git@vger.kernel.org, peff@peff.net
Cc:	dwwang@google.com, gitster@pobox.com, dennis@kaarsemaker.net,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 3/4] push: accept push options
Date:	Fri,  1 Jul 2016 17:20:13 -0700
Message-Id: <20160702002014.29497-4-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.141.gd59d3e9.dirty
In-Reply-To: <20160702002014.29497-1-sbeller@google.com>
References: <20160702002014.29497-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This implements everything that is required on the client side to make use
of push options from the porcelain push command.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-push.txt |  8 +++++++-
 builtin/push.c             | 16 +++++++++++++---
 send-pack.c                | 29 +++++++++++++++++++++++++++++
 send-pack.h                |  3 +++
 transport.c                |  2 ++
 transport.h                |  7 +++++++
 6 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 19f46b6..b0b1273 100644
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
 
+-L::
+--push-option::
+	Transmit the given string to the server, which passes them to
+	the pre-receive as well as the post-receive hook. Only C strings
+	containing no new lines are allowed.
+
 --receive-pack=<git-receive-pack>::
 --exec=<git-receive-pack>::
 	Path to the 'git-receive-pack' program on the remote
diff --git a/builtin/push.c b/builtin/push.c
index 4e9e4db..1b5d205 100644
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
@@ -500,6 +507,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int push_cert = -1;
 	int rc;
 	const char *repo = NULL;	/* default repository */
+	static struct string_list push_options = STRING_LIST_INIT_DUP;
+
 	struct option options[] = {
 		OPT__VERBOSITY(&verbosity),
 		OPT_STRING( 0 , "repo", &repo, N_("repository"), N_("repository")),
@@ -533,6 +542,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		  0, "signed", &push_cert, "yes|no|if-asked", N_("GPG sign the push"),
 		  PARSE_OPT_OPTARG, option_parse_push_signed },
 		OPT_BIT(0, "atomic", &flags, N_("request atomic transaction on remote side"), TRANSPORT_PUSH_ATOMIC),
+		OPT_STRING_LIST('o', "push-option", &push_options, N_("server-specific"), N_("option to transmit")),
 		OPT_SET_INT('4', "ipv4", &family, N_("use IPv4 addresses only"),
 				TRANSPORT_FAMILY_IPV4),
 		OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
@@ -563,7 +573,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		set_refspecs(argv + 1, argc - 1, repo);
 	}
 
-	rc = do_push(repo, flags);
+	rc = do_push(repo, flags, &push_options);
 	if (rc == -1)
 		usage_with_options(push_usage, options);
 	else
diff --git a/send-pack.c b/send-pack.c
index 37ee04e..17c30a1 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -261,6 +261,7 @@ static int generate_push_cert(struct strbuf *req_buf,
 			      const char *push_cert_nonce)
 {
 	const struct ref *ref;
+	struct string_list_item *item;
 	char *signing_key = xstrdup(get_signing_key());
 	const char *cp, *np;
 	struct strbuf cert = STRBUF_INIT;
@@ -279,6 +280,12 @@ static int generate_push_cert(struct strbuf *req_buf,
 		strbuf_addf(&cert, "nonce %s\n", push_cert_nonce);
 	strbuf_addstr(&cert, "\n");
 
+	if (args->push_options) {
+		for_each_string_list_item(item, args->push_options)
+			strbuf_addf(&cert, "push-option %s\n", item->string);
+		strbuf_addstr(&cert, "\n");
+	}
+
 	for (ref = remote_refs; ref; ref = ref->next) {
 		if (check_to_send_update(ref, args) < 0)
 			continue;
@@ -371,6 +378,8 @@ int send_pack(struct send_pack_args *args,
 	int agent_supported = 0;
 	int use_atomic = 0;
 	int atomic_supported = 0;
+	int use_push_options = 0;
+	int push_options_supported = 0;
 	unsigned cmds_sent = 0;
 	int ret;
 	struct async demux;
@@ -393,6 +402,8 @@ int send_pack(struct send_pack_args *args,
 		args->use_thin_pack = 0;
 	if (server_supports("atomic"))
 		atomic_supported = 1;
+	if (server_supports("push-options"))
+		push_options_supported = 1;
 
 	if (args->push_cert != SEND_PACK_PUSH_CERT_NEVER) {
 		int len;
@@ -419,6 +430,11 @@ int send_pack(struct send_pack_args *args,
 
 	use_atomic = atomic_supported && args->atomic;
 
+	if (args->push_options && !push_options_supported)
+		die(_("the receiving end does not support push options"));
+
+	use_push_options = push_options_supported && args->push_options;
+
 	if (status_report)
 		strbuf_addstr(&cap_buf, " report-status");
 	if (use_sideband)
@@ -427,6 +443,8 @@ int send_pack(struct send_pack_args *args,
 		strbuf_addstr(&cap_buf, " quiet");
 	if (use_atomic)
 		strbuf_addstr(&cap_buf, " atomic");
+	if (use_push_options)
+		strbuf_addstr(&cap_buf, " push-options");
 	if (agent_supported)
 		strbuf_addf(&cap_buf, " agent=%s", git_user_agent_sanitized());
 
@@ -513,6 +531,17 @@ int send_pack(struct send_pack_args *args,
 	strbuf_release(&req_buf);
 	strbuf_release(&cap_buf);
 
+	if (use_push_options) {
+		struct string_list_item *item;
+		struct strbuf sb = STRBUF_INIT;
+
+		for_each_string_list_item(item, args->push_options)
+			packet_buf_write(&sb, "%s", item->string);
+			write_or_die(out, sb.buf, sb.len);
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
index 095e61f..598bd1f 100644
--- a/transport.c
+++ b/transport.c
@@ -510,6 +510,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
 	args.porcelain = !!(flags & TRANSPORT_PUSH_PORCELAIN);
 	args.atomic = !!(flags & TRANSPORT_PUSH_ATOMIC);
+	args.push_options = transport->push_options;
 	args.url = transport->url;
 
 	if (flags & TRANSPORT_PUSH_CERT_ALWAYS)
@@ -640,6 +641,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	struct transport *ret = xcalloc(1, sizeof(*ret));
 
 	ret->progress = isatty(2);
+	ret->push_options = NULL;
 
 	if (!remote)
 		die("No remote provided to transport_get()");
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
2.9.0.141.gd59d3e9.dirty

