From: David Turner <dturner@twopensource.com>
Subject: [PATCH/RFC 4/6] transport: add refspec list parameters to functions
Date: Fri, 15 Apr 2016 15:19:07 -0400
Message-ID: <1460747949-3514-5-git-send-email-dturner@twopensource.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 21:19:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar9HU-0006Y9-3Z
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 21:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbcDOTTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 15:19:42 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34990 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394AbcDOTTg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 15:19:36 -0400
Received: by mail-qg0-f41.google.com with SMTP id f105so86893963qge.2
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 12:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FQQCUbDFinsmzmXqa8KXNyPqkqGm0ZUPFTjqv0w1B6M=;
        b=R+mEYdH6fEB0y3WQlYby/LGk/ZPKTp279lJ3gZlwks5AVgTeGjN1eHb67Kp5UKj5Wt
         4dKw0r6x9Na58+ThhPhklzgR/a0OPwgeDVrwyDolM8m7LAxAtr/aG5c5R2JglxaCj8yf
         +O0rCJfVNRBwQq+BqEVlwILRWChzRqL97CGwpPXXudSF9vTxm+2lqvD24tohS2Q+IPTp
         mmSpmQh6oH4VBGnXGjiJYENEM01cgbdUcEThZl1Wu29mI/PQXj6WJ75BDJbl0j1I6rxy
         SY2zIvrmleyIjJVcvHLvnJseVQ6DlgX3HdckweYDrgfyvgM5cjlTWYqaRQm9uUB2wTds
         TIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FQQCUbDFinsmzmXqa8KXNyPqkqGm0ZUPFTjqv0w1B6M=;
        b=ZdT/X5fz349sWkL+ef5gADvseDx0AXuTQGMcG5/jQh8c9KcOyHmRUdihm2oRPngKIJ
         7xidq8gti0O9Ebog+MewAx+s7sndg3iP0WJXPiCCJvfn414QIDHynYdzLzLSnMjj+2ZP
         nquLFeeSZ7EYqgUADfVP13DKH5ZK6tzxRz5P8w1Q/1RtxFT7RZl0sbrZE0//PMH17e8I
         g2u1nrptmzKqG7bsJ8gITHVeClWWUusThyXb5oO39rUOukB/SZkTFqOz+IPBD48zEdkf
         S1n6IEVRan09B8rY4cfEmRZ15saNOlZQOm6ySwiw7YbLeJP3NeBSzqwpvtFEgcr6GND1
         R/sQ==
X-Gm-Message-State: AOPr4FWBaEEyRN64OmPIvvPiM8leQpmNj7s0dBI36FW6rJyJefCAglL5hEwIhQDG+XhfGQ==
X-Received: by 10.140.98.133 with SMTP id o5mr27625286qge.44.1460747975483;
        Fri, 15 Apr 2016 12:19:35 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id c2sm21077097qkb.41.2016.04.15.12.19.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Apr 2016 12:19:34 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291639>

Add parameters for a list of refspecs to transport_get_remote_refs and
get_refs_list.  These parameters are presently unused -- soon, we will
use them to implement fetches which only learn about a subset of refs.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/clone.c     |  2 +-
 builtin/fetch.c     |  6 ++++--
 builtin/ls-remote.c |  2 +-
 builtin/remote.c    |  2 +-
 transport-helper.c  | 24 ++++++++++++------------
 transport.c         | 14 ++++++++------
 transport.h         |  4 ++--
 7 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 6616392..91f668c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1010,7 +1010,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (transport->smart_options && !option_depth)
 		transport->smart_options->check_self_contained_and_connected = 1;
 
