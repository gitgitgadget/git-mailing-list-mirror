Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EACB1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 22:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeC2WfU (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 18:35:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52894 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbeC2WfS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 18:35:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id l9so13202648wmh.2
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 15:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2PkspLxCs5NKOV06ioWzvHDYJuOjlkxRB4CPqfSprk4=;
        b=o9oNDvtr6q5Xrw8OET9O2xduGVnhZVCqos60tsuzMNW9fiyGagDM5leTuPZbDfiKxf
         LNXA+uGWbo0lqZWqtUtG8nKaTZgaojzegSw4yMFmw3iOYZWpSs2gTTQE6jZWCISqp+rn
         45J6pp7enHlEf1fa+82XL4Fz5CBQlNzsW/0z2KYlkgiBQAsGiGiYUwtEl7GZ1mtKSEiB
         kKEge0cCOKBzztsEl9ZJNXt4ArqW26ZJKzGmSlmUhmMWu7DkQmKiUO5lVpfFUB3fE5mk
         HzKuFqumNAv7QIfZMwFLsrNg4E48A6V2NbYj/shae1d6kSoPLW922biFtpwHp2OtJI7b
         iMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2PkspLxCs5NKOV06ioWzvHDYJuOjlkxRB4CPqfSprk4=;
        b=auIfNN50UwJ4M73DDI1+EIvHFpsbvlkrdeJgsBI9m+bbx4XaQJceOI+My0LZ1PU+hA
         C09NsqZpHxTiXIsKSD+WszEb9BwO3UJ1BWO9ALk+ctIxlr66Itq7TMPP8swqcvw5vuyp
         ANa1Cu7PReIpCidYXNbyr405uTS5qccjcyCMuQdZ7RInb+AOUhIGqqsOxIeKQf3kn6IM
         37B50A6LH1m7varn5lMBA3OBHn11l8+ye+jqSAhnUTmbNSOBtmevDA5xUinIGcK/yKTm
         f9gt4TVl7mjD+GoJ5JxK945xv0Hm3K47gFWlIjjae1xCHRimBl4SYsFKbfgJ8Y/WBiTk
         wLFw==
X-Gm-Message-State: AElRT7HY3RRv28LNxT6PVrNX5MiA+MP+7EvfPHYzW8HT3xr4Gv/I2UAy
        yXSDnRDBHasSPlYNo/iqEV8MK4GO
X-Google-Smtp-Source: AIpwx4+wdx33br0T49qp1VgINH1ERIh69xr4kJfBUlB/ZixxUKVPhf68LwcU2V9Up5tBuSP8LRwxtw==
X-Received: by 10.28.141.138 with SMTP id p132mr551071wmd.51.1522362916994;
        Thu, 29 Mar 2018 15:35:16 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m35sm12102099wrm.59.2018.03.29.15.35.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Mar 2018 15:35:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Erik E Brady <brady@cisco.com>, git@vger.kernel.org
Subject: Re: [PATCH] credential: ignore SIGPIPE when writing to credential helpers
References: <20180329175501.GE31833@sigill.intra.peff.net>
        <20180329180056.9941-1-brady@cisco.com>
        <20180329215153.GJ2939@sigill.intra.peff.net>
Date:   Thu, 29 Mar 2018 15:35:16 -0700
In-Reply-To: <20180329215153.GJ2939@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 29 Mar 2018 17:51:54 -0400")
Message-ID: <xmqqzi2q4ijf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Mar 29, 2018 at 11:00:56AM -0700, Erik E Brady wrote:
>
>> The credential subsystem can trigger SIGPIPE when writing to an
>> external helper if that helper closes its stdin before reading the
>> whole input. Normally this is rare, since helpers would need to read
>> that input to make a decision about how to respond, but:
>> 
>> 1. It's reasonable to configure a helper which only handles "get"
>>    while ignoring "store".  Such a handler might not read stdin
>>    for "store", thereby rapidly closing stdin upon helper exit.
>> 
>> 2. A broken or misbehaving helper might exit immediately. That's an
>>    error, but it's not reasonable for it to take down the parent Git
>>    process with SIGPIPE.
>> 
>> Even with such a helper, seeing this problem should be rare. Getting
>> SIGPIPE requires the helper racily exiting before we've written the
>> fairly small credential output.
>> 
>> Signed-off-by: Erik E Brady <brady@cisco.com>
>> ---
>>  credential.c | 3 +++
>>  1 file changed, 3 insertions(+)
>
> This version looks good to me. Thanks!

Yup, looks good.  Thanks, both.
