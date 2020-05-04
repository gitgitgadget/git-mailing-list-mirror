Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D30C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 20:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D6D1206A5
	for <git@archiver.kernel.org>; Mon,  4 May 2020 20:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgEDUf6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 16:35:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:36516 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726111AbgEDUf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 16:35:58 -0400
Received: (qmail 1764 invoked by uid 109); 4 May 2020 20:35:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 May 2020 20:35:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21780 invoked by uid 111); 4 May 2020 20:35:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 May 2020 16:35:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 May 2020 16:35:56 -0400
From:   Jeff King <peff@peff.net>
To:     Leonardo Bras <leobras.c@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org, Jan Viktorin <viktorin@rehivetech.com>,
        Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH] send-email: Defines smtpPassCmd config option
Message-ID: <20200504203556.GA28192@coredump.intra.peff.net>
References: <20200501105131.297457-1-leobras.c@gmail.com>
 <20200501125308.GE33264@Carlos-MBP>
 <xmqqees3odrb.fsf@gitster.c.googlers.com>
 <20200501222723.GF41612@syl.local>
 <20200501235948.GD6530@camp.crustytoothpaste.net>
 <306703d7687377d6a74ec9f1d63331580a3c109b.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <306703d7687377d6a74ec9f1d63331580a3c109b.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 04:49:09PM -0300, Leonardo Bras wrote:

> On Fri, 2020-05-01 at 23:59 +0000, brian m. carlson wrote:
> >   git config credential.smtp://smtp.crustytoothpaste.net.helper \
> >     '!f() { echo username=my-username; echo "password=$(my-password-command)"; }; f'
> 
> I have tried doing this, with --global, and my config file changed like
> this:
> 
> [credential "smtp://smtp.gmail.com"]
>         helper = "!f() { echo username=mymail@gmail.com; echo
> \"password=$(gpg2 -q --for-your-eyes-only --no-tty -d ~/words/imap)\";
> }; f"
> 
> While sendemail has:
> [sendemail]
>         smtpServer = smtp.gmail.com
>         smtpServerPort = 587
>         smtpEncryption = tls
>         smtpUser = mymail@gmail.com
> 
> Yet still,  I was asked for password:
> Password for 'smtp://mymail@gmail.com@smtp.gmail.com:587': 

I think the way the host-matching works, you'd need to put the ":587"
into the credential.*.url config section heading for it to match.

-Peff
