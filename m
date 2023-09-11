Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E54DCA0EC8
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 02:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240673AbjILCvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 22:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240581AbjILCus (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 22:50:48 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D354E24799
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 16:05:09 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id 6a1803df08f44-64d09183380so50203476d6.0
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 16:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694473424; x=1695078224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g4eApIAE2yIJgjxtFHu/PsOEKqv95oiIu4u3JDz0loI=;
        b=YaXtxxWu2E/Gmj13s1avH/PoGNQ6nHnJi4TLLbLXD/a76ZNKAhfWWCRRxVQuduelQn
         H36meQZbS89QYnWgfCT/vooRD0Wc5L0147OrKth8BXEcimw0lyYHhOl86ENYdeBvbqkZ
         XeAtun2cKc5+aN9WFI62yvJL/g3PzHjDq0RLmoktD+jgQoZNcnINV2vdu8Fte0sxyg1G
         2oOyTj7HAoi9p2SO9zEmzwg9y8qIWGLbC4ur4une8iYbzZnOo9tPuvZJq2d67+F3NxTv
         A1Jm2tNYX4PST5tTSyDh/LNDqYGE5Y34tavDOKp7bOtRsTmeawNBpfvKU0mW6zuUtFOg
         tieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694473424; x=1695078224;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4eApIAE2yIJgjxtFHu/PsOEKqv95oiIu4u3JDz0loI=;
        b=cJKnLS77GQRcrcnqnOZvMHpQsIqk5sp082w2rFD5b/NJnFl21HtQ5lIZORtVUv98Ii
         jPY4j46/TDEyzOV/UDsxqKHWHoemiZNkugjaDNXf1pwCk74rdAwQn3nQJHDjohb3DWQy
         6ee1GRpgGKuVzIUvv/Ko/3g51Qa092EZbxbfr7ENcvIKJOjCYBO1LyAEOPwoGlEGb8W1
         AcnwS5oY+2jedcMJFmI+UL4orkO2eEICIau8MkQu7Nyn1FFRpIPW5HPReMDV2vEP4jRi
         6TRIhI574li6NdmuRuRbbeMHH2wQeX4ORedODzQzTvUJS2nxN2OT9uFPKm2EUMGQqzu5
         m8nw==
X-Gm-Message-State: AOJu0YwqpmP6k91X5soAuMA9ZDeBxJBd4xX23VNWnHecWdEQMAI43LZQ
        /rRdTdOYjIb5xxBYdHBckpv1x5PHf76UqMwKaHW5fkD+YPGCoxCEAG6gSB6QbljmItv0vAI1QJS
        EXlw25bHPFIUp3gr/DMjKhIChP/qH7QzhZa9xSLemTEkKEMBFa0n2TwRlBIdpHN10r9EGc4BeKR
        z/
X-Google-Smtp-Source: AGHT+IHvSCnXAIUXqBHKRqivZyD7ikbD8FfjAqItJdQURjCAq2ETky9zoCD07DvQ4HSpsE8b4+Po6jCenLmVzToOBvoD
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:622e:802b:6d3:1364])
 (user=jonathantanmy job=sendgmr) by 2002:a81:450f:0:b0:569:e04a:238f with
 SMTP id s15-20020a81450f000000b00569e04a238fmr253013ywa.4.1694471519979; Mon,
 11 Sep 2023 15:31:59 -0700 (PDT)
Date:   Mon, 11 Sep 2023 15:31:56 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230911223157.446269-1-jonathantanmy@google.com>
Subject: [RFC PATCH] Not computing changed path filter for root commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, szeder.dev@gmail.com,
        me@ttaylorr.com, derrickstolee@github.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is following the discussion about adding a new changed path filter
version due to the current implementation of murmur3 not matching the
algorithm. [1]

SZEDER G=C3=A1bor suggested [2] that we change the revision walk to read
changed path filters also for root commits, but I don't think that's
possible - we have to tie reading changed path filters to when we read
trees, and right now, we don't seem to read trees when evaluating root
commits (rev_compare_tree() in revision.c is in the only code path that
uses changed path filters, and it itself is only called per-parent and
thus not called for root commits). The alternative is to not generate
changed path filters for root commits (or what I did in this patch,
which is to generate an all-1 filter), which seems reasonable to me.

