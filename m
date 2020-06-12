Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622C1C433E0
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 16:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33E2020835
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 16:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSpdYdB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgFLQUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgFLQUF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 12:20:05 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE5FC08C5C1
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 09:20:05 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r7so10351515wro.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 09:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h8MOdG5ScNHrk8SrMGWVSBQUlVk0ldpdLpEf4d/7LXw=;
        b=YSpdYdB9lhFV6qUtZ2JzDq1Hkw4f2ej43irKNlqGT6QkpiEJA0rsDIJKUfG9x4ECdP
         cpD0lXs+7ah3iR2QV0+nB60CRh5g+vXfKzHHcB5+Ghc6MLERT6Viq/JgRYLynYs4DE54
         /zP+n9RuBeA0ayF4dzosCAwO45BWNbGxKNNll6+CU1AimaBJV1jZyEIgd40Lq5S5DYw2
         A0Hnb4MsqXEmBN4Cmhljk2YQI/eyVlfLSkyfGj9mIRdApiaojtr+VHRtLoimW4HOXiaw
         akAj6lR2CHslKWgWKY5PLuAgkkVGhIeY1MstpbXDtPyJfw7qhFxG22vkOZeOaevbEqGE
         fhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h8MOdG5ScNHrk8SrMGWVSBQUlVk0ldpdLpEf4d/7LXw=;
        b=ik77kbaiFZzNHJZ2oi/YRfz1kALHrtNlwOlaEWer0oRyKAX/h+2B5hH0qyhhtCQ8ne
         ASE4iEFCA6PRjutpehyNkFJTTXpePnGQ6y8kB3qkxSo+e2fW02VQXPnE5/+RAWhLiHVq
         MMX3S3ZtG79tLaEb/Z1xtF7l06XD6SFOpuzCyRH0ENAG1cgUoEyKfGlM1KrBI+z5B8I+
         B+V0X/h5Npe0sb+G6Cq7/xyz8DKT3IrYfhS4XxA/M9rQwj1J/I1ZI7e5f2V2F8rh1thl
         duviXNQUMcuvoXawz1yVDLZH3AFf9r2WN9GY6bcvPCsYOzJQgvpsHULXmAap8M1yD/TG
         1+kw==
X-Gm-Message-State: AOAM531ZhEwBTBqK/1iCKJiydBO8TvpY2koNS32NdsKb2VOFlUhePH0C
        KHc0PVueElBQB6NICnJ+N5dwroN0
X-Google-Smtp-Source: ABdhPJx75rLllcV4PuuTAzDrUfeEcQtJVYP26gQ46rho8IGgB70eWdueQ0947eRL/v+xTvA4CNwF+A==
X-Received: by 2002:adf:fe07:: with SMTP id n7mr15266124wrr.240.1591978803876;
        Fri, 12 Jun 2020 09:20:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y19sm9113953wmi.6.2020.06.12.09.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 09:20:03 -0700 (PDT)
Message-Id: <2ccaad645ff01b786e76dc63210d75da633389a6.1591978801.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.v4.git.git.1591978801.gitgitgadget@gmail.com>
References: <pull.804.v3.git.git.1591888511.gitgitgadget@gmail.com>
        <pull.804.v4.git.git.1591978801.gitgitgadget@gmail.com>
From:   "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Jun 2020 16:19:58 +0000
Subject: [PATCH v4 1/3] t/t3430: avoid undefined git diff behavior
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

The autosquash-and-exec test used "git diff HEAD^!" to mean
"git diff HEAD^ HEAD".  Use these directly instead of relying
on the undefined but actual-current behavior of "HEAD^!".

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

