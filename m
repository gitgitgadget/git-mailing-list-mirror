Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B46C433F5
	for <git@archiver.kernel.org>; Wed, 11 May 2022 18:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345980AbiEKSAg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 14:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345992AbiEKSAO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 14:00:14 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC366FA3D
        for <git@vger.kernel.org>; Wed, 11 May 2022 11:00:12 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id kl21so2637360qvb.9
        for <git@vger.kernel.org>; Wed, 11 May 2022 11:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MCcojyDFGEH5xMYRHfLhxeU5siVLIr1xF5P/67zZtKE=;
        b=Gfj/G9jmeIgF87uDQopxjN6+CNeAWBoU3cRd4xlwXdaam7v8CGRA6iVxBGruwLxtgG
         hkDPJZgkDrn+OcEaAOwiNigtCOZ6ML2NBDwVZk5qCqd+PJ/sS+GdCWm9XnGebLLsDhPZ
         IMjMQ02+P3QXyiOCl1K8Jxy/J7BwHTVjn1e40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MCcojyDFGEH5xMYRHfLhxeU5siVLIr1xF5P/67zZtKE=;
        b=Kt2TXGLvzoC8cK/elXE3pjfdPt0usQ8XKBtynfSr19BNrU4zjizyO4Xy0pOLh0QFbw
         ml36craNFhmmdVpdunWJaVHLKvAFu7SUX+x0pOisRjMTQEe32NmSbPsu9uIC8iCQWoNG
         t6ZL7EzhomEaEAXEKNxJBLwmNQBOCPURGmUVEM5GKI8qr81qwbbxc7YH78RoTm1jPvaR
         4k8oB3vnvKlD+bMMNssWjescuAGaYHLaSzV2wobdClomESBq6KnxVVgjgjjzGNF9TB8f
         +JTdNzgYODARaFhwD0qXSj3z2/rVDcxw4se01kr/cvlJiGmoSLivYbwY5e4lPNqCC6nW
         MT0w==
X-Gm-Message-State: AOAM532dazpyVhsyRtRcGM5z5Zkm7C3RbaY4kws54J40wp/vq4Vcvpam
        YoYJ9RsQbPJpVeRIuab7R0rDpOZ2hTamBru4eVo=
X-Google-Smtp-Source: ABdhPJxFWqXLGgyWPY/RWn0f00vOhlUyVMUvK8Ur6TycmApi8BHXAQO7+pX8W+bCVCs11Vng8HRXqg==
X-Received: by 2002:a05:6214:13e5:b0:458:812:217e with SMTP id ch5-20020a05621413e500b004580812217emr23144164qvb.60.1652292011028;
        Wed, 11 May 2022 11:00:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e9fd])
        by smtp.gmail.com with ESMTPSA id x22-20020a05620a099600b0069fc13ce216sm1491853qkx.71.2022.05.11.11.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 11:00:10 -0700 (PDT)
Date:   Wed, 11 May 2022 19:00:09 +0100
From:   Chris Down <chris@chrisdown.name>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>, kernel-team@fb.com
Subject: [PATCH v3 1/2] bisect: output state before we are ready to compute
 bisection
Message-ID: <2cd916580524d0d303b252687e29a064a3aaa387.1652291688.git.chris@chrisdown.name>
References: <cover.1652291688.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1652291688.git.chris@chrisdown.name>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 73c6de06aff8 ("bisect: don't use invalid oid as rev when
starting") changes the behaviour of `git bisect` to consider invalid
oids as pathspecs again, as in the old shell implementation.

While that behaviour may be desirable, it can also cause confusion. For
example, while bisecting in a particular repo I encountered this:

    $ git bisect start d93ff48803f0 v6.3
    $

...which led to me sitting for a few moments, wondering why there's no
printout stating the first rev to check.

It turns out that the tag was actually "6.3", not "v6.3", and thus the
bisect was still silently started with only a bad rev, because
d93ff48803f0 was a valid oid and "v6.3" was silently considered to be a
pathspec.

While this behaviour may be desirable, it can be confusing, especially
with different repo conventions either using or not using "v" before
release names, or when a branch name or tag is simply misspelled on the
command line.

In order to avoid situations like this, make it more clear what we're
waiting for:

    $ git bisect start d93ff48803f0 v6.3
    status: waiting for good commit(s), bad commit known

We already have good output once the bisect process has begun in
earnest, so we don't need to do anything more there.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 bisect.h                    |  9 +++++++
 builtin/bisect--helper.c    | 53 ++++++++++++++++++++++++++++---------
 t/t6030-bisect-porcelain.sh | 18 +++++++++++++
 3 files changed, 67 insertions(+), 13 deletions(-)

diff --git a/bisect.h b/bisect.h
index 1015aeb8ea..ee3fd65f3b 100644
--- a/bisect.h
+++ b/bisect.h
@@ -62,6 +62,15 @@ enum bisect_error {
 	BISECT_INTERNAL_SUCCESS_MERGE_BASE = -11
 };
 
+/*
+ * Stores how many good/bad commits we have stored for a bisect. nr_bad can
+ * only be 0 or 1.
+ */
+struct bisect_state {
+	unsigned int nr_good;
+	unsigned int nr_bad;
+};
+
 enum bisect_error bisect_next_all(struct repository *r, const char *prefix);
 
 int estimate_bisect_steps(int all);
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 8b2b259ff0..fa8024a864 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -329,12 +329,12 @@ static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
 	return 0;
 }
 
