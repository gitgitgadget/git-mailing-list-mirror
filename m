Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D043BC433DF
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 00:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFEEA20823
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 00:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxCwSlUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbgFIAEC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731558AbgFIAD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 20:03:56 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0625C08C5C3
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 17:03:45 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id y17so19294111wrn.11
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 17:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rWjDBeDXv+puIR2JG/Srjp+KkmK0iV8uZb0jzyreUXY=;
        b=IxCwSlUuj6pzK8iY26dBCwCiFLeozspjwT0rNGEyVQgZS4cgrmHD+R649zhsT3eR+f
         8af7KlrmxCLEHD75mTbZalpZ8YbAIrnwluvbJn/VdoQcjdVeQr7VpvofGLeVjK5V9YT8
         bSMmUs1Co6H6NQuCHW7W0nUkLTQPgJx2mXc5U+pDp/qaFLhuKgCBpc6f5CDFotyap7et
         kKAyiDuvckBTbIMGvXWAO3WaEPf5Jjj0+NCVL1/kkVKoE8iFf4uRMyDKcFEC8KC6NCR4
         Ou/UCNLBHPq0wcOW/MLADUEXB+XlQ63NUlydM/dv9Ua52pi4mhLPqgA7ZRrOWDoffw+y
         +VQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rWjDBeDXv+puIR2JG/Srjp+KkmK0iV8uZb0jzyreUXY=;
        b=MRYP/stcrwUHyLgHTQmE1le95vhAfkMlzC53gr+6oFqUCUp4d7BS348t1xtSzl5BTp
         hw2VA9Fvq/BJ1rqa9JS8a2Y4xHCyyeRVKOrXBESENA36iQi4PduvsNRe5jzLUhI03WRa
         115G/x62rEM1zvj4/TRZT59mJll8ItiQWSsqGk7ZBo0ps4g7dbevSBtRgH5dNON7GSTj
         zaoDQumu574uU8Fn59bX5AUft2njQYNnzVHfY952HU/O5fMCsNRqxNVEf/9EO4cDZtsk
         BGmsBb4/OpLNkSy97whVSvEwsSGLqK/g+Yor/3/S3imbhWVssjSxtMcAC6OuIHyvRUlT
         ZaeA==
X-Gm-Message-State: AOAM532na7lIpts37S9Scqh4GK8d1EGmxAzuVA2Lxt2Iu/FG01UAccnS
        CsdwN3aqYl5jRdxNN1QZyVOyBins
X-Google-Smtp-Source: ABdhPJw/xte1fhH8hMzIU6+7n8Repsj0nMpfWwAG92aaPDdiz8QhJwcgwtoAgjVGjgg+LdHnQ6wq9g==
X-Received: by 2002:adf:9021:: with SMTP id h30mr1301789wrh.19.1591661023921;
        Mon, 08 Jun 2020 17:03:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u13sm1283113wrp.53.2020.06.08.17.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 17:03:43 -0700 (PDT)
Message-Id: <414163bbc3cbdda241bedc7bc4dfb8b493071dcb.1591661021.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.git.git.1591661021.gitgitgadget@gmail.com>
References: <pull.804.git.git.1591661021.gitgitgadget@gmail.com>
From:   "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Jun 2020 00:03:39 +0000
Subject: [PATCH 1/3] t/t3430: avoid undocumented git diff behavior
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Chris Torek <chris.torek@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chris Torek <chris.torek@gmail.com>

According to the documentation, "git diff" takes at most two commit-ish,
or an A..B style range, or an A...B style symmetric difference range.
The autosquash-and-exec test relied on "git diff HEAD^!", which works
fine for ordinary commits as the revision parse produces two commit-ish,
namely ^HEAD^ and HEAD.

For merge commits, however, this test makes use of an undocumented
feature: the resulting revision parse has all the parents as UNINTERESTING
followed by the HEAD commit.  This looks identical to a symmetric
diff parse, which lists the merge bases as UNINTERESTING, followed by
the A (UNINTERESTING) and B revs.  So the diff winds up treating it
as one, using the first oid (i.e., HEAD^) and the last (i.e., HEAD).
The documentation, however, says nothing about this usage.

Since diff actually just uses HEAD^ and HEAD, call for these directly
here.  That makes it possible to improve the diff code's handling of
symmetric difference arguments.

Signed-off-by: Chris Torek <chris.torek@gmail.com>
---
 t/t3430-rebase-merges.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index a1bc3e20016..b454f400ebd 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -420,7 +420,7 @@ test_expect_success 'with --autosquash and --exec' '
 	git commit --fixup B B.t &&
 	write_script show.sh <<-\EOF &&
 	subject="$(git show -s --format=%s HEAD)"
-	content="$(git diff HEAD^! | tail -n 1)"
+	content="$(git diff HEAD^ HEAD | tail -n 1)"
 	echo "$subject: $content"
 	EOF
 	test_tick &&
-- 
gitgitgadget

