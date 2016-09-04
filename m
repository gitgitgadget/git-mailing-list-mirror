Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7B491FBB0
	for <e@80x24.org>; Sun,  4 Sep 2016 06:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752899AbcIDGs2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 02:48:28 -0400
Received: from mout.gmx.net ([212.227.17.22]:53221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750747AbcIDGs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 02:48:27 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Li1hG-1bJniN2csM-00n5Rs; Sun, 04 Sep 2016 08:48:09
 +0200
Date:   Sun, 4 Sep 2016 08:47:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Josh Triplett <josh@joshtriplett.org>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] rebase -i: rearrange fixup/squash lines using the
 rebase--helper
In-Reply-To: <20160903180344.truur5ey6j6ah2wh@x>
Message-ID: <alpine.DEB.2.20.1609031548540.129229@virtualbox>
References: <cover.1472833365.git.johannes.schindelin@gmx.de> <3810bd4bddb3b850a78e5d960207157de64a2e56.1472833365.git.johannes.schindelin@gmx.de> <20160903180344.truur5ey6j6ah2wh@x>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:z9II9YJnhnQzubLBMsJsf6F1SNOUqLtyD4ygPEve04nUD/j6kV/
 Io4HR+2yl5Ol61rzhoAdOVB+1Y/mSFcgEEhjboftiu6zxOKoZ/ROl2tsQLWljPmXvmlJIzw
 MTmDxDWbU1BHWlYZ01Ci1i5caOrYCD8rLZk1s8mT8D/8TXJQIXKZAX8eTgWBnWJf4W4WC4o
 vufSN6qhqdknUHKFKapJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jFZ9sqZkiek=:JD4Cago744VsOQJQQ46zHJ
 yfFdol5klNC4Z1cmP3MP06a6y3tr8ZLOu7Wz5i8dsWvEZZHjfUVrxcw0IfWRKsyZWBTI17qoJ
 coLPeYlkNI2eQxSeOHj1tcqMpWEzMkDCgQ4Q+BrLdpAZflY/Za9QY5DfvDLKbg/lFUfIdMaW7
 SHX2u6nK/gQE5+DBsZCftFooUVvRmUuiIsavLwxEQlU67zo6OHIW2JJ+r+aYfsDZAbRG8DVAM
 L3Z7cmpJ/4bzX6agSOyKPqy1FW9q0CHDKUtfTwKmuLP0t8ytkQI7I9KJilngczpC5c50F0nBr
 bIf9HdqUdZ3b4OlTepdvXw1MSzGnjZMdEUxDR2UkTcxa5FvtxGVp+wsdIR/WMOl6aUR/Gzmzp
 t+prGj4H6I/hQVqe0y2XQ18qg5IDtqp02+yYepstB43YS0gn08o7YYntHlkKC75zeeoFKMcfX
 53zF1sxmwhCNeueIgejyO5lccZw9PESHz8smAjA1F5bGDSIVLXfryZ8+zx+tm2PRLl+Wd3MNe
 TefKfjqm7IQWa06o2gEmvKDT5rPk4JiaRdWbazu/bZfGuLrOrSST7xGV46SglB4RpbIQcciNW
 5SrCGgY6CuRAoEDI6uBhmNypEzA7LL52cNbmD4NbuCu6+bjeHUKIKe/NSObYpYc2S3AZmohC/
 VluAZ/4De+1MeiZNtcEN4s+4faBRm3US1YIdDLcwwegJLOrbO9ve7TXL0tgT7H4D1+9BPFhan
 8iasIISYRYpfkMCqnjiMs0ZOmcqToU4tQGQ4J+yqbMUyJ9iD9KWa6i1FT259PgGzSlhpeAF35
 z8+VYWn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Josh,

On Sat, 3 Sep 2016, Josh Triplett wrote:

> On Fri, Sep 02, 2016 at 06:23:42PM +0200, Johannes Schindelin wrote:
> > Let's reimplement this with linear complexity (using a hash map to
> > match the commits' subject lines) for the common case; Sadly, the
> > fixup/squash feature's design neglected performance considerations,
> > allowing arbitrary prefixes (read: `fixup! hell` will match the
> > commit subject `hello world`), which means that we are stuck with
> > quadratic performance in the worst case.
> 
> If the performance of that case matters enough, we can do better than
> quadratic complexity: maintain a trie of the subjects, allowing prefix
> lookups.  (Or hash all the prefixes, which you can do in linear time on
> a string: hash next char, save hash, repeat.)  However, that would
> pessimize the normal case of either a complete subject or a sha1, due to
> the extra time taken constructing the data structure.  Probably not
> worth it, if you assume that most "fixup!" subjects come from `git
> commit --fixup` or similar automated means.

Right. My reaction to finding our that subject prefixes were allowed, too,
was "WTF?". And then: who uses that? And then: that's gonna hurt
performance! And then: but I can optimize for the common case!

The point is: only when people specify a strict prefix will the
performance be hurt. Meaning that the performance is linear in the most
common cases.

That is good enough for me, and probably good enough for the vast majority
of the users. If it ain't broke, don't fix it.

In the case that somebody needs strict prefixes to be handled more
efficiently, which I do not expect, the "hash all prefixes" approach may
work well, but it would slow down the common case, so I'd suggest doing
that only as a fallback (i.e. if a fixup! could not be matched up, fall
back to hashing the prefixes, re-hashing the commit subjects that were
already seen so far). If this needs to be implemented at all, I would also
suggest that the person in need of that improvement also needs to take
charge of this: I will not spend more time thinking about this.

Ciao,
Johannes
