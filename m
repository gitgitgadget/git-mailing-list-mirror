Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89093EB64DD
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 17:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbjHKRIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbjHKRIU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 13:08:20 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3203330F0
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:08:18 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6bd0a0a6766so2066888a34.2
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691773697; x=1692378497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBUFVmhRcEXfJwu8804Dvnmtn1rfUR+f2zmy2g1gd8c=;
        b=q7PKvcfvOg3wAofHOJbdobCRL1urkY5b03x3yEV06U9JuNhlqW4mLfdU/BVY4cPqmu
         p7vz+31rKzfnaFS93uW0wg586CBPVsx23Te0ThzBF4pd9htngv+ptnrW6wqIPuZkktgz
         p8XP7LtgLe6m8M0QhvEHhoY03d7USUubNnnAcMR/ybTwGdnwhlI0twQ3tpo8kH+iFXrW
         EZ06Lm2p+3RT/Dlh12HR7/SOi4Zx895Fh9Xhdo44jplIKZPQiTaSFcKPM0xlzggc1/Q7
         8O2jRFMH9IlalGi0RNXZgyELHfSKVT5exesUGesYJZGIDlwRnEts6vUfZxaSozmN7GhX
         OXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691773697; x=1692378497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBUFVmhRcEXfJwu8804Dvnmtn1rfUR+f2zmy2g1gd8c=;
        b=LNnxL4BWWAh9Bo/OD1f25CONncaGqJ9TRC0F79o27P5it8KVJVhAygvipIAJy6D9gc
         RwwyjmEPENfgZooeHRyt9tJkeUAZbFjwtWsL4xBZ7S90t9cm9IVGbCwNQBQLImyx1kM5
         lC7rp+8Lnw7Pz/OgD7aCjQOJontdNrsQaWw1NLI+17N3YAUnB93q+nBj29WrHnZobmvP
         FPgDeDV7z/VYlyaz6z5JaPWmXpueJHNrMmNEvZFlfAsnR1s19UMh6KYqpX93E/VDQO2t
         x1Zc88k15cmYgiAPvxfnmF/V4GNk8ayxkV5TV5Qhdnok/mo0tbEx/bgk5w0JkcvFg57D
         N+vg==
X-Gm-Message-State: AOJu0YyaUMOMT+kfJ5r37nvQiS92sPC1jp06ITupq6MjJsC9yQd5OF+f
        VgDt7285Oep8yGud2iOguZisRA==
X-Google-Smtp-Source: AGHT+IEBBrv/q4oWAzc14h4oKZAbzeSLuFDePqc0SKXaqyauvOAkp9EHfpH1omUnrzaBLNdkxbR/9w==
X-Received: by 2002:a05:6871:591:b0:1be:f4b3:7f49 with SMTP id u17-20020a056871059100b001bef4b37f49mr2592012oan.23.1691773696207;
        Fri, 11 Aug 2023 10:08:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i72-20020a816d4b000000b00579df9098e3sm1102060ywc.38.2023.08.11.10.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 10:08:15 -0700 (PDT)
Date:   Fri, 11 Aug 2023 13:08:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/4] commit-graph: verify swapped zero/non-zero
 generation cases
Message-ID: <ZNZq/25LhQfXdo2+@nand.local>
References: <ZNUiEXF5CP6WMk9A@nand.local>
 <cover.1691699851.git.me@ttaylorr.com>
 <9b9483893c072961c5871bd0bae17a7098d73c06.1691699851.git.me@ttaylorr.com>
 <xmqqleeir35l.fsf@gitster.g>
 <20230811150114.GC2303200@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811150114.GC2303200@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2023 at 11:01:14AM -0400, Jeff King wrote:
> > Hmph, doesn't this potentially cause us to emit the two reports
> > alternating, if we are unlucky enough to see a commit with 0
> > generation first (which will silently set gz to ZERO_EXISTS), then
> > another commit with non-zero generation (which will complain we saw
> > non-zero for the current one and earlier we saw zero elsewhere, and
> > then set gz to NUM_EXISTS), and then another commit with 0
> > generation (which will complain the other way, and set gz back again
> > to ZERO_EXISTS)?
> >
> > I am tempted to say this gz business should be done with two bits
> > (seen zero bit and seen non-zero bit), and immediately after we see
> > both kinds, we should report once and stop making further reports,
> > but ...
>
> Yeah, I think you are right. It might be OK, in the sense that we would
> show a different commit each time as we flip-flopped, but it's not clear
> to me how valuable that is.
>
> If the actual commit ids are not valuable, then we could just set bits
> and then at the end of the loop produce one warning:
>
>   if (seen_zero && seen_non_zero) {
> 	graph_report("oops, we saw both types");
>   }

Thanks, both. I think that this is a very reasonable suggestion and an
improvement on the existing reporting. I made this change and sent the
revised series as a v2 lower down in the thread.

Thanks,
Taylor
