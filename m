Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CEEC4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 21:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiKHVNj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 16:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKHVNh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 16:13:37 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8363B1146E
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 13:13:36 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id p141so12510616iod.6
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 13:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sarO4sKHUd6S95Il5zFtobht7lCVYfotTXFkhbky95w=;
        b=dTA8nA/BEhJ3TIwkvqUvJH9hIDdfI3C36Ub3nWQ5zFfaQh9peVgEMtGI/LsLM99Rl4
         x+Kew9iA1L5QQCeOO/epeqTwK9HaWXuezH6L7Sh8WJD52nsg/ZZWytBDMRZiUdwKQn0a
         GNftwzaIr1SCgj3k76ZiRCswWvWP6AgIq6dtn/XVOEM8rDCsce5asZ/XtvGpzyC4/pBK
         21HVTRZ0CPkvfABiSm2fjWmP59FzzsB3XaGvafBuL1xd5jktMgo2spW+t2M1DsXGRbrS
         C/nbdpuq1WOPq270ayInkokvO/7W+sbXPUqSMiEENIQlqO/nzeKXqn4NbsbfgEMkaXoh
         Fw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sarO4sKHUd6S95Il5zFtobht7lCVYfotTXFkhbky95w=;
        b=H+j+2q1elcJpHFhlhyx2abNgouzlU/3sDYJcAKHjyLNxZ6AMp3vpgykiB0AQ8ome+W
         iMnqnQ+0PczrVKH+Tw6nFJHHAPsaVUoSv/46Jv2lj6AZDaMq5vmUpvfeCYp9gm7kqpDA
         EOVFRbOcnKpBk5maVFzsYH3X4edY5fr+5JUQRKr0dDI66QyeJIAdbqSLmi8Qa3RY9iGD
         UDXiHe7QfnUtg61qR0MYPK1OfkDWkd/XMKdd6AbZbVaE7dztdduIB+Ixsbhn5eAI9sWR
         9OGOW6aqa68LyetS9MP/dz4zx1MH3aUWnc0IecoPpObwJBixovnsagqE2kZSJGNy7rfj
         6Qvg==
X-Gm-Message-State: ACrzQf3ulAIp8KIQa00MGvI8i1iQ8t7nYtbmiww9ArVM8/ppoVIVvxYL
        4ZSPwDbPOK2EEYaTRnod3XlI+Q==
X-Google-Smtp-Source: AMsMyM5YIqtnKxh49Szrxi8i9YHx4FYFt0x68Wj9f9cRl2w7uPDu1mDuPh7nK3FLIRO9IbkrrP6DAA==
X-Received: by 2002:a05:6638:1a89:b0:374:7b1a:b9f with SMTP id ce9-20020a0566381a8900b003747b1a0b9fmr33732481jab.79.1667942015912;
        Tue, 08 Nov 2022 13:13:35 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h8-20020a926c08000000b002ff54e19cb0sm4221745ilc.36.2022.11.08.13.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 13:13:35 -0800 (PST)
Date:   Tue, 8 Nov 2022 16:13:34 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 4/6] revision: add new parameter to exclude hidden refs
Message-ID: <Y2rGfjr9vPEx1JEs@nand.local>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667901510.git.ps@pks.im>
 <c7fa6698dbe7b0eb5e2b9c4725e9bdc6cdb22983.1667901510.git.ps@pks.im>
 <Y2pwt77e9KP5J3XD@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2pwt77e9KP5J3XD@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 10:07:35AM -0500, Jeff King wrote:
> I'm sure this _could_ be made to work, but I wonder if it is worth the
> trouble. If it's not going to work, though, I think we'd want to detect
> the situation and complain, at least for now. And likewise the
> documentation needs to make clear it only works with --all and --glob.
>
> Sorry to have misled in my initial suggestion to turn --visible-refs
> into --exclude-hidden. However, I do still stand by that suggestion.
> Even if we don't make it work with "--branches" now, the user-visible
> framework is still there, so it becomes a matter of extending the
> implementation later, rather than re-designing the options.

Good catch. I agree completely, so hopefully we will see something to
this effect in the forthcoming v5.

I'll hold off on merging this down until we see that version.


Thanks,
Taylor
