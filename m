Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CB8E1F453
	for <e@80x24.org>; Wed,  1 May 2019 21:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfEAVJr (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 17:09:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:46346 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726166AbfEAVJq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 17:09:46 -0400
Received: (qmail 25023 invoked by uid 109); 1 May 2019 21:09:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 May 2019 21:09:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22761 invoked by uid 111); 1 May 2019 21:10:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 01 May 2019 17:10:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 May 2019 17:09:44 -0400
Date:   Wed, 1 May 2019 17:09:44 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Barret Rhoden <brho@google.com>, Olaf Hering <olaf@aepfle.de>
Subject: Re: How to undo previously set configuration? (again)
Message-ID: <20190501210944.GA15902@sigill.intra.peff.net>
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
 <20190424023438.GE98980@google.com>
 <20190424230744.GL6316@genre.crustytoothpaste.net>
 <87k1fis8gq.fsf@evledraar.gmail.com>
 <20190425143614.GA91608@google.com>
 <CACsJy8B5j2K=RU7N+h-i9HszuYuYd+fNmAftVDW-4nJ_o5z8Sw@mail.gmail.com>
 <20190430211415.GB16290@sigill.intra.peff.net>
 <CACsJy8B+hDqKnu+0tkPC42w+_6RhzYac1BxYtdyxctcARG=VCg@mail.gmail.com>
 <87r29iqsf9.fsf@evledraar.gmail.com>
 <CACsJy8CSPBbxrJm1sh4a+f_B03MFXxDXSrOvb6yFCRa4Qa2wMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CSPBbxrJm1sh4a+f_B03MFXxDXSrOvb6yFCRa4Qa2wMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 01, 2019 at 07:32:20PM +0700, Duy Nguyen wrote:

> > We also provide no way in "git config" to properly interpret a
> > value. E.g. does a "user.email" showing up twice for me mean I have two
> > E-Mails at the same time, or does the last one win?
> 
> Actually --get knows this. Single-valued options can be handled
> correctly quite easily. It's --get-all (or rather, the future
> --get-multi because we can't change --get-all's behavior) which can't
> interpret values because there's no standardized way of doing it.

Right. We need a hint from the caller about how they expect us to
interpret the values. And I agree we should probably introduce a new
verb instead of modifying --get-all, which some callers might be
expecting to do their own list processing.

Likewise in the C code. We probably want to leave existing callers of
git_config_get_value_multi() alone, and give them a new
git_config_get_string_list() or something.

-Peff
