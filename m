Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC40B2070F
	for <e@80x24.org>; Thu,  7 Jul 2016 01:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650AbcGGBMr (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 21:12:47 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35046 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbcGGBMp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 21:12:45 -0400
Received: by mail-pa0-f54.google.com with SMTP id dx3so1265947pab.2
        for <git@vger.kernel.org>; Wed, 06 Jul 2016 18:12:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NMavaj+ygXEpLLQlbSwbPehSVfSpHiDTp0G+flXIFQ8=;
        b=JsUofVGdxuwHhFWZRsWqDoE+x6tm8syrbqZ4QH6WirlW40zb+RD9SwAE/JQtjtZtSR
         bPjd2Ta0lmdhvboSVeQw8J8V8c1ulmAf0+4Ik6MPJ0ye7FBHv6hDk/9gtC/RpsrtYZx2
         dK4o8ERk8pwDGetfxY32EHD8jyc4eLdOxQiWkNjeaoXVWzvGSrkLTnPbGrN295oQQhqS
         c4BD2fbsoOhP6c9UiYZn9BuaGGmUXHYUo4zVJkhlBLBnYWhyLmlEFHAYWhGMVdwY8jTv
         v8NgXSUstlphzqy+6FGqgRwghzrbiwBsugxZMHBY+r6TP6TZnB/8Z4ZXSLns9VReTtYO
         tLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NMavaj+ygXEpLLQlbSwbPehSVfSpHiDTp0G+flXIFQ8=;
        b=KgAtnOgEePnF1HSqaKhiTk7TQ9mHy6waUKScWinz5Gr87H0+ARcTEz36YCj98unk2x
         OY8GzeX0bTuYC9W+juVZZ/IOfTYGGW0NDHfqBvVxaGlhnpXCglRlBM7WygBCQoSSY6QD
         7E8kzyXA5Pk0NWiMfqeLL9r8ZzQRMV1nLFmPv/ToYUqb3fVesDzFdBKL75XLdE29yeuL
         68vxtIfbz/VLkyUHcu6GMtKgW3FQne7sIkKRQz3KBvHaiAO5RKGYgLxW9PDMgoT3djWw
         Bmp4dowQspiRPWwohurHszSUlTEUfWjju7A4K86geEXBCovOkv5kuZ57FWkKn3aREtsu
         mt9w==
X-Gm-Message-State: ALyK8tIKWEZS0f3/2YoqjAghkX3xN0T+p5OWTJ8hhfmIzl0RvC8OaM6tqtUFI1yu5QRnb+qS
X-Received: by 10.66.179.168 with SMTP id dh8mr47240836pac.36.1467853964438;
        Wed, 06 Jul 2016 18:12:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:7518:e836:5c9c:93dd])
        by smtp.gmail.com with ESMTPSA id z127sm6841668pfz.20.2016.07.06.18.12.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 06 Jul 2016 18:12:43 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, e@80x24.org, peff@peff.net, dwwang@google.com,
	dennis@kaarsemaker.net, Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/4] push: accept push options
Date:	Wed,  6 Jul 2016 18:12:17 -0700
Message-Id: <20160707011218.3690-4-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.141.gd59d3e9.dirty
In-Reply-To: <20160707011218.3690-1-sbeller@google.com>
References: <20160707011218.3690-1-sbeller@google.com>
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
 send-pack.c                | 30 ++++++++++++++++++++++++++++++
 send-pack.h                |  3 +++
 transport.c                |  1 +
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
index 299d303..c943560 100644
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
@@ -278,6 +279,12 @@ static int generate_push_cert(struct strbuf *req_buf,
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
@@ -370,6 +377,8 @@ int send_pack(struct send_pack_args *args,
 	int agent_supported = 0;
 	int use_atomic = 0;
 	int atomic_supported = 0;
+	int use_push_options = 0;
+	int push_options_supported = 0;
 	unsigned cmds_sent = 0;
 	int ret;
 	struct async demux;
@@ -392,6 +401,8 @@ int send_pack(struct send_pack_args *args,
 		args->use_thin_pack = 0;
 	if (server_supports("atomic"))
 		atomic_supported = 1;
+	if (server_supports("push-options"))
+		push_options_supported = 1;
 
 	if (args->push_cert != SEND_PACK_PUSH_CERT_NEVER) {
 		int len;
@@ -418,6 +429,11 @@ int send_pack(struct send_pack_args *args,
 
 	use_atomic = atomic_supported && args->atomic;
 
+	if (args->push_options && !push_options_supported)
+		die(_("the receiving end does not support push options"));
+
+	use_push_options = push_options_supported && args->push_options;
+
 	if (status_report)
 		strbuf_addstr(&cap_buf, " report-status");
 	if (use_sideband)
@@ -426,6 +442,8 @@ int send_pack(struct send_pack_args *args,
 		strbuf_addstr(&cap_buf, " quiet");
 	if (use_atomic)
 		strbuf_addstr(&cap_buf, " atomic");
+	if (use_push_options)
+		strbuf_addstr(&cap_buf, " push-options");
 	if (agent_supported)
 		strbuf_addf(&cap_buf, " agent=%s", git_user_agent_sanitized());
 
@@ -512,6 +530,18 @@ int send_pack(struct send_pack_args *args,
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
2.9.0.141.gd59d3e9.dirty

