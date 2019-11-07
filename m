Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C39911F4C0
	for <e@80x24.org>; Thu,  7 Nov 2019 08:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfKGICT (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 03:02:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:41796 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726734AbfKGICT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 03:02:19 -0500
Received: (qmail 29923 invoked by uid 109); 7 Nov 2019 08:02:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Nov 2019 08:02:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 337 invoked by uid 111); 7 Nov 2019 08:05:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Nov 2019 03:05:40 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Nov 2019 03:02:18 -0500
From:   Jeff King <peff@peff.net>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 3/8] t3900: demonstrate git-rebase problem with multi
 encoding
Message-ID: <20191107080218.GA11245@sigill.intra.peff.net>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1573094789.git.congdanhqx@gmail.com>
 <ca869cef57bcf620a7b5d0519d362dcd9a27eae6.1573094789.git.congdanhqx@gmail.com>
 <20191107060233.GB6431@sigill.intra.peff.net>
 <20191107064854.GB8096@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191107064854.GB8096@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 07, 2019 at 01:48:54PM +0700, Danh Doan wrote:

> On 2019-11-07 01:02:33 -0500, Jeff King wrote:
> > On Thu, Nov 07, 2019 at 09:56:14AM +0700, Doan Tran Cong Danh wrote:
> > 
> > > +test_commit_autosquash_multi_encoding () {
> > > +	flag=$1
> > > +	old=$2
> > > +	new=$3
> > > +	msg=$4
> > > +	test_expect_failure "commit --$flag into $old from $new" '
> > > +		git checkout -b '$flag-$old-$new' C0 &&
> > 
> > These single quotes are funny; they close the test-snippet string, so
> > these variables are outside of any quoting (and thus subject to
> > whitespace splitting).
> 
> Yes, those quotes are funny, and I'm also aware that
> they will be subjected to whitespace spliting.
> But those quotes were intentional, they're there in order to have
> better log with:
> 
>     ./t3900-i18n-commit.sh -v
> 
> With those funny quotes, we will see this (verbose) log:
> 
>     expecting success of 3900.38 'commit --fixup into ISO-2022-JP from UTF-8':
>                 git checkout -b fixup-ISO-2022-JP-UTF-8 C0 &&

Yes, it's true you get the expanded version here, but...

>                 git config i18n.commitencoding ISO-2022-JP &&
>                 echo ISO-2022-JP >>F &&
>                 git commit -a -F "$TEST_DIRECTORY/t3900/ISO-2022-JP.txt" &&

...you still can't just run this manually because of other lines like
this one.

It's also weirdly unlike all of the other tests, which creates confusion
for people reading the code. IMHO the tradeoff isn't worth it.

-Peff
