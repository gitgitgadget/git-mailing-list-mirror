Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D24411F461
	for <e@80x24.org>; Fri, 28 Jun 2019 10:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfF1KDb (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 06:03:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45613 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfF1KDb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 06:03:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so5600478wre.12
        for <git@vger.kernel.org>; Fri, 28 Jun 2019 03:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RQhsY+aSZPHhAKJj97TFA4aA3q+2b4KMu75O4Ixq75Y=;
        b=ubyedqPzeQp2q2HbvBSIEeLFkFdMYlC+EQC+Oqd0FVDKfwHOrSSotGM04wg7Vd0oRm
         CGrTFdH/MBjocaWKHN9lYSUfs9K9tN0i/SlpF+NVuTKyD2YY6dQEZrCUdQa3pmBBauNq
         q6Egimzcl90EMEzBNQWaO3A7cAlWoUAmLXvPy5qCvPgNyVdshaRqy56pe+DlftsOxkJI
         oRUb+M/YH9NJ24OxwWElyAIkk53mfXaQU2mJUtt+2qI9zpMbpls6/QBAKQouCKhIyA4u
         4whiRHNJ5cswA9hzEFGkLy7AuTcH5uWxwjPPBJAnv0Ro6P0J6mPatqfCNs71v8BZaSVZ
         Vn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RQhsY+aSZPHhAKJj97TFA4aA3q+2b4KMu75O4Ixq75Y=;
        b=CWzqm6q49eirJ3zeAgM8gza29jF4HSx6kNoN2InuqREgkT3A4s927l3JZNdCTE3LMC
         RUtTiyKXaj93AXpOYGNWBqJaqjfMEJ2f4XKvNyaFewtaMgZVBhhgd7GSBr1eBwWklY40
         0aAiZux88//DJIfDOXiGAMQVaE/bUTX8fm0W6iONh5/AdHC9gQPxpBdGWaF5fyZEJpz4
         fAAsNCk8iBEI/4GNmam048CByrwn2ceUzNy+K4RHHKQAfffOEDQa1yNGg5qkfK5qlbs9
         DrafR8uFeiPFUyKR379ygCl7fVO1aFAuZ48wLOOO+/yBo5X+WVSNdNmlZxPU+opNDtFI
         c53A==
X-Gm-Message-State: APjAAAWfemHcVFIpgL367ZM9P3oKnAE0FF9eW0oxQpVyKFQC8VUPuq1D
        6NTyvBGeu6b1VQzcXOfWc/IbSEPa
X-Google-Smtp-Source: APXvYqyGXbAUXEYRGdxBLQwIwsQ68fNzUKbj0TIaCI4F0ARVCo2ZI110Dhzp16ncI/l7E41CWYFgKw==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr6980350wrm.68.1561716209667;
        Fri, 28 Jun 2019 03:03:29 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.googlemail.com with ESMTPSA id f7sm1876749wrv.38.2019.06.28.03.03.28
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 03:03:29 -0700 (PDT)
Subject: Re: fprintf_ln() is slow
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
References: <20190627052515.GA21207@sigill.intra.peff.net>
 <20190627055739.GA9322@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1906271358260.44@tvgsbejvaqbjf.bet>
 <20190627210959.GA20250@sigill.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <374b237e-a29f-5983-0932-63f1c2ebcbbe@gmail.com>
Date:   Fri, 28 Jun 2019 11:03:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190627210959.GA20250@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Peff and Dscho

On 27/06/2019 22:10, Jeff King wrote:
> On Thu, Jun 27, 2019 at 02:00:54PM +0200, Johannes Schindelin wrote:
> 
>>> We can use setvbuf() to toggle buffering back and forth, but I'm not
>>> sure if there's a way to query the current buffering scheme for a stdio
>>> stream.
>>
>> It also is not very safe, especially when we want to have this work in a
>> multi-threaded fashion.
> 
> I considered that, too, but I think it is safe. stdio has its own
> locking, so every individual call is atomic. The potentially problematic
> case would be where we switch back from line buffering to no-buffering,
> and somebody else has written some content into our stack-based buffer
> (that is about to go out of scope!). But I'd assume that as part of the
> switch to no-buffering that any stdio implementation would flush out the
> buffer that it's detaching from (while under lock). Nothing else makes
> sense.

The C standard section 7.19.5.6 says that
  The setvbuf function may be used only after the stream pointed to by
  a stream has been associated with an open file and before any other
  operation (other than an unsuccessful call to setvbuf) is performed
  on the stream.

The is a note about the buffer that says
  The buffer has to have a lifetime at least as great as the open
  stream, so the stream should be closed before a buffer that has
  automatic storage duration is deallocated upon block exit.

So changing the buffer in the way that has been proposed is undefined
behavior on two counts I think.

Best Wishes

Phillip


> That said...
> 
>> I'd be much more comfortable with rendering the string into a buffer and
>> then sending that buffer wholesale to stderr.
> 
> It's sufficiently complex that I think I prefer to just use our own
> buffer, too.
> 
> It also makes it more likely for the newline and the message to end up
> in an atomic write(), so if multiple threads _are_ writing to stderr
> they'd be more likely to stay together.
> 
> It does sound like people in the other part of the thread are OK with
> just getting rid of the "_ln" functions altogether.
> 
> -Peff
> 

