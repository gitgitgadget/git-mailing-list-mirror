Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D801D20401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbdFTH5B (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:57:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35243 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752304AbdFTH4x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id d64so21288213wmf.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=shmYxPtdrowdwAL6PfkKc0UgQZPtN2B0Cm2H/PCZgAg=;
        b=GOW5HQiF18PyUAows0Zc1XnC5Ru7vK7TboS4N7tIz44TybWbBXDxyvr2sJ/uY8M0yf
         w1X6YGorjcpkyH13fWpc6ncBjO7T/hDS5VA7z8/frPU6EXpVQFTgWWUJJ/a/LOGWFx1+
         OfBdmgkU7MWo5VWZ/g+TMz0pPTuUEkRWiU7EJZdqF0pInrZX7OFF8Yk91Jge/F143h5c
         ykMAJ8Nj/IipFMECelEkSOYMOv4XvDdqdBF2aAtMhcb56jFjbbrsql3r7IYF3PULU3Rr
         dOwC4uw5+afDMispiDVQvoFK90GWA1e8mjFHKFQgmRIMS5seWnkz3VZ2jjt19E+lZCXX
         +NxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=shmYxPtdrowdwAL6PfkKc0UgQZPtN2B0Cm2H/PCZgAg=;
        b=j+PB4IScT4Ggpim5Mc2eci09FsSPy6HJonEFY9OLLROTwJfyAI+tCiBbCvxDIZkljN
         EUna++mE+Zxswvu6YO0jCqxciuS4NVaZ01z6rsE5Mn20+VToocn2Cint4uwhLNwq+y4p
         +PdC6gCgGPbZb1sq2rhi7AuSmOrgnSrE/9U4I5yPcySAXPZDevIoFXbUtq415HAx38z9
         BG8PaLxSU4zUIjAHsN4/tuhnTJiQeexw0RhownQ/7bNqyc4bbAt6kg+KKeRfDXleBz4U
         VasC1tVxexiLY6OnIkH6nCvGvDbqZ7HENybJ+MBjSb34SHgmrjoWIKO9zRun/4dXsdGm
         BfVA==
X-Gm-Message-State: AKS2vOzLgKsgxK/3IvfUjWlT5phaHs7yHUFIM2r19vW1ZKIp+zqHEBFn
        qulmO3Rzx2zzxvb+
X-Received: by 10.28.105.218 with SMTP id z87mr1765213wmh.121.1497945412016;
        Tue, 20 Jun 2017 00:56:52 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:51 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v4 46/49] clone: add --initial-refspec option
Date:   Tue, 20 Jun 2017 09:55:20 +0200
Message-Id: <20170620075523.26961-47-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/clone.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index bd690576e6..dda0ad360b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -55,6 +55,7 @@ static enum transport_family family;
 static struct string_list option_config = STRING_LIST_INIT_NODUP;
 static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
 static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
+static struct string_list option_initial_refspec = STRING_LIST_INIT_NODUP;
 static int option_dissociate;
 static int max_jobs = -1;
 static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
@@ -105,6 +106,8 @@ static struct option builtin_clone_options[] = {
 			N_("reference repository")),
 	OPT_STRING_LIST(0, "reference-if-able", &option_optional_reference,
 			N_("repo"), N_("reference repository")),
+	OPT_STRING_LIST(0, "initial-refspec", &option_initial_refspec,
+			N_("refspec"), N_("fetch this refspec first")),
 	OPT_BOOL(0, "dissociate", &option_dissociate,
 		 N_("use --reference only while cloning")),
 	OPT_STRING('o', "origin", &option_origin, N_("name"),
@@ -864,6 +867,47 @@ static void dissociate_from_references(void)
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
@@ -887,6 +931,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct refspec *refspec;
 	const char *fetch_pattern;
 
+	struct refspec *initial_refspecs;
+	int is_initial;
+
 	packet_trace_identity("clone");
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
@@ -1054,6 +1101,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
+	initial_refspecs = parse_initial_refspecs();
+
 	fetch_pattern = xstrfmt("+%s*:%s*", src_ref_prefix, branch_top.buf);
 	refspec = parse_fetch_refspec(1, &fetch_pattern);
 	free((char *)fetch_pattern);
@@ -1109,6 +1158,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	refs = transport_get_remote_refs(transport);
 
 	if (refs) {
+		fetch_initial_refs(transport, refs, initial_refspecs,
+				   branch_top.buf, reflog_msg.buf, is_local);
+
 		mapped_refs = wanted_peer_refs(refs, refspec);
 		/*
 		 * transport_get_remote_refs() may return refs with null sha-1
@@ -1168,9 +1220,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	else if (refs && complete_refs_before_fetch)
 		transport_fetch_refs(transport, mapped_refs);
 
+	is_initial = !refs || option_initial_refspec.nr == 0;
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
 			   branch_top.buf, reflog_msg.buf, transport,
-			   !is_local, 0);
+			   !is_local, is_initial);
 
 	update_head(our_head_points_at, remote_head, reflog_msg.buf);
 
-- 
2.13.1.565.gbfcd7a9048

