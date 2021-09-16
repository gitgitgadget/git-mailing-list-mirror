Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0CFC433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 05:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8241A61164
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 05:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244613AbhIQFwU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 01:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbhIQFwR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 01:52:17 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3522AC061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 22:50:56 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c22so25649063edn.12
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 22:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:user-agent:in-reply-to:message-id
         :mime-version:content-transfer-encoding;
        bh=p2qGNqS6zhn1CqHnspm7K1jcn9vaAdPe3L0HnKx9Eb4=;
        b=mJui4UFXoNHexAiY/qc1dakrHNIuGIZcyEq5VxvherOoHR6RuDk5pMaVmlb2l4cJob
         VMdd0Ul9eVoGlrTRzImoSDxxlxpiBHF+JpbkuQUplCSb5t+E38CiybfXtawzz03FVW0I
         QOoXERdZ3J0vuVLiYuvNvzHtbwlR2NWdVrfKyzKJ80ug/R8QKVQsTMAQuySVStt8zGt3
         63k9NXdb2YL2XFGQV+WOyqEYTZzK7G3b8qxpsogyJRHgyy1QV7MIGbeaxa1E7u+2kwM3
         1F40rEvs9r2YlMBK4h6o2iKol8hwRDvxVCgmheoPgtRq5fjeerBTpZP1rEai9pnQaV+V
         sGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=p2qGNqS6zhn1CqHnspm7K1jcn9vaAdPe3L0HnKx9Eb4=;
        b=vsNqQhdTDPchLm5RAQpNJGvlv2Xhfu2PQhZCesHpamHSmtAV030S9nX1XrwiyonJoR
         dPULqsLYFzxPKp4DaMkP6XztsmeXKG8BCQ3rFFUUW3922z7e4qCZWUfLkJ2MC4u2+7aM
         2LUYbRcAKLmI7+JXpWaAhbTgh6BW0+7SUUIXKd45n5gjbiepkYf/i3b5/iBPG81VDpw8
         WTi4BrxzmHSWVXo9Zpm0u37l1EN4JzoqqFzGPVhaBWsUUufimFg+F0vvq2dsRABs0X7F
         7O0qduYWKPZAq4pgOviI7GghSAN691WchJg1ZFHX34e46p78gEEcvJqJYLS5K1bYoza+
         hcuQ==
X-Gm-Message-State: AOAM532TsMcj955eQ8FaszyMuV4idgRU8fvmE455VKMy1diFgTnAQ1Tg
        ZpTxCT3piaxPygeZIURRt0OoQ6jrT+ddEA==
X-Google-Smtp-Source: ABdhPJxx5WtoCNiw38xs6NvmNz1JGJH/n7qDeex2LCJ90w8leHNOBUTLibdE1M7ik7XMbsxmdvomMw==
X-Received: by 2002:a17:906:e82:: with SMTP id p2mr10266962ejf.50.1631857854538;
        Thu, 16 Sep 2021 22:50:54 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w9sm2173047edr.20.2021.09.16.22.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 22:50:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 12/25] progress.c: add & assert a "global_progress"
 variable
Date:   Thu, 16 Sep 2021 23:34:56 +0200
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <patch-8.8-1a14176bee-20210722T125012Z-avarab@gmail.com>
Message-ID: <877dffg37n.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I've adjusted the In-reply-to header here.

This is really in reply to <20210916183137.GD76263@szeder.dev>, but
that's a reply to a previous & longer RFC-ish iteration of the
series. https://lore.kernel.org/git/cover-0.8-0000000000-20210722T125012Z-a=
varab@gmail.com/
is what's currently queued as ab/only-single-progress-at-once in "seen".

Let's continue the discussion relevant to the currently proposed patches
in this thread.

On Thu, Sep 16 2021, SZEDER G=C3=A1bor wrote:

