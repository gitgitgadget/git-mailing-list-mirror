Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B345C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 10:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 751C661101
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 10:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbhHSKGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 06:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237746AbhHSKGw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 06:06:52 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361C1C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 03:06:16 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so8116910oti.0
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 03:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZJLXuX0ObDBh73sgqCvIvgUyLQ522Lf57GzLSss+Qs0=;
        b=Owbu7djIv9IkGOyzLsjZ9/6Ulq7nvltDKZOhf3W7qEmax1hhiQGjgDsbL1k3mRlEog
         qjq6egaiarcRIPBpS8weeWnhm2kot3crgzqceGMePxEYZT4IqEdj3PgrAs1hzqj9Maeg
         3++2zZXTeJnBmyweK/jG8EIk2x6kl2PbZd5nIjtaLm03rxrxp6OLRzwMVpf7pB3DD42M
         hBZy/IiKnGK1nu1g+fTPPME2uXYVSG10gF3VhQkwuy+FGWGlDKgQijY0/1H9iAeSxfmg
         0/FTHEAboN35UOu1toEjH/2CDhtjBMveq102mNKCRa0WmHEEhJQocGOTliaJDh20Qgh0
         ZJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZJLXuX0ObDBh73sgqCvIvgUyLQ522Lf57GzLSss+Qs0=;
        b=XjNnfvawA0p9kYLZ7I0v6W7cfuMx/B/qetX+D8JoR9+xXppczrz6sZbXcWM1VEAMLi
         dAShh1Hf1AzrbLzReyMyWmPUZfLo9uTT2ZsJ3Enrh0rM6evx7RQ1Ugw7tL6VgbH+8ePS
         cQ0szYC+93i72ESyAnvsHBDKzK31Y4U9g4znmwUYfU6kzzHwTbj6p/4p16opLXRwsZY4
         pkY0sh/GjWKLclLLxtHEyTJ3zLo8zsrRgN3jlFcagS+HCDxjw9E7VBYZl2QGStLUHp55
         dZB6TXjttiO0sj24PIgngValQJBQ/7aP6sXvjnqnTVZW2scnjgxUmugMHjDN75FU1nid
         f3Zw==
X-Gm-Message-State: AOAM5327mP5Kl0HS+lyARKDO2kCspzGVKljRkm4t9XBCwtgujr1OBrcd
        kXupuphv8c8hH6tkMVpwvC4=
X-Google-Smtp-Source: ABdhPJzY6GiN9AwJIXrTOULXf8Gg+uyR6uO2Th9OhWlYtzTT592rajnpxYEiRy6H0ap6dAFqvavVfA==
X-Received: by 2002:a9d:d61:: with SMTP id 88mr10779758oti.40.1629367575489;
        Thu, 19 Aug 2021 03:06:15 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id g8sm7301otk.34.2021.08.19.03.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 03:06:15 -0700 (PDT)
Date:   Thu, 19 Aug 2021 03:06:12 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 09/11] reflog expire: don't lock reflogs using
 previously seen OID
Message-ID: <YR4tFHW7oVDjgOJC@carlos-mbp.lan>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
 <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
 <patch-09.11-60d6cf342fc-20210716T140631Z-avarab@gmail.com>
 <CAFQ2z_MhNgimn=7qcu-G823X=yTRT3xXrDP7qRiELShXY9A3AA@mail.gmail.com>
 <xmqqlf4y4g6v.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqlf4y4g6v.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 18, 2021 at 02:05:12PM -0700, Junio C Hamano wrote:
