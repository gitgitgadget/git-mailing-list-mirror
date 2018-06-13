Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 295D31F403
	for <e@80x24.org>; Wed, 13 Jun 2018 18:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935335AbeFMSg2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 14:36:28 -0400
Received: from mail179-28.suw41.mandrillapp.com ([198.2.179.28]:28080 "EHLO
        mail179-28.suw41.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935219AbeFMSg1 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Jun 2018 14:36:27 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jun 2018 14:36:27 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=okmzpvosbBa3f12fC7LX+bhEUGdpx9fLpdjKSEdEvx8=;
 b=SsefsmUaxxKva01teMmAL7n5cpaYId+U8MUrwE0rq4qvtmQ3ncINHUlcKxxdTEuf59MwBXwj2qPa
   ybTCfycPz3XE2DYBxiQEoY4yJNgIehthFlPXyziGEqspqpKXmZbkqmXSF5MIIlaC1fofP4+oUIRl
   6VswyQygPK9y2ImY+sc=
Received: from pmta04.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail179-28.suw41.mandrillapp.com id h45i2m22s280 for <git@vger.kernel.org>; Wed, 13 Jun 2018 18:21:26 +0000 (envelope-from <bounce-md_31050260.5b2160a6.v1-067bfdaf98374c88abe949d75dae849c@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1528914086; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=okmzpvosbBa3f12fC7LX+bhEUGdpx9fLpdjKSEdEvx8=; 
 b=P7uU/J3Kqzog1wTvmsgYmVzJGyZNRQcQ06JA4meCaEQXJGLyON9dNxAP0T9TeNXQ11BOlb
 fQKBXzBR6tvmURY7yIXF5BqqI6YBv8NQI9IZfVvLt6Hkg6DcVJVJQVoHohn8/kBMZ46+U62z
 7yxg2udsmiWkP3SRRfGoG3KgFbh0s=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH] fetch-pack: demonstrate --all failure when remote is empty
Received: from [87.98.221.171] by mandrillapp.com id 067bfdaf98374c88abe949d75dae849c; Wed, 13 Jun 2018 18:21:26 +0000
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Takuto Ikuta <tikuta@chromium.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git List <git@vger.kernel.org>
Message-Id: <20180613182122.GA22854@deco.navytux.spb.ru>
References: <20180610143231.7131-1-kirr@nexedi.com> <20180611042016.GA31642@sigill.intra.peff.net> <20180611044710.GB31642@sigill.intra.peff.net> <CAPig+cT73d0rYoSbt7oHVG4MYHVvjKidP0ogRwV+9F73jcjZEA@mail.gmail.com> <20180611055357.GA16430@sigill.intra.peff.net> <20180611094255.GA15563@deco.navytux.spb.ru> <20180612094849.GB26123@sigill.intra.peff.net> <20180612185413.GA21856@deco.navytux.spb.ru> <20180613125549.4mshuymvdpwh44qk@deco.navytux.spb.ru> <xmqqh8m67gpo.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh8m67gpo.fsf@gitster-ct.c.googlers.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.067bfdaf98374c88abe949d75dae849c
X-Mandrill-User: md_31050260
Date:   Wed, 13 Jun 2018 18:21:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 13, 2018 at 10:13:07AM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@nexedi.com> writes:
> 
> > ( Junio, please pick up the patch provided in the end )
> >
> > On Tue, Jun 12, 2018 at 06:54:17PM +0000, Kirill Smelkov wrote:
> >> On Tue, Jun 12, 2018 at 05:48:49AM -0400, Jeff King wrote:
> >> > On Mon, Jun 11, 2018 at 09:43:02AM +0000, Kirill Smelkov wrote:
> > [...]
> >
> >> > > I'm not sure, but I would say that `fetch-pack --all` from an empty
> >> > > repository should not fail and should just give empty output as fetch
> >> > > does.
> >> > 
> >> > Yeah, that seems reasonable to me. The die() that catches this dates
> >> > back to 2005-era, and we later taught the "fetch" porcelain to handle
> >> > this. I don't _think_ anybody would be upset that the plumbing learned
> >> > to treat this as a noop. It's probably a one-liner change in
> >> > fetch_pack() to return early instead of dying.
> 
> I actually have a slight preference to the current "attempting to
> fetch from a total emptiness is so rare that it is worth grabbing
> attention of whoever does so" behaviour, to be honest.

I see.

> Oh, wait, is this specific to "fetch-pack" and the behaviour of
> end-user-facing "git fetch" is kept same as before?  If then, I'd be
> somewhat sympathetic to the cause---it would be more convenient for
> the calling Porcelain script if this turned into a silent noop (even
> though it would probably make it harder to diagnose when such a
> Porcelain is set up incorrectly e.g. pointing at an empty repository
> that is not the one the Porcelain writer intended to fetch from).

Yes, it is only for fetch-pack, and behaviour of porcelain fetch is kept
as it was before.

> > However with transport.c being there too, since I'm no longer using
> > `fetch-pack --all`, now it is best for me to not delve into this story
> > and just stop with attached patch.
> 
> If we do not plan to change the behaviour later ourselves, I do not
> think it makes sense, nor it is fair to those future developers who
> inherit this project, to declare that the established behaviour is
> wrong with an 'expect-failure' test like this, to be honest.

I see. Let's please cancel this patch then.


> > +test_expect_failure 'test --all wrt empty.git' '
> > +	git init --bare empty.git &&
> > +	(
> > +		cd client &&
> > +		git fetch-pack --all ../empty.git
> > +	)
> > +'
