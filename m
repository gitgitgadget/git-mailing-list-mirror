Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E63831FAE3
	for <e@80x24.org>; Wed,  7 Mar 2018 18:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeCGSk3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 13:40:29 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37311 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbeCGSk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 13:40:27 -0500
Received: by mail-wr0-f194.google.com with SMTP id z12so3206456wrg.4
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 10:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NCmJ5FOls/G/KUUgHlKzBuN8+qIOjESfHfeAG7b4yD0=;
        b=Tb5BaJWIQ2OgGIVOIc0ap+OkWHewP42GEvImt8ZuWV5YRUnvJ+AdVLDPQJrFSko9zp
         o5QWzg8z42cCouYM5xIDOFcrkHYnYmF8gKceu4oS7YLLIBRVYSoP9DzohyKkuwp7MQdH
         Q1QhSXKrlh4oSkVq0cS8cpprTqgsM6LmEd+U0g6AFQ1XbevqpNKkMpHTwpSxmi9NiCyw
         Yi2kOJgOoHRfBl/tln1YPUgl6x+JCeZs/n5eIZviudcNNfxBGAxO2sUfQzjGW4Ms7sim
         fFK/6CcllRml1YbAuns8Z0jkirDNyCBaNfu2Jvu0IR2+29KbAkKYj4zG9bzCeSwOCpGz
         VaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NCmJ5FOls/G/KUUgHlKzBuN8+qIOjESfHfeAG7b4yD0=;
        b=p9TFkwpA7mGpXcfqFHGvU5bI1rFrfJPN5IZH8Oe1fT1qlOsw6mg6GCDhZeZMr33cpU
         LXJ41CNOLSPNyKTc5tpypQFG2vCp+veGzJBB1EiW8TayKkXwDlCUvir1Sw/C1Tsw8J9O
         tRxJFC+Zqu+tHhlNqvqJoQ5+4ShUnnXPyzmQl/ITIwADxSLr74aFHZpE39sdF0mOBnIM
         C6sL2vDkWitPIYcpb0J5gfxjnevdi3cVpAyIY69w797mly4BXGcl5R0n7jzjUukAwYRO
         nus+N/wPBy6vu2SCfS22uQcB1EGbVHmBW/lTY6uXgvyZP9JygljnhZJtiv3kWS5aKujl
         2EGQ==
X-Gm-Message-State: AElRT7GAA3qhL2eD6dHwNG7k0BzJxfdjiG0Zj7flI2NC+KDf/gZoGcE2
        Twr+glrr68nxt6TyA6jA4oSuitQvKGk=
X-Google-Smtp-Source: AG47ELvjZS8VLeAbfTyurAKYFRuioUgl68xPq8mD8pVArKk2H/B+EB+RzZs/H1xNnXp7cTj3r1XGSA==
X-Received: by 10.223.193.73 with SMTP id w9mr13113075wre.101.1520448026100;
        Wed, 07 Mar 2018 10:40:26 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b9sm20657263wrh.68.2018.03.07.10.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Mar 2018 10:40:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        e@80x24.org, git@vger.kernel.org, peff@peff.net,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 3/5] gc --auto: exclude base pack if not enough mem to "repack -ad"
References: <20180301092046.2769-1-pclouds@gmail.com>
        <20180306104158.6541-1-pclouds@gmail.com>
        <20180306104158.6541-4-pclouds@gmail.com>
        <nycvar.QRO.7.76.6.1803071140130.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Wed, 07 Mar 2018 10:40:24 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1803071140130.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Wed, 7 Mar 2018 11:48:45 +0100
        (STD)")
Message-ID: <xmqq8tb320h3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Junio, may I ask you to put this into a SQUASH??? commit so that the
> Windows build no longer fails?

Thanks for a reminder; I also spotted it (I first thought I screwed
up in my editor while reviewing and then went back to the original
on the list) and sent out a response, but then by that time I was
already far into the day's integration cycle.

Will queue a SQUASH??? at the tip.
