Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6A1C43461
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 03:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E996221E7
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 03:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="08l+ZjWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgILDR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 23:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgILDR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 23:17:57 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165F2C061573
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 20:17:56 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cy2so6265831qvb.0
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 20:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vPr4/+nKY9Jqy1Zrg1SzadXmfkdvLnk+dAMPE6wnpH8=;
        b=08l+ZjWV+y6t4imoIAeWqkwgk5OaI/2W0V9qyzQZMX8Tys3oy7MMbvtAR2CZ9iAqtC
         lmQZqc8GEGn8Ie199c4F0YJ+fNLGkAk9KlzBVuCAgJ0tK2hhmKW3ghu0ssTEOQ1nLYwJ
         Xsyvn3BjG9Fe9fR33JAgdCsCM95lUUQ9mfH7d6Y8HihPArlIeOsFmhB8SVIgYC92D35Q
         OGPiPiUHUZ7dmqveF0mgGUQv77rRAkopGRQoZDLI3Kp5f9ry6+KP9U4I/2XnHFmRnDSF
         rKKuESKGx1jZoKyJZFD1EEBLIjjbZO8svZ0ik+/etmlDj8m+pTHgeQUnf938K4KlKAma
         RNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vPr4/+nKY9Jqy1Zrg1SzadXmfkdvLnk+dAMPE6wnpH8=;
        b=LbVQjVUCQt4JU2MKe52FjubGsKTi1t03meAOjB/8hjXn7mqE1ysFnG6x20mxgjciNK
         tLGNdjuvQjrRMjy9HaPoqfzyJ1kGG9qlXKW24pX8THcO96d6U9iwUJa88AtVLoFgzYAU
         N4cYNbBrmPP9JAqaFwPXBIsYLjbogZVT0RrC9tW8XQVdayioBif/DNehPcWhsyjszgW9
         ObOGcITO1ZEQ8bu9ttVTtwy4lKAk2D6Ik/DMsDvg2N9GBJbQ3JQCVen5uz3sWRN8G8fu
         XGF/ecwz5b0GGJQIzdZ5PuME9EK4MBe4KjVQhmv5H44xGqj7UgD5P0x12Dpry1GqK4Xv
         t2SA==
X-Gm-Message-State: AOAM530vwzluTc7AlcAEGa368g1gSB5kc1kVj1ldsX2HtStJz65eVFlG
        xvEilX2x9ydJU5mUkHavPB0sZA==
X-Google-Smtp-Source: ABdhPJxguuMLSaclSY5F0Rf78zabNTwNegCPyOV2PjS9yorlU7PNsgNirYnY0FENgLyLR9Sxs9DDaQ==
X-Received: by 2002:a0c:d682:: with SMTP id k2mr4898530qvi.27.1599880675132;
        Fri, 11 Sep 2020 20:17:55 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:14f0:d4d0:9608:fa48])
        by smtp.gmail.com with ESMTPSA id t140sm5505573qke.125.2020.09.11.20.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 20:17:54 -0700 (PDT)
Date:   Fri, 11 Sep 2020 23:17:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Sean Barag via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sean Barag <sean@barag.org>
Subject: Re: [PATCH 1/4] clone: add tests for --template and some disallowed
 option pairs
Message-ID: <20200912031752.GA1988@nand.local>
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
 <4cdcedff313751da8c91d701c095f1051e759ce2.1599848727.git.gitgitgadget@gmail.com>
 <8f864b6c-4b05-a9d6-b649-5f7c50697730@gmail.com>
 <20200911195622.GB2697399@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200911195622.GB2697399@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 11, 2020 at 03:56:22PM -0400, Jeff King wrote:
>  - I didn't even know we had test_debug. ;) The last time somebody added
>    a call to it was in 2012. I think it's being used as intended here,
>    but I'm not sure that the clutter to the test is worth it (we have
>    other tools like "-i" to stop at the right spot and let you inspect
>    the broken state).

Me either :). I think what you said about using -i to inspect whatever
is broken applies not only to this test, but also to all other tests in
the suite.

I'd be pretty happy to see 'test_debug' go away. There are only 104 uses
of it in the tree, and I think most of them could simply be removed
without needing to touch anything else.

I've never found it useful in debugging a problem on my end, but perhaps
others have. Food for thought.

> -Peff

Thanks,
Taylor
