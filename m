Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFFD91F406
	for <e@80x24.org>; Mon, 14 May 2018 21:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeENV5w (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:57:52 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:49094 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752567AbeENV5r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:57:47 -0400
Received: by mail-ua0-f202.google.com with SMTP id l31-v6so18282680uae.15
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=mrq2ZshMpNr9Ko361GlwmOmrFbJMciRXKWjR9dQHDmY=;
        b=jrD/T7Ka1ZBhM6bqe4Q6JPHNvmp20dc0w2ULKUciiVu14kWi4+q6BYeTzYs9h2rc2O
         GBo80VC8AlaXLZB33IyYfEAP6Gtb7/hI/cafWv7u4eMFAJCPih/xl1TddZ0qoMGtZ72J
         wgWCnB6mkLV28vkdko46/TWJPS/1IhyccaAprWoCn4H9kKrezCgknjwohdcT2pz5TiuA
         ON3FGsQMlSVBlkTDQ/cnVvTWXsrKf+GmbYPMCjpOozHCslaSbVwJDw9RfmQxahIU6/ZR
         5PR4NtazfHCEHnK6YZ6XZqVK2jYX1Y3hxr2DPSSBquNaD1RKNCpxz27Z4HHZen+kkD+n
         Za6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=mrq2ZshMpNr9Ko361GlwmOmrFbJMciRXKWjR9dQHDmY=;
        b=HBE0Dc/tOdYNoi9rvNBh2rvtGO/TI8NRTU9L1nKvKfjkDYspc1Dqd+n7gqOD4qVweT
         wJYB8NzSJXDc9jq0AoMvVAQDdsTl7OJkMK8uyPpv3jkVZKFYvR76vJhfdWVkMofsu2mv
         KftYBMKTwnOq/p4z3LaYB8E9CtsBveH6QiVizHakl7Z50F1bsodHVD2oq6vhiDp8m6pd
         +AH8Lduu5DwksP3AQNmN9g9U9MtKBxsCE1VCyn2B0Icg8YIw1RsDTAIg7G7T/MwU+GmN
         uxiBQCY3Wg2ibUvUCPaQtJidc2KxfqKgfVcN7PpY+mBOdy+sHCObM4qExqnt+GKHPKXV
         tKnA==
X-Gm-Message-State: ALKqPwflu5S7QMqkk3qt5jhg2VM+PjDc2TSLq2ZELwNMQL+X+X0qLrvp
        Qke9/uZJQWknz2Cl+vT9/+4AxoP8jgV7dA8Qcm/IhAerd2k+vdmZFkiRlOGZe0U8/77mqhsgqK5
        f9zfPLXcYpS5GWJy/RN/dSPdGJs5NvUbhVrN7RTCzTxUyaKhWwy4yPv7LWQ==
X-Google-Smtp-Source: AB8JxZrnw+2O/Pyc/sYWOm1RbhhfHzXht78l62sHBi+McSeSXC8GhkiOGQwmV2RqL7b0lT7wiD+NfMYxMC8=
MIME-Version: 1.0
X-Received: by 2002:a9f:3ed8:: with SMTP id n24-v6mr12468172uaj.78.1526335067098;
 Mon, 14 May 2018 14:57:47 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:19 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-29-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 28/35] push: convert to use struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the refspecs in builtin/push.c to be stored in a 'struct
refspec' instead of being stored in a list of 'struct refspec_item's.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/push.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index df5df6c0d..ef42979d1 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -57,19 +57,10 @@ static enum transport_family family;
 
 static struct push_cas_option cas;
 
-static const char **refspec;
-static int refspec_nr;
-static int refspec_alloc;
+static struct refspec rs = REFSPEC_INIT_PUSH;
 
 static struct string_list push_options_config = STRING_LIST_INIT_DUP;
 
-static void add_refspec(const char *ref)
-{
-	refspec_nr++;
-	ALLOC_GROW(refspec, refspec_nr, refspec_alloc);
-	refspec[refspec_nr-1] = ref;
-}
-
 static const char *map_refspec(const char *ref,
 			       struct remote *remote, struct ref *local_refs)
 {
@@ -138,7 +129,7 @@ static void set_refspecs(const char **refs, int nr, const char *repo)
 			}
 			ref = map_refspec(ref, remote, local_refs);
 		}
