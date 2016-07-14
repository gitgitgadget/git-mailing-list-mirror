Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 744412019E
	for <e@80x24.org>; Thu, 14 Jul 2016 17:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbcGNRjs (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 13:39:48 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36362 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbcGNRjp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 13:39:45 -0400
Received: by mail-pf0-f170.google.com with SMTP id t190so32039540pfb.3
        for <git@vger.kernel.org>; Thu, 14 Jul 2016 10:39:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P+v6EjCjSOd8wrP8vvd2uEt2StUMoeeJxivpGAu7VlY=;
        b=XcDCDRsOAE8QOGP5A6V7XPpaYpz/RfigDxfYZfSMZWRS1aJWX24lQGngxCoT2LLryB
         ShLTIuoj731o03M3Ooz0heSo+bpKfIXLugfvmFAntUQPskx7fNfpezQP6Ln495Kfhl0l
         8gYYpjOweJF4xC5PDdeXqtXH/i4OKfDkQPz0xs63aUYI/fL0AQTvqC+EKKimy0X9HVCK
         P/CmKk6jeCHiVEInZmmweS9Do9lsAwS1qeih6xSOVMt/DDESfGS8fbYqR7HHsqBZBXD2
         nLar+qQhXV7DWFWBGvVhmfqQrC0Xj3UQTtWl0wtbb8py4ovSxN77/m884XWlLXe4jzRr
         +CtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P+v6EjCjSOd8wrP8vvd2uEt2StUMoeeJxivpGAu7VlY=;
        b=Atr+XY5x1Zvp0ro22aOWQWRCIpDQMOq90nPTEa3AoNLNih6+jea/LjcV0D+EBCV7Ns
         OsvDVtsx/2I/3L12GzMufblHalmQMUiDadJD1Gzwg0eu+muJ8rpmtFNVuD/tYkEg/A90
         sPusBL3atdmGY7+6I8prIXLcxJapBhZU890gqi3FI/+PpEvUkr9IG19BZ7TVC9IT4Wyj
         ideyqSeSkluSrC95UQjWufetV6sSks/OHhTYFmhAGUgvutUHTJm/4BFCxDfQr576d81W
         rG8PUh5aP7vaATF84hYErhauuAQTv8UBitYZ8hiax/JdcFLHYa4+4vFDnZliXIuPIsYI
         FyYQ==
X-Gm-Message-State: ALyK8tLOhpK3Kf4hhdlvrL8Gqyah7wj99Q8PN2nU8YWN17cIV3ygL+apbELhqosxAQiDAg/m
X-Received: by 10.98.102.221 with SMTP id s90mr14294056pfj.69.1468517984028;
        Thu, 14 Jul 2016 10:39:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c041:4809:7eab:7652])
        by smtp.gmail.com with ESMTPSA id 72sm3978974pfs.51.2016.07.14.10.39.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 14 Jul 2016 10:39:43 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	git@vger.kernel.org, gitster@pobox.com
Cc:	dwwang@google.com, e@80x24.org, peff@peff.net,
	dennis@kaarsemaker.net, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/4] push: accept push options
Date:	Thu, 14 Jul 2016 10:39:19 -0700
Message-Id: <20160714173920.22001-4-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.247.gf748855.dirty
In-Reply-To: <20160714173920.22001-1-sbeller@google.com>
References: <20160714173920.22001-1-sbeller@google.com>
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
2.9.0.247.gf748855.dirty

