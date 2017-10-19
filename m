Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2800202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 21:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbdJSVTu (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 17:19:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:58366 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751762AbdJSVTt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 17:19:49 -0400
Received: (qmail 4967 invoked by uid 109); 19 Oct 2017 21:19:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 21:19:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12726 invoked by uid 111); 19 Oct 2017 21:19:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 17:19:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 17:19:47 -0400
Date:   Thu, 19 Oct 2017 17:19:47 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH 4/5] diff: fix whitespace-skipping with --color-moved
Message-ID: <20171019211947.cif4ui2qwdzizazw@sigill.intra.peff.net>
References: <20171019202326.grovyfsragl2d7xx@sigill.intra.peff.net>
 <20171019202926.irldca42wqosmxrd@sigill.intra.peff.net>
 <CAGZ79kZhCoFe1P_gwigzrgzzcqRunrUWGOAgy9xvS2ugNeVLmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZhCoFe1P_gwigzrgzzcqRunrUWGOAgy9xvS2ugNeVLmA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 02:15:12PM -0700, Stefan Beller wrote:

> > +test_expect_failure 'move detection ignoring whitespace at eol' '
> > +       git reset --hard &&
> > +       # Lines 6-9 have new eol whitespace, but 9 also has it in the middle
> > +       q_to_tab <<-\EOF >lines.txt &&
> > +       long line 6Q
> > +       long line 7Q
> > +       long line 8Q
> > +       longQline 9Q
> > +       line 1
> > +       line 2
> > +       line 3
> > +       line 4
> > +       line 5
> > +       EOF
> > +
> > +       # avoid cluttering the output with complaints about our eol whitespace
> > +       test_config core.whitespace -blank-at-eol &&
> 
> We avoid the eol space change as we want to test the move detection
> without interference. Do we want to test it with that as well?

I don't think it creates interference. It's just that the expected
output becomes more like:

  <CYAN>+<RESET><CYAN>long line 6<RESET><BLUE> </RESET>

and the extra coloring just made it harder for me to read and write the
test. :)

I agree it might be worth checking the interaction between whitespace
coloring and --color-moved, but I think we'd want it to be more thorough
(e.g., covering the beginning of line with indent-with-non-tab or
similar).

> The commit message really enlightened me,
> Thanks!

Thanks for reviewing.

-Peff
