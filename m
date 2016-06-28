Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 152A02018A
	for <e@80x24.org>; Tue, 28 Jun 2016 21:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbcF1Vou (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 17:44:50 -0400
Received: from alt13.smtp-out.videotron.ca ([135.19.0.26]:64074 "EHLO
	alt12.smtp-out.videotron.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752508AbcF1Vop (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2016 17:44:45 -0400
Received: from yoda.home ([96.23.157.65])
	by Videotron with SMTP
	id I0o2baoexq3HFI0o5bUVfQ; Tue, 28 Jun 2016 17:44:34 -0400
X-Authority-Analysis: v=2.1 cv=Q9lym9Ca c=1 sm=1 tr=0
 a=keA3yYpnlypCNW5BNWqu+w==:117 a=keA3yYpnlypCNW5BNWqu+w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=pD_ry4oyNxEA:10 a=dg4UtMH5AAAA:8 a=fOC3hCqT-krO7fYxbDwA:9
 a=k2jzDucoAzBJoNO0:21 a=tyS9515zN_iOTHfO:21 a=CjuIK1q_8ugA:10
 a=byNfn09xH3PuSfgbYLsR:22
Received: from xanadu.home (xanadu.home [192.168.2.2])
	by yoda.home (Postfix) with ESMTPSA id 76AE52DA0200;
	Tue, 28 Jun 2016 17:44:30 -0400 (EDT)
Date:	Tue, 28 Jun 2016 17:44:30 -0400 (EDT)
From:	Nicolas Pitre <nico@fluxnic.net>
To:	Junio C Hamano <gitster@pobox.com>
cc:	Lukas Fleischer <lfleischer@lfos.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Refactor recv_sideband()
In-Reply-To: <xmqqwpl96mvv.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.20.1606281726330.24439@knanqh.ubzr>
References: <20160613195224.13398-1-lfleischer@lfos.de> <20160628043526.19403-1-lfleischer@lfos.de> <xmqqa8i59rph.fsf@gitster.mtv.corp.google.com> <xmqq60st9qg5.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.20.1606281334030.24439@knanqh.ubzr>
 <xmqqlh1p89mo.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.20.1606281422500.24439@knanqh.ubzr> <xmqq60st853d.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.20.1606281629280.24439@knanqh.ubzr> <xmqqwpl96mvv.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfNV7dxsqVgUxKcGcmqIf85sKjZrK6+pE1l5Xq08jR59TXRtFssqZfbgj/vdjgzp6+q9MaWb+Ae696TlIV5lDG1gX+gEJENstEslMR3oc3Ds4+0KRppA6
 Sjyfu2qOLGHj9+IgUHdSog/88aaPX+xdmaE/OMB+u7gSBTeFkujCZNnMxYzEQYah1fHSQ8lJiShzayATHguQ0YHgm0VuXlX4qvDU8BNsM0gzB+3J23N3vEDN
 dDEZVg/h0ubEH7tMsHX8GwFhtFlCS205HSw48PkZGkI=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, 28 Jun 2016, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> >> There is something else going on.  I cannot quite explain why I am
> >> getting this failure from t5401-update-hooks.sh, for example:
> >> 
> >>     --- expect      2016-06-28 19:46:24.564937075 +0000
> >>     +++ actual      2016-06-28 19:46:24.564937075 +0000
> >>     @@ -9,3 +9,4 @@
> >>      remote: STDERR post-receive
> >>      remote: STDOUT post-update
> >>      remote: STDERR post-update
> >>     +remote: To ./victim.git
> >>     not ok 12 - send-pack stderr contains hook messages
> >> 
> >> ... goes and looks what v2.9.0 produces, which ends like this:
> >> 
> >>     ...
> >>     remote: STDERR post-receive        
> >>     remote: STDOUT post-update        
> >>     remote: STDERR post-update        
> >>     To ./victim.git
> >>        e4822ab..2b65bd1  master -> master
> >>      ! [remote rejected] tofail -> tofail (hook declined)
> >> 
> >> The test checks if lines prefixed with "remote: " match the expected
> >> output, and the difference is an indication that the new code is
> >> showing an extra incomplete-line "remote: " before other parts of
> >> the code says "To ./victim.git" to report where the push is going.
> >
> > Ah...  I think I know what's going on.
> >
> > The leftover data in the strbuf is normally (when there is no errors) an 
> > unterminated line. So instead of doing:
> >
> > -                       fprintf(stderr, "%s: protocol error: no band designator\n", me);
> > +                       strbuf_addf(&outbuf,
> > +                                   "\n%s: protocol error: no band designator\n",
> > +                                   me);
> >
> > you could omit the final \n in the format string and:
> >
> > -       if (outbuf.len > 0)
> > -               fprintf(stderr, "%.*s", (int)outbuf.len, outbuf.buf);
> > +       if (outbuf.len)
> > +               fwrite(outbuf.buf, 1, outbuf.len, stderr);
> >         strbuf_release(&outbuf);
> >
> > and here a \n could be added before writing out the buffer.
> 
> Unfortunately, that is not it.
> 
> The basic structure of the code (without the "SQUASH" we discussed)
> looks like this:
> 
> 	strbuf_addf(&outbuf, "%s", PREFIX);
> 	while (retval == 0) {
> 		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX, 0);
> 		...
> 		band = buf[0] & 0xff;
> 		switch (band) {
> 		case 3:
> 			... /* emergency exit */
> 		case 2:
> 			while ((brk = strpbrk(b, "\n\r"))) {
> 				int linelen = brk - b;
> 
> 				if (linelen > 0) {
> 					strbuf_addf(&outbuf, "%.*s%s%c",
> 						    linelen, b, suffix, *brk);
> 				} else {
> 					strbuf_addf(&outbuf, "%c", *brk);
> 				}
> 				fprintf(stderr, "%.*s", (int)outbuf.len,
> 					outbuf.buf);
> 				strbuf_reset(&outbuf);
> 				strbuf_addf(&outbuf, "%s", PREFIX);
> 				b = brk + 1;
> 			}
> 			if (*b)
> 				strbuf_addf(&outbuf, "%s", b);
> 			break;
> 		...
> 		}
> 	}
> 
> 	if (outbuf.len > 0)
> 		fprintf(stderr, "%.*s", (int)outbuf.len, outbuf.buf);
> 
> Imagine we are reading from band #2 and we find a complete line.  We
> concatenate the payload up to the LF at the end of the line to the
> PREFIX we prepared outside the loop and emit it, and then we ASSUME
> that we further have something after strpbrk() and add PREFIX to the
> buffer, before going to the next line in the payload.
> 
> But there may not be anything after the LF.  outbuf.len is still
> counting the PREFIX and we end up showing it, without termination.

You're right.  Although my previous observations still apply.

> This takes us back to what I said in my review of an earlier round,
> in $gmane/297332, where I said:
> 
>     Instead of doing "we assume outbuf already has PREFIX when we add
>     contents from buf[]", the code structure would be better if you:
> 
>      * make outbuf.buf contain PREFIX at the beginning of this innermost
>        loop; lose the reset/addf from here.
> 
>      * move strbuf_reset(&outbuf) at the end of the next if (*b) block
>        to just before "continue;"
> 
>     perhaps?
> 
> I think the strbuf_addf(PREFIX) above the loop should be removed,
> and instead the code should use the PREFIX only when it decides that
> there is something worth emitting, i.e.
> 
> 	while (!retval) {
>         	len = packet_read();
>                 ...
>                 band = buf[0] & 0xff;
>                 switch (band) {
>                 case 3:
>                 	... /* emergency exit */
> 		case 2:
>                 	while ((brk = ...)) {
>                         	/* we have something to say */
> 				strbuf_reset(&outbuf);
>                                 strbuf_addstr(&outbuf, PREFIX);

That won't work. If at this point there is the beginning of a partial 
line queued in the buffer from the previous round waiting to see its 
line break, you just deleted the beginning of that line.

Furthermore, that partial line won't get a prefix if it doesn't have at 
least one line break in the packet data.

Rather the prefix should be added whenever the buffer is empty before 
every addition.

>                                 if (linelen)
>                                 	strbuf_addf(...);
> 				else
>                                 	strbuf_addch(*brk);
> 				fwrite(outbuf.buf, 1, outbuf.len, stderr);
> 				b = brk + 1;
> 			}
>                         if (*b) {
>                         	/* we still have something to say */
> 				strbuf_reset(&outbuf);
>                                 strbuf_addstr(&outbuf, PREFIX);
>                                	strbuf_addf(...);

This is also wrong.  If the middle part of a partial line is received, 
you just deleted its queued beginning.


Nicolas
