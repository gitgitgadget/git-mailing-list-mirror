Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7361C00523
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 06:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837C42081E
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 06:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tpag8PyE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgAHGIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 01:08:46 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37961 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgAHGIq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 01:08:46 -0500
Received: by mail-qk1-f193.google.com with SMTP id k6so1692864qki.5
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 22:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g3bOCGmvyrFM/EKf79q2ecBr1+/UfFICUWMo/p6bZkU=;
        b=tpag8PyEWxD0FmyDgG/d1alVkILRASqyVSFjf4DEE68OTV6Q61Wg6ew3xJOqxorRn/
         LcyIgvht7HVtIv+3byWixYXBZJeC3nlGsue6hx4RywIteA5GLQxrmkAbt9dF7uQ8xP8z
         cDN94pd/hAU7HcUFCOm0zEkN5g7BoHvTjOjRkY9OaSGMfZFxeqAxCUv5mQACkiK6tnFo
         rwufsFlQ07XX6yvM8weP6GQyJZOKnBOvbUpbtK4lXzQ/xn0HMKvYqnE2I9dCfd2LGdEd
         5ZUL8y3tHQAUAwoxPVXAPQYp8ot0cgze7XdvVuxRpHSvlxQK8c265NSNFpC43d7dutcT
         6yAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g3bOCGmvyrFM/EKf79q2ecBr1+/UfFICUWMo/p6bZkU=;
        b=nLx4tI0WmUuFUCCQQQ4Dd7C07z5R9gIo73vaGIL6AqdB4RFOVSjT3yAdh6LTQ0993X
         DkU3HdVC3P89I6G4egNK0OdJ6ERmXZHL3ejJmIU/uAQveg2+COVnC9kvU/0YU7hHCT6w
         4vZWy4w0aoEvCSYD59lORv5ojUHTfyIxlKqBxDiFPO1iagl5CtQKKPptqp2yJTU4Lt4f
         CA+87/rsZ/c7Pv+DcVhJ/pdFJyIbSUISUUWK5WoH4vFF05fVWucwB5i/GKRa7kTsiKyJ
         ukmtPrd4Konyc+p2fZeZzbMw5ssStQHoAf4IuRI1eO5rWhgFfk0kwORinSpNOFpWrkNa
         5OOQ==
X-Gm-Message-State: APjAAAV2qFSQVkCx1NHZtRt7WX2E7l9bLIQSPvw5VECCaP0bEQDam6Fl
        wVBoGbXYmryU2QnN8MPkS3w=
X-Google-Smtp-Source: APXvYqzccN3u4ioOSXsAapUgJYVJgNZpvQX5SQxbnUbumXTbga9s0Sdx+FdlEOShT1vfqYSW1h/HXg==
X-Received: by 2002:a37:814:: with SMTP id 20mr2813183qki.314.1578463725019;
        Tue, 07 Jan 2020 22:08:45 -0800 (PST)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id r80sm941542qke.134.2020.01.07.22.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 22:08:44 -0800 (PST)
Date:   Wed, 8 Jan 2020 01:08:42 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 00/17] merge: learn --autostash
Message-ID: <20200108060842.GA51465@generichostname>
References: <cover.1571246693.git.liu.denton@gmail.com>
 <cover.1577185374.git.liu.denton@gmail.com>
 <xmqqo8vpfpri.fsf@gitster-ct.c.googlers.com>
 <4032e4bd-fa3d-54eb-fe95-38549dff3aaa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4032e4bd-fa3d-54eb-fe95-38549dff3aaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Sorry for the late reply. I'm back in school so I've been pretty busy
lately.

On Tue, Dec 31, 2019 at 10:34:30AM +0000, Phillip Wood wrote:
> For `merge --autostash` I think we need to consider the interaction of
> `--no-commit` with `--autostash` as `stash pop` will refuse to run if the
> merge modified any of the stashed paths.

The only time when we run the `stash pop` is when we either commit the
merge or abort it. With this in mind, what do you think of the following
test cases? If they look good, I can squash them into the appropriate
patch and send in a reroll.


	diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
	index e0c8a0bad4..af5db58e16 100755
	--- a/t/t7600-merge.sh
	+++ b/t/t7600-merge.sh
	@@ -727,6 +727,33 @@ test_expect_success 'conflicted merge with --autostash, --abort restores stash'
		test_cmp file.1 file
	 '
	 
	+test_expect_success 'completed merge with --no-commit and --autostash' '
	+	git reset --hard c1 &&
	+	git merge-file file file.orig file.9 &&
	+	git diff >expect &&
	+	git merge --no-commit --autostash c2 &&
	+	git stash show -p MERGE_AUTOSTASH >actual &&
	+	test_cmp expect actual &&
	+	git commit 2>err &&
	+	test_i18ngrep "Applied autostash." err &&
	+	git show HEAD:file >merge-result &&
	+	test_cmp result.1-5 merge-result &&
	+	test_cmp result.1-5-9 file
	+'
	+
	+test_expect_success 'aborted merge with --no-commit and --autostash' '
	+	git reset --hard c1 &&
	+	git merge-file file file.orig file.9 &&
	+	git diff >expect &&
	+	git merge --no-commit --autostash c2 &&
	+	git stash show -p MERGE_AUTOSTASH >actual &&
	+	test_cmp expect actual &&
	+	git merge --abort 2>err &&
	+	test_i18ngrep "Applied autostash." err &&
	+	git diff >actual &&
	+	test_cmp expect actual
	+'
	+
	 test_expect_success 'merge with conflicted --autostash changes' '
		git reset --hard c1 &&
		git merge-file file file.orig file.9y &&

Thanks,

Denton

> 
> Best Wishes
> 
> Phillip