-		add_refspec(ref);
+		refspec_append(&rs, ref);
 	}
 }
 
@@ -226,7 +217,7 @@ static void setup_push_upstream(struct remote *remote, struct branch *branch,
 	}
 
 	strbuf_addf(&refspec, "%s:%s", branch->refname, branch->merge[0]->src);
-	add_refspec(refspec.buf);
+	refspec_append(&rs, refspec.buf);
 }
 
 static void setup_push_current(struct remote *remote, struct branch *branch)
@@ -236,7 +227,7 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
 	if (!branch)
 		die(_(message_detached_head_die), remote->name);
 	strbuf_addf(&refspec, "%s:%s", branch->refname, branch->refname);
-	add_refspec(refspec.buf);
+	refspec_append(&rs, refspec.buf);
 }
 
 static int is_workflow_triangular(struct remote *remote)
@@ -253,7 +244,7 @@ static void setup_default_push_refspecs(struct remote *remote)
 	switch (push_default) {
 	default:
 	case PUSH_DEFAULT_MATCHING:
-		add_refspec(":");
+		refspec_append(&rs, ":");
 		break;
 
 	case PUSH_DEFAULT_UNSPECIFIED:
@@ -341,7 +332,8 @@ static void advise_ref_needs_force(void)
 	advise(_(message_advice_ref_needs_force));
 }
 
-static int push_with_options(struct transport *transport, int flags)
+static int push_with_options(struct transport *transport, struct refspec *rs,
+			     int flags)
 {
 	int err;
 	unsigned int reject_reasons;
@@ -363,7 +355,7 @@ static int push_with_options(struct transport *transport, int flags)
 
 	if (verbosity > 0)
 		fprintf(stderr, _("Pushing to %s\n"), transport->url);
-	err = transport_push(transport, refspec_nr, refspec, flags,
+	err = transport_push(transport, rs->raw_nr, rs->raw, flags,
 			     &reject_reasons);
 	if (err != 0) {
 		fprintf(stderr, "%s", push_get_color(PUSH_COLOR_ERROR));
@@ -397,6 +389,7 @@ static int do_push(const char *repo, int flags,
 	struct remote *remote = pushremote_get(repo);
 	const char **url;
 	int url_nr;
+	struct refspec *push_refspec = &rs;
 
 	if (!remote) {
 		if (repo)
@@ -417,10 +410,9 @@ static int do_push(const char *repo, int flags,
 	if (push_options->nr)
 		flags |= TRANSPORT_PUSH_OPTIONS;
 
-	if (!refspec && !(flags & TRANSPORT_PUSH_ALL)) {
-		if (remote->push.raw_nr) {
-			refspec = remote->push.raw;
-			refspec_nr = remote->push.raw_nr;
+	if (!push_refspec->nr && !(flags & TRANSPORT_PUSH_ALL)) {
+		if (remote->push.nr) {
+			push_refspec = &remote->push;
 		} else if (!(flags & TRANSPORT_PUSH_MIRROR))
 			setup_default_push_refspecs(remote);
 	}
@@ -432,7 +424,7 @@ static int do_push(const char *repo, int flags,
 				transport_get(remote, url[i]);
 			if (flags & TRANSPORT_PUSH_OPTIONS)
 				transport->push_options = push_options;
-			if (push_with_options(transport, flags))
+			if (push_with_options(transport, push_refspec, flags))
 				errs++;
 		}
 	} else {
@@ -440,7 +432,7 @@ static int do_push(const char *repo, int flags,
 			transport_get(remote, NULL);
 		if (flags & TRANSPORT_PUSH_OPTIONS)
 			transport->push_options = push_options;
-		if (push_with_options(transport, flags))
+		if (push_with_options(transport, push_refspec, flags))
 			errs++;
 	}
 	return !!errs;
@@ -631,7 +623,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		flags |= TRANSPORT_RECURSE_SUBMODULES_ONLY;
 
 	if (tags)
-		add_refspec("refs/tags/*");
+		refspec_append(&rs, "refs/tags/*");
 
 	if (argc > 0) {
 		repo = argv[0];
-- 
2.17.0.441.gb46fe60e1d-goog

