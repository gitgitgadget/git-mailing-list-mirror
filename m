Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8B861F406
	for <e@80x24.org>; Wed, 16 May 2018 22:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeEPW7U (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:59:20 -0400
Received: from mail-ot0-f201.google.com ([74.125.82.201]:54387 "EHLO
        mail-ot0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbeEPW7R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:59:17 -0400
Received: by mail-ot0-f201.google.com with SMTP id d61-v6so2000208otb.21
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=8vTABSBfZe9BR5phXLS/aBkdMy1Y1fDnkxvwkAYxOrQ=;
        b=ggLhBHMuQ7FjCBbONE+Mmk1iuuZ5BvRgjBqHQCly9LaGDHj7CCNSN9zX57a88uRDEq
         QcBX1SJEc7O8FyZgb43BhU1GXEt2lpbaexO66fO26Rj0aj6FZ3lxYl6DCRkAvRhGLIRi
         35fPSW1QUXjkJeOmcChBTVs3xyfGr4n2I6nRPlmxt80+VgB8n3sC5a7iI7C4ZpSIw9ds
         T7yPU82Zwf3R+FTka7fiuvaxS/u5GJAytSFxurYlcfeJGSuel+mx/uTkfM88Ip1LWINk
         oUWtZRsJIdNbrCWXD3cWlAr/qfBKsvqwEDwo5aLHq6YGRz3CRki4S83cZioT1QCJem2V
         GKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=8vTABSBfZe9BR5phXLS/aBkdMy1Y1fDnkxvwkAYxOrQ=;
        b=nMu4KAy9qotdpGpYJiD83UJSVcPY12yCPolc4LlkaA6+GN3UM4jUpYexksjZPt9vms
         sH/K92bV6jyr030Acf5e3XOfMJ26N/aZXFGPwJumPnSkytBASXXUOE+b5mjEkcUOfgTk
         1wmF6YHPKwk1640L5cZXfZuccz3cK+kbP1mh/rnkvPUIoDd1D9C8of4kzJNA/36IvKlm
         buXIhq6/o6iMWA1+D7SmkxccogTmn6rKgsXYwUdsdKTEC3cTPX/JSOkqhXMm3Bhm6ZNw
         /Co5XUOKerbP+l4VRva85oB7F5tL1xHs0P6TP6tZkU4kBGBvPxTds4t5JASq3j4vlo9g
         Tl+A==
X-Gm-Message-State: ALKqPwdsZf249riOiYvgAlC0Sx5SDfALu5NszsG2RSchvZrOpTJaVdDa
        HXUR80MRJqGJe0evBNk6/Adw2zXg1bQ90sB/fqLHnh/DSr0yTHdc2a/CtfeSEhGqvXJ4bBHGjzL
        wJcMgWo8yqXH6//Xs41G0XJpN+41IGbqubkEXycj13EDSve2ymvm54bNUEw==
X-Google-Smtp-Source: AB8JxZrtK4JcoBpGnV+wtkCJHm6YDyvSzMkVTaYGi2hQr1DxLsi3FLpYQvwoh9ixqADrzTXQnWqBDClLe/E=
MIME-Version: 1.0
X-Received: by 2002:aca:4ac4:: with SMTP id x187-v6mr2439056oia.118.1526511556370;
 Wed, 16 May 2018 15:59:16 -0700 (PDT)
Date:   Wed, 16 May 2018 15:58:03 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-17-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 16/36] transport-helper: convert to use struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the refspecs in transport-helper.c to be stored in a
'struct refspec'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 transport-helper.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index b156a37e7..33f51ebfc 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -36,8 +36,7 @@ struct helper_data {
 	char *export_marks;
 	char *import_marks;
 	/* These go from remote name (as in "list") to private name */
-	struct refspec_item *refspecs;
-	int refspec_nr;
+	struct refspec rs;
 	/* Transport options for fetch-pack/send-pack (should one of
 	 * those be invoked).
 	 */
@@ -107,9 +106,6 @@ static struct child_process *get_helper(struct transport *transport)
 	struct helper_data *data = transport->data;
 	struct strbuf buf = STRBUF_INIT;
 	struct child_process *helper;
-	const char **refspecs = NULL;
-	int refspec_nr = 0;
-	int refspec_alloc = 0;
 	int duped;
 	int code;
 
@@ -139,6 +135,7 @@ static struct child_process *get_helper(struct transport *transport)
 
 	data->helper = helper;
 	data->no_disconnect_req = 0;
+	refspec_init(&data->rs, REFSPEC_FETCH);
 
 	/*
 	 * Open the output as FILE* so strbuf_getline_*() family of
@@ -184,11 +181,8 @@ static struct child_process *get_helper(struct transport *transport)
 			data->export = 1;
 		else if (!strcmp(capname, "check-connectivity"))
 			data->check_connectivity = 1;
-		else if (!data->refspecs && skip_prefix(capname, "refspec ", &arg)) {
-			ALLOC_GROW(refspecs,
-				   refspec_nr + 1,
-				   refspec_alloc);
-			refspecs[refspec_nr++] = xstrdup(arg);
+		else if (skip_prefix(capname, "refspec ", &arg)) {
+			refspec_append(&data->rs, arg);
 		} else if (!strcmp(capname, "connect")) {
 			data->connect = 1;
 		} else if (!strcmp(capname, "stateless-connect")) {
@@ -207,14 +201,7 @@ static struct child_process *get_helper(struct transport *transport)
 			    capname);
 		}
 	}
-	if (refspecs) {
-		int i;
-		data->refspec_nr = refspec_nr;
-		data->refspecs = parse_fetch_refspec(refspec_nr, refspecs);
-		for (i = 0; i < refspec_nr; i++)
-			free((char *)refspecs[i]);
-		free(refspecs);
-	} else if (data->import || data->bidi_import || data->export) {
+	if (!data->rs.nr && (data->import || data->bidi_import || data->export)) {
 		warning("This remote helper should implement refspec capability.");
 	}
 	strbuf_release(&buf);
@@ -378,8 +365,7 @@ static int release_helper(struct transport *transport)
 {
 	int res = 0;
 	struct helper_data *data = transport->data;
-	free_refspec(data->refspec_nr, data->refspecs);
-	data->refspecs = NULL;
+	refspec_clear(&data->rs);
 	res = disconnect_helper(transport);
 	free(transport->data);
 	return res;
@@ -536,8 +522,8 @@ static int fetch_with_import(struct transport *transport,
 		if (posn->status & REF_STATUS_UPTODATE)
 			continue;
 		name = posn->symref ? posn->symref : posn->name;
-		if (data->refspecs)
-			private = apply_refspecs(data->refspecs, data->refspec_nr, name);
+		if (data->rs.nr)
+			private = apply_refspecs(data->rs.items, data->rs.nr, name);
 		else
 			private = xstrdup(name);
 		if (private) {
@@ -815,11 +801,11 @@ static int push_update_refs_status(struct helper_data *data,
 		if (push_update_ref_status(&buf, &ref, remote_refs))
 			continue;
 
-		if (flags & TRANSPORT_PUSH_DRY_RUN || !data->refspecs || data->no_private_update)
+		if (flags & TRANSPORT_PUSH_DRY_RUN || !data->rs.nr || data->no_private_update)
 			continue;
 
 		/* propagate back the update to the remote namespace */
-		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
+		private = apply_refspecs(data->rs.items, data->rs.nr, ref->name);
 		if (!private)
 			continue;
 		update_ref("update by helper", private, &ref->new_oid, NULL,
@@ -939,7 +925,7 @@ static int push_refs_with_export(struct transport *transport,
 	struct string_list revlist_args = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
 
-	if (!data->refspecs)
+	if (!data->rs.nr)
 		die("remote-helper doesn't support push; refspec needed");
 
 	set_common_push_options(transport, data->name, flags);
@@ -956,7 +942,7 @@ static int push_refs_with_export(struct transport *transport,
 		char *private;
 		struct object_id oid;
 
-		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
+		private = apply_refspecs(data->rs.items, data->rs.nr, ref->name);
 		if (private && !get_oid(private, &oid)) {
 			strbuf_addf(&buf, "^%s", private);
 			string_list_append_nodup(&revlist_args,
-- 
2.17.0.441.gb46fe60e1d-goog

