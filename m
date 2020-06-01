Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1D8C433DF
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 18:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 648AC206C3
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 18:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Uduab5Dm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbgFASzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729811AbgFASBd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 14:01:33 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD082C05BD43
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 11:01:33 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m7so261168plt.5
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 11:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h1eOsJrDkG75kqiqFndS4cHdncP2ghe18/Y5Cane21E=;
        b=Uduab5Dm/sINVSrZlu6geF9rS4r5oJcKmDSv3MQj2yJyBVavVRVSfj6dU77MCt3PNJ
         nOIQPtYdF4oFYvCIKey62hpyaJvfzL44ONVfSwg64IyGVSLjAEY0Nn4dhVIKhYHH0GrN
         RVjK3oCpIzR6R816LbEmqyidfYkChisHIkH60FSdsPkWVc1MvLyH55zKjf6MmV8H3brD
         DkUJvf3kGnpPujaDnz9CeW8bM21Gty51HQBnM4Cn/MYLjRih3PgRCr2GXX0uIHNFgFjR
         hgYC7lBPY4H1qxSwxgHrVtR5EWlhG7qIsa4nR5KUZ9S0bgHhx9lfIOZ+8Pjt+WOt2Dxs
         a6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h1eOsJrDkG75kqiqFndS4cHdncP2ghe18/Y5Cane21E=;
        b=l3pcGSexmEkZFFL5rMJe0JjNPtKu13TePC7bhXrv8fzac1lpJQGv9+YKDJArRuUH3F
         5XER+wgqLBvPyELp8PJKLHWmyX/RGkC0C8h+R80rwTfdn8DGjFFqHJ0nY4B7oyCoXUX+
         jRI1FU+aCOnrckfv4xLP9TEh8fOw9FE51R3+ePVp2LrNO7OMII7SIJnWuo2+TXzoWm5D
         I8I40aEdVUgCZRc+qyXYubZUuHapiAJMBmGD8qmSaBbNyfZghTrRKA383iZmeO1rC66a
         vO/xm/o6aKvg4Xi8HkaOHW+HCmUrPp9tvt+RC2AgyVsS8esKGT3CLWf3Ac45LKhwWrpO
         0wdQ==
X-Gm-Message-State: AOAM531k03P5TDFhA/PlRjKr6erdANEybt+i0j114xupUufcoHNU6e/r
        ZMDIx8X9vSoom+GDl8EJLvdIrMBrPEM=
X-Google-Smtp-Source: ABdhPJysP3Ez2QYVF+/0203Kp+QCXrVE59hwy8NBWs9aFF9vjFza7bCPsJo/QcA760iNuqUaDQ3nGw==
X-Received: by 2002:a17:90a:6584:: with SMTP id k4mr611857pjj.171.1591034492918;
        Mon, 01 Jun 2020 11:01:32 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id l23sm84501pff.80.2020.06.01.11.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 11:01:32 -0700 (PDT)
Date:   Mon, 1 Jun 2020 12:01:31 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com
Subject: [PATCH 2/2] t5318: test that '--stdin-commits' respects
 '--[no-]progress'
Message-ID: <cc6b3749abc039f8502f490d3b7c7cad485810bc.1591034353.git.me@ttaylorr.com>
References: <cover.1591034353.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1591034353.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following lines were not covered in a recent line-coverage test
against Git:

  builtin/commit-graph.c
  5b6653e5 244) progress = start_delayed_progress(
  5b6653e5 268) stop_progress(&progress);

These statements are executed when both '--stdin-commits' and
'--progress' are passed. Introduce a trio of tests that exercise various
combinations of these options to ensure that these lines are covered.

More importantly, this is exercising a (somewhat) previously-ignored
feature of '--stdin-commits', which is that it respects '--progress'.
Prior to 5b6653e523 (builtin/commit-graph.c: dereference tags in
builtin, 2020-05-13), dereferencing input from '--stdin-commits' was
done inside of commit-graph.c.

Now that an additional progress meter may be generated from outside of
commit-graph.c, add a corresponding test to make sure that it also
respects '--[no]-progress'.

The other location that generates progress meter output (from d335ce8f24
(commit-graph.c: show progress of finding reachable commits,
2020-05-13)) is already covered by any test that passes '--reachable'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5318-commit-graph.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index d23986f603..26f332d6a3 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -162,6 +162,27 @@ test_expect_success 'commit-graph write with the --no-progress option' '
 	test_must_be_empty err
 '
 
+test_expect_success 'commit-graph write --stdin-commits progress off for redirected stderr' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git rev-parse commits/5 >in &&
+	git commit-graph write --stdin-commits <in 2>err &&
+	test_must_be_empty err
+'
+
+test_expect_success 'commit-graph write --stdin-commits force progress on for stderr' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git rev-parse commits/5 >in &&
+	GIT_PROGRESS_DELAY=0 git commit-graph write --stdin-commits --progress <in 2>err &&
+	test_i18ngrep "Collecting commits from input" err
+'
+
+test_expect_success 'commit-graph write --stdin-commits with the --no-progress option' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git rev-parse commits/5 >in &&
+	git commit-graph write --stdin-commits --no-progress <in 2>err &&
+	test_must_be_empty err
+'
+
 test_expect_success 'commit-graph verify progress off for redirected stderr' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph verify 2>err &&
-- 
2.26.2.1052.gcc6b3749ab
