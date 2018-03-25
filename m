Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABBA51F404
	for <e@80x24.org>; Sun, 25 Mar 2018 20:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeCYUYz (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 16:24:55 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:38357 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751903AbeCYUYz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 16:24:55 -0400
Received: by mail-wr0-f179.google.com with SMTP id m13so3551862wrj.5
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 13:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WkX4ijWgst1aYd9zGs+7g4nAiFS/tHUGn7SgxRjcdZI=;
        b=igK+MRBnugY+b/fnNJu2ULQ/PSvnRgTkHew/xRiMVdw3XXFvXjeYOncehic4S1lVXu
         KUz/8YjsN4lq+5+dlfC7LUOz36211NUHxS3gVyQAsplg+JUBf2ACo2NAt9q5jdHf6N/1
         /w2iNezHjMGTvDeKn/Vgns7tyjBz6Zt98/+3gGQ+amqbm5OLMpWnYGoB1Zn/ETCRBCJq
         Q/pT/9sJJzNzbAcXQgMduPOBur5Wqcn5Bb+IhVm7t9yeM1M2meZeinBmck21mBcezDNT
         rJRQJsERrHQj6BkwKU+INnz4xtS2/UyGtiImqn5Ox4RQkdFXKJ2lML09JUcCtXYh5eAd
         OeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WkX4ijWgst1aYd9zGs+7g4nAiFS/tHUGn7SgxRjcdZI=;
        b=pinv40CloATHip2P9aHv0gJ5S8sGiZcruKPh4ccKiXwT3MEOlr5+4SAN5ouXz/3KKL
         LXmt8tWZLZepuxJ2HshcMaFRSgC3Cxl8r18hF3MSUi7LiUpAevl0CTpUcnREGy2IDcyJ
         pBmQDqINcU4DHZI2tg0+eWmBZu1iTOQ8LQe8d/hq91zzeppsbKOQDHT9jfl67eTrFUno
         3b9CyVv4UOzQAXgywcQbxBLUMD44aDyUTEI9QO9D+HGOK+DS3bvW5wRJ4fzx/nQcq+zF
         Vbiwq5WIP29wW03NmXrI7JiByAB0dNu3yGl/WIWsDL+Rb2z9EOEs6A7Z2w0ousF+Y6Zm
         +jVg==
X-Gm-Message-State: AElRT7F9smt+OT4bEpM+8IXzMoWnttkOsw7AViJItDt+XnRg10hea5QS
        LrP58aBGMHVrrzd6rAAqHCoD53+M
X-Google-Smtp-Source: AG47ELu1kYirgWVVoCFRVtM1WMa+0n6icqjKvV8TxPtoYRQOX4NZUSFCSdJt0Ui1c1il3LS45G/ATg==
X-Received: by 10.223.145.161 with SMTP id 30mr28556329wri.106.1522009493359;
        Sun, 25 Mar 2018 13:24:53 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 59sm17948566wro.35.2018.03.25.13.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 13:24:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yuki Kokubun <orga.chem.job@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] filter-branch: fix errors caused by refs that point at non-committish
References: <5ab7d35a.9060650a.fe7a7.04ef@mx.google.com>
Date:   Sun, 25 Mar 2018 13:24:52 -0700
In-Reply-To: <5ab7d35a.9060650a.fe7a7.04ef@mx.google.com> (Yuki Kokubun's
        message of "Sun, 25 Mar 2018 16:39:45 +0000")
Message-ID: <xmqqtvt3ewdn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yuki Kokubun <orga.chem.job@gmail.com> writes:

> References: <xmqqr2o8f7hd.fsf@gitster-ct.c.googlers.com>
> 	<xmqqvadmilx5.fsf@gitster-ct.c.googlers.com>
> 	<5ab46520.0352650a.cc02b.a177@mx.google.com>
> 	<20180323050913.5188-1-orga.chem.job@gmail.com> 
> Content-Type: text/plain
>
>> Grammo (third-person singular 'prints' misspelt without 's'; the
>> "when" clause has a complex subject but no verb).
>> 
>> Perhaps this will salvage what you meant:
>> 
>> 	"git filter-branch -- --all" prints error messages when
>> 	processing refs that point at objects that are not
>> 	committish.
>
> Thanks. I'm gonna fix it.
>
>> Please sign-off your patch (cf. Documentation/SubmittingPatches).
>
> OK I'm gonna add it.
>
> I greatly appreciate for your kind review.
> I couldn't write this patch without your help.
> Thanks.

Heh, it's a team effort, and it is not like I am helping your effort
to build "open source contribution credit" for your coursework ;-)

Thank *you* for contributing to make Git a better system.



