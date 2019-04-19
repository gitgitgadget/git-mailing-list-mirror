Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDFB120248
	for <e@80x24.org>; Fri, 19 Apr 2019 21:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfDSVAS (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 17:00:18 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:48885 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfDSVAS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 17:00:18 -0400
Received: by mail-ot1-f74.google.com with SMTP id 70so3355765otn.15
        for <git@vger.kernel.org>; Fri, 19 Apr 2019 14:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=d3MpMh0soJSj8Xaa9q+qOECYi2fSFCnOT5SposoeIsY=;
        b=engYvqMci89/YfBRhAZGS8qESHDU/pMBqOxeHr86pqWMdhc2sLW7gCd/8zuTDzBRyo
         lBkVIHYtDoY3EuN09+qKjPUFUN+HSMcuoLTyA3fvScoLbnZn584XupAtrE5Oou7ivmV9
         PY2MjmKX6YwjyZVzynf5e9ifdLGTHIe6L4Bd8o7vnCDXhvT5CerdvPe927sKPy0HL61U
         QYwUKgnriNkPu3bDtwHcAPJNIGU0how6W+Tb7bVrESiGC3KvEtS51a4JF/rdIqC4f3tN
         PcXQoKfJ93FxKtXlpGPVhGYzjkmKLnp5aIGP0UW3V3y25qQwDLNYpXbh7fwlhJ8zAg4R
         kvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d3MpMh0soJSj8Xaa9q+qOECYi2fSFCnOT5SposoeIsY=;
        b=pjIOHNShzVlNHM73n1RcszaUz1Xl4vZu4owrQOubCDvDNwEhR+hCWdQ6wsMJ62ej0Y
         Ng7xgMZtuJq/cNiQ1T2qkxP9q4cYXYU4wmizjrenkfflZqlTHTz+icKdviL6ykHBDrbB
         +EcWplmJXn3LThnzDCEDFvH9RPkyW0UOPZ8ILpIYK5QcoQlN9fLu8gYYOFvpliLozAcT
         q93oHqgsdAvWfc7FvrxLM8MhL4iMyXc2bgnqzvaju42euQFq1cEwHNwPBFYXApEgwb6w
         4jGt2P5Yp+xLGBpoNJ6WeTZ+sesnCthH10r8OWPHVLNDySKEg1KKKIPVvREB/9y6tXwc
         QITg==
X-Gm-Message-State: APjAAAXrvUtZ6QD6Rut1oaeIT2fZGgzV3rjKeTCqsnB1SeVOG2i1LFVW
        qhqtGYAV5bg/1n+kFzzDJ2obP6PKA4mfzJrtr3PC7PGHgQeuIUFo/LuxyD980OdSI5kQahqcdW3
        slDOhu3qgJCbq8ouRbVkiu5qwgIuDgsvxOZ7G+hZgtUd+QDbXQZHprLblUfMuJLQ=
X-Google-Smtp-Source: APXvYqxDa/fUyttllDp4OzRIOf4M9MwlR5Gi91ZX/XIXz4rgUI6Y5diCgk3jhtAslucAozqwZunwGhweQcOXxw==
X-Received: by 2002:aca:cf92:: with SMTP id f140mr2989915oig.48.1555707617196;
 Fri, 19 Apr 2019 14:00:17 -0700 (PDT)
Date:   Fri, 19 Apr 2019 14:00:13 -0700
In-Reply-To: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
Message-Id: <b4a285e2a199ea059c165aa344d037374797fa40.1555707373.git.steadmon@google.com>
Mime-Version: 1.0
References: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v4] clone: do faster object check for partial clones
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For partial clones, doing a full connectivity check is wasteful; we skip
promisor objects (which, for a partial clone, is all known objects), and
enumerating them all to exclude them from the connectivity check can
take a significant amount of time on large repos.

At most, we want to make sure that we get the objects referred to by any
wanted refs. For partial clones, just check that these objects were
transferred.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
This is an update of the original V1 approach (skipping the fully
connectivity check when doing a partial clone) with updated commit
message and comments to address the review concerns.


