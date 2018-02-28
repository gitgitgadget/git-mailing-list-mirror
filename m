Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 233861F404
	for <e@80x24.org>; Wed, 28 Feb 2018 17:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934662AbeB1RxQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 12:53:16 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38728 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933898AbeB1RxO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 12:53:14 -0500
Received: by mail-wr0-f194.google.com with SMTP id n7so3352093wrn.5
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 09:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kbKIuexI9a2aZ4p9LbAY+DLsXGLoL6nY25cHzXm/o9k=;
        b=o9H3EiyN5TaPc0QiermP8Xgw/yB0hZz74yTJ3FFAKZOxSgPX+l1MS4iMp8SsEceCHe
         1XXllOxWqqPJMwNQztWHsCWj5zk1Ki+jGgDl+Hc6EhvP8nmHATggWiMvdytAa3TzYWk+
         /6e6LkWcihLsOLijmH26wF0+/B5h0GEJUm7Rdfi+2fCkhPphVqXmKMWOdK1xqKEhnelB
         MY4ZfDOHOeRGtx08AK5CrSFIEuj4ffO3Q24JlY+qNzKphVMAoO6jL9u3DGAgQPO1+m/V
         CF3S0FLaW5uPCbnbLMp3ILItxoXZnXNesPL64XalFJImIPVm3kT6rsqhaI6tjIh7uw49
         AVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kbKIuexI9a2aZ4p9LbAY+DLsXGLoL6nY25cHzXm/o9k=;
        b=ByzywZolEnh1rewgVY3Bc3u1Yg6v68isBdTe4xErBMYFSzkofXtnnXWSGtHgABt40M
         RCLAeg1bdl1M95H3UWeYXgdsi4L6xx+TMNYutZ0KaLAkuOafZ2Oek/FfvGWTLixheHSq
         zTPh7HiIqQyPBYMrvGsAH0mxeOUgVxkeaiCevZnWmRTtlnhKICyyhpW7799AYcPTlOhT
         14c4RAHaNdSnXy91AsXdkKYIM/OXPdFwCRLhWd55vvZZIvV6sx8fxHpy6wCt4CxvTgSJ
         zwROmhigulyBUx2nzVBVe2uVkLp7BTzfcbmykNWpP1zYE+qCNzr4nqTowRa53/ZSXT+2
         BsSQ==
X-Gm-Message-State: APf1xPDg3KADRwu4R1ZyWsv7BfVAfQA/uCGx2A3ll0TYSWMTZAkBHzu+
        oZ/6ttO7xSZLVY1sXQEf7xg=
X-Google-Smtp-Source: AH8x227qv6RjBjZy/S8SW2kGxXE1ScWIGXLs/JZIuwhwwRwpG4veWO5nmmsTo/3ZbG7vPogyuWnxeg==
X-Received: by 10.223.187.19 with SMTP id r19mr16136796wrg.110.1519840393135;
        Wed, 28 Feb 2018 09:53:13 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g7sm1924612wrb.78.2018.02.28.09.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 09:53:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] protocol: treat unrecognized protocol.version setting as 0
References: <20180228005059.GA251290@aiede.svl.corp.google.com>
Date:   Wed, 28 Feb 2018 09:53:11 -0800
In-Reply-To: <20180228005059.GA251290@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Tue, 27 Feb 2018 16:50:59 -0800")
Message-ID: <xmqqbmg9m260.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> If I share my .gitconfig or .git/config file between multiple machines
> (or between multiple Git versions on a single machine) and set
>
> 	[protocol]
> 		version = 2
>
> then running "git fetch" with a Git version that does not support
> protocol v2 errors out with
>
> 	fatal: unknown value for config 'protocol.version': 2
>
> In the spirit of v1.7.6-rc0~77^2~1 (Improve error handling when
> parsing dirstat parameters, 2011-04-29), it is better to (perhaps
> after warning the user) ignore the unrecognized protocol version.

I do not agree with the analogy at all.  

Showing dirstat with different tweaks than the user expected to see
is a local and read-only thing.  Talking to the other side over a
protocol the user explicitly wanted to avoid (e.g. imagine the case
where your upstream's protocol version 1 implementation is
critically buggy and you want to use version 2 if you talk with
them) by accident is a more grave error, possibly affecting the
other side that you may not have enough power to recover from
(e.g. damaging the remote repository to which you only have push
access and not interactive shell).

