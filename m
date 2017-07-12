Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 923131F661
	for <e@80x24.org>; Wed, 12 Jul 2017 21:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753439AbdGLVKJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 17:10:09 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33102 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbdGLVKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 17:10:09 -0400
Received: by mail-pg0-f67.google.com with SMTP id u62so4357080pgb.0
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 14:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SrzWeMlIZqcMMUA6bliVoXaYOLhg3jhFSKvlDxbHdvU=;
        b=j2eiJp7iu4j9lj/L4JmQQWz6oJUNONLpPB2X6uClWEUUJVwqvqhucto9e25MsdR42f
         v4zjOKrCpgJHi4T0ZYwu2ShdwvY8rpehAGDefLf9XC3zSKsibsB33yErzOYVC02TNMxX
         FuYBM8Zuk3xZER7vw+Xxy/PVapr7RxSk70JPgmMXKbrCvg2bLV36nEwzOHr1X4MtvxOP
         4YqCZDVGEuc6zcInwYNX1xSy9fGR4iftCURsVHhmBfJ6VObAoPEWypvFsLkBVE1M1b7V
         gFcdxEhm3uJ6/p4sv+kh2IrwFckyRW7onsUw0A4MFoHEGUPyS05Hpfjmm1hbJ6ZUgsZE
         jKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SrzWeMlIZqcMMUA6bliVoXaYOLhg3jhFSKvlDxbHdvU=;
        b=rs/KQuEWDMc8nuk5PToTKeRoTDME8T29ZruVQpXmwBZiVb8LaLnkCn49NXFdpdgEk+
         TgYnqBYhCfQFz/6dJkR+G1L5Z0zH12qQ22FI+jqa9gbF4XUuFJE1XlLsqfewdCV10MiH
         yyzH0qnP0PEmWTXGz/Kaf83jPiW65QEEvqwxSfY9O4gNK7KbscATjeJKIynLOuIQj7EB
         K+IZu/dNjCEOHbMEqF3QnMc41i2pGQ+yWCbK5vvj4qUWjF+Gl4xfAd8YYy72e8yVMyq0
         7ICl3HlUiTYim15kZ3n1dNxYelMgwoTs/CBH2bTgM7j2efOAlJWcBvlpG/HAP6nPERGM
         ljWQ==
X-Gm-Message-State: AIVw11291l71SNJ0tyrFgXcnSJ4/GmmBwvyHwlHNhopTWdF/2s/1ohk8
        4QIsiO+ATgQM5g==
X-Received: by 10.101.88.8 with SMTP id g8mr5874702pgr.137.1499893808208;
        Wed, 12 Jul 2017 14:10:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8c0d:cddc:dbb9:7a95])
        by smtp.gmail.com with ESMTPSA id g184sm7311395pfb.3.2017.07.12.14.10.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 14:10:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andreas Krey <a.krey@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] gc: run pre-detach operations under lock
References: <20170704075758.GA22249@inner.h.apk.li>
        <20170705082027.ujddejajjlvto7bp@sigill.intra.peff.net>
        <20170706133124.GB1216@inner.h.apk.li>
        <CAGyf7-FnaWM=XNb_Skb1qR4vu_jAw-5swkgWpEDQqwM0NNq3YQ@mail.gmail.com>
        <20170711044553.GG3786@inner.h.apk.li>
        <20170711072536.ijpldg4uxb5pbtdw@sigill.intra.peff.net>
        <20170711090635.swowex7yry7kqb7v@sigill.intra.peff.net>
        <xmqqvamx1u3i.fsf@gitster.mtv.corp.google.com>
        <20170712165817.xcq4we5ynl3opm37@sigill.intra.peff.net>
Date:   Wed, 12 Jul 2017 14:10:06 -0700
In-Reply-To: <20170712165817.xcq4we5ynl3opm37@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 12 Jul 2017 12:58:17 -0400")
Message-ID: <xmqq8tjt1hw1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... And I
> really think it's not "a little more work". Even if we decided to keep
> the same file and replace the PID in it with the daemonized one, I think
> that still isn't quite right. Because we don't do so atomically unless
> we take gc.pid.lock again.

Exactly.
