Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95635C636CA
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 876A7613E8
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240316AbhGPOQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240460AbhGPOQV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 10:16:21 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22A7C061764
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:13:25 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d12so12229087wre.13
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ZenKHIZoNm9ef3GfmGRxVWQMfhVZAff6Jexs/sxezc=;
        b=jTle2sDN0iGcn6JYj5UpqMvxLwLBdS7l6VxW4LJsEvMJlF3b9e4PVQQAxwdQ7uesRr
         /IZzeLYI5PSfPyNKGOVz1QTNb5Af8eTlb4WZtOTCPBBVg21eWLxzb/X1jAFxP/tkBhjx
         y0vOpaOOUzhTsLiGRZrHht8afSKPUoTk3DpvuE2j6UwfIygCX0O7s+8VP955OprPxjke
         6017yDBUit5JlYvy48RPMCyRsFQ/haDqVssYJWqybCgllu7VTcO9/1VJgVg/3cy1iBOk
         FDum9jkdU5YHjlTxev1IR7wrFx+RNlQ8o8AJ08Kqus7SGKG/jZkrcjpwM0YuzU6X+Whi
         51IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ZenKHIZoNm9ef3GfmGRxVWQMfhVZAff6Jexs/sxezc=;
        b=cvCe68rin/Que67jzR5aXMCdd5MXKROI8Q/2xtjpqqeFOMPAWpqLfaU1a0MyIvVPNZ
         nsemU4aJQWQ52yQDpjuGiP0T2OaOGZMUgV02v0aMyBCFYylmozijJ+aFfq6MxnAV2O4l
         820pmsoF9s9Apm5VShaZb47N0bZHjafm5cb9Sk4MAcJLck9GwVcrhcgaTexvsauIqbCU
         VXrA8xe2LEAitr+j94HzP2L0pPbMHtY7th12qGE70C+Ky5mLGrGDhYOquVvZ9cTSQacI
         DosFFaAjdFmPAy35QTQ4O0IKDUJzXbPynyeKqXwyXB+zhRCtTDpxS19nCFF5vv+6qduC
         Lk3A==
X-Gm-Message-State: AOAM533pkr9OYhErzkgzyhO96jUquDell7sMiyT+zuL86xunzeCupPMo
        CUWfyh8xe4k2K6auYPYaMrvrLxeGBZt3DQ==
X-Google-Smtp-Source: ABdhPJzm36ktB62bZCDFLa0ixxqdOnw5Bo2fR8G35uPeF0vNelIXeSym8srOcH3SFvZ4TfPcOIGPQA==
X-Received: by 2002:a5d:5609:: with SMTP id l9mr12768366wrv.123.1626444804098;
        Fri, 16 Jul 2021 07:13:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a9sm10101363wrv.37.2021.07.16.07.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 07:13:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/11] reflog expire: don't lock reflogs using previously seen OID
