Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6035ECD611D
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 18:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377059AbjJISR6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 14:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjJISR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 14:17:57 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9D09C
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 11:17:56 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-65b0557ec77so28440096d6.0
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 11:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696875476; x=1697480276; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rE2wb3K+g3hZWa0NISVYUty7XFg3ypp7A45k3bhADvw=;
        b=rHLnvldkZBBzZehVDCDG9ENTZMOFiRP7yJda9zfO8Yk/300GfO7bYOh/2S2AYmlRBd
         LvlGA6GvWBuch7Mj3XPbff9P+xrJsU113/BhBOdaKSkcw7cqe8g6XIVMf/OzQ6Cvwvjr
         HHSQD8NQo1WfVWCgsRvs8u2d8PtIjPNKYujqjwgNmzwxuxQ/cpJ9MLmkRPWDNvk/j/kc
         yKT6UFTqFc6IggFLDl33yS1xeikjC/AsbrZm1y6RDmVS33rXvOhH9RLwQtezAD5kETBn
         bzU4fmTIJF5PwlUVuzBNvyA8/MK2ajpyZKVzBj+Vehu5Qb0UedNT4du2ezZv1GOYclaO
         3gEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696875476; x=1697480276;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rE2wb3K+g3hZWa0NISVYUty7XFg3ypp7A45k3bhADvw=;
        b=P/5oPiQeYR9vwhXw8jn/Tc1DshcwncMTnck6scTH5Ldqv22dViahbF17yNeIxagBnI
         lpvcLd+QRDOg0WhIUEEQUYno61hjTLOdjw1Rh23C1gaqOfV8N0jpDu7AoGoTidjgHHWh
         rOsKwJa0EpVH8PvrSfd2uOmFJAmTuDM+riYSO0N/nN3LCqfLHmmeZuBADuwFZNIOf/mq
         ArM/CH7RBrDsh3NMVz9TQSTuFl8DDvfhVxExrRy1zvk+InFSeBpCw6Pqe8Ow+tT1vZrC
         qDLR30yjMVSt75fNOREs43kfz8Pptw5Q60Ek+m7MeIXTrSBMDCqIF1Zkw1NFNVcurtKR
         gz7Q==
X-Gm-Message-State: AOJu0YzXaWz7/lHpQSu7vFZUKmEnXkJ/Db4VL0RhNsL3lY3W+lDW7Lw3
        DFWXxKL/pl52A7/8tCXJKpGlcw==
X-Google-Smtp-Source: AGHT+IFiYs9YOza29Jf6gM0X3uAnKs21ADCtOqNkVmfbfgewc3p4GfVpN7YHBizQq1+elwJ/Ngtwmg==
X-Received: by 2002:a0c:b38f:0:b0:66c:ed5a:ca8e with SMTP id t15-20020a0cb38f000000b0066ced5aca8emr258929qve.46.1696875475799;
        Mon, 09 Oct 2023 11:17:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i1-20020a0cf381000000b0064f43efc844sm4019096qvk.32.2023.10.09.11.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:17:55 -0700 (PDT)
Date:   Mon, 9 Oct 2023 14:17:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 07/15] commit-graph: new filter ver. that fixes murmur3
Message-ID: <ZSRD0tK3bk67aDw4@nand.local>
References: <20230830200218.GA5147@szeder.dev>
 <20230901205616.3572722-1-jonathantanmy@google.com>
 <ZRIRtlbsYadg7EUx@nand.local>
 <20231008143523.GA18858@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231008143523.GA18858@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 08, 2023 at 04:35:23PM +0200, SZEDER Gábor wrote:
> > Hmm. I am confused -- are you saying that this series breaks existing
> > functionality, or merely does not patch an existing breakage? I *think*
> > that it's the latter,
>
> It's neither: the new functionality added in this series is broken.
>
> > since this test case fails identically on master,
> > but I am not sure.
>
> Not sure what test you are referring to.  My test demonstrating the
> breakage succeeds when adaped to master, because master doesn't
> understand the commitgraph.changedPathsVersion=2 setting, and keeps
> writing v1 Bloom filter chunks instead, so all commit-graphs layers
> contain the same version.

I was referring to the test you sent back in:

    https://public-inbox.org/git/20201015132147.GB24954@szeder.dev/

but I think that I should have been looking at the one you sent more
recently in:

    https://lore.kernel.org/git/20230830200218.GA5147@szeder.dev/

Thanks,
Taylor