Is this a good idea? If yes, there is the follow-up question of how to
report it in traces. I don't know off-hand if it's better to reuse the
"large" statistic, since what we output is the same (all 1s), or if we
should make a new one. Presumably what we need to weigh is the clarity
versus the migration costs, but I don't know how to weigh it.

If people are generally in agreement, I can send an updated patch that
does not goto into an "else" block :) and also with updated tests (t0095
needs to check a non-root commit, and t4216 needs to be updated with
whatever statistics we decide to use).

[1] https://lore.kernel.org/git/20230826150610.GA1928@szeder.dev/
[2] https://lore.kernel.org/git/20230830200218.GA5147@szeder.dev/
---
 bloom.c              |  3 ++-
 t/t0095-bloom.sh     |  2 +-
 t/t4216-log-bloom.sh | 12 +++---------
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/bloom.c b/bloom.c
index aef6b5fea2..b21130b236 100644
--- a/bloom.c
+++ b/bloom.c
@@ -226,7 +226,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct=
 repository *r,
 	if (c->parents)
 		diff_tree_oid(&c->parents->item->object.oid, &c->object.oid, "", &diffop=
t);
 	else
-		diff_tree_oid(NULL, &c->object.oid, "", &diffopt);
+		goto large;
 	diffcore_std(&diffopt);
=20
 	if (diff_queued_diff.nr <=3D settings->max_changed_paths) {
@@ -292,6 +292,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct=
 repository *r,
 	} else {
 		for (i =3D 0; i < diff_queued_diff.nr; i++)
 			diff_free_filepair(diff_queued_diff.queue[i]);
+large:
 		init_truncated_large_filter(filter);
=20
 		if (computed)
diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
index b567383eb8..02a0b41026 100755
--- a/t/t0095-bloom.sh
+++ b/t/t0095-bloom.sh
@@ -74,7 +74,7 @@ test_expect_success !SANITIZE_LEAK 'get bloom filters for=
 commit with no changes
 	git commit --allow-empty -m "c0" &&
 	cat >expect <<-\EOF &&
 	Filter_Length:1
-	Filter_Data:00|
+	Filter_Data:ff|
 	EOF
 	test-tool bloom get_filter_for_commit "$(git rev-parse HEAD)" >actual &&
 	test_cmp expect actual
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index fa9d32facf..d14fe93fb1 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -283,7 +283,6 @@ test_expect_success 'correctly report changes over limi=
t' '
 			git commit-graph write --reachable --changed-paths &&
 		test_max_changed_paths 11 trace-update &&
 		test_filter_computed 2 trace-update &&
-		test_filter_trunc_large 0 trace-update &&
=20
 		for path in $(git ls-tree -r --name-only HEAD)
 		do
@@ -306,9 +305,7 @@ test_expect_success 'correctly report commits with no c=
hanged paths' '
 		GIT_TRACE2_EVENT=3D"$(pwd)/trace.event" \
 			git commit-graph write --reachable --changed-paths &&
 		test_filter_computed 1 trace.event &&
-		test_filter_not_computed 0 trace.event &&
-		test_filter_trunc_empty 1 trace.event &&
-		test_filter_trunc_large 0 trace.event
+		test_filter_not_computed 0 trace.event
 	)
 '
=20
@@ -363,8 +360,7 @@ test_expect_success '--max-new-filters overrides config=
uration' '
 				--max-new-filters=3D1 &&
 		test_filter_computed 1 trace.event &&
 		test_filter_not_computed 1 trace.event &&
-		test_filter_trunc_empty 0 trace.event &&
-		test_filter_trunc_large 0 trace.event
+		test_filter_trunc_empty 0 trace.event
 	)
 '
=20
@@ -386,9 +382,7 @@ test_expect_success 'Bloom generation backfills empty c=
ommits' '
 				git commit-graph write --reachable \
 					--changed-paths --max-new-filters=3D2 &&
 			test_filter_computed 2 trace.event &&
-			test_filter_not_computed 4 trace.event &&
-			test_filter_trunc_empty 2 trace.event &&
-			test_filter_trunc_large 0 trace.event || return 1
+			test_filter_not_computed 4 trace.event || return 1
 		done &&
=20
 		# Finally, make sure that once all commits have filters, that
--=20
2.42.0.283.g2d96d420d3-goog

