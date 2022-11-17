Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E07C433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 21:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbiKQV0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 16:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240249AbiKQVZY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 16:25:24 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB4E490AA
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 13:24:33 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id z3so2434298iof.3
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 13:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NijmLBoMjn5WRBX7yU87ysSFmYqq3exLNB+KOGdMyeU=;
        b=w6mopDC/+ZzBw4IGyZXFG+87qoISJE83+g9Ke94YYyzjcKcdrAFEg+bKdcwj2ltXl/
         T1TjXhih4aUkWiVntx5aqfOFm3YKtlmB67nyaRImNuKVEo6++enXAbdtltsL3yScgOmu
         7ztSHm88jMNERv2JiIc5FfHGXWZdQILsLmWe8COKrZMd7nVSQ8tnAzXkDpJC0BCbwh/1
         KM93JLL/SX0brK8FWCCbock1Tc0h9pEERzakbPoH2M2TV+N7jXZl4uslGaDrF6UF3kH8
         pZUsnP26DXC9gI+XbyzyBpMbLz9lsrxaoh9V5uVcjtBof0vtuartWoBxzNgamCg+D4ms
         dobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NijmLBoMjn5WRBX7yU87ysSFmYqq3exLNB+KOGdMyeU=;
        b=CcVQ2oCBOVvUAHd/pWEGAkVxX7nsIdtdG1rPlvNWySyZQIu/oRKoNetUWxsoHWBM6d
         g7SN6INchhf1ntMjgzN27qui8eOl05ROboDqNT1Z4RZwgy6A/dgpT+jJ11VRElWk9q/I
         OTIFJyym+s7a0Pan6u1xVstj5LJV/Nm23cd1Wl1zsZ2q9MCDUwZvkFr78ZXvmo3dNAJb
         pKW18XUr+Gvemlad0PvIDvo8pyytlAxQDJlN3b9oiaUsosi8P5tA/Wf3036YyTuM/ay2
         h8gyTsg13bkrg2hBCV0vzk6DWQcNk+VH7qbKMR8MDHxzHC7dZBzvsaTRg107VdhyGy1h
         eSaA==
X-Gm-Message-State: ANoB5pnzISRbLZOZIDWFsaaB6o9Kqui+KrHKdpB2UgTMllyr+FT0FwpO
        2cidZVhsa5qbb5nfNJj+SoHmlg==
X-Google-Smtp-Source: AA0mqf5U6RoQ9SJm3pVl5jHubNPdZsQ8YlDfue3Y/+e1wuykCcJWN/1Nsf6S8/N+JuhvJY6AZFkMyw==
X-Received: by 2002:a05:6602:2145:b0:6d1:f042:c307 with SMTP id y5-20020a056602214500b006d1f042c307mr2237163ioy.165.1668720273040;
        Thu, 17 Nov 2022 13:24:33 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m30-20020a02a15e000000b0036e605a3e79sm590041jah.17.2022.11.17.13.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:24:31 -0800 (PST)
Date:   Thu, 17 Nov 2022 16:24:30 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v6 0/7] receive-pack: only use visible refs for
 connectivity check
Message-ID: <Y3amjknVMzSMN4g6@nand.local>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1668663795.git.ps@pks.im>
 <Y3ZNUuyWF2gDk2mA@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3ZNUuyWF2gDk2mA@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2022 at 10:03:46AM -0500, Jeff King wrote:
> On Thu, Nov 17, 2022 at 06:46:35AM +0100, Patrick Steinhardt wrote:
>
> > this is the sixth version of my patch series that tries to improve
> > performance of the connectivity check by only considering preexisting
> > refs as uninteresting that could actually have been advertised to the
> > client.
> >
> > There are only two changes in this version compared to v5:
> >
> >     - A fix to the test setup in commit 5/7 so that tests pass when
> >       GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main.
> >
> >     - A typo fix in the commit message of patch 6/7.
>
> Thanks. Looking at the range diff, this seems good to me!

Yep, I concur. Let's make sure that it passes CI, too, and then start
merging this down. Thanks, both.

Thanks,
Taylor