> Han-Wen Nienhuys <hanwen@google.com> writes:
> 
> > On Fri, Jul 16, 2021 at 4:13 PM Ævar Arnfjörð Bjarmason
> > <avarab@gmail.com> wrote:
> >> -                       status |= reflog_expire(e->reflog, &e->oid, flags,
> >> +                       status |= reflog_expire(e->reflog, NULL, flags,
> >>                                                 reflog_expiry_prepare,
> >
> > this causes reflog_expiry_prepare() to be called with a NULL oid. I'm
> > seeing a crash in do_lookup_replace_object() because of this in
> > t0031-reftable.sh.
> 
> Yeah, given that reflog_expire() is documented to take "oid is the
> old value of the reference", the change looks bogus to me too.
> 
> Ævar, what is going on here?

FWIW the crude revert of this commit (cut below for easy access)  does
almost (except for the pedantic fixes[1] that are expected with the next
fsmonitor rollup) allow a CI run[2] for "seen" to go fully to green.

Carlo

[1] https://lore.kernel.org/git/20210809063004.73736-1-carenas@gmail.com/
[2] https://github.com/carenas/git/runs/3370161764

--- >8 ---
Subject: [PATCH] Revert "reflog expire: don't lock reflogs using previously
 seen OID"

This reverts commit 8bb2a971949c50787809f14ccf1d2a5d5324f4e4.
---
 builtin/reflog.c     | 13 +++++++------
 refs.h               |  2 +-
 refs/files-backend.c |  5 +----
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 61795f22d5..09541d1c80 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -629,9 +629,8 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		free_worktrees(worktrees);
 		for (i = 0; i < collected.nr; i++) {
 			struct collected_reflog *e = collected.e[i];
-
 			set_reflog_expiry_param(&cb.cmd, explicit_expiry, e->reflog);
-			status |= reflog_expire(e->reflog, NULL, flags,
+			status |= reflog_expire(e->reflog, &e->oid, flags,
 						reflog_expiry_prepare,
 						should_expire_reflog_ent,
 						reflog_expiry_cleanup,
@@ -643,12 +642,13 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 
 	for (; i < argc; i++) {
 		char *ref;
-		if (!dwim_log(argv[i], strlen(argv[i]), NULL, &ref)) {
+		struct object_id oid;
+		if (!dwim_log(argv[i], strlen(argv[i]), &oid, &ref)) {
 			status |= error(_("%s points nowhere!"), argv[i]);
 			continue;
 		}
 		set_reflog_expiry_param(&cb.cmd, explicit_expiry, ref);
-		status |= reflog_expire(ref, NULL, flags,
+		status |= reflog_expire(ref, &oid, flags,
 					reflog_expiry_prepare,
 					should_expire_reflog_ent,
 					reflog_expiry_cleanup,
@@ -700,6 +700,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 
 	for ( ; i < argc; i++) {
 		const char *spec = strstr(argv[i], "@{");
+		struct object_id oid;
 		char *ep, *ref;
 		int recno;
 
@@ -708,7 +709,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (!dwim_log(argv[i], spec - argv[i], NULL, &ref)) {
+		if (!dwim_log(argv[i], spec - argv[i], &oid, &ref)) {
 			status |= error(_("no reflog for '%s'"), argv[i]);
 			continue;
 		}
@@ -723,7 +724,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 			cb.cmd.expire_total = 0;
 		}
 
-		status |= reflog_expire(ref, NULL, flags,
+		status |= reflog_expire(ref, &oid, flags,
 					reflog_expiry_prepare,
 					should_expire_reflog_ent,
 					reflog_expiry_cleanup,
diff --git a/refs.h b/refs.h
index 3e4ee01f8f..38773f3229 100644
--- a/refs.h
+++ b/refs.h
@@ -810,7 +810,7 @@ enum expire_reflog_flags {
  * expiration policy that is desired.
  *
  * reflog_expiry_prepare_fn -- Called once after the reference is
- *     locked. Called with the OID of the locked reference.
+ *     locked.
  *
  * reflog_expiry_should_prune_fn -- Called once for each entry in the
  *     existing reflog. It should return true iff that entry should be
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f546cc3cc3..e72cb0e43f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3078,7 +3078,7 @@ static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
 }
 
 static int files_reflog_expire(struct ref_store *ref_store,
-			       const char *refname, const struct object_id *unused_oid,
+			       const char *refname, const struct object_id *oid,
 			       unsigned int flags,
 			       reflog_expiry_prepare_fn prepare_fn,
 			       reflog_expiry_should_prune_fn should_prune_fn,
@@ -3095,7 +3095,6 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	int status = 0;
 	int type;
 	struct strbuf err = STRBUF_INIT;
-	const struct object_id *oid;
 
 	memset(&cb, 0, sizeof(cb));
 	cb.flags = flags;
@@ -3113,7 +3112,6 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		strbuf_release(&err);
 		return -1;
 	}
-	oid = &lock->old_oid;
 
 	/*
 	 * When refs are deleted, their reflog is deleted before the
@@ -3157,7 +3155,6 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		}
 	}
 
-	assert(!unused_oid);
 	(*prepare_fn)(refname, oid, cb.policy_cb);
 	refs_for_each_reflog_ent(ref_store, refname, expire_reflog_ent, &cb);
 	(*cleanup_fn)(cb.policy_cb);
-- 
2.33.0.476.gf000ecbed9

