Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 669F320D0A
	for <e@80x24.org>; Tue, 30 May 2017 03:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750898AbdE3Dxv (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 23:53:51 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35425 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbdE3Dxt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 23:53:49 -0400
Received: by mail-pf0-f179.google.com with SMTP id n23so59668971pfb.2
        for <git@vger.kernel.org>; Mon, 29 May 2017 20:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=C04Sx9s6NNN19VQ/6O19b9qe6+i2hxX/n//KfxG9RV4=;
        b=e5EThC1O2RYsP+IkwRYoZtaenvzt+uPyn7lD38lh+JEkoF6Vipewkv8M6loH5rL0iC
         KgOJoWJ7amhTKo/GK0qCUdyRzaCm4/gtXJA07WT0gfGZOkCVUyk50vwSvcjsuq0wRssf
         B2PGQjUgUVD/IFDldETFlSqX5FQ4KmrmCx3ds3c1sQuLx78qCtVt5CjwTXJqb31csCD2
         OnpKl3W8OHRcIFSPRoAjoMp2joNXXRQtEjOWXeJ2Gbbc0ZVVPbfnPxqEtA5OAW0YSkfI
         fo/ORgH/MWrZzVKu829ucF0e1a13GE2ImHPOuDWVOQGuIJmbowKj2wh0UyiFg2eFvmAf
         ARRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=C04Sx9s6NNN19VQ/6O19b9qe6+i2hxX/n//KfxG9RV4=;
        b=aPd5NOx9kaWc76p6xk3dypqyZV5CoyB6eF/3tXEg00AWOTL34Qqp/Sg7o/wdy/0hEL
         FUJPIBLtDAYJTqYRWcwYKlryREiFqDmcXhV75o7uUdmuqU8J8coHFZN50jmPUnKtJ4BN
         o4oo19inQZ7OXKcEFcvO1asoD2jWQodmVzNuPZSnOllrwI0eT6VohK89zlGKhWKqtCvO
         WdBsle+awVrkmsv2zGDkxl8GuzSc9lW2nsU3MLIq7C0gen2/bCZEo9t1n+9j+/lZWIFl
         I54lTB2CYf49K1qvXhdk30GGxjiLFmiQbHfaSR4ek19aO+cIgdqTqYVsEDe516BFOOKk
         E7Qg==
X-Gm-Message-State: AODbwcBauoq097zmDTbQDg3qzEY5zaLzNZjUpY2BiYLblxOUhzKr2YF9
        ZaPBcCNfT2canNgIP5Q=
X-Received: by 10.84.202.163 with SMTP id x32mr80505321pld.51.1496116429179;
        Mon, 29 May 2017 20:53:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id c29sm21391517pfj.101.2017.05.29.20.53.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 May 2017 20:53:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCHv3 1/4] clone: respect additional configured fetch refspecs during initial fetch
References: <20170515230727.hw75whugf25asuor@sigill.intra.peff.net>
        <20170526100403.19270-1-szeder.dev@gmail.com>
        <20170526133024.g5rztiv3lea37n72@sigill.intra.peff.net>
Date:   Tue, 30 May 2017 12:53:47 +0900
In-Reply-To: <20170526133024.g5rztiv3lea37n72@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 26 May 2017 09:30:24 -0400")
Message-ID: <xmqq8tlfdmpg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, May 26, 2017 at 12:04:03PM +0200, SZEDER Gábor wrote:
>
>> Unfortunately, putting the default refspec into this temporary
>> configuration environment breaks a few submodule tests
>> (t5614-clone-submodules or t5614-clone-submodules-shallow (it's got
>> renamed between this topic and master), t7407-submodule-foreach,
>> t7410-submodule-checkout-to), because it "leaks" to the submodule
>> environment.
>
> Doh, of course. I didn't think of that. That's probably a bad direction,
> then, as there's no "just for this process" global config.

Yuck, right.  So... do we have a further plan for this topic, or are
the patches more or less good as they are?
