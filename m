Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF86C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7FF961028
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhELArM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 20:47:12 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:44321 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhELArM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 20:47:12 -0400
X-Originating-IP: 73.26.133.58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gpanders.com;
        s=gm1; t=1620780364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vBRhBqzJGvjHB9xCNU99aTjDwOzQmkIzzETgLJSTI7w=;
        b=Mam5XJJYNH7PH2LzWIQ0ZQ1+NwR2UE9QxBYipw2mOdWI1miBCBpYSqQ8H2kD8Ta3cuL/9h
        yQoUXrAuirEah3oA3E2vWRnv9wx8OdybuW2J+q8ZtmSOhJtnGK9xqIGAZFj2OeJEnDFTAL
        OeSyjr7eURuny2eOkQ7uFtblBiyoarNW9qtEQ92StQwByLB85YrVvP6t39Y4savtPj+ZI3
        2+9aQ83MDi7f0X7Xd1DmNgIGGxZm2fWTY1vbFBN7eJjmVyo123rzot4Y3ZAyrNjsBM8+84
        t+CHTiNkSEwUm7AfAXKymSYZjK9fZNXuTPgHFF4ICrZbVMDqA8CgYhjV5jBFug==
Received: from localhost (c-73-26-133-58.hsd1.nm.comcast.net [73.26.133.58])
        (Authenticated sender: greg@gpanders.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id D119E40006;
        Wed, 12 May 2021 00:46:02 +0000 (UTC)
Date:   Tue, 11 May 2021 18:45:58 -0600
From:   Gregory Anders <greg@gpanders.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] git-send-email: use ! to indicate relative path to
 command
Message-ID: <YJslRhzOmSwD7V2E@gpanders.com>
References: <20210511204044.69047-1-greg@gpanders.com>
 <20210511234935.65147-1-greg@gpanders.com>
 <YJsas0d4XPsYYpI7@camp.crustytoothpaste.net>
 <YJsi1jbtNFDRKXmq@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <YJsi1jbtNFDRKXmq@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 11 May 2021 20:35 -0400, Jeff King wrote:
>On Wed, May 12, 2021 at 12:00:51AM +0000, brian m. carlson wrote:
>
>> > +	specify a sendmail-like program instead, either by a full
>> > +	path-name or by prefixing the program name with `!`.  The
>> > +	program must support the `-i` option.  Default value can be
>> > +	specified by the `sendemail.smtpServer` configuration option;
>> > +	the built-in default is to search for `sendmail` in `/usr/sbin`,
>> > +	`/usr/lib` and $PATH if such program is available, falling back
>> > +	to `localhost` otherwise.
>>
>> Elsewhere we use the ! syntax we invoke the shell, and I would suggest
>> that we do the same here.  That means we'll get PATH functionality by
>> default and we'll let people do a modicum of scripting if they like.
>
>Thanks for bringing that up. I agree it makes things more consistent
>with other uses of "!", and certainly it's more flexible. It does
>introduce an inconsistency with the absolute-path form, as I mentioned
>in https://lore.kernel.org/git/YJsiKDNbKclFU00b@coredump.intra.peff.net/.
>
>I don't know if that's a show-stopper or not. Certainly the
>documentation can explain the difference, but it's nice to keep the
>rules as simple as possible.
>
>(My gut feeling is that consistency with other "!" places is more
>important than consistency with the absolute-path form).
>
>-Peff

We already have sendemail.smtpServerOption to add options:

     [sendemail]
             smtpServer = !msmtp
             smtpServerOption = -f
             smtpServerOption = greg@gpanders.com

I agree that it's not the prettiest and it's a little annoying to have 
to specify the option multiple times, but I thought it worth mentioning 
before considering another way to do the same thing.

I also am curious what other's thoughts are on Felipe's suggestion to 
add a sendemail.program option, which would altogether remove the need 
to further overload sendemail.smtpServer: 
https://lore.kernel.org/git/609b0017a323b_6064920888@natae.notmuch/

IMO if we want to add the capability to run an arbitrary shell command 
as the smtpServer, this makes more sense to add as a dedicated 
sendemail.program option that has that functionality baked right in:

     [sendemail]
             program = "msmtp -f greg@gpanders.com"
