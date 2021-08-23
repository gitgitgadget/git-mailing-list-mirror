Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48997C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AE4461361
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbhHWLhO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbhHWLhI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:37:08 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED559C061757
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:25 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so687173wms.4
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H5B8djGujbu/JyJreI6ZhAaipoCfWkLVE5+VILHd1Y8=;
        b=MwnoorlmSG9B8FDm4b3qWkFveP/C+fJ8h31k40oKjAOLnzOwBhksFPmDzKJZJ9tWWq
         z5gbckkvXFnFRKptBmEUhqPJ4lk8d2FXyrtUL+vJz/6Ye2Ut4r/aOwCF9adRcJlNrKD3
         XbFXnD5HrbNWSjSSV5EftjFPWPq7yrFEX+e4V/ncLth8OuKH9PAARsiatLvVO1VxWRnv
         xBh0iyMKNHxUbBufA/RBTIL/urXBbg6Kyyk2SW05vESQ14F4fncUBzAR5bcPQcvAhF+o
         mhE7+UoeBH9l8oM8/PRwDnUzjaKoXeHAa0qGGhv9Hk2LnCnPUeKKGXIU85s2ysNnkHlD
         I0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H5B8djGujbu/JyJreI6ZhAaipoCfWkLVE5+VILHd1Y8=;
        b=b9XSmn8Ic/2KQH8jS3fUFi3GEeJClMN8MevjnHLje+T7B3z5w3XuddYo96nWfNTWkg
         WmW1EOjL/o6uuF+7EH4FnZNw45iSTS0UFaQ9sJRLwlSq7Er1kr39SuFZPjLOXoAWeBYi
         yu93xcq77De1GrdngDfAz38Zhc6xWbrD1Uo9v4ZH4PaYdUuErmjhvQB4bg0+98pcZo0i
         BSbRSIMFYiOQvp4ts+fOnve1YNoefT2Y0XM4k/5erUmCFzZvH14PC4Xgf7vBbqGYwfPE
         tK0qLnFtWg72iW2n8gGjDeCLrh1n7A30nu125W+oHj40MeFcqU0gmFpIKXlr0DmdUB3t
         dJ0A==
X-Gm-Message-State: AOAM530LUJA6Xet3AY/1X/GNPy94gWp4ICIPTeWjanTcH1mgqkq7lLyS
        G8520oiukadr0k+PqXkVKbNeAcFaJO6RewzW
X-Google-Smtp-Source: ABdhPJxhdl5hsN8C1wfNZG5Nisk1CgfqhuG64dP8eK71tQWNPFP7S12S16LgoSYbjlNTrE2JjK3vug==
X-Received: by 2002:a7b:c8cd:: with SMTP id f13mr15981938wml.6.1629718584285;
        Mon, 23 Aug 2021 04:36:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g35sm20555313wmp.9.2021.08.23.04.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:36:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 09/13] reflog expire: don't lock reflogs using previously seen OID
Date:   Mon, 23 Aug 2021 13:36:10 +0200
Message-Id: <patch-v5-09.13-aba12606cea-20210823T113115Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.g438caf9576d
In-Reply-To: <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com> <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
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
 3. Later in builtin/reflog.c we use the OID we looked as input to
    lookup_commit_reference_gently(), assured that it's equal to the
    OID we got from dwim_log().

We can be sure that this change is safe to make because between
dwim_log (step #1) and lock_ref_oid_basic (step #2) there was no other
logic relevant to the OID or expiry run in the cmd_reflog_expire()
caller.

We can thus treat that code as a black box, before and after this
change it would get an OID that's been locked, the only difference is
that now we mostly won't be failing to get the lock due to the TOCTOU
race[0]. That failure was purely an implementation detail in how the
"current OID" was looked up, it was divorced from the locking
mechanism.

What do we mean with "mostly"? It mostly mitigates it because we'll
still run into cases where the ref is locked and being updated as we
want to expire it, and other git processes wanting to update the refs
will in turn race with us as we expire the reflog.

That remaining race can in turn be mitigated with the
core.filesRefLockTimeout setting, see 4ff0f01cb7 ("refs: retry
acquiring reference locks for 100ms", 2017-08-21). In practice if that
value is high enough we'll probably never have ref updates or reflog
expiry failing, since the clients involved will retry for far longer
than the time any of those operations could take.

See [1] for an initial report of how this impacted "git gc" and a
large discussion about this change in early 2019. In particular patch
looked good to Michael Haggerty, see his[2]. That message seems to not
have made it to the ML archive, its content is quoted in full in my
[3].

I'm leaving behind now-unused code the refs API etc. that takes the
now-NULL "unused_oid" argument, and other code that can be simplified now
that we never have on OID in that context, that'll be cleaned up in
subsequent commits, but for now let's narrowly focus on fixing the
"git gc" issue. As the modified assert() shows we always pass a NULL
oid to reflog_expire() now.

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
the "but expected" error noted above.

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
have a single failure. The loops visibly stall while waiting for the
lock, but that's expected and desired behavior.

0. https://en.wikipedia.org/wiki/Time-of-check_to_time-of-use
1. https://lore.kernel.org/git/87tvg7brlm.fsf@evledraar.gmail.com/
2. http://lore.kernel.org/git/b870a17d-2103-41b8-3cbc-7389d5fff33a@alum.mit.edu
3. https://lore.kernel.org/git/87pnqkco8v.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c     | 13 ++++++-------
 refs.h               |  2 +-
 refs/files-backend.c |  7 +++++--
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 09541d1c804..61795f22d53 100644
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
diff --git a/refs.h b/refs.h
index 48970dfc7e0..ddbf15f1c21 100644
--- a/refs.h
+++ b/refs.h
@@ -796,7 +796,7 @@ enum expire_reflog_flags {
  * expiration policy that is desired.
  *
  * reflog_expiry_prepare_fn -- Called once after the reference is
- *     locked.
+ *     locked. Called with the OID of the locked reference.
  *
  * reflog_expiry_should_prune_fn -- Called once for each entry in the
  *     existing reflog. It should return true iff that entry should be
diff --git a/refs/files-backend.c b/refs/files-backend.c
index fbcd0c790bc..d81bda8bc25 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3027,7 +3027,7 @@ static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
 }
 
 static int files_reflog_expire(struct ref_store *ref_store,
-			       const char *refname, const struct object_id *oid,
+			       const char *refname, const struct object_id *unused_oid,
 			       unsigned int flags,
 			       reflog_expiry_prepare_fn prepare_fn,
 			       reflog_expiry_should_prune_fn should_prune_fn,
@@ -3044,6 +3044,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	int status = 0;
 	int type;
 	struct strbuf err = STRBUF_INIT;
+	const struct object_id *oid;
 
 	memset(&cb, 0, sizeof(cb));
 	cb.flags = flags;
@@ -3055,12 +3056,13 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_oid_basic(refs, refname, oid, &type, &err);
+	lock = lock_ref_oid_basic(refs, refname, NULL, &type, &err);
 	if (!lock) {
 		error("cannot lock ref '%s': %s", refname, err.buf);
 		strbuf_release(&err);
 		return -1;
 	}
+	oid = &lock->old_oid;
 
 	/*
 	 * When refs are deleted, their reflog is deleted before the
@@ -3104,6 +3106,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		}
 	}
 
+	assert(!unused_oid);
 	(*prepare_fn)(refname, oid, cb.policy_cb);
 	refs_for_each_reflog_ent(ref_store, refname, expire_reflog_ent, &cb);
 	(*cleanup_fn)(cb.policy_cb);
-- 
2.33.0.662.g438caf9576d

