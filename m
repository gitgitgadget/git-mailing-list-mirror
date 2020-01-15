Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8304BC32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 18:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645A424656
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 18:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgAOSNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:13:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:37154 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728921AbgAOSNw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 13:13:52 -0500
Received: (qmail 18435 invoked by uid 109); 15 Jan 2020 18:13:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 Jan 2020 18:13:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31708 invoked by uid 111); 15 Jan 2020 18:20:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Jan 2020 13:20:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Jan 2020 13:13:51 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Git alias syntax help
Message-ID: <20200115181351.GB4081287@coredump.intra.peff.net>
References: <CAHMHMxWpLAnj3w8DGLMFbfy-A-pBjDxNdMeiM-fyuu-gnZyg+Q@mail.gmail.com>
 <20200114222802.GC3957260@coredump.intra.peff.net>
 <CAHMHMxVajKxjBweG=mps0gLwE1o8M69DvPb1iUQYgLXx0VO5AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHMHMxVajKxjBweG=mps0gLwE1o8M69DvPb1iUQYgLXx0VO5AA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 15, 2020 at 01:13:17AM +0200, Σταύρος Ντέντος wrote:

> > > new = "!f() { : git log ; git log \"${1}@{1}..${1}@{0}\" \"$@\" ; } ; f"
> > > new = !f() { : git log ; git log "${1}@{1}..${1}@{0}" "$@" ; } ; f
> >
> > Only the first one is correct. In addition to the quotes in the second
> > one being eaten by the config parser, the unquoted semicolon starts a
> > comment.
> 
> Could somehow the latter "become" the correct option?

Unfortunately not without breaking compatibility of existing config
files.

> Especially in the case of `!sh`:
> 1) You need to quote everything after `=` sign ("forced" double quotes), then
> 2) `sh -c` needs another set (singles are most safe here, I think), and
> 3) If, for some reason, you need to quote further ("$@" would be a
> common suspect usually)

Yes, the quoting can get pretty hairy. If your command is complicated, I
suggest writing it as a separate script and dropping it into your $PATH
as git-new. Then "git new" will run it automatically (and it's not even
any less efficient; it still ends up with a single shell invocation).

> Thank you very much for a complete explaination of all of this .
> 
> Can some of this be documented somewhere?
> Are they somewhere and I missed them?

I think the config syntax around quoting is described in "git help
config" (see the section Syntax). The shell parts seem out of scope for
Git's manpages themselves, though it sounds like maybe some examples you
found could stand to be fixed (and/or to call out the subtlety).

> If nothing more, a link to this e-mail chain either on the wiki (if
> https://git.wiki.kernel.org/index.php/Aliases is an official page) or
> on git-alias help (here
> https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases or in some
> "advanced" section, which I cannot find)
> 
> If https://git.wiki.kernel.org/index.php/Aliases is an official page,
> then: was this written for an earlier version?
> Could it also be updated?

I think both of the issues you mentioned have always been true. That
wiki is open to editing by the world, so it's possible that somebody
just added bad examples (and fixes would be welcome).

I don't know the book content very well. Looking at the page you
linked, I don't think it says anything _wrong_, but it definitely
doesn't discuss more advanced alias usage. I suspect that would be a
welcome addition; they take contributions at
https://github.com/progit/progit2.

-Peff
