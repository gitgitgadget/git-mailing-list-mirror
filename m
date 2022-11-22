Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C132C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 02:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbiKVCC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 21:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbiKVCC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 21:02:56 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F230C15A34
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 18:02:53 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y10so11065698plp.3
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 18:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0lRaGnEi0nFVQ+jEge6wOP3J2YekohhmQ8C28SioWvk=;
        b=W0kW0wV2IgKJnzqS/PVZRaFm4sxVd9MXM3uKbWYiEIYCkDUbo4XZareDZ17saTCCG8
         I2ulbhzNC2NZRdFcuVSJ1IIMPJrSdAQywUGJYfYK08XUeYsF2zBiqiR60mf9DFhAb1+W
         /24kbbRM6R4WDy1KAPv0uOTWT71Ep0QbGZIiHOMP45keobZUPv/a/3kjMieIPZLjDeIn
         SND101FLhNMFg2LBGqBXX0Tk1gsz+alGIHkLYZJYDeoK8h9C6/ubanEqELDseP8ejFQl
         aqRSaszkStafNbaKvVeYXDx9h5TCk3NOLJ34fncbOJ9E/uurfTqXtyhSoD9+11DnCYo7
         r+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0lRaGnEi0nFVQ+jEge6wOP3J2YekohhmQ8C28SioWvk=;
        b=YwYUbVXE9X+hU5s9ZGqipAEBzr+qrkqvVCP/6zd7w6O/rusR7qhX3idHDyFuWmRwUT
         USSKRLWjuBgrAx+tCLws+NP088SauNYWUKw2okW4MnUOLRdEip+8GWgvshbpxepEa13w
         uPjxtX2nWDE7X2rgQRi3+XcTEVhFaljSNjEDVoYPDRKwws4Q+CsokYfktw8fSjoGcphM
         Nw7k9sjvnBntSG7SCXMyQjqm6+CrWmcZRnVTYI8ij4qyTSK4QQOl3Oeyv/7kS76TLklY
         wzy77B4tA5NXd0lTtFv8hY381fESt+N7EPBT2R5XwBVBmZnvC5oIaAIYRfX/yHNpxpL3
         Wr/Q==
X-Gm-Message-State: ANoB5pmhW62xS0prS10s1ar+9UBfuOYtHfrdHqe/0TdzTCEjTjA/fwe1
        aWsLQXzUNHjcciwpty/jEVg=
X-Google-Smtp-Source: AA0mqf5UOQcrhUvdF8gAXxE0IyWKKIvxnOwKR98iUreqHzgO/knfOc5I4sQ/YEAQGFqOjFtBRjsBwA==
X-Received: by 2002:a17:902:ea91:b0:186:880c:1680 with SMTP id x17-20020a170902ea9100b00186880c1680mr3609945plb.164.1669082573228;
        Mon, 21 Nov 2022 18:02:53 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m12-20020a17090ade0c00b00205db4ff6dfsm8367493pjv.46.2022.11.21.18.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 18:02:52 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <git@dinwoodie.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: fix cygwin build failure
References: <0dec6e1e-207c-be13-ae95-294d9b1e8831@ramsayjones.plus.com>
        <Y2wwfQWrs+KYpWNv@nand.local>
        <221110.868rkjpty3.gmgdl@evledraar.gmail.com>
        <Y2xf7HbAdqXOmgR3@nand.local> <Y2xgI30EFZisqpRG@nand.local>
        <Y2xgef6IvBHnnfE/@nand.local>
Date:   Tue, 22 Nov 2022 11:02:52 +0900
In-Reply-To: <Y2xgef6IvBHnnfE/@nand.local> (Taylor Blau's message of "Wed, 9
        Nov 2022 21:22:49 -0500")
Message-ID: <xmqqwn7nsq43.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Nov 09, 2022 at 09:21:23PM -0500, Taylor Blau wrote:
>> On Wed, Nov 09, 2022 at 09:20:28PM -0500, Taylor Blau wrote:
>> > Yes, 'ab/remove--super-prefix' is only in seen for now.
>>
>> Oops, I clearly meant 'ab/make-bin-wrappers' here. Sorry about that.
>
> ...Double oops. Now that I think about it, my notes show that we were
> planning on dropping this topic per the discussion beginning at [1].

OK, let's discard it for now.
