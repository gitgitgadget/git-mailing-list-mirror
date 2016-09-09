Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 674D120705
	for <e@80x24.org>; Fri,  9 Sep 2016 21:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754974AbcIIVAu (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 17:00:50 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:32940 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754598AbcIIVAt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 17:00:49 -0400
Received: from mfilter48-d.gandi.net (mfilter48-d.gandi.net [217.70.178.179])
        by relay3-d.mail.gandi.net (Postfix) with ESMTP id 0DFAAA80BE;
        Fri,  9 Sep 2016 23:00:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter48-d.gandi.net
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
        by mfilter48-d.gandi.net (mfilter48-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id wqs15o84WOLH; Fri,  9 Sep 2016 23:00:45 +0200 (CEST)
X-Originating-IP: 45.61.26.130
Received: from x (unknown [45.61.26.130])
        (Authenticated sender: josh@joshtriplett.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id C8C5BA80CD;
        Fri,  9 Sep 2016 23:00:43 +0200 (CEST)
Date:   Fri, 9 Sep 2016 14:00:41 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] Move format-patch base commit and prerequisites before
 email signature
Message-ID: <20160909210040.zlsczhcotrxnu4e4@x>
References: <20160908011200.qzvbdt4wjwiji4h5@x>
 <xmqqshtags0o.fsf@gitster.mtv.corp.google.com>
 <20160908185408.5qtfnztjbastlrtw@x>
 <20160908200819.pkg7jqcvxjpdqr3a@sigill.intra.peff.net>
 <xmqqd1kef5k5.fsf@gitster.mtv.corp.google.com>
 <xmqq7fakc12z.fsf@gitster.mtv.corp.google.com>
 <20160909200721.xfkbud377ja4wkrt@x>
 <xmqqpoocajbb.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpoocajbb.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20160827 (1.7.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 09, 2016 at 01:51:04PM -0700, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> 
> > On Fri, Sep 09, 2016 at 12:41:56PM -0700, Junio C Hamano wrote:
> >> So here is a suggested replacement.  I notice that in the MIME case,
> >> we do not leave any blank line between the last line of the patch
> >> and the baseinfo, which makes it look a bit strange, e.g. output of
> >> "format-patch --attach=mimemime -1" may end like this:
> >> 
> >>     +       test_write_lines 1 2 >expect &&
> >>     +       test_cmp expect actual
> >>     +'
> >>     +
> >>      test_expect_success 'format-patch --pretty=mboxrd' '
> >>             sp=" " &&
> >>             cat >msg <<-INPUT_END &&
> >>     base-commit: 6ebdac1bab966b720d776aa43ca188fe378b1f4b
> >> 
> >>     --------------mimemime--
> >> 
> >> We may want to tweak it a bit further.
> >>  ...
> >
> > Looks good to me.
> 
> Thanks.
> 
> Do you mean that the base information that appears immediately after
> the patch text (either for MIME case or plain-text) does not bother
> you, though?

Sorry, I should have clarified that further.  I meant that the
additional tests looked good to me.

As it turns out, the patch I used to test this on happened to have a
blank line as the last line of context before the base-commit line, so
I'd overlooked this in the non-MIME case.  The issue you mentioned does
apply to both the MIME and non-MIME cases, and I agree that it needs
fixing.  It doesn't seem like a functional issue, but aesthetically it
doesn't look good.

Do you plan to make that change to print an additional blank line
(likely inside print_bases), or should I?
