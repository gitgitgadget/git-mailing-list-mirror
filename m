Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E05C636C9
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 839E1611C1
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbhGTJt3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237659AbhGTJqO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:46:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC22BC061341
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:31 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d12so25375779wre.13
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QbBMDDH6pr5hKmJWPfK7Eu/bWEEx+jmTSktgti/nTfs=;
        b=FKTGlV6Iw+xP0i5fut6I5vVGj8HgwpePlVu8mK/hoFTfIQQzwCvXQuApF0D1PsdOiY
         maEsDEhiZ0mbYG4WCZeL2QTZT6za9rJcvLCiAJGu0Hh5ua5txzuG1It7mNV3Rp7BuPfW
         wap9hSqtFBNZ2X7T2nzvqDXXNx84gxe++CxQOAMn/Qclg86qZAqsLVo12wZcrICK8l20
         raHqJ3/z0OZ4dCIfXBz/8jLmaUR9Q/BQZcvr1CvrVTX+0OCh8NFppi++BjabtNZf72t6
         4s0paFH6WwEjSzh39TnaWpri+hsigAvHoHDeXYWw9rAhwpOs0LW8pwyZE/REAnhUEPjv
         trXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QbBMDDH6pr5hKmJWPfK7Eu/bWEEx+jmTSktgti/nTfs=;
        b=kJg6C/MZZbwkJKyUqQlx43t7A8l+cA/aTIOVI22JcmkUIq7EVV3qhzHc2H29PHdjqU
         cSEsLuCEkCmOAnKh6taxXBPYLGzmhGFfQjgYnDt+9DreSoMpLjFBDdWW4g9fh/GmzIsq
         aUDgQ8R0tK/ytODOdrenaRMRTswPLEgmzLDBrdHPH144pdN5HsCXb1fAJ88/CLpZHxeD
         PHkBtujy75Pudbi9nQy9hpogJUlMtyJt7sK6K94YbLbpy1PqCjqs1yipKOrPmxmSlvlw
         EFo8D9pkkn/dxXnqyEAckMspb9Hr9gpmTixE9TCpAqDdd2L8pxKx49dnU9xjycB5VWPf
         3mig==
X-Gm-Message-State: AOAM533ApfPo1rQ8HYaBbsvQfWD/qEd9XJMJ0HP0FO5h91lgn0NuJSoM
        8dEVO0N0h8v82ldCdVBFGQTDxo1d10JLGQ==
X-Google-Smtp-Source: ABdhPJyCnEuJpoXfJYIuX545AFOuUyfalougMHWN30roYaRfiHwdpZO9aEKfHhmDSiBw2dc4XDq4XQ==
X-Received: by 2002:a5d:4c8c:: with SMTP id z12mr36313318wrs.97.1626776670160;
        Tue, 20 Jul 2021 03:24:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l23sm9684536wme.22.2021.07.20.03.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:24:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/12] reflog expire: don't lock reflogs using previously seen OID
Date:   Tue, 20 Jul 2021 12:24:14 +0200
Message-Id: <patch-09.12-1050743e27c-20210720T102051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com> <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
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
now-NULL "oid" argument, and other code that can be simplified now
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
 refs/files-backend.c |  4 ++--
 2 files changed, 8 insertions(+), 9 deletions(-)

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
index 92f49cfb7d4..819351c82fc 100644
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
@@ -3111,7 +3111,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		}
 	}
 
-	assert(oideq(&lock->old_oid, oid));
+	assert(!oid);
 	(*prepare_fn)(refname, &lock->old_oid, cb.policy_cb);
 	refs_for_each_reflog_ent(ref_store, refname, expire_reflog_ent, &cb);
 	(*cleanup_fn)(cb.policy_cb);
-- 
2.32.0.874.ge7a9d58bfcf

