Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93CEE1F406
	for <e@80x24.org>; Wed, 16 May 2018 23:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeEPXAf (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 19:00:35 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:45134 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752343AbeEPW7r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:59:47 -0400
Received: by mail-qk0-f201.google.com with SMTP id z140-v6so2280818qka.12
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=mrq2ZshMpNr9Ko361GlwmOmrFbJMciRXKWjR9dQHDmY=;
        b=a/YwjmH2NZsSPaU8Tfi0nHb4ItgFpIX1p2alwY0KVnMJWLobHT1WbrMRgQs8Yb4SNd
         diuA+xlKOr5qEYWZ5qY7HUoBSHZRbWV2s8bs9pXffL36DpogggMkTh6Y5qRPc2iO+aQY
         hi/ewHkr6bnNprSDYJ6M0EHX8JPEzcJ6qW5mOs5i1mbJmiOW/DIeJRRRTekN9susUH+t
         KmicmE+kpD8G9WiEjLiFLI2xKEC8y7mx5l22pseK5V7ccEvPXAc0SX56Sv7wmRkmyfAg
         qmtn271NbvF76MtWZ11xN0Pxz+8SiGVEDYyzw2o07WZJetoA9faxDexx0PtSb8HtVrlm
         2mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=mrq2ZshMpNr9Ko361GlwmOmrFbJMciRXKWjR9dQHDmY=;
        b=NuLzz0OWCPZPqRv30XCizTjiHdEbkeF3EZHWwRuYtR5LikG8Bqn4Zeqw7MLhSjiaJQ
         znXbaa0wAujwEfZQk0tUrw0Efuloc7yKx3hVGbbFy0x4HiSWqSd++JhpvM3cuTf7uFhu
         0bgjAfZ+ISB8k6QEZ1IeZosQQtnZtCfhaBSzMAv8jDq3N/ch894pbrP+IC/u8MgPo0IQ
         jg9c3zQ0QbYxJGHzA5jnYvRDsqWc2C1FcjMXoZVRn2CcivrbdyrKg+Gtp9+42aeoAsoP
         tP4ftbz0bbJHjrPB2h2jFFE+8tE0gMlYyXz9ciPAg3o+n6f3j6TO4Ba+1Tm75oAadPAq
         ZH5w==
X-Gm-Message-State: ALKqPweKkGRZk8N48LOiacBbEVd10/cx89EgRnYlyGNOiFxttGtYSrMB
        SEMihha3P7jdR2He/hstt20wvwZz+X+AHNr2FO6scZeO/YGzg7QETJy5rGztEg0VIRJBGgMR7WO
        nOgR6Gp5eEJsNOKRLpMBk9PT2u8Kgh+KL8Tby4wC4wFpty9aWZeXlTjiCZg==
X-Google-Smtp-Source: AB8JxZrgafw04NJqLRQp8i9VjignyRuwoiLWJMm1eXEj4grJBqtHYoNcUkFv8ZYochFtKCqX3MidMtQleF8=
MIME-Version: 1.0
X-Received: by 2002:a0c:f946:: with SMTP id i6-v6mr2958556qvo.4.1526511586805;
 Wed, 16 May 2018 15:59:46 -0700 (PDT)
Date:   Wed, 16 May 2018 15:58:16 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-30-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 29/36] push: convert to use struct refspec
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

