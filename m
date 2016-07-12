Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB8B22018E
	for <e@80x24.org>; Tue, 12 Jul 2016 11:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbcGLL5n (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 07:57:43 -0400
Received: from wmauth3.doit.wisc.edu ([144.92.197.226]:61155 "EHLO
	smtpauth3.wiscmail.wisc.edu" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750897AbcGLL5m (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2016 07:57:42 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jul 2016 07:57:42 EDT
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; CHARSET=US-ASCII
Received: from avs-daemon.smtpauth3.wiscmail.wisc.edu by
 smtpauth3.wiscmail.wisc.edu
 (Oracle Communications Messaging Server 7.0.5.37.0 64bit (built Jan 25 2016))
 id <0OA7007007J5VJ00@smtpauth3.wiscmail.wisc.edu> for git@vger.kernel.org;
 Tue, 12 Jul 2016 05:57:35 -0500 (CDT)
Received: from virtualbox (aftr-37-24-141-253.unity-media.net [37.24.141.253])
 by smtpauth3.wiscmail.wisc.edu
 (Oracle Communications Messaging Server 7.0.5.37.0 64bit (built Jan 25 2016))
 with ESMTPSA id <0OA70082N7RW9W00@smtpauth3.wiscmail.wisc.edu>; Tue,
 12 Jul 2016 05:57:34 -0500 (CDT)
Date:	Tue, 12 Jul 2016 12:57:31 +0200 (CEST)
From:	Johannes Schindelin <schindelin@wisc.edu>
X-X-Sender: virtualbox@virtualbox
To:	Andreas Schwab <schwab@linux-m68k.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
In-reply-to: <mvmtwfve22e.fsf@hawking.suse.de>
Message-id: <alpine.DEB.2.20.1607121249390.6426@virtualbox>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
 <87lh17kgdy.fsf@linux-m68k.org> <20160711235417.GA26163@sigill.intra.peff.net>
 <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607120927410.6426@virtualbox>
 <mvmtwfve22e.fsf@hawking.suse.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Andreas,

On Tue, 12 Jul 2016, Andreas Schwab wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > @@ -88,11 +88,11 @@ static int local_tzoffset(unsigned long time)
> >  	return offset * eastwest;
> >  }
> >  
> > -void show_date_relative(unsigned long time, int tz,
> > +void show_date_relative(time_t time, int tz,
> >  			       const struct timeval *now,
> >  			       struct strbuf *timebuf)
> >  {
> > -	unsigned long diff;
> > +	time_t diff;
> >  	if (now->tv_sec < time) {
> >  		strbuf_addstr(timebuf, _("in the future"));
> >  		return;
> > @@ -100,65 +100,65 @@ void show_date_relative(unsigned long time, int tz,
> >  	diff = now->tv_sec - time;
> >  	if (diff < 90) {
> >  		strbuf_addf(timebuf,
> > -			 Q_("%lu second ago", "%lu seconds ago", diff), diff);
> > +			 Q_("%" PRIuMAX " second ago", "%" PRIuMAX " seconds ago", diff), diff);
> 
> PRIuMAX isn't compatible with time_t.

That statement is wrong. But you probably meant that PRIuMAX is *not
necessarily* the correct thing to use.

And I would agree with that. I had to have a patch that 1) compiles and 2)
fixes t0006 on Windows, and the patch I presented achieved both goals.

I hoped that my brief "starting point" hint would make it obvious that I
do not think that this patch is acceptable?

My idea was to introduce a TIME_T_LARGER_THAN_ULONG and take it from
there, but I had to switch contexts before I could finish that part of the
patch, yet I still wanted to let y'all know that patches are in the
working.

For future record: I appreciate feedback especially when it is
constructive, i.e. when "that's wrong" is not left on its own, but is
instead followed by "why not do XYZ instead".

Ciao,
Johannes