Range-diff against v1:
1:  9c29e1ce8d ! 1:  b4a285e2a1 clone: do faster object check for partial clones
    @@ -4,8 +4,8 @@
     
         For partial clones, doing a full connectivity check is wasteful; we skip
         promisor objects (which, for a partial clone, is all known objects), and
    -    excluding them all from the connectivity check can take a significant
    -    amount of time on large repos.
    +    enumerating them all to exclude them from the connectivity check can
    +    take a significant amount of time on large repos.
     
         At most, we want to make sure that we get the objects referred to by any
         wanted refs. For partial clones, just check that these objects were
    @@ -59,10 +59,12 @@
      
     +	if (opt->check_refs_only) {
     +		/*
    -+		 * For partial clones, we don't want to walk the full commit
    -+		 * graph because we're skipping promisor objects anyway. We
    -+		 * should just check that objects referenced by wanted refs were
    -+		 * transferred.
    ++		 * For partial clones, we don't want to have to do a regular
    ++		 * connectivity check because we have to enumerate and exclude
    ++		 * all promisor objects (slow), and then the connectivity check
    ++		 * itself becomes a no-op because in a partial clone every
    ++		 * object is a promisor object. Instead, just make sure we
    ++		 * received the objects pointed to by each wanted ref.
     +		 */
     +		do {
     +			if (!repo_has_object_file(the_repository, &oid))
    @@ -86,8 +88,8 @@
     +	/*
     +	 * If non-zero, only check the top-level objects referenced by the
     +	 * wanted refs (passed in as cb_data). This is useful for partial
    -+	 * clones, where this can be much faster than excluding all promisor
    -+	 * objects prior to walking the commit graph.
    ++	 * clones, where enumerating and excluding all promisor objects is very
    ++	 * slow and the commit-walk itself becomes a no-op.
     +	 */
     +	unsigned check_refs_only : 1;
      };

 builtin/clone.c |  6 ++++--
 connected.c     | 17 +++++++++++++++++
 connected.h     |  8 ++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 50bde99618..fdbbd8942a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -657,7 +657,8 @@ static void update_remote_refs(const struct ref *refs,
 			       const char *branch_top,
 			       const char *msg,
 			       struct transport *transport,
-			       int check_connectivity)
+			       int check_connectivity,
+			       int check_refs_only)
 {
 	const struct ref *rm = mapped_refs;
 
@@ -666,6 +667,7 @@ static void update_remote_refs(const struct ref *refs,
 
 		opt.transport = transport;
 		opt.progress = transport->progress;
+		opt.check_refs_only = !!check_refs_only;
 
 		if (check_connected(iterate_ref_map, &rm, &opt))
 			die(_("remote did not send all necessary objects"));
@@ -1224,7 +1226,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
 			   branch_top.buf, reflog_msg.buf, transport,
-			   !is_local);
+			   !is_local, filter_options.choice);
 
 	update_head(our_head_points_at, remote_head, reflog_msg.buf);
 
diff --git a/connected.c b/connected.c
index 1bba888eff..1ab481fed6 100644
--- a/connected.c
+++ b/connected.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "object-store.h"
 #include "run-command.h"
 #include "sigchain.h"
 #include "connected.h"
@@ -49,6 +50,22 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		strbuf_release(&idx_file);
 	}
 
+	if (opt->check_refs_only) {
+		/*
+		 * For partial clones, we don't want to have to do a regular
+		 * connectivity check because we have to enumerate and exclude
+		 * all promisor objects (slow), and then the connectivity check
+		 * itself becomes a no-op because in a partial clone every
+		 * object is a promisor object. Instead, just make sure we
+		 * received the objects pointed to by each wanted ref.
+		 */
+		do {
+			if (!repo_has_object_file(the_repository, &oid))
+				return 1;
+		} while (!fn(cb_data, &oid));
+		return 0;
+	}
+
 	if (opt->shallow_file) {
 		argv_array_push(&rev_list.args, "--shallow-file");
 		argv_array_push(&rev_list.args, opt->shallow_file);
diff --git a/connected.h b/connected.h
index 8d5a6b3ad6..ce2e7d8f2e 100644
--- a/connected.h
+++ b/connected.h
@@ -46,6 +46,14 @@ struct check_connected_options {
 	 * during a fetch.
 	 */
 	unsigned is_deepening_fetch : 1;
+
+	/*
+	 * If non-zero, only check the top-level objects referenced by the
+	 * wanted refs (passed in as cb_data). This is useful for partial
+	 * clones, where enumerating and excluding all promisor objects is very
+	 * slow and the commit-walk itself becomes a no-op.
+	 */
+	unsigned check_refs_only : 1;
 };
 
 #define CHECK_CONNECTED_INIT { 0 }
-- 
2.21.0.593.g511ec345e18-goog

