Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C1CA1F424
	for <e@80x24.org>; Thu, 26 Apr 2018 17:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756820AbeDZRsk (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 13:48:40 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:47894 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754557AbeDZRsi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 13:48:38 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id A4D00335C7D
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 17:48:37 +0000 (UTC)
Received: (qmail 24359 invoked by uid 10000); 26 Apr 2018 17:48:35 -0000
Date:   Thu, 26 Apr 2018 17:48:35 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Marc Branchaud <marcnarc@xiplink.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
Message-ID: <robbat2-20180426T165501-471483273Z@orbis-terrarum.net>
References: <20180413170129.15310-1-mgorny@gentoo.org>
 <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
 <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com>
 <robbat2-20180425T060717-325652820Z@orbis-terrarum.net>
 <xmqqin8f4qoq.fsf@gitster-ct.c.googlers.com>
 <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com>
 <CACsJy8ATwEPiCDpOr7e=wJxhZAr1R4OpSdOvb6EgpnyYonQYWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8ATwEPiCDpOr7e=wJxhZAr1R4OpSdOvb6EgpnyYonQYWg@mail.gmail.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 26, 2018 at 06:43:56PM +0200, Duy Nguyen wrote:
> On Wed, Apr 25, 2018 at 5:18 PM, Marc Branchaud <marcnarc@xiplink.com> wrote:
> > Are we all that sure that the performance hit is that drastic?  After all,
> > we've just done write_entry().  Calling utime() at that point should just
> > hit the filesystem cache.
> I have a feeling this has "this is linux" assumption. Anybody knows
> how freebsd, mac os x and windows behave?
I don't know sorry. futimens might be better here if it can be used
before the fd is closed.

> > * In a "file checkout" ("git checkout -- path/to/file"), $1 and $2 are
> > identical so the above loop does nothing.  Offhand I'm not even sure how a
> > hook might get the right files in this case.
> Would a hook that gives you the list of updated files (in the exact
> same order that git updates) help?
Yes, that, along with the target revision I think would allow most or
all of the desired behaviors mentioned in this thread *. It also needs to
fire in cases like 'git reset --hard $REV'.

* For this case, I just need the mtimes to be consistent within a single
  checkout, I don't need them to have specific values.

-- 
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
