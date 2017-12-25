Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40C741F424
	for <e@80x24.org>; Mon, 25 Dec 2017 02:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbdLYB5p (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 20:57:45 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:49964 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751039AbdLYB5o (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 20:57:44 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 7563D1F424;
        Mon, 25 Dec 2017 01:57:44 +0000 (UTC)
Date:   Mon, 25 Dec 2017 01:57:44 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC/PATCH] perl: bump the required Perl version to 5.10.0 from
 5.8.0
Message-ID: <20171225015744.o47ackbwi2wbtkbv@untitled>
References: <20171223174400.26668-1-avarab@gmail.com>
 <20171224143831.GD23648@sigill.intra.peff.net>
 <871sjkrtrm.fsf@evledraar.gmail.com>
 <20171224230839.f6r66u37wj4ai3sj@untitled>
 <87y3lrr78q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y3lrr78q.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> I think for any given external dependency of git.git it makes sense to
> just pick a version, not say that this script requires perl so-and-so,
> this one python so-and-so, or curl/openssl so-and-so etc.

Agreed.  Any version support changes should be tree-wide.

> On Sun, Dec 24 2017, Eric Wong jotted:
> > Maybe we change our docs to say we welcome 5.10 features for new
> > code, but I'm against changing things for the sake of change.
> 
> I should have mentioned this in the commit message, but for me it's
> mainly that whenever I patch the Git perl code there's no easy way to
> test if it works on a currently supported release, 5.8.* doesn't even
> build anymore on a modern compiler without monkeypatching with
> Devel::PatchPerl (and then only some subreleases).

Fair enough, I haven't run 5.8 in a while, either.  One concern
I have is it makes reviewing more difficult as the language gets
bigger and (even more) unfamiliar constructs pop up.  This is
probably more important for git as most of us are not dedicated
Perl hackers.

What mostly bugs me about this is going from:

	"we'll accept patches to keep your old system working"

 to:

	"your software is too old, upgrade or go away"

> I think it's reasonable for us, in general, to at some point pass the
> buck in maintaining dependencies to people who want to still build on
> ancient versions. And not just for perl, but e.g. curl too, which is
> something I commented on at some length in <874ltg2tvo.fsf@gmail.com>
> (https://public-inbox.org/git/874ltg2tvo.fsf@gmail.com/). I.e. if you
> need to really build the latest git on RHEL 5 with all bells & whistles
> you also build perl.

I don't disagree; but curl is different animal in that it was a
maintenance burden for us.

> It's not just change for the sake of change, there's a high cognitive
> overhead in trying to write code against the last 15 years of some
> software as opposed to "just" 10 years (which is already bad enough).

Heh, I was making the same point for staying with older versions
since it's less cognitive overhead for me (and presumably others)
to use a smaller featureset.

> Of course any one change isn't going to be what makes it or breaks it,
> so it's hard to make the argument in terms of "I must use this new
> feature here". But if that was the standard we were applying we'd still
> be supporting perl 5.6[1].

Right, if there's a compelling case to depend on 5.10 then I'm
all for it.  I don't think we've hit a breaking point like
we did with 5.8, yet.

> 1. If it hadn't turned out that it was broken for years because of using
>   a new feature, see d48b284183 ("perl: bump the required Perl version
>   to 5.8 from 5.6.[21]", 2010-09-24)
