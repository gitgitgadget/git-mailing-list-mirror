Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E713BC001DE
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 17:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjGKRUA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 13:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjGKRTy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 13:19:54 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C511BE8
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 10:19:21 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-c581c758ad8so6756570276.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 10:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689095952; x=1691687952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pwIn11o9UG2icmHFhCNlCOZxpB87pUpr9W8P4bUdBtc=;
        b=tWK/mzwZSQbhzghNqql6bU0FoIUH3fH+3QL/oPW5WvH20B63OoYyKo75nBim1Cg3mB
         C66nywqil1VddJwm5pTcZUmY2t7JJsjev889zoN8TJhipM39P/uKD9nb+CCDNLtQqRE3
         JRlVXGnw0XIALxS+eWJARw/zompgeHxovRoHXC+jAX4hJIusWoxWvfS9vQMJIUvLhrHM
         n628zOLGqSUXEH34Z3Kg76oIrKiSzIbGrAYWSk5rn3mKiRGRkAoC7/YRlYpHMrqkUlAp
         aw3EukP9l+DgYuQQ+O2JUPPLQ+F+J2Ja1dDhVBScEN0aTJH1GkrvkpunBZiLwq+Hzgpa
         9ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689095952; x=1691687952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwIn11o9UG2icmHFhCNlCOZxpB87pUpr9W8P4bUdBtc=;
        b=GVGqv8CRg+P07tiDl/6bzVx4Snx8jNgjW3964YG5npos0G6caTdQJvXbcr523AhodP
         5Oyx5/2sbCPuxRLd9B5qKCYWCTVC0ayX/lmNwXZZAJznTjpqSpSlNnRk3YU+cmZsJVrZ
         I/RNHQgZny8VsnYFkvQ2aiy7EpCMKAgVsTHiu1r0cZ64cVtJ4TE/mrtsaQ45E2ANKp45
         p8LYPPCSm0buZzyAdcaBh0ZMvKN+Y6wuHqEInsLV+oV8uNoP08wy6ctikMJFMEoVLvTq
         XtvEVjcvmMXDsuAZZumAIKsM0K9wu9TgAqGi8n+VpCtWhBVnUJvma0AHhR5iAv8riysu
         r2MA==
X-Gm-Message-State: ABy/qLb+HXRh2TiZYd1ENFGc0zt6CK66elzHQYqyckr7pyO+PeEg+7LA
        0R7Lr+TZJerUP8oUKgO0utkxwg==
X-Google-Smtp-Source: APBJJlEeJosg5Yh1EE1/9ncexRIzf8kiWQJLzvu/uXsaPR1eP/FseLnLJ9uwpUa1UmFcP7mhi87N6A==
X-Received: by 2002:a25:8b86:0:b0:c60:9caf:bf57 with SMTP id j6-20020a258b86000000b00c609cafbf57mr13528746ybl.45.1689095952256;
        Tue, 11 Jul 2023 10:19:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y11-20020a25dc0b000000b00c4e93761e38sm535609ybe.64.2023.07.11.10.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 10:19:11 -0700 (PDT)
Date:   Tue, 11 Jul 2023 13:19:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 00/16] refs: implement jump lists for packed backend
Message-ID: <ZK2PDJbGQoTcR/si@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1689023520.git.me@ttaylorr.com>
 <xmqq5y6r4con.fsf@gitster.g>
 <eddehgbfqnmkhvhkacbvnqiiripbn6jvjawpy76ysfnpohsygt@a43fbutqg64z>
 <xmqqilaq30hi.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqilaq30hi.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2023 at 08:56:57AM -0700, Junio C Hamano wrote:
> >> I've skimmed the whole set again and nothing jumped at me as an
> >> unexpected change.  Let's wait for a few days to see if we have
> >> others comment on the patches and then merge it down to 'next'
> >> unless there is something spotted in there.
> >>
> >> Thanks.
> >
> > The patch series looks good to me, too, so please feel free to add my
> > Reviewed-by. Thanks for these exciting changes!
>
> Thanks.

Thanks, both :-).

Thanks,
Taylor
