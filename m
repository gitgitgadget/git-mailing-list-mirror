Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EFBF20188
	for <e@80x24.org>; Mon,  8 May 2017 00:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750795AbdEHATS (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 20:19:18 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36364 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbdEHATR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 20:19:17 -0400
Received: by mail-pg0-f65.google.com with SMTP id 64so571274pgb.3
        for <git@vger.kernel.org>; Sun, 07 May 2017 17:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iouGdlueUs1No8vV2+UYobl9ZzmekRiJSLFottreJQU=;
        b=uMm7XgSJI9K11TMjluyQt47inP6tABlYUraa/+hPTEphVuts4mTaiOOFgWT1KLrqw4
         2ynSZpxsc8o38rONTFJh9vwJGgn8lgktL3++VRnPAp+7Jpp5Idx5CfKcl9F18HNNezoE
         nIl50xPAjR+CwchHMhHP5AGkyT2NXN2TlhlXA7eyI1rbFWSIiD+topqqn3gymYjAcfio
         gt+9qAWXtX+wGLeV8UIdWSbfXy5Vh/SfrjDQ1ZQvPKWHOJ0HawXNXuGnsDfvhjvkF039
         M+4mgDg2dMmdly00dgPNk8Q9IAybUTfSNP1jSmEhXi8mb1XibyrKwF/+ZKEuykjo628n
         7iAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iouGdlueUs1No8vV2+UYobl9ZzmekRiJSLFottreJQU=;
        b=QIhkkTXD30ZgRV9FtUAediq3wJXdeGnF6mvm+uYxg7T+DmG07UDn/WuaHJG6O0I+uV
         UzzJZCMD1M+x2rS8roTAS49RGErstu1Wet25vINPvXWhbi7k/2WsYfWT09P89V8GccHl
         GM20ALiwqJ6PH1wkvgNY1Oyq+UAXVmO3OQnDAr3YPD5QygnNNDhC/U90MmF3+ofmYzt2
         P5tytWjy0k5d2XPnlfD/5erN2stLNcx8DI01aRUeCX4D38E4SkvLaIQiV0PS8UdSL/LC
         7KnNgYoFUmB6l4upJIejx9KWcQtpZnu2utcu6BMYdcb3FjtM4GWH4HufnKKJWWqII+0U
         Xr+w==
X-Gm-Message-State: AODbwcClkaBdNpNPqT/XmvGypvkzkvUCZnIKwQPtuNzddE/4RxE0QArP
        Wophe7d9IVNZGw==
X-Received: by 10.98.32.132 with SMTP id m4mr5511608pfj.131.1494202757074;
        Sun, 07 May 2017 17:19:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3011:642f:81a0:efbd])
        by smtp.gmail.com with ESMTPSA id m24sm20813962pfi.129.2017.05.07.17.19.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 17:19:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] archive-tar: fix a sparse 'constant too large' warning
References: <252ddd6a-3516-6619-8ea6-d3897f13d93d@ramsayjones.plus.com>
        <alpine.DEB.2.21.1.1705041121520.4905@virtualbox>
        <70b431dc-c5cc-e376-b63e-6a58ee1385f1@ramsayjones.plus.com>
Date:   Mon, 08 May 2017 09:19:15 +0900
In-Reply-To: <70b431dc-c5cc-e376-b63e-6a58ee1385f1@ramsayjones.plus.com>
        (Ramsay Jones's message of "Fri, 5 May 2017 02:21:50 +0100")
Message-ID: <xmqqshkgci9o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Sure, I can add this. (Although, I don't think it actually
> matters).
>
> Hmm, unless somebody objects in the meantime, I will re-roll
> the patch (tomorrow, it's late!).

Thanks.
