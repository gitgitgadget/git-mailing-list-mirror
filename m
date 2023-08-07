Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52183C001DB
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 16:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjHGQXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 12:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjHGQXu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 12:23:50 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E5D10DE
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 09:23:21 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5860c7fc2fcso48628297b3.2
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 09:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691425367; x=1692030167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QkW7LeFo9wAFkFEg96ka/0VbdQ7rvBDush8xxH/Y/VM=;
        b=SYt3oCSbU+6T6tC/r8pk3cNeeZy1pXPuzmsPWvmZSR9HXH6+AdXnP+V6bC422fUZvm
         CC6aM6GjlfIBNH6RzPlOIGlhiR2n1rumy5UH4RsJk6ViEgR0qbQ5ZPasUY9okrCTb23a
         Vwz7uWMs5rC11tGJUvoNNuetAmHJIuL5hTZ/Xt7ir2HdnqV2pD9tSm6YGqw6OqmfMso/
         sVWzu9Kr6lGUlkVARkxz45vYQ5GvRzuDQZ/uoVAcF92TFwH2zbI/XfVdJA+x4xZ37Yrd
         36LtsmQmKpashx/K/mfjYSgbmjXeb6N3jh3myyqghxb3fWmAXKkl89k3I2lKm4n10HHH
         iCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425367; x=1692030167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkW7LeFo9wAFkFEg96ka/0VbdQ7rvBDush8xxH/Y/VM=;
        b=JZpwZ41QaqfOzYj4DvSC2CErQllgBgW98CBvWzDBYhJI9+yWyWf1V+ZWMdhRDnzNG9
         5EqzjhXJoooKV7yEnQ0ZWm3hKCxtFJGpR9L3JmTSHLKcXTgqwGja208ACuZPGAZzVS2D
         jX9cF9HYwadclfvUbjalDriY4heK72aJEtbPvEzSKcE9WLZQCR7yqugoJDWTCc6zD3k+
         vzFcUP/K6cy/miRGXHnZ5HewecTb91fykRM3Vlw5u179zgiSZbrQqn+/U1FCW7BEeKv4
         eoLcRVzBQTE18Xlg5+odne9NAgZ/ZHS9faoLfzYXE1tanvjYIvDDvfElWWL3kebRW5cJ
         fk+w==
X-Gm-Message-State: AOJu0YxiSKiTsrSBh6+AFC3DG0qdw3nIjnSdd+UiZ5sHUiOcTLnIDH7k
        TBlERUVbhI/BtPnVjmwsK1GZkg==
X-Google-Smtp-Source: AGHT+IHQ6S7WqyVG/q2Wl7ShOvL2hm+wc9fK9hBig4hwil0uuIY8fU95vF6KbVcwNWnU3MnnPPwHWw==
X-Received: by 2002:a81:84d2:0:b0:583:d363:8d1b with SMTP id u201-20020a8184d2000000b00583d3638d1bmr9111548ywf.47.1691425366904;
        Mon, 07 Aug 2023 09:22:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s9-20020a81bf49000000b0054bfc94a10dsm2745035ywk.47.2023.08.07.09.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 09:22:46 -0700 (PDT)
Date:   Mon, 7 Aug 2023 12:22:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>, git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2023, #01; Wed, 2)
Message-ID: <ZNEaVefeE86s2V6h@nand.local>
References: <xmqqfs518gdh.fsf@gitster.g>
 <CAP8UFD1vuB2kRr890B7GXum9HAMjRep86zy2tE4yE2C3W5QGHA@mail.gmail.com>
 <CAP8UFD2Fw+oGz4VK=_i3B_D_VMQqMoXTJPpXRbkDiWjHciEqJw@mail.gmail.com>
 <xmqqv8dqhlkz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv8dqhlkz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 07, 2023 at 09:19:08AM -0700, Junio C Hamano wrote:
> >> However in a recent article
> >> (https://github.blog/2023-07-27-scaling-merge-ort-across-github/)
> >> GitHub says that they are already using git-replay (though not sure
> >> it's this exact version or another one), and GitLab plans to use it
> >> too.
>
> So there are plenty folks who are capable of reviewing but they are
> not interested in giving it to the general public by withholding
> their reviews ;-)?

I think the most capable reviewer would be Johannes, who was most
involved the Git-related parts of this work at GitHub.

I was party to most of the changes that went through in this area, but
didn't look closely.

Thanks,
Taylor
