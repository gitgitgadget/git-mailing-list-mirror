Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A5AC2D0B1
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 08:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8468720720
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 08:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAwbDift"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgBFI54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 03:57:56 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:56143 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgBFI54 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 03:57:56 -0500
Received: by mail-wm1-f41.google.com with SMTP id q9so5345457wmj.5
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 00:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7+eCsVHaBDRMmSQeMqh+7ss5U1g4iT9JXvzO1b/bcrg=;
        b=JAwbDiftsF2RPltBlqCRiS/ruxpeSPR48OTOSyyeOQYT7KJVwf1EkyaxSVqC50cstT
         uL+0rZGI0JwGspPR4QfpO8+8pQvvbBD0VGDqClDF6fmNxB4sQwfrj5ZPUyICnsDzTJ6s
         n+TAUC2NcZ9yg5RXdkyjolll9/vLUQ0BQAfi+az+EyArsS4MiO7yQWmBz51HWXp308Y9
         em1jxKwigW9cpFy0rUhmzzoZMFIgNQKqXSstFQr2DSJDRQyZZg4BOe0wMNxewxkFlIrf
         krEPTfTUAlTnopx7rZ14IeVdn01d1ozj6P+2jijR492LyZMnWHXBupCZFDIoGBgAAfl2
         7qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7+eCsVHaBDRMmSQeMqh+7ss5U1g4iT9JXvzO1b/bcrg=;
        b=ljxjZbHoSBb4UPeVve0yawv2i9tc+gzep7MQmwO+tVxAzuDpgPzk/ornVzNoAlSpPX
         i6KlETDDckEC32ArKnvE38mC01/UEEZlSGLUSbO3mKonqXxoX8HZm2nPUYCJh6xQ42Fx
         NVJ7XQO+G5hKarF98ngLkIptpPZSI04iSW6FTxApk7DoS7Sd4L1uRxX3EcpzgCd0+L92
         SB0+iOFx7JRRzV/9H45gRDVGKuUTaAWz8oQWVo/VmY1EYi1LEz8ds+W8c0xkRhkG6MqE
         8WYEnwKsBdBUxgBm5e1G91wBJ+Njkf/+DV1d4iPAMX+8ok4YxnDDHdM2i4Vw/i6Sd/y6
         GWoA==
X-Gm-Message-State: APjAAAUkV3S2ouFKAqggyDjUT7qUW0v1EVC8EvQmHmFJdUvv8JE+Habx
        Gr70s0JbA21ZrShadlSzcpw=
X-Google-Smtp-Source: APXvYqxPxbLA6hdUDPPpjYlOgcKrxVbC+yo+S3VaMautAfBqwZp+WYHTxqVAzQciMngWgiHL+FC6eg==
X-Received: by 2002:a7b:c76a:: with SMTP id x10mr3268035wmk.49.1580979473938;
        Thu, 06 Feb 2020 00:57:53 -0800 (PST)
Received: from szeder.dev (x4db62c67.dyn.telefonica.de. [77.182.44.103])
        by smtp.gmail.com with ESMTPSA id e18sm3207933wrw.70.2020.02.06.00.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Feb 2020 00:57:52 -0800 (PST)
Date:   Thu, 6 Feb 2020 09:57:48 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        martin.agren@gmail.com
Subject: Re: What's cooking in git.git (Feb 2020, #01; Wed, 5)
Message-ID: <20200206085747.GA17654@szeder.dev>
References: <xmqqpnesfw74.fsf@gitster-ct.c.googlers.com>
 <20200206025130.GA22748@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200206025130.GA22748@syl.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 05, 2020 at 06:51:30PM -0800, Taylor Blau wrote:
> > * tb/commit-graph-split-merge (2020-02-05) 3 commits
> >  - builtin/commit-graph.c: support '--input=none'
> >  - builtin/commit-graph.c: introduce '--input=<source>'
> >  - builtin/commit-graph.c: support '--split[=<strategy>]'
> >  (this branch uses tb/commit-graph-object-dir.)
> >
> >  The code to write out the commit-graph has been taught a few
> >  options to control if the resulting graph chains should be merged
> >  or a single new incremental graph is created.
> >
> >  Will merge to 'next'?
> 
> I think that this is ready. Martin Ågren and I discussed a little bit
> about the rationale behind why the new options were chosen over
> alternatives, but I think we reached consensus (at least, the thread has
> been quiet for a few days after sending 'v2').
> 
> So, if you're asking whether or not this is ready to merge to 'next',
> I'd say that it is, but I'd like to hear from Martin's thoughts, too.
> (For what it's worth, we're *also* running this at GitHub, and without
> issue).

Please don't rush it, those '--input=<source>' options need more
consideration.

