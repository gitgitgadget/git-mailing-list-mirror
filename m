Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AFFC433F5
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 12:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbiDHMDh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 08:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiDHMDc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 08:03:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC26D13E1A
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 05:01:27 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bg10so16897962ejb.4
        for <git@vger.kernel.org>; Fri, 08 Apr 2022 05:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=eJb/aJrq3WlQpxW2CUadAtgo6StZZDb3GII0yHSktz0=;
        b=QiKQUhKXS6AA0W2h5+BnJJTTGN1zmaQqKMj9dLopzFrmUu/o7xyo0CAJE2BZ5gDEdW
         uV3tmR37rYAF5x60BJm6rHMndvo6zRmys8BmWWfO+Oh68Iyq7j8zdSxe/bze36yTs1vj
         idmZDwefwGL0mRUulJbcW4XIv3DxDbiCw968Hsr+0GB/m37gPnYApasA7m5+Piw86fT9
         iMnOzExPBUVCAWxkvQ5YXBsP+4gf9BzDFQCQ5iWqblBqaP4upXZcbjPXKZSLELK2ghyk
         hXSePja/UrXQ1JW7Azj5SVGQDTWn/daDVYEMjFtHLiBKcSG5vTwaQ8/8UhSAkAydY8ym
         nY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=eJb/aJrq3WlQpxW2CUadAtgo6StZZDb3GII0yHSktz0=;
        b=vaHbw3v9wqT16NdZ47xB0cGlbsZ8YsrHmHmLjOoEPJMPhakvpF2eNOHZUQp6kFMyXx
         fN5E+y4gSlI6vO+aGHMKdn8IphraO9gw2ihTsY+k/7Ee2xyhLECx3Aks7GJ9LzMkBx0Z
         7AR93KF6N8z5H7btSZVS3b1dK26bwEkc3CNh0hovrvBOYKDooP6kxjmZuSqsAvOW9Kpn
         Flz7ErBQ4LDsrImiZcYgo4PxWP0p6NGlUBO5lss9A5OSswlNERFSp+Fnhk9DXLWzEVId
         yfcsj0f2r0+ghmz41qzCYVU0lt7Rnx4svYnuhlPiVAiI8RLWN3Nz6cSE6CIi3cAFr80N
         mwMQ==
X-Gm-Message-State: AOAM530g05ni3wUWik4wJElyzu+WKy1TFY993X9qAqDbOv0169MoDA6a
        YR5/8x6tQTUHfiuqwPgxJwfWl8EduTw6sA==
X-Google-Smtp-Source: ABdhPJzWgX7jbRYSa29WNiKc4PZWvA+Kl3TtxJWqGFIjjmRcWWt7bZ3DGLCB39/mVVFm1V+z7r0trA==
X-Received: by 2002:a17:907:6e16:b0:6e4:de0d:d93 with SMTP id sd22-20020a1709076e1600b006e4de0d0d93mr17837750ejc.29.1649419285705;
        Fri, 08 Apr 2022 05:01:25 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b20-20020a1709063f9400b006e12836e07fsm8620169ejj.154.2022.04.08.05.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 05:01:25 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ncnIq-001Kdy-Kz;
        Fri, 08 Apr 2022 14:01:24 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>
Subject: Re: How to get git-send-email use a proxy?
Date:   Fri, 08 Apr 2022 13:51:33 +0200
References: <CAJyCBOSAekywgzVSf1uGb8s+hY7a7A=0fC5kFhMVpiqS1KEw4w@mail.gmail.com>
 <Yk9dOoit/Ua69s7A@camp.crustytoothpaste.net>
 <CAJyCBOTwsGtkEFuPHosQ-v6xot051OCRWh1QdmqMk3gucuEnPQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAJyCBOTwsGtkEFuPHosQ-v6xot051OCRWh1QdmqMk3gucuEnPQ@mail.gmail.com>
Message-ID: <220408.86mtgvbx7v.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 08 2022, Shaoxuan Yuan wrote:

> On Fri, Apr 8, 2022 at 5:53 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>>
>> On 2022-04-06 at 14:19:43, Shaoxuan Yuan wrote:
>> > Greetings, Git community,
>> >
>> > I'm using git-send-email with Git 2.35.1 under system
>> > 5.4.72-microsoft-standard-WSL2, x86_64 GNU/Linux.
>> >
>> > I am on a system-wide socks5 proxy. Although I set the global
>> > .gitconfig to use the socks5 proxy trying to send emails, the
>> > connection to the SMTP server seems does not go through the proxy at
>> > all.
>> >
>> > Other git commands do go through the globally set .gitconfig proxy,
>> > git-send-email seems to be an exception.
>>
>> I think you're referring to http.proxy.  That affects only HTTP, HTTPS,
>> and FTP (if we even still support that).  All of those protocols are
>> handled by libcurl, which includes native proxy support.  It doesn't
>> affect other protocols like SSH or SMTP.
>>
>> > So I'm wondering if there needs to be a code change in
>> > 'git-send-email.perl' to run the connection through a proxy, or I just
>> > need to tune the setting to accomplish this?
>>
>> git send-email is written in Perl and doesn't use libcurl, so it doesn't
>> have proxy support.  If there's a particular optional module we could
>> dynamically load to provide proxy support, that's an option we could
>> support if someone wanted to provide a patch.
>>
>> In the mean time, you could also try using some sort of tool, like
>> socat, to bind a local port tunnelling over the proxy to the destination
>> server and then use SMTP over that local port to connect.
>> --
>> brian m. carlson (he/him or they/them)
>> Toronto, Ontario, CA
>
> Thanks, it's pretty informative ;-)

If you want to add a "native" feature to git-send-email.perl (and
provide a patch) it looks from
https://stackoverflow.com/questions/3253360/using-socks5-proxy-with-netsmtp
that doing so isn't too hard.

I.e. Net::SMTP (which we use) just uses standard Perl modules to connect
to the network, and there's other existing modules to ferry any such
connection through a SOCKS proxy: https://metacpan.org/pod/Net::SOCKS &
https://metacpan.org/pod/IO::Socket::Socks (I'm not sure which of these
is a better choice).

So it seems like a rather easy 10-20 line patch (including docs and
boilerplate) where we'd just create our own Git::Net::SMTP class, and
that class in turn would be like Net::SMTP, except its @ISA would first
dispatch to a "new" in a class we own.

We could thus intercept the new() invocation it makes to the socket
class it's picking now, and direct it to a wrapper.

There's probably even an existing CPAN module for "given this class,
screw with its @ISA such that socks support is added", I just haven't
looked.
