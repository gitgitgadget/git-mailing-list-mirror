Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D611CC3DA66
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 20:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbjHWUIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 16:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbjHWUIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 16:08:25 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A339110CC
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 13:08:23 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-579de633419so66872717b3.3
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 13:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692821303; x=1693426103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WiQmNplbZnlFEZnF6RFkTRgkdlT+9mVeNRLlNiq+vxc=;
        b=x1FJ/2wHHP3AuwkMeFPwj1vFv/7wpS7hvhoxkViYnqG+1+yC4cYVz5WZMxQhGXi9OM
         D2khZ9lfax/w8eWpfp/+kMNj5DpCAafpjRo8MI9en66kUBp8tI5K6WxLlI8p5I+fq8gs
         CA5MYCpOHb1mAv0vwkHiFkB5XU6t/FpPdnCdLh8KNfoL/ThQURVVAnevhLrvPeewHJQQ
         LreFYNzoJlcALDK3Jf4TU7TKB4XAWk57ZdVcU+CRMCMN9JB5+Ylk/y8CfvHYP1DB3qe9
         EkoKOeGuYEKRxu2sBGzGGhK4z7bGK1cAuVxLqHOcqUj7trpNfLkn5Lf+PXvQVD6E7anT
         sY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692821303; x=1693426103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiQmNplbZnlFEZnF6RFkTRgkdlT+9mVeNRLlNiq+vxc=;
        b=lH9PPWlcIty0uVX4BXYrbnlmXMkzs7txLU26rU/qB20x9Ar03Pbhot/RIEakTVK7k8
         M28IybzwiDOPEBW8+Fd1tD6o/6CX71gfDgxeZNYXaPwXUjQeDzK+Nj3Mz7+935IC3ODt
         lNTeJtJS+rkrSiEsYaiHtAlniMTnAXCsSeSt4CqprYKRp7RL1803/e4J18n5dfkdmMbz
         fd5Iz0zD/iePO7tU4FXglNuBxvn0dMtglW8+utwD5eBaZJnZeBw/6cksxerEdNDvh5+S
         MpFfimqyxLxYMbmpJQQcn8RRKdmW0PLNgKvTPaEk/S3H5Iut7ba4JdWu5TV7CFfWsVES
         7Lpg==
X-Gm-Message-State: AOJu0YzL18i5USqrYXt+oM9TIEWRKV9AUC24afipsWY/81+7N20bsOGu
        T+NwYHG4YELsKAyn8XEiaZbM0A==
X-Google-Smtp-Source: AGHT+IH54rrJccTrKKyXjFXStOREq2d7lmLpie5WuIuzgIZ82Fg+2qDJ2d60Qlan7caQAi8wwb8cEA==
X-Received: by 2002:a81:7b86:0:b0:586:9e6e:e2e6 with SMTP id w128-20020a817b86000000b005869e6ee2e6mr13285086ywc.48.1692821301246;
        Wed, 23 Aug 2023 13:08:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y129-20020a81a187000000b005707d7686ddsm3522387ywg.76.2023.08.23.13.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 13:08:20 -0700 (PDT)
Date:   Wed, 23 Aug 2023 16:08:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 1/2] sequencer: beautify subject of reverts of reverts
Message-ID: <ZOZnNDd2pMX6M2Au@nand.local>
References: <20230809171531.2564807-1-oswald.buddenhagen@gmx.de>
 <20230821170720.577850-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230821170720.577850-1-oswald.buddenhagen@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 21, 2023 at 07:07:19PM +0200, Oswald Buddenhagen wrote:
> To achieve these goals, the mechanism does not need to be particularly
> sophisticated. Therefore, more complicated alternatives which would
> "compress more efficiently" have not been implemented.

This version is looking good. The main functionality is well-reasoned
and straightforwardly implemented. One minor suggestion that you could
consider squashing in is some test clean-up like so:

--- 8< ---
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 7011e3a421..4dee71d6d5 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -176,29 +176,27 @@ test_expect_success 'advice from failed revert' '
 	test_cmp expected actual
 '

+test_expect_commit_msg () {
+	echo "$@" >expect &&
+	git log -1 --pretty=%s >actual &&
+	test_cmp expect actual
+}
+
 test_expect_success 'title of fresh reverts' '
 	test_commit --no-tag A file1 &&
 	test_commit --no-tag B file1 &&
 	git revert --no-edit HEAD &&
-	echo "Revert \"B\"" >expect &&
-	git log -1 --pretty=%s >actual &&
-	test_cmp expect actual &&
+	test_expect_commit_msg "Revert \"B\"" &&
 	git revert --no-edit HEAD &&
-	echo "Reapply \"B\"" >expect &&
-	git log -1 --pretty=%s >actual &&
-	test_cmp expect actual &&
+	test_expect_commit_msg "Reapply \"B\"" &&
 	git revert --no-edit HEAD &&
-	echo "Revert \"Reapply \"B\"\"" >expect &&
-	git log -1 --pretty=%s >actual &&
-	test_cmp expect actual
+	test_expect_commit_msg "Revert \"Reapply \"B\"\""
 '

 test_expect_success 'title of legacy double revert' '
 	test_commit --no-tag "Revert \"Revert \"B\"\"" file1 &&
 	git revert --no-edit HEAD &&
-	echo "Revert \"Revert \"Revert \"B\"\"\"" >expect &&
-	git log -1 --pretty=%s >actual &&
-	test_cmp expect actual
+	test_expect_commit_msg "Revert \"Revert \"Revert \"B\"\"\""
 '

 test_expect_success 'identification of reverted commit (default)' '
--- >8 ---

To my eyes, it makes checking the subject of our revert commit against
an expected value more readable by factoring out the echo, git log,
test_cmp pattern.

Thanks,
Taylor