-static int mark_good(const char *refname, const struct object_id *oid,
-		     int flag, void *cb_data)
+static int inc_nr(const char *refname, const struct object_id *oid,
+		  int flag, void *cb_data)
 {
-	int *m_good = (int *)cb_data;
-	*m_good = 0;
-	return 1;
+	unsigned int *nr = (unsigned int *)cb_data;
+	(*nr)++;
+	return 0;
 }
 
 static const char need_bad_and_good_revision_warning[] =
@@ -384,23 +384,48 @@ static int decide_next(const struct bisect_terms *terms,
 			     vocab_good, vocab_bad, vocab_good, vocab_bad);
 }
 
-static int bisect_next_check(const struct bisect_terms *terms,
-			     const char *current_term)
+static void bisect_status(struct bisect_state *state,
+			  const struct bisect_terms *terms)
 {
-	int missing_good = 1, missing_bad = 1;
 	char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
 	char *good_glob = xstrfmt("%s-*", terms->term_good);
 
 	if (ref_exists(bad_ref))
-		missing_bad = 0;
+		state->nr_bad = 1;
 
-	for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
-			     (void *) &missing_good);
+	for_each_glob_ref_in(inc_nr, good_glob, "refs/bisect/",
+			     (void *) &state->nr_good);
 
 	free(good_glob);
 	free(bad_ref);
+}
+
+static void bisect_print_status(const struct bisect_terms *terms)
+{
+	struct bisect_state state = { 0 };
+
+	bisect_status(&state, terms);
+
+	/* If we had both, we'd already be started, and shouldn't get here. */
+	if (state.nr_good && state.nr_bad)
+		return;
 
-	return decide_next(terms, current_term, missing_good, missing_bad);
+	if (!state.nr_good && !state.nr_bad)
+		printf(_("status: waiting for both good and bad commits\n"));
+	else if (state.nr_good)
+		printf(Q_("status: waiting for bad commit, %d good commit known\n",
+			  "status: waiting for bad commit, %d good commits known\n",
+			  state.nr_good), state.nr_good);
+	else
+		printf(_("status: waiting for good commit(s), bad commit known\n"));
+}
+
+static int bisect_next_check(const struct bisect_terms *terms,
+			     const char *current_term)
+{
+	struct bisect_state state = { 0 };
+	bisect_status(&state, terms);
+	return decide_next(terms, current_term, !state.nr_good, !state.nr_bad);
 }
 
 static int get_terms(struct bisect_terms *terms)
@@ -606,8 +631,10 @@ static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
 
 static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char *prefix)
 {
-	if (bisect_next_check(terms, NULL))
+	if (bisect_next_check(terms, NULL)) {
+		bisect_print_status(terms);
 		return BISECT_OK;
+	}
 
 	return bisect_next(terms, prefix);
 }
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 5382e5d216..686f6d5c7f 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -1025,4 +1025,22 @@ test_expect_success 'bisect visualize with a filename with dash and space' '
 	git bisect visualize -p -- "-hello 2"
 '
 
+test_expect_success 'bisect state output with multiple good commits' '
+	git bisect reset &&
+	git bisect start >output &&
+	grep "waiting for both good and bad commits" output &&
+	git bisect good "$HASH1" >output &&
+	grep "waiting for bad commit, 1 good commit known" output &&
+	git bisect good "$HASH2" >output &&
+	grep "waiting for bad commit, 2 good commits known" output
+'
+
+test_expect_success 'bisect state output with bad commit' '
+	git bisect reset &&
+	git bisect start >output &&
+	grep "waiting for both good and bad commits" output &&
+	git bisect bad "$HASH4" >output &&
+	grep -F "waiting for good commit(s), bad commit known" output
+'
+
 test_done
-- 
2.36.0

