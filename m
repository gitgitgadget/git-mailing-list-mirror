Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BE83203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 18:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757121AbcG0SNj (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 14:13:39 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48465 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756830AbcG0SNi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2016 14:13:38 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 800B2204F2;
	Wed, 27 Jul 2016 14:13:37 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 27 Jul 2016 14:13:37 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=pennock-tech.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=9jbrL
	TKTqb9loiVInTkIQ+RZI9s=; b=fRFLAZyZyXA7zcxQfKNafyp8oMjTL/UIsv4+1
	njKNqkgFasGfWqBVlxA49He7SgnNglKOBsqNWixWgOjV2UDIZtu5r3vU1wH2a8LY
	5yybIohPAj+b710+JqwskGJKTlhM5fEeENFVABOIfOHMaig5P1dDMLMezX/dj9YS
	lJ/ccw=
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=9jbrLTKTqb9loiVInTkIQ+RZI9s=; b=P7pIN
	+n75TSq+HjIXOOIMY+LQt5A8tYD6kVOlEK/b1XjYiDEgw3fDnM9RyoP/IjChFeWO
	X0Q8UrGQ+ogvu/TIUtWViwFMAYYT9fUa5rWHqE8UnqNosZZmOxIKNT4Fq49v+Qpx
	ln/vUMqx01g95WMHCUTf+/8Um1tCCWFy94VYi4=
X-Sasl-enc: hJkrgjhmgqVVtqds8pyUJ3gWEUtFdRT8XTFDoDYEmKRc 1469643217
Received: from tower.spodhuis.org (tower.spodhuis.org [94.142.242.224])
	by mail.messagingengine.com (Postfix) with ESMTPA id E3038F29F4;
	Wed, 27 Jul 2016 14:13:36 -0400 (EDT)
Date:	Wed, 27 Jul 2016 18:13:34 +0000
From:	Phil Pennock <phil@pennock-tech.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] pretty format string support for reflog times
Message-ID: <20160727181334.GA24224@tower.spodhuis.org>
References: <20160727081414.GA21451@breadbox>
 <20160727175622.GA9961@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160727175622.GA9961@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2016-07-27 at 13:56 -0400, Jeff King wrote:
> On Wed, Jul 27, 2016 at 04:14:14AM -0400, Phil Pennock wrote:
> > +		 */
> > +		case 'T':
> > +			if (get_reflog_timeinfo(&timestamp, &tz, c->pretty_ctx->reflog_info)) {
> > +				strbuf_addstr(sb, show_date(timestamp, tz, &c->pretty_ctx->date_mode));
> > +			}
> > +			return 2;
> >  		}
> 
> I think we can drop this one. It's a nice direction to go eventually,
> but without the extra placeholders I mentioned elsewhere, it doesn't buy
> us much.

Will do.

> Our usual error-return is "0 is success", "-1 is error".

The idea was "boolean function" and adding more negations elsewhere just
made things ugly.  I can change if you really want, as consistency wins,
but I'll be holding my nose as the invoker flow becomes:

    if (! function_call(out_params)) {
      use(out_params);
    }

which is counter-intuitive (but then, I do much less C these days and
have been corrupted).  So I'll hold off for now, until told otherwise.

> Though we don't _always_ adhere to that, and I won't be surprised if you
> simply copied this from other nearby code.

Not _this_ one ..

> > +refhead1_short=$(git rev-parse --short --verify HEAD@{0}) &&
> > +refhead2_short=$(git rev-parse --short --verify HEAD@{1}) &&
> 
> We try to push as much as possible into a test_expect_success block,
> since it handles things like unexpected output to stderr. I guess you
> put these outside because they are used in multiple tests. You don't
> have to do that, because tests can affect the greater environment. But
> if you do keep something outside of a test, you _don't_ want to use
> &&-chaining, as it means that the lines below it (i.e., the next test!)
> would simply not be run at all.

This however was matching existing style for `head1` and `head2` a
little above.  I was somewhat surprised.

> > +test_expect_success 'can access the reflog' '
> > +	git reflog -n 2 >actual &&
> > +	cat >expected <<EOF &&
> > +$refhead1_short HEAD@{0}: commit (amend): shorter
> > +$refhead2_short HEAD@{1}: commit (amend): short
> > +EOF
> > +	test_cmp expected actual
> > +'
> 
> I'm not sure what this is testing. Just that we have reflogs turned on
> at all? I think we can skip this, as it's implicit in the
> reflog-formatting test below.

Disagree: I could see no existing tests for reflog content matching an
expected layout (but could have missed one; I see some _using_ reflog).
If adding a test for minutiae of how tuning options adjust the output,
and something changes which breaks the output more widely, the person
investigating can spend a lot of time investigating a red herring,
looking to see what they broke in the `--pretty` handling.

First test the basics, then test the specifics, so that if the basics
break too then the developer is naturally led to the correct thing to
investigate instead of their only clue being that specifics broke.

> You can use "<<-" to ask the shell to strip leading tabs from the
> here-doc. And then you can indent the contents to match the rest of the
> test.

You can, but it's fragile if tabs become spaces and it isn't consistent
with the existing tests above.

> I kind of wonder if it would be better to drop "%h" from your format,
> too. You're just testing the timestamps, and handling the shortening is
> cluttering up the test. So maybe just:

This makes a lot of sense.

> (I did a few more tweaks to the format to hopefully make it easier to
> read). It would probably be a more interesting test if the two reflogs
> actually had different timestamps, though.

Is there a way to force that, through the normalizations?

> Also, come to think of it, that "%gr" test is going to break in about
> year. :-/

Oh crap, I saw the normalization and thought everything was being set to
specifics, but of course the relative is against now.  Good catch,
thanks.  How about:

    | sed "s/[1-9][0-9]* years/N years/"

and then test against "N years" in expected?

-Phil
