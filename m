Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0349B201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 22:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933822AbdBVWGv (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 17:06:51 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36639 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933051AbdBVWGa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 17:06:30 -0500
Received: by mail-pg0-f67.google.com with SMTP id z128so2059773pgb.3
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 14:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=65ti0Q6u1+OM20okMkjyet0Uxo3DTM1r+FirxM5gkzU=;
        b=L2fue7yEpTl4r6qFiS4Ov9j910Ck0IBteLiEsgdTrPphRdYleE0k1AcIBlb9x6/8Fk
         1LhHwv3li3xdJVzc/X02KpKz/9ga3JVklDbeoi1RvlZfn5JOLx7fu9EBfqf/IejM0v9Z
         4PynPH0nQMqWgUAGXkijcgovoxQeKt0ebqzIEKlspwbMK1t+YB5u3WcFToeM61mNKT0D
         x6vFqssQbOMgVGHiQX4Fc2DtDlbt5bJXYQm7E2wjZHcKsQiOF1bAT/LQMxR8bGV6WfTR
         ApkoYKjQQfexhTM9Ofmx7MCFe9Ya76werUt40pkRzZ9fmVChuHr26Rk8yliWmi9OIO09
         R1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=65ti0Q6u1+OM20okMkjyet0Uxo3DTM1r+FirxM5gkzU=;
        b=N4ROXR2XJwGioyWoS9lhben1xlXJg47FVgj57W8eIB/AosbACGDwDBWsuTemy2d4gT
         7ngauhxsC45+60E5R7/gWljIeQNb756nF15braWpPuJHj+OpCFBxnKKZmnYA1t1MAtz9
         CntQh8KKsIyyMIttgdsPYaf7GsFzuMzi+bqw4dQKMBFQfE+LHyIWvI62RMswYzEG1vvZ
         ocWfTYnFNZrbOHjC9lax1T2GaPgEQPs9MYz4j7T1Fpv4+hsHbFkR/x2VhB92us7uvuCC
         XCzlsPuU9ThMfyQDFgqIxRb3kAIv5hXcsxNJuNg1EU9W2+vC+NztXU1fTSPveqgY7mMx
         fpyw==
X-Gm-Message-State: AMke39kmo8080seLWLkfOMA34hZb1oxgbNswtnZXYv9ENQyUwhL5ibwb3PjPpbeqSZ/6qQ==
X-Received: by 10.99.119.74 with SMTP id s71mr30650861pgc.172.1487800649633;
        Wed, 22 Feb 2017 13:57:29 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:21a0:716b:e013:d129])
        by smtp.gmail.com with ESMTPSA id q64sm5488649pga.0.2017.02.22.13.57.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Feb 2017 13:57:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http(s): automatically try NTLM authentication first
References: <20170222173936.25016-1-dturner@twosigma.com>
        <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com>
        <20170222210636.k2ps3qhhpiyyv6cp@sigill.intra.peff.net>
        <xmqq4lzlc408.fsf@gitster.mtv.corp.google.com>
        <20170222213542.opunuepfmj557zyr@sigill.intra.peff.net>
Date:   Wed, 22 Feb 2017 13:57:28 -0800
In-Reply-To: <20170222213542.opunuepfmj557zyr@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 22 Feb 2017 16:35:43 -0500")
Message-ID: <xmqqwpchanxz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Feb 22, 2017 at 01:25:11PM -0800, Junio C Hamano wrote:
>> 
>> Thanks for your thoughts.  I'd think that we should take this change
>> and leave the optimization for later, then.  It's not like the
>> change of the default is making the normal situation any worse, it
>> seems.
>
> I'm not excited that it will start making known bogus-username requests
> by default to servers which do not even support Negotiate. I guess that
> is really the server-operators problem, but it feels pretty hacky.

I guess that's another valid concern.  The servers used to be able
to say "Ah, this repository needs auth and this request does not, so
reject it without asking the auth-db".  Now it must say "Ah, this
repository needs auth and this request does have one, but it is
empty so let's not even bother the auth-db" in order to reject a
useless "empty-auth" request with the same efficiency.

After the first request without auth (that fails), do we learn
anything useful from the server side (like "it knows Negotiate")
that we can use to flip the "empty-auth" bit to give a better
default to people from both worlds, I wonder...?
