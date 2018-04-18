Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A90D1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 21:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbeDRVv7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 17:51:59 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39986 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752560AbeDRVv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 17:51:57 -0400
Received: by mail-wr0-f196.google.com with SMTP id v60-v6so8644102wrc.7
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 14:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GaLG+GR/pi9qH7YvUcwzyckmjea33M8TgAksVcPzcPI=;
        b=RUrdwxKi/sKOu3WTx5/VKcHwq5oBddAmYoQTnsniHdlNJIaiPm/p1asuwn22iewLJV
         QYGAldlKIes9Q409mJ5Ff/pVkoK2RNfumH1Ulcn5sLlUNEJeCYmgjXdES6DKOjSn+lXP
         +5f16gkoN18Ad/TIG6XGCHlWBybQPjXXbjX9fNObgjlksQy3NHLoSBz8jfJVj5pSFmVl
         KaMyiKjqSZvSZXuG9BYydwe4XG95EJ9jlnMdzPc+uFn+VyGv7aYhG9uaeYP9lcBr+d0i
         oHO3wuF0g4Bwfgd7zpDadMVUc21iftvTXPYI0XmD6BmEOJ1iDhJtKKK6sochjmPui1an
         6WQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GaLG+GR/pi9qH7YvUcwzyckmjea33M8TgAksVcPzcPI=;
        b=ISeKkFp9AoamNSuzZ4Q4R86AetX5V0cmNKvYPpQSu019XpPYXjmUU0VumcNXi59dNx
         jDj6IXCbl/OdKBPioCSsZvNsizVahtbAmfNkC6KDKLiWj1sPgY3AtJ9m65PtsvoCH51G
         VAFa0u7kS/GbbBTEbo2Xy6rC/+p3eQHOin2LFVMvWPbUzkISeUh9VfUzFP8fFGJ7G7Zf
         Hv9Yf4UcTx9KDhck3npdRr/okuIuGtcCYdrmw9ZUHRsNQHJjHI3/1U4izSGZjPTXSjk1
         mw6LHk2uXMEeReCjTdHu3a86RStzN/tEVWXb5NyUtXrxjT9s6gN2CnLiDVFd2e6wKPun
         A8Wg==
X-Gm-Message-State: ALQs6tCRnJJMUeydx9zYdnIjgH1KwFC57vBDhjZ4zFhqwpSFZIEb+jhA
        AOYePmHC8axYsJQE/S0Re5g=
X-Google-Smtp-Source: AIpwx4+3RGOGLmeQ9+mw4v3HLhqPmmVUtS+rtlMsYWUR8EJZ0DoQd0ctXsuZCnbPluAUeXMGRzsqqw==
X-Received: by 2002:adf:c384:: with SMTP id p4-v6mr2788218wrf.279.1524088316391;
        Wed, 18 Apr 2018 14:51:56 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j89-v6sm2263412wrj.86.2018.04.18.14.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 14:51:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Kim Gybels <kgybels@infogroep.be>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] daemon: use timeout for uninterruptible poll
References: <20180412210757.7792-1-kgybels@infogroep.be>
        <20180412210757.7792-2-kgybels@infogroep.be>
        <xmqq36zw16gv.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1804182251070.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Thu, 19 Apr 2018 06:51:55 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1804182251070.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Wed, 18 Apr 2018 23:07:18 +0200
        (DST)")
Message-ID: <xmqqy3hkfais.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Unless I am misunderstanding violently what you say, that is, in which
> case I would like to ask for a clarification why this patch (which does
> not change a thing unless NO_POLL is defined!) must be rejected, and while
> at it, I would like to ask you how introducing a layer of indirection with
> a full new function that is at least moderately misleading (as it would be
> named xpoll() despite your desire that it should do things that poll()
> does *not* do) would be preferable to this here patch that changes but a
> few lines to introduce a regular heartbeat check for platforms that

Our xwrite() and other xfoo() are to "fix" undesirable aspect of the
underlying pure POSIX API to make it more suitable for our codebase.
When pure POSIX poll() that requires the implementing or emulating
platform pays attention to the children being waited on is not
appropriate for the codepath we are using (i.e. the place where the
patch is touching), it would be in line to introduce a "fixed" API
that allows us to pass that information, so that we can build on top
of that abstraction that is *not* pure POSIX abstraction, no?  After
all, you are the one who constantly whine that Git is implemented on
POSIX API and it is inconvenient for other platforms.

