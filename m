Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823C3C3A5A9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 00:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BBF020661
	for <git@archiver.kernel.org>; Tue,  5 May 2020 00:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Kanj9i0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgEEAO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 20:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgEEAO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 20:14:59 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9878C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 17:14:57 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h12so469567pjz.1
        for <git@vger.kernel.org>; Mon, 04 May 2020 17:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ugxGF7nQIiMvgbBTlikAuHe1qEwtTCjEalEfgZKtX9s=;
        b=Kanj9i0fLJH6YCtGSS/6Nq7bU9sMiwva6jrUu18ME9/JQ8ZbtcH8whwestANaMwrP2
         Q3fNmiiOmI5tIs8jPsDLZSDTQSVQUhPu+buYqbXBZE1BhsJaS0OriXqqha4LS7E+wr4w
         SM2PJRLnqxX5j36Eslvu4aoAJmlO7DneJxL5q2XN/oLik+qlrQA75BTMf5v9sUuNSdcK
         +ZppwHvAAbRxjUHLO+BH5MmCU7pMHVp5lOuIHIe6Vt+dUocsyQq5doxeoeOkp790l0tH
         KjaBTJBTMhoAp8ohfSwgpT0cdCHfFbKkjd+EX2ypjyNeeluO4gOAerTIlKSK/PQsYCqu
         cRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ugxGF7nQIiMvgbBTlikAuHe1qEwtTCjEalEfgZKtX9s=;
        b=Lldm6jeZuCFzkYiq527zbs3KAj6awwbU9I+WS/3o32vIQeh3XLQj1uo9q/5ibiNopo
         EP+eK8MbXtKDGk1cLViAnTIUdA7p65vhpfJIpPxI3h8gi8x89+tzzNcWzYAPWAjy1uaC
         sg3A8WmoJsR+3KHFZGiYbt2G57XyGj8IupalXG8uteC8gv7M9w6q320H8alstWwI3dvE
         GoOSEGwyC2MOTgfV+Akpbyw5+vGIds3WIaiJsgq1cexBG+yGx9dw9MRa5k/d7WMU6YhJ
         +wkrkOgRkM3d5Lh9AZUy5n1zYBj/6btK772uOUAj719jmYTfrNjoqv4ykEWv6Pxu49Md
         3M8g==
X-Gm-Message-State: AGi0PubhHm8+oRl/cWEGjWnszh3EV92k3kclLPv5npn85L8BL3869BEh
        tCD0aPpyIqjajaQ9iYuDmlnE1Q==
X-Google-Smtp-Source: APiQypKEKOQPbJvezG0effAWdNu1UI4gNSvKcpwKIQiN1P9xvuude3Nmh5cxNHfyNkicsqHVNkhIoA==
X-Received: by 2002:a17:90a:24e7:: with SMTP id i94mr110979pje.117.1588637697303;
        Mon, 04 May 2020 17:14:57 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id v26sm221793pfe.121.2020.05.04.17.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 17:14:56 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Mon, 4 May 2020 18:14:55 -0600
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, clime <clime7@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] ref-filter: apply fallback refname sort only after
 all user sorts
Message-ID: <20200505001455.GA64230@syl.local>
References: <20200503090952.GA170768@coredump.intra.peff.net>
 <20200503091309.GB170902@coredump.intra.peff.net>
 <xmqqd07jfm2b.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd07jfm2b.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 02:05:16PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> > Commit 9e468334b4 (ref-filter: fallback on alphabetical comparison,
> > 2015-10-30) taught ref-filter's sort to fallback to comparing refnames.
> > But it did it at the wrong level, overriding the comparison result for a
> > single "--sort" key from the user, rather than after all sort keys have
> > been exhausted.
>
> Good find.  It does look like that the fallback was broken from the
> very first version when it was introduced, as we did have multiple
> keys support back in that version already.
>
> The fix looks good to me.

Me too.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

> Thanks.

Thanks,
Taylor