> On Wed, Jun 23, 2021 at 07:48:12PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> The progress.c code makes a hard assumption that only one progress bar
>> be active at a time (see [1] for a bug where this wasn't the case),
>> but nothing has asserted that that's the case. Let's add a BUG()
>> that'll trigger if two progress bars are active at the same time.
>
> I very much dislike the idea of any BUG() in the progress code that
> can trigger outside of the test suite.

First regarding the state of this series. I'd understood your:

    Please don't advance this to next yet.  I've found some issues with
    it, but not the time to raise them.

In https://lore.kernel.org/git/20210901050406.GB76263@szeder.dev/ to
mean (, by perhaps overly reading between the lines out of paranoia,)
that you'd found some case where we'd hit the BUG() here.

Am I correct that you haven't, but are concerned that we've left some
case undiscovered where we might?

I'm wondering given your replies there if you thought that the series to
be merged down was that 25 patch one. I agree (e.g. because of your
https://lore.kernel.org/git/20210916183711.GE76263@szeder.dev/) that
merging that one down wouldn't be a good idea in its current state.

Of course you may still have valid concerns etc., just trying to clarify
if there's some specific known outstanding issue or not with the current
8-patch series in "seen".

> As the number of progress-related fixes clearly show, we often misuse
> the progress API, and, arguably, a bug is a bug is a bug, so strictly
> speaking a BUG() is not wrong here.
>
> However, the progress line is merely a UI gimmick, not a crucial part
> of Git, and none of those progress bugs affected the correctness of
> the operation itself.  Worse, calling BUG() during some operations
> (e.g. 'git commit-graph write', the worst offender when it comes to
> progress bugs) can leave a lockfile behind, resulting in scary errors
> and requiring manual cleanup in the .git directory, which is a much
> worse UX than showing some bogus values or out of order progress
> lines.

Yes, I agree that actually hitting this BUG() would absolutely suck, and
that we shouldn't consider this patch if we weren't certain, or near
enough, that we wouldn't hit it.

As covered in the cover letter of the earlier series I sent (at
https://lore.kernel.org/git/cover-00.25-00000000000-20210623T155626Z-avarab=
@gmail.com/)
I share your concerns that it's hard to uncover if we've reached
sufficient coverage to be certain that we should add certain assertions,
i.e. some of the ones your initial series added around the actual
progress counting that we do.

In this case though, I do think we can safely add this. Maybe you have
run into the BUG() and I'm about to get some egg on my face, but here's
why I think we won't hit it.

This is a *much* narrower case than the general thread quagmire around
display_progress() etc., since this only covers the start/stop progress
calls. All of the multi-threaded code we have does the equivalent of:

    p =3D start_progress();
    start_threads();
    /* do stuff in threads, including with "p" */
    stop_threads();
    stop_progress(p);

Do you agree that if this is the pattern everywhere that this patch
would be safe in its current form?

To assert that that's the case (I'd read the code before) I instrumented
the tests to BUG() out if we ever start() or stop() where getpid() !=3D
gettid(), which on Linux means you're inside a pthread. The diff-on-top
is at the end of this E-Mail.

With that and running the tests with:

    GIT_TEST_BUG_START=3D1 \
    GIT_TEST_BUG_STOP=3D1

We pass all tests, i.e. there's no current callers that call
start_progress() or start_progress() and do so in anything but the main
program thread.

Well, there could be, per the concerns I had in the CL linked above,
i.e. sometimes that start_progress() is guarded by a preceding isatty()
or whatever, but having looked at those / grepped the union of pthread +
progress in the source I think there's no such cases. That's *much*
easier to eyeball than "does all this control flow around
display_progress() make sense?".

Getting back on topic, we pass all tests with that, but we'll fail with:

    GIT_TEST_BUG_DISPLAY=3D1 \
    GIT_TEST_BUG_DISPLAY_HARDER=3D1

Why the second variable? Because I marked up the two callers that call
display_progress() within threads, it's just index-pack and
pack-objects. If you don't set GIT_TEST_BUG_DISPLAY_HARDER=3D1 we'll
whitelist those two, and all tests pass.

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 6cc48902170..05c82dc6e6d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1229,6 +1229,7 @@ static void resolve_deltas(void)
 	QSORT(ofs_deltas, nr_ofs_deltas, compare_ofs_delta_entry);
 	QSORT(ref_deltas, nr_ref_deltas, compare_ref_delta_entry);
=20
+	no_progress_bug();
 	if (verbose || show_resolving_progress)
 		progress =3D start_progress(_("Resolving deltas"),
 					  nr_ref_deltas + nr_ofs_deltas);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ec8503563a6..97ad321f67c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3072,6 +3072,7 @@ static void prepare_pack(int window, int depth)
 	if (nr_deltas && n > 1) {
 		unsigned nr_done =3D 0;
=20
+		no_progress_bug();
 		if (progress)
 			progress_state =3D start_progress(_("Compressing objects"),
 							nr_deltas);
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index f3aba5d6cbb..efa1e5e5bdf 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -5,6 +5,9 @@
=20
 . ${0%/*}/lib.sh
=20
+export GIT_TEST_BUG_START=3Dtrue
+export GIT_TEST_BUG_STOP=3Dtrue
+
 case "$CI_OS_NAME" in
 windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")=
";;
 *) ln -s "$cache_dir/.prove" t/.prove;;
diff --git a/progress.c b/progress.c
index 14a023f4b43..bdebf100ad8 100644
--- a/progress.c
+++ b/progress.c
@@ -16,6 +16,7 @@
 #include "trace.h"
 #include "utf8.h"
 #include "config.h"
+#include <unistd.h>
=20
 #define TP_IDX_MAX      8
=20
@@ -202,8 +203,18 @@ void display_throughput(struct progress *progress, uin=
t64_t total)
 		display(progress, progress->last_value, NULL);
 }
=20
+static int no_bug_please;
+void no_progress_bug(void)
+{
+	no_bug_please =3D 1;
+}
+
 void display_progress(struct progress *progress, uint64_t n)
 {
+	if (getpid() !=3D gettid() && getenv("GIT_TEST_BUG_DISPLAY") &&
+	    (getenv("GIT_TEST_BUG_DISPLAY_HARDER") || !no_bug_please))
+		BUG("display: pid =3D %d, tid =3D %d: %s\n", getpid(), gettid(),
+		    progress ? progress->title : "N/A");
 	if (progress)
 		display(progress, n, NULL);
 }
@@ -281,6 +292,11 @@ static struct progress *start_progress_delay(const cha=
r *title, uint64_t total,
 	progress->split =3D 0;
 	set_progress_signal(progress);
 	trace2_region_enter("progress", title, the_repository);
+
+	if (getpid() !=3D gettid() && getenv("GIT_TEST_BUG_START"))
+		BUG("start: pid =3D %d, tid =3D %d: %s\n", getpid(), gettid(),
+		    title ? title : "N/A");
+
 	return progress;
 }
=20
@@ -334,6 +350,11 @@ static void finish_if_sparse(struct progress *progress)
=20
 void stop_progress(struct progress **p_progress)
 {
+	no_bug_please =3D 0;
+	if (getpid() !=3D gettid() && getenv("GIT_TEST_BUG_STOP"))
+		BUG("stop: pid =3D %d, tid =3D %d: %s\n", getpid(), gettid(),
+		    ((p_progress && *p_progress) ? (*p_progress)->title : "N/A"));
+
 	if (!p_progress)
 		BUG("don't provide NULL to stop_progress");
=20
diff --git a/progress.h b/progress.h
index f1913acf73f..2ebb1da2666 100644
--- a/progress.h
+++ b/progress.h
@@ -20,5 +20,6 @@ struct progress *start_delayed_sparse_progress(const char=
 *title,
 					       uint64_t total);
 void stop_progress(struct progress **progress);
 void stop_progress_msg(struct progress **progress, const char *msg);
+void no_progress_bug(void);
=20
 #endif
