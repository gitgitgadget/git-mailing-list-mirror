Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEC2ECAAA1
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 21:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiIFVRA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 17:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiIFVQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 17:16:58 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D670BB81E1
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 14:16:57 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id e28so9099251qts.1
        for <git@vger.kernel.org>; Tue, 06 Sep 2022 14:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=YmdSxDZLzXpG8bo/sO1jUQrD0Jayfa5xCMDrbfw6QRY=;
        b=cbheSm6rEalqzwsyONZcqLSihYF3edl9IxEBx4jehw1tOduQwT09nQcdS3VT8zVHic
         zdEE3Ri/xgAP/RiksUpjjNkLSejnTBpNL77MT4p28POhAQKpfEVBgrVpWRzg90YAOASM
         gNLSth3vVQgP4p/9QkjTvgTRbmWrU4sI/A+CsWzCQaAkTycF+XIOnvFHlwG7Wsr8cpZY
         itlM3rneYbkFG+yCSZvltDKVPtrukqq3ZLQGC4eHu6xq1hj9CZSmVsLRGEUrsLA1HjOu
         wLPE7RlBS+O2IpNZ6+rFc5q2Q+0VAHLL0fOvBZp6C8BkS4I0g0LPihAWItmpax/Rsy5G
         fc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YmdSxDZLzXpG8bo/sO1jUQrD0Jayfa5xCMDrbfw6QRY=;
        b=1/wNniWvIRr3qODMn9qjPN8AXRB28m9eufGjWx9JEQueT+GEgrabbXnt7UKJHQ9CYd
         W53wZMcXhvRRmdTtDuJswZ6JE9pRGQmyefduyKAnkkWyNu90tD9ZjgS3PbmJZyRxwO7Y
         c30gYQbXdCtPnMyq1+fajLUi+5S8XvHQDyNEWlBApOBB9aSVe5M+aqxg9jaYlYoF/N+P
         qIiWBDvyezTvvGsc9VZ3JwEeKTtWWbRIymdaFXRGtJNiR3FbdQTRzbaM+K+QKd/htEpG
         wCm4FSf+8Zt0+ftD/99CQd8P8cQGbkfpcg7aPmFIqK0qPFf+3dcwZGLKU7NuzpfIa8dm
         YodQ==
X-Gm-Message-State: ACgBeo3EbJGdqmBw2ELlPmpZQIH4COO7PGO/Wx1F5fLXTZEu/9uzhn5O
        VttqnULluLaB4wX1VId6ozOG1A==
X-Google-Smtp-Source: AA6agR4nK9ir7zSNK3H4zUo1S5J5KNMMSPGNaGq6e1elmM5JS1JvOwoCNoqJHjZWkJYg+/aJDXTG2g==
X-Received: by 2002:a05:622a:1c5:b0:343:6cfb:32b with SMTP id t5-20020a05622a01c500b003436cfb032bmr495490qtw.31.1662499016967;
        Tue, 06 Sep 2022 14:16:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e27-20020ac84b5b000000b003445bb107basm10049328qts.75.2022.09.06.14.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 14:16:56 -0700 (PDT)
Date:   Tue, 6 Sep 2022 17:16:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] lookup_commit_in_graph(): use prepare_commit_graph()
 to check for graph
Message-ID: <Yxe4xxF/yWTLAtI3@nand.local>
References: <Yxe0k++LA/UfFLF/@coredump.intra.peff.net>
 <Yxe1VbyYovwprPgQ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yxe1VbyYovwprPgQ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 06, 2022 at 05:02:13PM -0400, Jeff King wrote:
> I couldn't find any other reason to avoid calling prepare_commit_graph()
> here (especially since it ends up lazy-loaded as discussed above). The
> cost of the call should not be high; after the first call, it is
> simplified down to a few integer checks.

Neither could I. Obviously f559d6d45e (revision: avoid hitting packfiles
when commits are in commit-graph, 2021-08-09) is adding a call to look
for a commit by object ID in the commit-graph where there wasn't one
before, so there isn't anything to compare to there.

But the next-closest function `load_commit_graph_info()` calls
`prepare_commit_graph()` (via `repo_find_commit_pos_in_graph()`).

And that all matches my understanding that `r->objects->commit_graph` is
lazily loaded. Perhaps it should be made more difficult to access via
the struct member, and instead done behind a function like
`prepare_commit_graph()` (modified to return the `struct commit_graph*`
if one was found).

But that's for another day :-). This is obviously correct in the
meantime.

Thanks,
Taylor
