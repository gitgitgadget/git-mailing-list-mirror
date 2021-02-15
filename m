Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5734C433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 19:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3A1B64DFD
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 19:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhBOTyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 14:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhBOTyc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 14:54:32 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE651C061574
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 11:53:52 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id x3so5625607qti.5
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 11:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0x3IXv2Ts3Tcrm3NS08gLSMtgzkLqKbsFr1fyp+ddVc=;
        b=Pq7W3PDTCbfJLPRH+KZqsJFU4gfOfsIHulLhdNvBRCOgYflPna9+nqVvMDToKl/fMn
         0yOZgyoZXq7RKJzobTB3QOZuF+xjO5H9wKkCiwCNWehd9vc6AIH0163wfTlCZuLSa9xv
         YJILRcSaCOjEsk9c+H/kXEjRWntA2EbjXfy7AuH+JZ6qNpUOL5tueeHZ9o0p+PRyT5g+
         1l4JoX4AsvS9YhtEOv7IFdZS5TJLSQFuVO9b4UhiOwNykO/UHhtM4+FCeh0TU1NayRmm
         syWDQDHoda/UlrWN+jlGfg4TbfbpW3uLXveMUdfYrqXD6aFiiRkt79JgPE3t2cINYy07
         vxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0x3IXv2Ts3Tcrm3NS08gLSMtgzkLqKbsFr1fyp+ddVc=;
        b=buWVJFBLSjsMeSGYRWf+MSZJvhuAXLMK7xaD5K1c0nPwrYLr1G91C8xYJ94PNIuvhp
         3wIv7MJ33byqN+b8+Ge8+ASSsYG8UxnlMeJct3GAUrkNoSA/VBK2iAPypMENbPwsroog
         /YQw6pln+scLOBm7ZLk5/ft1M52mIYVwWs3lXVzwRzXk1ORWkSqNIOiKsNlfPoLNbpCU
         /5vC6y9JU2mjYaYCVWNww9sltrIhJ2SBgNcMldiG8iKKzBP1BCxV7lGG/LaPz6NgNMqr
         P+CnH1laqw+rSdhUrJiyv6xxgHYHA6cP+WJjiKPzDmO0OB6agpK18Awe3SvwZGdKL692
         vBbw==
X-Gm-Message-State: AOAM5322Y3WZmu+LdB2zEc+zyjNdKMXGIELCu6lHrpDq5svk3YW2ZGTS
        pt24wL1PmMKOZ0mYl4lPc/QsFA==
X-Google-Smtp-Source: ABdhPJx7ewcB4UaNHc6iEYanVvH+NNg4R/bja/pyQAapO3nvzmYBey3mo06AOiZurVz6L5sFLNsn/g==
X-Received: by 2002:ac8:7b43:: with SMTP id m3mr15605959qtu.121.1613418831916;
        Mon, 15 Feb 2021 11:53:51 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:808e:e46a:5ad1:bdf0])
        by smtp.gmail.com with ESMTPSA id 76sm13013636qke.95.2021.02.15.11.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 11:53:51 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:53:49 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        dstolee@microsoft.com,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        peff@peff.net
Subject: Re: [PATCH 3/5] commit-graph: use parse_options_concat()
Message-ID: <YCrRTXFkn1lXt4Mw@nand.local>
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <20210215184118.11306-4-avarab@gmail.com>
 <YCrCt8sEFJSPE+28@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCrCt8sEFJSPE+28@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 15, 2021 at 01:51:35PM -0500, Taylor Blau wrote:
> Another nitpick, but I'd rather see the initialization of "options" and
> its declaration be on the same line, after declaring
> builtin_commit_graph_verify_options.

Ignore me; the NULL initialization is important.

Thanks,
Taylor
