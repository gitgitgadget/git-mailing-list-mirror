Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40F99202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 12:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753205AbdCHMwQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 07:52:16 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:55986 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753175AbdCHMwK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 07:52:10 -0500
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1clZdh-0002Ye-BM; Wed, 08 Mar 2017 11:20:17 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <22719.59633.269164.986923@chiark.greenend.org.uk>
Date:   Wed, 8 Mar 2017 11:20:17 +0000
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>
Subject: Re: RFC: Another proposed hash function transition plan
In-Reply-To: <CA+55aFyyi0vBBApf9grYQzF2PRZMjtCzkB4LzYvLpqQ-Z7QfJQ@mail.gmail.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
        <22719.680.730866.781688@chiark.greenend.org.uk>
        <CA+55aFyyi0vBBApf9grYQzF2PRZMjtCzkB4LzYvLpqQ-Z7QfJQ@mail.gmail.com>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds writes ("Re: RFC: Another proposed hash function transition plan"):
> Also, since 256 isn't evenly divisible by 6, and because you'd want
> some way to explictly disambiguate the new hashes, the rule *could* be
> that the ASCII representation of a new hash is the base64 encoding of
> the 258-bit value that has "10" prepended to it as padding.
> 
> That way the first character of the hash would be guaranteed to not be
> a hex digit, because it would be in the range [g-v] (indexes 32..47).

We should arrange for this to be an uppercase, not a lowercase,
letter, for the reasons I explained in my own proposal.  To summarise:
It would be undesirable to further increase the overlap between object
names and ref names.  Few people use uppercase in ref names because of
the case-insensitive filesystem problem; so object names starting with
uppercase ascii are distinct from most object names.

> Of course, having written that, I now realize how it would cause
> problems for the usual shit-for-brains case-insensitive filesystems.
> So I guess base64 encoding doesn't work well for that reason.

AFAIAA object names occur in publicly-visible filenames only in notes
tree objects, which are manipulated by git internally and do not
necessarily need to appear in the filesystem.

The filenames in .git/objects/ can be in whatever encoding we like, so
are not an obstacle.

Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.

If I emailed you from an address @fyvzl.net or @evade.org.uk, that is
a private address which bypasses my fierce spamfilter.
