Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67156EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 12:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjFTMJD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 08:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjFTMJC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 08:09:02 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22BBC6
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 05:09:01 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b58c7cc06aso1027598a34.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 05:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687262941; x=1689854941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YZTQ6DkbbXKn3yAU1IXf/U5JIDbUQtK1vBtbPKjfEHg=;
        b=Aoe5sx1/kEF03b+1L+Ei5Odrowkuis3x02fi0TlyyyE5dXrMkeOq7U2/1f24o0Q43H
         /VoQrZMSbzJgkDE5zdVHRvklxp4UBODaW2vbdrRhVKi4ZbxyO6jj0WcKym9/fHDpDhgk
         r7Pq3k/REO+ysRkoxIiS54LOuijwc2SSz8GjquaNaExZjTaKuFRzw/zsq91OZH0JJzue
         Uc7Vupi8187oDhe76xH7bdKbi0tq68zt9L01i6GhAA1zfefOSqvw4qhovTPNWwZ6lLIT
         wjr7+QUvc4aCpeicyW2e2jpBdM2wmn8kD079rgclltcWgZDdO6E8lCMqTyQ99xM24epL
         DFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687262941; x=1689854941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZTQ6DkbbXKn3yAU1IXf/U5JIDbUQtK1vBtbPKjfEHg=;
        b=gO4FXhKrbOyOKD3dRdmNQ5+Ugiv8U3KKWKOQzjUe35JmU8r/UGykTKeXWYrQY2+C4P
         wv2J1DrQi4qS2af2QAsUvEKUalADjtcQL+51pQbNws0FQJDYQx5lVMYO+EUet4GdkSPM
         Lwz+yxVHU6I0gvM3WYdw9jS4W+B5fIUpzKYo3QMi5g8Ped17AjYO0ZZRLUdyMdbhVl12
         BFMr/17XrUiBAoFs6QHKjBFyMtNkTeyerq1/Qua33SfiNq7DUwG9RoM+JgrUNjIFzgGq
         3PuRPMnQ40fEh9dVZy44+jYp2VpJmS9M3jyB0Srb0V44K5iIPye4K9Xa07+UVdsYLYdE
         jsow==
X-Gm-Message-State: AC+VfDyYQgPF6AZoEAdinl3N/v9jQKztgePVtn0F8VSgzZCuSnNH3n1F
        oT+tmkkazX65cguV857PmHBq0w==
X-Google-Smtp-Source: ACHHUZ4jJk80BcY90uQx0Q1NDIV3aV2nU10lwwiarpxrO9IoUQwJLthxSM+QUeNmSlZWn3iQBy1bIQ==
X-Received: by 2002:a05:6358:e820:b0:129:c3a3:5efd with SMTP id gi32-20020a056358e82000b00129c3a35efdmr4136720rwb.24.1687262940245;
        Tue, 20 Jun 2023 05:09:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d137-20020a25e68f000000b00bc68b767cf9sm333960ybh.41.2023.06.20.05.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 05:08:59 -0700 (PDT)
Date:   Tue, 20 Jun 2023 08:08:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 10/16] refs/packed-backend.c: add trace2 counters for
 jump list
Message-ID: <ZJGW2NaQQhS+hirp@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1686134440.git.me@ttaylorr.com>
 <3c045076a95fab9d050a312114c9aca712eb7141.1686134440.git.me@ttaylorr.com>
 <xmqqttva28a7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqttva28a7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2023 at 05:32:16PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > +assert_jumps () {
> > +	local nr="$1"
> > +	local trace="$2"
> > +
> > +	grep -q "name:jumps_made value:$nr" $trace
> > +}
>
> You may expect 1 hit and the test will pass if trace had 10 or 12 hits.

Oops. Well spotted, thanks.

Thanks,
Taylor
