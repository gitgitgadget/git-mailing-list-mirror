Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E45C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 21:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiKHV1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 16:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiKHV1q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 16:27:46 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A495D69A
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 13:27:45 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ft34so5578708ejc.12
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 13:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=044vU4PWRCVpUq8xW8zjXSNMQCJyy8p6xfFhD77X45I=;
        b=pOfTPFelPjhngeIqSXAKk0GKQ8zyk9jC0RFliRiMYKbIPj+MKLbmdETBqVIXMybErU
         rgxGTOPc/bwcJPbvcLg8rdC2T7ygh5FJcAolFlkq7cO4eW5i+wmB08BjAd1uCm8xoozE
         FI80o6QTlOtWjl50c/HPrLxD2f/FyIB/dUKG9o2UYATZq93jaKni6ONr2d3+9ui4VsZp
         A33MF6bNuH0kMikcnxJheZ7C9XOMx1ihFXydKJFAHunWO9bROs0KeLST5BCn1WcXPfTy
         M/HKKfk/laJL9znSXhs9xwoP02ofVderj8o8UysGOr9ZzGse7fcP02QROTnEVS+pEFep
         i5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=044vU4PWRCVpUq8xW8zjXSNMQCJyy8p6xfFhD77X45I=;
        b=Dlu3dKceGIP/U7ZE81ya7wq7WdrRELT9taL0qoyGTEFPNDnGf1D6Z5SuCD/qqZDEG+
         o3bFmD62fZndWnhyl2VxjwSZHw2pHhQZYCTBESGDz+GS/AQf+QtdpktjqNwwiLHXoiXm
         YUEqrqwB8xBWNWS8+DqCoU4k44db2hFPGjRGT+hVG7/RFhJ9XciO3CshOxYKdohkFi6T
         T0D3a3UmZ2SQc+w9xT3hUU0yFITP+JxAKoDkzaiQ7Ixdtl4bZvWSY1Y3xliXuj4YiFR9
         0t+UkLOftseO+VS4jDwi1VznD/rOQs6ICKjzGKhiHCuyzpGVwuKSqDp2ZSOY7dQlloeX
         12EA==
X-Gm-Message-State: ANoB5plEFu/brKlt8SexaWrFIFQ8XP6SdXoev6Ccetr3cEZpVto2Qwdz
        g7JIb+RaDwH6RPRAAxLAaWk=
X-Google-Smtp-Source: AA0mqf52vf1BB8mGB1jKKUnEvtXVBFvcdfUJIO9UmZ7dqBpLagNuNBwwwiv6dVFnIhrbu7yADqh2FA==
X-Received: by 2002:a17:907:1c12:b0:7ae:52a9:84d with SMTP id nc18-20020a1709071c1200b007ae52a9084dmr17753972ejc.174.1667942863443;
        Tue, 08 Nov 2022 13:27:43 -0800 (PST)
Received: from localhost (78-131-17-60.pool.digikabel.hu. [78.131.17.60])
        by smtp.gmail.com with ESMTPSA id vv2-20020a170907a68200b007417041fb2bsm5035009ejc.116.2022.11.08.13.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 13:27:42 -0800 (PST)
Date:   Tue, 8 Nov 2022 22:27:41 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v8 06/12] docs: move commit-graph format docs to man
 section 5
Message-ID: <20221108212741.GC1731@szeder.dev>
References: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
 <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
 <patch-v8-06.12-df3ef265d45-20220804T162138Z-avarab@gmail.com>
 <20221108180417.GB1731@szeder.dev>
 <221108.86mt91qmkq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221108.86mt91qmkq.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 08:16:49PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Nov 08 2022, SZEDER Gábor wrote:
> 
> > On Thu, Aug 04, 2022 at 06:28:35PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> Continue the move of existing Documentation/technical/* protocol and
> >> file-format documentation into our main documentation space.
> >> 
> >> By moving the documentation for the commit-graph format into man
> >> section 5 and the new "developerinterfaces" category. This change is
> >> split from subsequent commits due to the relatively large amount of
> >> ASCIIDOC formatting changes that are required.
> >
> > So after this series I got a couple of gitformat-* manpages, but,
> > alas, most of them render improperly: a lot of paragraphs are for some
> > reason fixed width even in a fullscreen terminal window, and their
> > width is more than 80 chars, so they are rather awkward in a
> > standard-width terminal.  This also affects the html version, where
> > those paragraphs are rendered with a fixed-width font.
> 
> Do you have examples of that

Here's the description of two chunks copy-pasted from 'man
gitformat-commit-graph' in a full-screen terminal, the first being
properly formatted (i.e. line length adjusted to the width of the
terminal), the latter having fixed-width:

       Generation Data Overflow (ID: {G, D, O, 2 }) [Optional]
           •   This list of 8-byte values stores the corrected commit date offsets for commits with corrected commit date offsets that cannot be stored within 31 bits.

           •   Generation Data Overflow chunk is present only when Generation Data chunk is present and atleast one corrected commit date offset cannot be stored within 31 bits.

       Extra Edge List (ID: {E, D, G, E}) [Optional]
               This list of 4-byte values store the second through nth parents for
               all octopus merges. The second parent value in the commit data stores
               an array position within this list along with the most-significant bit
               on. Starting at that array position, iterate through this list of commit
               positions for the parents until reaching a value with the most-significant
               bit on. The other bits correspond to the position of the last parent.

There are similar formating issues in 'gitformat-index' and
'gitformat-pack' as well.  I can see these both with AsciiDoc and
Asciidoctor.

> and are these cases where the formatting
> was different before the move from Documentation/technical/*
> 
> I'm aware of e.g. gitformat-commit-graph(5) being somewhat funny, and
> may have missed some cases, but I think that was also the case before...

I'm not sure about "before", because 'make man' never built and
installed these gitformat-* manpages before this series.

