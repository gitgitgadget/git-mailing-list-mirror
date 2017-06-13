Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B90CC1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 17:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753828AbdFMRsQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 13:48:16 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34341 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753825AbdFMRsP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 13:48:15 -0400
Received: by mail-pg0-f67.google.com with SMTP id v14so20070871pgn.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 10:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5hDT+ZLGsDhXwu7XiC3vpFmES9nKU0gckXx3OVgMhtg=;
        b=vdMr8ydfiI/XUk7t8aQvhDzknH32o8ab05c1J3b/gf6VvlWrQHaXMqipuL860HM4NZ
         BCCKr+suK216VKV9Fb64CdUgKK3ZYeCmGV5K9G1sEV5EPGvUS0JK8+AOljlGB4wRKjuz
         xMTdSrWoWntpRg39lyJUz5MkuPP8gr0pm2LgchzjTwmTcpdghFH3zJwryI0VzvXSXrpk
         TwTpGxpLIkuwmYJnhu+FlOabvb1Xi+FTuzMwNlD3yfEUQFZlOxTsSPZfvierYzG0RSab
         UbGV+tIcI6lVz3ikzmKHr2H49Hyxs8n/e4J44NM1nI0V/y42ReCr9WOrg63r5MALGzK6
         zpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5hDT+ZLGsDhXwu7XiC3vpFmES9nKU0gckXx3OVgMhtg=;
        b=Q5QVVsMtxzm3NWVepJCYuybF1K6EfwJK3ScUNPdEWge4QWHC2acjvnJY7TYG5XV1et
         dEc8IFmvXOw0qSwpwCAIXcWffajPiv0ViTJ7n69rCEHPGwJCUpx45eqMy5F8JynqKKih
         jSxOBrsgfiKhjS/eu1OzYQbFejZbs+J4UUMDRhHvTGJF9ax068VGMoBu62Z8mGZ8/aS0
         SwTkYRtfBd2iX1atfIkUuHs8XjCD7aEET4aTPhXFIePTWmmSrW8+iEtvUEloLfCoKuCs
         6nNNd004QMo5g2Pmmx3ibmhIeNBRGeUTgn1jniTPoY9K9Wvbtv3MZGFlxvyNYpXdga9i
         rmDw==
X-Gm-Message-State: AKS2vOykqbjF0KhBIlM5QuyJmUmMswStZS8aO85c7jfHzvd9KXvt1dU7
        8JPNpqr9vf2/z79Ezz0=
X-Received: by 10.98.11.196 with SMTP id 65mr737051pfl.110.1497376084603;
        Tue, 13 Jun 2017 10:48:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id f71sm26326058pfd.98.2017.06.13.10.48.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 10:48:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC/PATCH] builtin/blame: darken redundant line information
References: <20170613023151.9688-1-sbeller@google.com>
        <xmqqvanz9afq.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYR+qh1X-dQixdpDbcr5z-DJ2mkdncaVn_8y90kNco9tw@mail.gmail.com>
        <xmqqa85b9626.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYV8Ngis=ux50Zs1r5XOBUJ=hw2=8BEkNqk7PiGamX0AA@mail.gmail.com>
        <xmqqo9tr7qkk.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kafV5aXd9SAOHHGOgsAdpuY=YV6yWoWSsuG9rncLYhphA@mail.gmail.com>
        <xmqqbmpr7pyj.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZNXCjBBnzPZLJqPY9S_ovPAegNT0pdCKAMWJH5AQoCCw@mail.gmail.com>
Date:   Tue, 13 Jun 2017 10:48:03 -0700
In-Reply-To: <CAGZ79kZNXCjBBnzPZLJqPY9S_ovPAegNT0pdCKAMWJH5AQoCCw@mail.gmail.com>
        (Stefan Beller's message of "Tue, 13 Jun 2017 10:44:51 -0700")
Message-ID: <xmqq37b37p9o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, Jun 13, 2017 at 10:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> But you do not want to (yet)? The goal is not to tell you where the bounds
>>> are, but the goal is to point out that extra care is required for review of
>>> these particular 3 lines.
>>
>> And when you _can_ help users in that "extra care" by pointing out
>> where the boundary is, what is the justification for hiding that
>> information?
>
> It is very complicated and confusing. Consider this:
>
>>          context
>>         -C
>>          context
>>         -B
>>         -B
>>         -B
>>         -A
>>         -A
>>         -A
>>          context
>>         +A
>>         +A
>>         +A
>>         +C
>>         +B
>>         +B
>>         +B
>>          context
>
> So from your emails I understood you want to markup
> block starts and ends, but in this case C is *both* start
> and end of a block, and has also different blocks around.

I never said "start and end" (you did).  I just wanted the boundary
of A and B and C clear, so I'd be perfectly happy with:

         context
        +A      dim
        +A      dim
        +A      highlight #1
        +C      highlight #2
        +B      highlight #1
        +B      dim
        +B      dim
         context

You can do that still with only two highlight colors, no?
