Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22F4C208B6
	for <e@80x24.org>; Thu,  3 Aug 2017 09:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbdHCJUe (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:20:34 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36951 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbdHCJUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:20:25 -0400
Received: by mail-wr0-f196.google.com with SMTP id 12so571075wrb.4
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fGRbs7+jVLy9pPzzf7KcAI4pqUTit+mrrI+w7M2E6uw=;
        b=K8/3doTIfhJ9s7zy7APLiYaqBRPQIpR3l4lRe6hS3z9W/HgBz+zKXssZNgKBs+JwqC
         lypSxhB58F/VkcPetYGI7vQ/TQBnavWSXH3AnBqMAGX8UNc2tvFQ/5YI4AJk90+p+HQS
         s+DGszb11FgGXDD4EYzleYTF9fqn73J6zwTObraysCfpNvvPGFzLL6guynQaNRBDL/NU
         dbGBo0E62tom2uHqzvRfOzKXXRS5SJGDXg3l10hvZRuePZoLMBTnldo5onDTpUVtZjgo
         eA0ftF7kQMxfLpKVEpiSzJ5Z6PMv2Tw6RPShhYrsIYV1+ePTFGsSoku9s+MtkaO/Tqp4
         p4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fGRbs7+jVLy9pPzzf7KcAI4pqUTit+mrrI+w7M2E6uw=;
        b=AA3K9OOeDjr+uipJdtWXpvAjh23FR/ECaa6fZQxFMB33SPgLAaiB6YLxwpeMpZqZJT
         N7EwMjQ2hKYZTi9/RyIs0kUlKV91/CFVEgdFh3jYjLCf0MgcQEyKYxZDmE/vtofI2BT7
         G93szQZXMfEyuzysPB6vCHy9SQu5H9huUig2wiauxmWxvR7AG69oxYDHgRPvZJGGTgeg
         Z2VTXp6+pS1M3Qz3apWHEoB8vvfDRzlukZxsWgWFywhzsYn74RsouSrX3r9PEbvPrEyG
         J3bkW+ZNsG35sDPda+3kVGVYX7n6V8+AL6ByuYJVX/KCUoivOAvi+onN4AQ5sK/31vK+
         MTFA==
X-Gm-Message-State: AIVw112spSd3mlHH/UTKUPJH4KPEZW6wugKi7ACvz73s3KSjMZzpP12u
        4zTobIp+Jyzt8mTc
X-Received: by 10.223.183.12 with SMTP id l12mr752052wre.103.1501752024140;
        Thu, 03 Aug 2017 02:20:24 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:20:23 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 37/40] clone: add --initial-refspec option
Date:   Thu,  3 Aug 2017 11:19:23 +0200
Message-Id: <20170803091926.1755-38-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option makes it possible to separate fetching refs when cloning
in two parts, an initial part and a later normal part.

This way after the initial part, mechanisms like the external odb
mechanism can be used to prefetch some objects using information
that has been made available during the initial fetch.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/clone.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 2362dda880..76e561534d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -56,6 +56,7 @@ static enum transport_family family;
 static struct string_list option_config = STRING_LIST_INIT_NODUP;
 static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
 static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
+static struct string_list option_initial_refspec = STRING_LIST_INIT_NODUP;
 static int option_dissociate;
 static int max_jobs = -1;
 static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
@@ -106,6 +107,8 @@ static struct option builtin_clone_options[] = {
 			N_("reference repository")),
 	OPT_STRING_LIST(0, "reference-if-able", &option_optional_reference,
 			N_("repo"), N_("reference repository")),
+	OPT_STRING_LIST(0, "initial-refspec", &option_initial_refspec,
+			N_("refspec"), N_("fetch this refspec first")),
 	OPT_BOOL(0, "dissociate", &option_dissociate,
 		 N_("use --reference only while cloning")),
 	OPT_STRING('o', "origin", &option_origin, N_("name"),
@@ -865,6 +868,47 @@ static void dissociate_from_references(void)
 	free(alternates);
 }
 
+static struct refspec *parse_initial_refspecs(void)
+{
+	const char **refspecs;
+	struct refspec *initial_refspecs;
+	struct string_list_item *rs;
+	int i = 0;
+
+	if (!option_initial_refspec.nr)
+		return NULL;
+
+	refspecs = xcalloc(option_initial_refspec.nr, sizeof(const char *));
+
+	for_each_string_list_item(rs, &option_initial_refspec)
+		refspecs[i++] = rs->string;
+
+	initial_refspecs = parse_fetch_refspec(option_initial_refspec.nr, refspecs);
+
+	free(refspecs);
+
+	return initial_refspecs;
+}
+
+static void fetch_initial_refs(struct transport *transport,
+			       const struct ref *refs,
+			       struct refspec *initial_refspecs,
+			       const char *branch_top,
+			       const char *reflog_msg,
+			       int is_local)
+{
+	int i;
+
+	for (i = 0; i < option_initial_refspec.nr; i++) {
+		struct ref *init_refs = NULL;
+		struct ref **tail = &init_refs;
+		get_fetch_map(refs, &initial_refspecs[i], &tail, 0);
+		transport_fetch_refs(transport, init_refs);
+		update_remote_refs(refs, init_refs, NULL, branch_top, reflog_msg,
+				   transport, !is_local, 1);
+	}
+}
+
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
@@ -888,6 +932,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct refspec *refspec;
 	const char *fetch_pattern;
 
+	struct refspec *initial_refspecs;
+	int is_initial;
+
 	packet_trace_identity("clone");
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
@@ -1055,6 +1102,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
+	initial_refspecs = parse_initial_refspecs();
+
 	fetch_pattern = xstrfmt("+%s*:%s*", src_ref_prefix, branch_top.buf);
 	refspec = parse_fetch_refspec(1, &fetch_pattern);
 	free((char *)fetch_pattern);
@@ -1110,6 +1159,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	refs = transport_get_remote_refs(transport);
 
 	if (refs) {
+		fetch_initial_refs(transport, refs, initial_refspecs,
+				   branch_top.buf, reflog_msg.buf, is_local);
+
 		mapped_refs = wanted_peer_refs(refs, refspec);
 		/*
 		 * transport_get_remote_refs() may return refs with null sha-1
@@ -1169,9 +1221,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	else if (refs && complete_refs_before_fetch)
 		transport_fetch_refs(transport, mapped_refs);
 
+	is_initial = !refs || option_initial_refspec.nr == 0;
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
 			   branch_top.buf, reflog_msg.buf, transport,
-			   !is_local, 0);
+			   !is_local, is_initial);
 
 	update_head(our_head_points_at, remote_head, reflog_msg.buf);
 
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

