Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E62FC433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 04:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbiBSEQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 23:16:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbiBSEQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 23:16:26 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76881B9118
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 20:16:08 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id p7so18695786qvk.11
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 20:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ivFvcw2PRdXLSPqUT3H2nxzhUPwS2PxTpN0/bcik7+E=;
        b=VMLvum19fXG5EXKvWhwsiuZM2BLe05P/uW+022XVNbRw43stS8CopemBFU1y/EvXkz
         nQvwHh05XRLFr8b3c//komHBn8fIUfXGzUkTLHHRRUIALoV6sxQpqN3bA5i1hEUHB+PI
         9OqurjkyPF7awH6VwvmULFvM/lU5ZO6c1s0lt47FdX0Eq3zJfCMRGmtD7RopnS2ZIRl+
         hyX6P6RD2LFP6xKVEFuGR16P/hHIoJVr8ckJPJAjMoY1uN8kRzN0sB6if3jjHE63c2Pq
         sb/m4+bYT6W3B2QkAUQML9kMX6NnDW0y0IGYUOwaRRWUD8ICjq9A4PI3wee+ts+Gv8ZY
         s6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ivFvcw2PRdXLSPqUT3H2nxzhUPwS2PxTpN0/bcik7+E=;
        b=Q1N/EaxbTzWLiI6mgMVXnMD/VkI+wBVF07j1m5TnWaPCgYCKQVXGYswnt+sgsSxHsn
         h41UnGLydwB73xZFhghvmudT+4i+UfJnRueqm5kbHlkCYKMnt3aYlQ66pR7tM84iex40
         H3eYca4OcqSQwngMsqvP27F//0au8TXIT14GhtS6gmqpTgxSW/U71XDE5rE820f/4Y9l
         n7jcpEVz3Ihrz+H2axnLlIOu0bAus+dD/PlnNRM2xqcmn15LdZG59eajr9ZzT8c+weQw
         o67kPEP8C4MZvzvq035EV80JmoN1aApVPuvGm4NhAL3mBQJJjxIO34SMMjvjjx1YcHg7
         foVg==
X-Gm-Message-State: AOAM531DY2whO2cit5rYuGeFc1n9tuIR3KJwKGuzkOdMbjkARECxR4eH
        WLd4EfK14EDcg6xQr3sNLVhdIw==
X-Google-Smtp-Source: ABdhPJyf5VKXjst1OG0kOkq1qoU2gL0GiBiQva4jwI/452G8yIhjQlpKckgRBx8TG1hhNITrpXpuYQ==
X-Received: by 2002:ac8:7f01:0:b0:2dd:bab8:6885 with SMTP id f1-20020ac87f01000000b002ddbab86885mr4044706qtk.130.1645244167870;
        Fri, 18 Feb 2022 20:16:07 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h26sm2390639qtn.54.2022.02.18.20.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 20:16:07 -0800 (PST)
Date:   Fri, 18 Feb 2022 23:16:06 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Aaron Schrab <aaron@schrab.com>
Subject: Re: [PATCH 0/2] hook tests: pre-push test style & test accurace
Message-ID: <YhBvBscyDAfndvSB@nand.local>
References: <cover-0.2-00000000000-20220218T204719Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.2-00000000000-20220218T204719Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 18, 2022 at 09:52:57PM +0100, Ævar Arnfjörð Bjarmason wrote:
> A trivial topic to fix a blind spot in the test coverage for pre-push
> hooks, and to fix miscellaneous issues in that test while we're at it.

Indeed; both look good to me.

Thanks,
Taylor
