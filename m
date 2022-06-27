Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A89C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 21:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbiF0VvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 17:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241229AbiF0Vuu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 17:50:50 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DD762F0
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 14:50:49 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id n10so4897037qkn.10
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 14:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CSkug/uqw8iQtoZguG8yAaz6e/BUj5MnS5jowyv4ciE=;
        b=wiEy8leLtyiJj8UPcibmaeXvMHv2uDgATenGgMvSQIyXEFK2m7DlT5NFBHl77Y8UyY
         A97dRfh0EUC1JsILk5Nw0rQJTyy2Q/8QHBPuZlZTmQH+XkZ1woKxUepLdFu/HZgNqkcS
         tO4jKgQgf0q721vhhcH9FZs+gzH+ZUVrR/nwXi9QfPk4puBYmAcgMdhF2SVwIFmMQuAR
         7EHXzpAFKKP43llzMK4TpafWP0R3VAnlIsFVCeEZSGo9IUSPEZ79OLXGK150r84ecyi8
         RRflCHJW10eu3kpIigacliXJyWe/QAl6chkMEXYCa7zqYF1LBsn7IsGbxWfIVS8y6lrE
         EAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CSkug/uqw8iQtoZguG8yAaz6e/BUj5MnS5jowyv4ciE=;
        b=0DsqEtV2QM4PprhugqVnRv6PuYzm2LDShi0fFur4OdzrmenkXW+ZIZO7pH5IC9UKin
         ycB1hERwxZU7jk1IDnh50V85ADwB5MhXDzJuLfYrNF7XL8Md4uiDP/hbNkTWh+rJ3L2U
         dESxITxA+hvczHL1eaPm8thnM1f56ITDpqu5lm3lUsJQd50XSgLZ74kEzwEbS2thP/lk
         82kxmQwm6eT79b1rLO11suvMziKs8yRmHi8PN2UwjIjbE9mFUCcWqOV5ilWQPsp56Dg1
         UM1LfgzdHNgIkUmy74jX/sok8oExUatXEeQVlXsRJduxdgOqL40+xczCw4RIxsB6KSB8
         jblg==
X-Gm-Message-State: AJIora/3WWswK0ohNxN7567FiotQBhdMQmk1ZaJwnWR7IgO/+AegSEit
        1IPDZMMwb94K8vlfMPzy1RTlvA==
X-Google-Smtp-Source: AGRyM1uRRAh2TBcUYmkBKoQKQNsP7nWget5aKCLdAEXCWA0CX0OXJSX12UNuv/GlF9hfY6u7B3xtdg==
X-Received: by 2002:a37:4454:0:b0:69f:c339:e2dc with SMTP id r81-20020a374454000000b0069fc339e2dcmr9358475qka.771.1656366648888;
        Mon, 27 Jun 2022 14:50:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f11-20020a05620a408b00b006a74458410csm3903161qko.123.2022.06.27.14.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 14:50:48 -0700 (PDT)
Date:   Mon, 27 Jun 2022 17:50:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v2 6/6] p5310-pack-bitmaps.sh: enable
 pack.writeReverseIndex for testing
Message-ID: <YromNwFsUNGtW9pJ@nand.local>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
 <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <fe556b58814405baf5f19f4dd3e89883d08edb8e.1656249018.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe556b58814405baf5f19f4dd3e89883d08edb8e.1656249018.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 26, 2022 at 01:10:17PM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> Enable pack.writeReverseIndex to true to see the effect of writing
> the reverse index in the existing bitmap tests (with and without
> lookup table).

I think we should swap the order of these final two patches, since we're
primarily interested in the difference between using a reverse index
with and without the lookup table.

Thanks,
Taylor
