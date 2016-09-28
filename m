Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13BA520986
	for <e@80x24.org>; Wed, 28 Sep 2016 00:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932648AbcI1ALK (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 20:11:10 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:56504
        "EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932517AbcI1ALK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 20:11:10 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id AEAC813A0A61; Tue, 27 Sep 2016 20:11:08 -0400 (EDT)
Date:   Tue, 27 Sep 2016 20:11:08 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] docs/cvs-migration: mention cvsimport caveats
Message-ID: <20160928001108.GA9120@thyrsus.com>
Reply-To: esr@thyrsus.com
References: <20160922072350.ivjrfuedodd2rezn@sigill.intra.peff.net>
 <20160922072628.rs47hfiowtobw46s@sigill.intra.peff.net>
 <20160922131526.GB6320@thyrsus.com>
 <20160923035601.f5czdieouzvm3ptz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160923035601.f5czdieouzvm3ptz@sigill.intra.peff.net>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net>:
>               I am not qualified to write on the current state of
> the art in CVS importing.

I *am* qualified; cvs-fast-export has had a lot of work put into it by
myself and others over the last five years.  Nobody else is really
working this problem anymore, not much else than cvs2git is even left
standing at this point. Most other attempts on the problem have
stalled or flamed out, and were never very robust in dealing with
repository malformations to begin with.

cvs2git can probably still almost match cvs-fast-export in ability to handle
pathological cases, but is painfully slow by comparison.  (Part of that is
implementation in Python vs. C.)

cvs-fast-export has been successfully performance-tuned for very large
repositories, such as the entirety of NetBSD, and is orders of
magnitude faster than it used to be. (I parallelized the parsing
of RCS masters with a re-entrant Bison instance running per thread;
this makes a huge difference on large repositories, for which that
stage dominates running time.) Its ability to recover sense from
repository malformations was already pretty good five years ago
and is probably unmatched now.  It does .cvsignore conversion.

cvs-fast-export also now has a really good test suite collecting all
kinds of weird CVS deformations from the field, and a wrapper that can
both do a conversion and check for correctness at every tag as well as
the tip revision.

By contrast, the wrapper/cvsps combination git ships continues to be
disgracefully bad and should be scrapped - remember that I maintained
cvsps for a while and tried to EOL it because its branch-resolution
algorithms are unsound.  I have a replacement wrapper ready any time
the git maintainer decides to stop shipping broken, dangerous code.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
