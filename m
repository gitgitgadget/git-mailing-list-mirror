Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0E9C433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 00:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387695AbiEFA4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 20:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387699AbiEFA4c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 20:56:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530313DA48
        for <git@vger.kernel.org>; Thu,  5 May 2022 17:52:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i5so8054805wrc.13
        for <git@vger.kernel.org>; Thu, 05 May 2022 17:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VPWFeBpdFmvcmoVhPvdC0ycQ8uj+OFqkkSBfjlGM+qE=;
        b=cDbM9FsVHvui8LsBdTBboThN8S5R4J6U48iKZNZ4Qkv36IspPMwwdpREHai3gq8FF1
         ekYnFW1sxuWIZHWFLu+J8CtyItS/8yj7J7l1IP9m5KcUf38qRIs8CGexkSrgbaNwCrx0
         SqkCqFOWKU2frY5pwbYl10fUE84WJ5cIrpCqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VPWFeBpdFmvcmoVhPvdC0ycQ8uj+OFqkkSBfjlGM+qE=;
        b=3ynZthqLAahzzIMltmd8JiXlNhFmtga2gk3BOk4zaRCpYxFcjj19AodEIEYf+ut04o
         x77YOHvEF7mWF8kbiQCdp+gPXd0sjVCV5/GF1q4BO0G3SwE0pfTan/b9XKlNWJgH8H3q
         LbyzMJjtWwKnH2ICCNKSbwjx5ZgZvrxyMBRw3DzHH8S9clwykMQvnWrfRq2L9kXybnlG
         dPWOY0exvYDEffkJFM5zGVu9+eJqIoV3Yl7kx0Mn872tx1thIrffPuDbBR4um2Yq9GVh
         b6P+XxAVe/wrlGNkK3fnmbQavTOWfg1Ngrsm1nfAcI3TD4VW19SX7AV+e+dTKje2AtAR
         ukeg==
X-Gm-Message-State: AOAM532qxxC5Rhdnx9TyXeyEq/hQwUhDl+l5PqTdI/n1Bgifi2pArofX
        b57KzfkWr34zfM0NmYB3T9PfBW8+BxicdsebDnk=
X-Google-Smtp-Source: ABdhPJwW2+7qgW8DS9jk8EMsiyss/9+1j3upPFu07haPk/9S9OHjjJYidOejEGvZIXP8PpzcEuc9lQ==
X-Received: by 2002:adf:d1e7:0:b0:20c:61a7:de2a with SMTP id g7-20020adfd1e7000000b0020c61a7de2amr550466wrd.332.1651798367497;
        Thu, 05 May 2022 17:52:47 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8600:5ee4:2aff:fe50:f48d])
        by smtp.gmail.com with ESMTPSA id u21-20020a7bc055000000b003942a244ee6sm2560459wmc.43.2022.05.05.17.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 17:52:47 -0700 (PDT)
Date:   Fri, 6 May 2022 01:52:46 +0100
From:   Chris Down <chris@chrisdown.name>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>, kernel-team@fb.com
Subject: [PATCH v2 1/2] bisect: output state before we are ready to compute
 bisection
Message-ID: <11edd3e4dbaac7fada8a3bcd43f4bbd353087637.1651796862.git.chris@chrisdown.name>
References: <cover.1651796862.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651796862.git.chris@chrisdown.name>
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
 bisect.h                    |  6 +++++
 builtin/bisect--helper.c    | 54 ++++++++++++++++++++++++++++---------
 t/t6030-bisect-porcelain.sh | 18 +++++++++++++
 3 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/bisect.h b/bisect.h
index 1015aeb8ea..ccd9ad31f6 100644
--- a/bisect.h
+++ b/bisect.h
@@ -62,6 +62,12 @@ enum bisect_error {
 	BISECT_INTERNAL_SUCCESS_MERGE_BASE = -11
 };
 
+struct bisect_state {
+	int nr_good;  /* How many good commits do we have? */
+	int nr_bad;   /* How many bad commits do we have? (Well, you can only
+			  have 0 or 1, but...) */
+};
+
 enum bisect_error bisect_next_all(struct repository *r, const char *prefix);
 
 int estimate_bisect_steps(int all);
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 8b2b259ff0..9d583f651c 100644
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
+	int *nr = (int *)cb_data;
+	(*nr)++;
+	return 0;
 }
 
 static const char need_bad_and_good_revision_warning[] =
@@ -384,23 +384,49 @@ static int decide_next(const struct bisect_terms *terms,
 			     vocab_good, vocab_bad, vocab_good, vocab_bad);
 }
 
-static int bisect_next_check(const struct bisect_terms *terms,
-			     const char *current_term)
+static struct bisect_state bisect_status(const struct bisect_terms *terms)
 {
-	int missing_good = 1, missing_bad = 1;
 	char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
 	char *good_glob = xstrfmt("%s-*", terms->term_good);
+	struct bisect_state bs;
+
+	memset(&bs, 0, sizeof(bs));
 
 	if (ref_exists(bad_ref))
-		missing_bad = 0;
+		bs.nr_bad = 1;
 
-	for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
-			     (void *) &missing_good);
+	for_each_glob_ref_in(inc_nr, good_glob, "refs/bisect/",
+			     (void *) &bs.nr_good);
 
 	free(good_glob);
 	free(bad_ref);
 
-	return decide_next(terms, current_term, missing_good, missing_bad);
+	return bs;
+}
+
+static void bisect_print_status(const struct bisect_terms *terms)
+{
+	const struct bisect_state bs = bisect_status(terms);
+
+	/* If we had both, we'd already be started, and shouldn't get here. */
+	if (bs.nr_good && bs.nr_bad)
+		return;
+
+	if (!bs.nr_good && !bs.nr_bad)
+		printf(_("status: waiting for both good and bad commits\n"));
+	else if (bs.nr_good)
+		printf(Q_("status: waiting for bad commit, %d good commit known\n",
+			  "status: waiting for bad commit, %d good commits known\n",
+			  bs.nr_good), bs.nr_good);
+	else
+		printf(_("status: waiting for good commit(s), bad commit known\n"));
+}
+
+static int bisect_next_check(const struct bisect_terms *terms,
+			     const char *current_term)
+{
+	const struct bisect_state bs = bisect_status(terms);
+	return decide_next(terms, current_term, !bs.nr_good, !bs.nr_bad);
 }
 
 static int get_terms(struct bisect_terms *terms)
@@ -606,8 +632,10 @@ static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
 
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
index 5382e5d216..a02587d1a7 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -1025,4 +1025,22 @@ test_expect_success 'bisect visualize with a filename with dash and space' '
 	git bisect visualize -p -- "-hello 2"
 '
 
+test_expect_success 'bisect state output with multiple good commits' '
+       git bisect reset &&
+       git bisect start >output &&
+       grep "waiting for both good and bad commits" output &&
+       git bisect good "$HASH1" >output &&
+       grep "waiting for bad commit, 1 good commit known" output &&
+       git bisect good "$HASH2" >output &&
+       grep "waiting for bad commit, 2 good commits known" output
+'
+
+test_expect_success 'bisect state output with bad commit' '
+       git bisect reset &&
+       git bisect start >output &&
+       grep "waiting for both good and bad commits" output &&
+       git bisect bad "$HASH4" >output &&
+       grep -F "waiting for good commit(s), bad commit known" output
+'
+
 test_done
-- 
2.36.0

