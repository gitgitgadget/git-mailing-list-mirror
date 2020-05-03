Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E8FC28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 09:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A4EF20721
	for <git@archiver.kernel.org>; Sun,  3 May 2020 09:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgECJnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 05:43:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:35052 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726884AbgECJnt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 May 2020 05:43:49 -0400
Received: (qmail 22172 invoked by uid 109); 3 May 2020 09:43:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 03 May 2020 09:43:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4925 invoked by uid 111); 3 May 2020 09:43:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 03 May 2020 05:43:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 3 May 2020 05:43:48 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Leonardo Bras <leobras.c@gmail.com>, git@vger.kernel.org,
        Jan Viktorin <viktorin@rehivetech.com>,
        Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH] send-email: Defines smtpPassCmd config option
Message-ID: <20200503094348.GE170902@coredump.intra.peff.net>
References: <20200501105131.297457-1-leobras.c@gmail.com>
 <20200501125308.GE33264@Carlos-MBP>
 <xmqqees3odrb.fsf@gitster.c.googlers.com>
 <20200501222723.GF41612@syl.local>
 <20200501235948.GD6530@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200501235948.GD6530@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 01, 2020 at 11:59:48PM +0000, brian m. carlson wrote:

> I think perhaps many folks aren't aware that you can invoke Git with an
> arbitrary shell command as "credential.helper", which of course makes
> life a lot easier.  So if you want to invoke a separate command, it's
> really as easy as this:
> 
>   git config credential.smtp://smtp.crustytoothpaste.net.helper \
>     '!f() { echo username=my-username; echo "password=$(my-password-command)"; }; f'
> 
> So I think that documenting the use of the credential helper is step 1,
> because probably most people _do_ want to use that for their passwords,
> and then documenting that credential helpers can be arbitrary shell
> commands that speak the protocol is step 2, so that people who don't can
> figure out a way to do what they want.
> 
> I'll send some patches later which document the latter feature, since I
> don't think we mention it anywhere outside of the FAQ.  I actually
> didn't know about it until Peff mentioned it to me one time.

This is documented, but only recently did it make it out of
Documentation/technical/ and into gitcredentials(7). I don't mind adding
more pointers, though.

It's also being discussed in this thread:

  https://lore.kernel.org/git/63f35287c9ced4d674f938bedd439aefa6c46f41.camel@gmail.com/

about how deep into the rabbit-hole we want to go in terms of showing a
working example. In particular, in your example above I'd consider
checking that "$1" is "get" in the function.

You also could be using credential.*.username. It's twice as many
git-config commands to set up on the command-line, but IMHO the
resulting config file is a little easier to read.

-Peff