-	refs = transport_get_remote_refs(transport);
+	refs = transport_get_remote_refs(transport, NULL, 0);
 
 	if (refs) {
 		mapped_refs = wanted_peer_refs(refs, refspec);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index e4639d8..cafab37 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -221,7 +221,8 @@ static void find_non_local_tags(struct transport *transport,
 	struct string_list_item *item = NULL;
 
 	for_each_ref(add_existing, &existing_refs);
-	for (ref = transport_get_remote_refs(transport); ref; ref = ref->next) {
+	for (ref = transport_get_remote_refs(transport, NULL, 0);
+	     ref; ref = ref->next) {
 		if (!starts_with(ref->name, "refs/tags/"))
 			continue;
 
@@ -301,8 +302,9 @@ static struct ref *get_ref_map(struct transport *transport,
 
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
+	const struct ref *remote_refs;
 
-	const struct ref *remote_refs = transport_get_remote_refs(transport);
+	remote_refs = transport_get_remote_refs(transport, NULL, 0);
 
 	if (refspec_count) {
 		struct refspec *fetch_refspec;
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 66cdd45..bce706e 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -94,7 +94,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	if (uploadpack != NULL)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
 
-	ref = transport_get_remote_refs(transport);
+	ref = transport_get_remote_refs(transport, NULL, 0);
 	if (transport_disconnect(transport))
 		return 1;
 
diff --git a/builtin/remote.c b/builtin/remote.c
index fda5c2e..5745e8b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -862,7 +862,7 @@ static int get_remote_ref_states(const char *name,
 	if (query) {
 		transport = transport_get(states->remote, states->remote->url_nr > 0 ?
 			states->remote->url[0] : NULL);
-		remote_refs = transport_get_remote_refs(transport);
+		remote_refs = transport_get_remote_refs(transport, NULL, 0);
 		transport_disconnect(transport);
 
 		states->queried = 1;
diff --git a/transport-helper.c b/transport-helper.c
index b934183..b5c91d2 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -99,7 +99,7 @@ static void do_take_over(struct transport *transport)
 
 static void standard_options(struct transport *t);
 
-static struct child_process *get_helper(struct transport *transport)
+static struct child_process *get_helper(struct transport *transport, const struct refspec *req_refspecs, int req_refspec_nr)
 {
 	struct helper_data *data = transport->data;
 	struct strbuf buf = STRBUF_INIT;
@@ -267,7 +267,7 @@ static int set_helper_option(struct transport *transport,
 	struct strbuf buf = STRBUF_INIT;
 	int i, ret, is_bool = 0;
 
-	get_helper(transport);
+	get_helper(transport, NULL, 0);
 
 	if (!data->option)
 		return 1;
@@ -395,7 +395,7 @@ static int fetch_with_fetch(struct transport *transport,
 
 static int get_importer(struct transport *transport, struct child_process *fastimport)
 {
-	struct child_process *helper = get_helper(transport);
+	struct child_process *helper = get_helper(transport, NULL, 0);
 	struct helper_data *data = transport->data;
 	int cat_blob_fd, code;
 	child_process_init(fastimport);
@@ -418,7 +418,7 @@ static int get_exporter(struct transport *transport,
 			struct string_list *revlist_args)
 {
 	struct helper_data *data = transport->data;
-	struct child_process *helper = get_helper(transport);
+	struct child_process *helper = get_helper(transport, NULL, 0);
 	int i;
 
 	child_process_init(fastexport);
@@ -451,7 +451,7 @@ static int fetch_with_import(struct transport *transport,
 	struct ref *posn;
 	struct strbuf buf = STRBUF_INIT;
 
-	get_helper(transport);
+	get_helper(transport, NULL, 0);
 
 	if (get_importer(transport, &fastimport))
 		die("Couldn't run fast-import");
@@ -523,7 +523,7 @@ static int process_connect_service(struct transport *transport,
 	int r, duped, ret = 0;
 	FILE *input;
 
-	helper = get_helper(transport);
+	helper = get_helper(transport, NULL, 0);
 
 	/*
 	 * Yes, dup the pipe another time, as we need unbuffered version
@@ -599,7 +599,7 @@ static int connect_helper(struct transport *transport, const char *name,
 	struct helper_data *data = transport->data;
 
 	/* Get_helper so connect is inited. */
-	get_helper(transport);
+	get_helper(transport, NULL, 0);
 	if (!data->connect)
 		die("Operation not supported by protocol.");
 
@@ -805,7 +805,7 @@ static int push_refs_with_push(struct transport *transport,
 	struct string_list cas_options = STRING_LIST_INIT_DUP;
 	struct string_list_item *cas_option;
 
-	get_helper(transport);
+	get_helper(transport, NULL, 0);
 	if (!data->push)
 		return 1;
 
@@ -888,7 +888,7 @@ static int push_refs_with_export(struct transport *transport,
 			warning("helper %s does not support 'force'", data->name);
 	}
 
-	helper = get_helper(transport);
+	helper = get_helper(transport, NULL, 0);
 
 	write_constant(helper->in, "export\n");
 
@@ -992,7 +992,7 @@ static int has_attribute(const char *attrs, const char *attr) {
 	}
 }
 
-static struct ref *get_refs_list(struct transport *transport, int for_push)
+static struct ref *get_refs_list(struct transport *transport, const struct refspec *refspecs, int refspec_count, int for_push)
 {
 	struct helper_data *data = transport->data;
 	struct child_process *helper;
@@ -1001,11 +1001,11 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 	struct ref *posn;
 	struct strbuf buf = STRBUF_INIT;
 
-	helper = get_helper(transport);
+	helper = get_helper(transport, refspecs, refspec_count);
 
 	if (process_connect(transport, for_push)) {
 		do_take_over(transport);
-		return transport->get_refs_list(transport, for_push);
+		return transport->get_refs_list(transport, refspecs, refspec_count, for_push);
 	}
 
 	if (data->push && for_push)
diff --git a/transport.c b/transport.c
index 095e61f..e241e42 100644
--- a/transport.c
+++ b/transport.c
@@ -70,7 +70,9 @@ struct bundle_transport_data {
 	struct bundle_header header;
 };
 
-static struct ref *get_refs_from_bundle(struct transport *transport, int for_push)
+static struct ref *get_refs_from_bundle(struct transport *transport,
+					const struct refspec *refspecs,
+					int refspec_count, int for_push)
 {
 	struct bundle_transport_data *data = transport->data;
 	struct ref *result = NULL;
@@ -177,7 +179,7 @@ static int connect_setup(struct transport *transport, int for_push)
 	return 0;
 }
 
-static struct ref *get_refs_via_connect(struct transport *transport, int for_push)
+static struct ref *get_refs_via_connect(struct transport *transport, const struct refspec *refspecs, int refspec_count, int for_push)
 {
 	struct git_transport_data *data = transport->data;
 	struct ref *refs;
@@ -870,7 +872,7 @@ int transport_push(struct transport *transport,
 		if (check_push_refs(local_refs, refspec_nr, refspec) < 0)
 			return -1;
 
-		remote_refs = transport->get_refs_list(transport, 1);
+		remote_refs = transport->get_refs_list(transport, NULL, 0, 1);
 
 		if (flags & TRANSPORT_PUSH_ALL)
 			match_flags |= MATCH_REFS_ALL;
@@ -949,10 +951,10 @@ int transport_push(struct transport *transport,
 	return 1;
 }
 
-const struct ref *transport_get_remote_refs(struct transport *transport)
+const struct ref *transport_get_remote_refs(struct transport *transport, const struct refspec *refspecs, int refspec_count)
 {
 	if (!transport->got_remote_refs) {
-		transport->remote_refs = transport->get_refs_list(transport, 0);
+		transport->remote_refs = transport->get_refs_list(transport, refspecs, refspec_count, 0);
 		transport->got_remote_refs = 1;
 	}
 
@@ -1099,7 +1101,7 @@ static int refs_from_alternate_cb(struct alternate_object_database *e,
 	other[len - 8] = '\0';
 	remote = remote_get(other);
 	transport = transport_get(remote, other);
-	for (extra = transport_get_remote_refs(transport);
+	for (extra = transport_get_remote_refs(transport, NULL, 0);
 	     extra;
 	     extra = extra->next)
 		cb->fn(extra, cb->data);
diff --git a/transport.h b/transport.h
index c681408..e53d860 100644
--- a/transport.h
+++ b/transport.h
@@ -65,7 +65,7 @@ struct transport {
 	 * the ref without a huge amount of effort, it should store it
 	 * in the ref's old_sha1 field; otherwise it should be all 0.
 	 **/
-	struct ref *(*get_refs_list)(struct transport *transport, int for_push);
+	struct ref *(*get_refs_list)(struct transport *transport, const struct refspec *refspecs, int refspec_count, int for_push);
 
 	/**
 	 * Fetch the objects for the given refs. Note that this gets
@@ -207,7 +207,7 @@ int transport_push(struct transport *connection,
 		   int refspec_nr, const char **refspec, int flags,
 		   unsigned int * reject_reasons);
 
-const struct ref *transport_get_remote_refs(struct transport *transport);
+const struct ref *transport_get_remote_refs(struct transport *transport, const struct refspec *refspecs, int refspec_count);
 
 int transport_fetch_refs(struct transport *transport, struct ref *refs);
 void transport_unlock_pack(struct transport *transport);
-- 
2.4.2.767.g62658d5-twtrsrc