Date:   Fri, 16 Jul 2021 16:13:05 +0200
Message-Id: <patch-09.11-60d6cf342fc-20210716T140631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.gfa1990a4f10
In-Reply-To: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com> <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During reflog expiry, the cmd_reflog_expire() function first iterates
over all reflogs in logs/*, and then one-by-one acquires the lock for
each one and expires it. This behavior has been with us since this
command was implemented in 4264dc15e1 ("git reflog expire",
2006-12-19).

Change this to stop calling lock_ref_oid_basic() with the OID we saw
when we looped over the logs, instead have it pass the OID it managed
to lock.

This mostly mitigates a race condition where e.g. "git gc" will fail
in a concurrently updated repository because the branch moved since
"git reflog expire --all" was started. I.e. with:

    error: cannot lock ref '<refname>': ref '<refname>' is at <OID-A> but expected <OID-B>

This behavior of passing in an "oid" was needed for an edge-case that
I've untangled in this and preceding commits though, namely that we
needed this OID because we'd:

 1. Lookup the reflog name/OID via dwim_log()
 2. With that OID, lock the reflog
 3. Later in builtin/reflog.c we use the we looked as input to
    lookup_commit_reference_gently(), assured that it's equal to the
    OID we got from dwim_log().

What do I mean with "mostly" above? It mostly mitigates it because
we'll still run into cases where the ref is locked and being updated
as we want to expire it, and other git processes wanting to update the
refs will in turn race with us as we expire the reflog.

This remaining race can in turn be mitigated with the
core.filesRefLockTimeout setting, see 4ff0f01cb7 ("refs: retry
acquiring reference locks for 100ms", 2017-08-21). In practice if that
value is high enough we'll probably never have ref updates or reflog
expiry failing, since the clients involved will retry for far longer
than the time any of those operations could take.

See [1] for an initial report of how this impacted "git gc" and a
large discussion about this change in early 2019. In particular patch
looked good to Michael Haggerty his[2], but that seems to not have
made it to the ML archive, its content is quoted in full in my [3].

I'm leaving behind now-unused code the refs API etc. that takes the
now-NULL "oid" argument, and other code that can be simplified now
that we never have on OID in that context, that'll be cleaned up in
subsequent commits, but for now let's narrowly focus on fixing the
"git gc" issue

Unfortunately this sort of probabilistic contention is hard to turn
into a test. I've tested this by running the following three subshells
in concurrent terminals:

    (
        rm -rf /tmp/git &&
        git init /tmp/git &&
        while true
        do
            head -c 10 /dev/urandom | hexdump >/tmp/git/out &&
            git -C /tmp/git add out &&
            git -C /tmp/git commit -m"out"
        done
    )

    (
	rm -rf /tmp/git-clone &&
        git clone file:///tmp/git /tmp/git-clone &&
        while git -C /tmp/git-clone pull
        do
            date
        done
    )

    (
        while git -C /tmp/git-clone reflog expire --all
        do
            date
        done
    )

Before this change the "reflog expire" would fail really quickly with
a "but expected" error.

After this change both the "pull" and "reflog expire" will run for a
while, but eventually fail because I get unlucky with
core.filesRefLockTimeout (the "reflog expire" is in a really tight
loop). As noted above that can in turn be mitigated with higher values
of core.filesRefLockTimeout than the 100ms default.

As noted in the commentary added in the preceding commit there's also
the case of branches being racily deleted, that can be tested by
adding this to the above:

    (
        while git -C /tmp/git-clone branch topic master &&
	      git -C /tmp/git-clone branch -D topic
        do
            date
        done
    )

With core.filesRefLockTimeout set to 10 seconds (it can probably be a
lot lower) I managed to run all four of these concurrently for about
an hour, and accumulated ~125k commits, auto-gc's and all, and didn't
have a single failure.

1. https://lore.kernel.org/git/87tvg7brlm.fsf@evledraar.gmail.com/
2. http://lore.kernel.org/git/b870a17d-2103-41b8-3cbc-7389d5fff33a@alum.mit.edu
3. https://lore.kernel.org/git/87pnqkco8v.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c     | 13 ++++++-------
 refs/files-backend.c |  2 +-
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 9f9e6bceb03..4506852c471 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -629,8 +629,9 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		free_worktrees(worktrees);
 		for (i = 0; i < collected.nr; i++) {
 			struct collected_reflog *e = collected.e[i];
+
 			set_reflog_expiry_param(&cb.cmd, explicit_expiry, e->reflog);
-			status |= reflog_expire(e->reflog, &e->oid, flags,
+			status |= reflog_expire(e->reflog, NULL, flags,
 						reflog_expiry_prepare,
 						should_expire_reflog_ent,
 						reflog_expiry_cleanup,
@@ -642,13 +643,12 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 
 	for (; i < argc; i++) {
 		char *ref;
-		struct object_id oid;
-		if (!dwim_log(argv[i], strlen(argv[i]), &oid, &ref)) {
+		if (!dwim_log(argv[i], strlen(argv[i]), NULL, &ref)) {
 			status |= error(_("%s points nowhere!"), argv[i]);
 			continue;
 		}
 		set_reflog_expiry_param(&cb.cmd, explicit_expiry, ref);
-		status |= reflog_expire(ref, &oid, flags,
+		status |= reflog_expire(ref, NULL, flags,
 					reflog_expiry_prepare,
 					should_expire_reflog_ent,
 					reflog_expiry_cleanup,
@@ -700,7 +700,6 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 
 	for ( ; i < argc; i++) {
 		const char *spec = strstr(argv[i], "@{");
-		struct object_id oid;
 		char *ep, *ref;
 		int recno;
 
@@ -709,7 +708,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (!dwim_log(argv[i], spec - argv[i], &oid, &ref)) {
+		if (!dwim_log(argv[i], spec - argv[i], NULL, &ref)) {
 			status |= error(_("no reflog for '%s'"), argv[i]);
 			continue;
 		}
@@ -724,7 +723,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 			cb.cmd.expire_total = 0;
 		}
 
-		status |= reflog_expire(ref, &oid, flags,
+		status |= reflog_expire(ref, NULL, flags,
 					reflog_expiry_prepare,
 					should_expire_reflog_ent,
 					reflog_expiry_cleanup,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f73637fa087..cb8c64cffb5 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3060,7 +3060,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_oid_basic(refs, refname, oid,
+	lock = lock_ref_oid_basic(refs, refname, NULL,
 				  REF_NO_DEREF,
 				  &type, &err);
 	if (!lock) {
-- 
2.32.0.873.gb6f2f696497

