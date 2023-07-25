Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDFBEB64DD
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 23:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjGYXKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 19:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjGYXKb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 19:10:31 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ACBE0
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 16:10:30 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-584388ec441so12025077b3.3
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 16:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690326629; x=1690931429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cxtQVaZgjQanED0KE7+C7Ef3dALbTuIAb4isGi6m7z0=;
        b=WpfMmdKv3sXor3c0NA7/W2id7zC+QoWJ+reuTasf+gf6d9IxestvsjyNq/H4IE8uoj
         HhryBAl9emg2cxJWcpC2e+9nD5Tot5i6ITgi+WuaJJPK6b8enXRmWOUex6Lzs4rtZNZ/
         dbnxNOL6KVtajGX31yk/P9mT216WiM4fWBFOvaoVN85yNS5a2/IpZ65UuTOU9cUzCVZ2
         EyFDf8IVkhjb99Lejumv+BsbPaz0xeYA+zHCmuGOgwUv+IS2g0Vb28WHSKXhzdmmoGCF
         bEjNOR9NLJvjdOUhYedV6vaUKg56p8zRAsnG+QbFPlC9DfR+CAAW39E6SCvwwWe/SiPK
         YbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690326629; x=1690931429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxtQVaZgjQanED0KE7+C7Ef3dALbTuIAb4isGi6m7z0=;
        b=g0G5/ZLTEPE96+diKp7RZbV6oZr5JlrsJS+0bs/R4exe3Yoxyy/xQkiwMoNYdI6OvX
         FvAXnL31osd0bEBmkVxwoSOF5f9xTz8b9X5Q/rpxGnw11ZtNNX+/g8IPmjethQl0SDv0
         Vr9QOgnwppqPR4x/K7WB2+gGT51aeTeeMF+9YOf/NBBlpCfIqUw2raBOfF1+ZvDQ22XG
         N8dVre4NrrrdOYc/PW7dHGHbUyBjkPAwOmop2kNwlZbyfp5yNNEZBcfEH7RLdW80WxKh
         v2earZklRg/8jc1cPcAdV4PZeTpbR7oDjqssYkcB52+ASaahLGAoAwk68DlNQ1/gWfGS
         WKag==
X-Gm-Message-State: ABy/qLaY/DNiuGTNtOAXyklGxovBHZ2j+bZZEsPScc94CcS+QuQpWC1f
        lIuhnKO7o0AnPnUK4Wj7FOPqGQ==
X-Google-Smtp-Source: APBJJlHoYJQo9aHc27lelDRLpnTiSBvq0D+fE1hxkp+nP2XVV6pgAs6kW4TiD75NK1v46avllySy6w==
X-Received: by 2002:a81:678b:0:b0:579:f60f:d08f with SMTP id b133-20020a81678b000000b00579f60fd08fmr578741ywc.48.1690326629358;
        Tue, 25 Jul 2023 16:10:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k184-20020a0dfac1000000b005838c619a08sm3553584ywf.111.2023.07.25.16.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 16:10:29 -0700 (PDT)
Date:   Tue, 25 Jul 2023 19:10:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 0/8] Repack objects into separate packfiles based on a
 filter
Message-ID: <ZMBWZFoeEXcn5fXZ@nand.local>
References: <20230705060812.2865188-1-christian.couder@gmail.com>
 <20230724085909.3831831-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230724085909.3831831-1-christian.couder@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2023 at 10:59:01AM +0200, Christian Couder wrote:
> # Changes since version 2
>
> Thanks to Junio who reviewed both version 1 and 2, and to Taylor who
> reviewed version 1! The changes are the following:

Apologies for not getting to the second version sooner! It fell off of
my post-vacation to-do list, and I'm only just getting to the third
round.

Overall I am happy with the direction here and think that this is on
the right track. The major points (using --stdin-packs to implement the
complementary pack, the behavior of --filter-to, etc.) all look good to
me.

But I think there are a handful of smaller issues that we may want to at
least discuss first. If so, I think that a handful of them merit a
reroll. But I imagine that that rerolled version would be ready to get
picked up.

Thanks,
Taylor
