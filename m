Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6663D208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 21:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753139AbdHJVgD (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 17:36:03 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:42188 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbdHJVgC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 17:36:02 -0400
Received: from hopa.kiewit.dartmouth.edu ([129.170.31.166] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1dfv7Z-0005kk-4B
        for git@vger.kernel.org; Thu, 10 Aug 2017 17:36:02 -0400
Date:   Thu, 10 Aug 2017 17:35:55 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <20170810213555.fejnalargwwlws6k@hopa.kiewit.dartmouth.edu>
References: <20170809173928.h2ylvg5tp2p5inem@hopa.kiewit.dartmouth.edu>
 <8e307474-d180-6d98-2c6b-062f2181bd14@web.de>
 <xmqqzib72qvs.fsf@gitster.mtv.corp.google.com>
 <6d7b0d30-48ea-f79f-78cd-088557ea06ac@web.de>
 <20170810200502.rutab4z3ft7gcpjz@sigill.intra.peff.net>
 <cd49ce13-db87-89c1-77e7-998fdb9442c3@web.de>
 <20170810210246.p4vp2ibahgsii7fc@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170810210246.p4vp2ibahgsii7fc@sigill.intra.peff.net>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 129.170.31.166
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: [PATCH] strbuf: clear errno before calling getdelim(3)
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, 10 Aug 2017, Jeff King wrote:

> On Thu, Aug 10, 2017 at 10:56:40PM +0200, René Scharfe wrote:

> > getdelim(3) returns -1 at the end of the file and if it encounters an
> > error, but sets errno only in the latter case.  Set errno to zero before
> > calling it to avoid misdiagnosing an out-of-memory condition due to a
> > left-over value from some other function call.

> Looks good to me.

> > Do we need to save and restore the original value of errno?  I doubt it,
> > but didn't think deeply about it, yet.

> I'd say no. Anybody depending on strbuf_getwholeline() is clearly
> already wrong in the error case. And in general I think we assume that
> syscalls can clear errno on success if they choose to (this isn't a
> syscall, but obviously it is calling some).

Shouldn't ideally errno being reset to 0 upon check of the syscall
successful run right after that syscall?  (I also see some spots within
git code where it sets errno to ENOMEM)


-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
