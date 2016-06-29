Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79A9B2018B
	for <e@80x24.org>; Wed, 29 Jun 2016 03:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbcF2DmH (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 23:42:07 -0400
Received: from alt32.smtp-out.videotron.ca ([24.53.0.21]:61970 "EHLO
	alt32.smtp-out.videotron.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752598AbcF2DmC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2016 23:42:02 -0400
Received: from yoda.home ([96.23.157.65])
	by Videotron with SMTP
	id I6NqbNdCvYOXTI6NrbdqUK; Tue, 28 Jun 2016 23:41:51 -0400
X-Authority-Analysis: v=2.1 cv=Gfm35VjL c=1 sm=1 tr=0
 a=keA3yYpnlypCNW5BNWqu+w==:117 a=keA3yYpnlypCNW5BNWqu+w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=pD_ry4oyNxEA:10 a=ybZZDoGAAAAA:8 a=VwQbUJbxAAAA:8 a=m1-BmCBcJ1YEn9BM1NQA:9
 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=AjGcO6oz07-iQ99wixmX:22
Received: from xanadu.home (xanadu.home [192.168.2.2])
	by yoda.home (Postfix) with ESMTPSA id 04F872DA0200;
	Tue, 28 Jun 2016 23:41:50 -0400 (EDT)
Date:	Tue, 28 Jun 2016 23:41:49 -0400 (EDT)
From:	Nicolas Pitre <nico@fluxnic.net>
To:	Junio C Hamano <gitster@pobox.com>
cc:	Lukas Fleischer <lfleischer@lfos.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Refactor recv_sideband()
In-Reply-To: <xmqqshvw66oc.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.20.1606282337340.24439@knanqh.ubzr>
References: <20160613195224.13398-1-lfleischer@lfos.de> <20160628043526.19403-1-lfleischer@lfos.de> <xmqqa8i59rph.fsf@gitster.mtv.corp.google.com> <xmqq60st9qg5.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.20.1606281334030.24439@knanqh.ubzr>
 <xmqqlh1p89mo.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.20.1606281422500.24439@knanqh.ubzr> <xmqq60st853d.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.20.1606281629280.24439@knanqh.ubzr> <xmqqwpl96mvv.fsf@gitster.mtv.corp.google.com>
 <alpine.LFD.2.20.1606281726330.24439@knanqh.ubzr> <xmqqfurx6j16.fsf@gitster.mtv.corp.google.com> <xmqq8txp6icn.fsf@gitster.mtv.corp.google.com> <xmqqshvw66oc.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfMD6Ga2/fef3F4ByyBF3b4szLb+G/cWQe2O8qDWDQHmm8XL4ttUzUw0nfa6DudTRiOnFqzh/4IYuXTFrB/QeWO8SKHyikyeHDv5Ue4l9hSXtBsUNf+BY
 sQHsqpkVDta+mj41g6v+MsrwqxfbUPsM7oN7sll4PfhXZCcQNVVPu+5EtO6feVJBAYDUk8ZLbqQS6PkYJKsU4P1cnM28pcxcM6FWeLLw45GY4KResPVDEcqS
 o/LJGOqCRAoW/sOX8Wk7Q0Fcbprt3dwqypbyAH4550Y=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, 28 Jun 2016, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > It's just that if you take the latter, then the conditional after
> > the loop exits (i.e. the last transmission was an incomplete line)
> > cannot be "is outbuf empty?", as your base state is "has PREFIX and
> > can never be empty".  I was working back from that if statement.
> 
> Let's try this again.  How does this look?

Still broken.

> In this version:
> 
>  - "outbuf" is where we keep the (possibly partial) data collected
>    to be eventually shown;
> 
>  - output of pending (possibly partial) data is handled by a helper
>    function drain().  It is responsible for prepending of the
>    PREFIX, which is treated purely as a cosmetic thing.  It also is
>    responsible for completing an incomplete line at the end of the
>    transmission (e.g. flushing of the buffered input upon reception of
>    the emergency exit packet).

It uses strbuf_complete_line() which destroys the intended result for 
lines that end with '\r'.

>  - locally generated errors go directly to fprintf(stderr),
>    bypassing outbuf (hence drain()).
> 
>  sideband.c | 43 +++++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/sideband.c b/sideband.c
> index 226a8c2..6873137 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -18,6 +18,16 @@
>  #define ANSI_SUFFIX "\033[K"
>  #define DUMB_SUFFIX "        "
>  
> +static void drain(struct strbuf *outbuf)
> +{
> +	if (!outbuf->len)
> +		return;
> +	strbuf_splice(outbuf, 0, 0, PREFIX, strlen(PREFIX));
> +	strbuf_complete_line(outbuf);
> +	fwrite(outbuf->buf, 1, outbuf->len, stderr);
> +	strbuf_reset(outbuf);
> +}
> +
>  int recv_sideband(const char *me, int in_stream, int out)
>  {
>  	const char *term, *suffix;
> @@ -26,20 +36,21 @@ int recv_sideband(const char *me, int in_stream, int out)
>  	const char *b, *brk;
>  	int retval = 0;
>  
> -	strbuf_addf(&outbuf, "%s", PREFIX);
>  	term = getenv("TERM");
>  	if (isatty(2) && term && strcmp(term, "dumb"))
>  		suffix = ANSI_SUFFIX;
>  	else
>  		suffix = DUMB_SUFFIX;
>  
> -	while (retval == 0) {
> +	while (!retval) {
>  		int band, len;
>  		len = packet_read(in_stream, NULL, NULL, buf, LARGE_PACKET_MAX, 0);
>  		if (len == 0)
>  			break;
>  		if (len < 1) {
> -			fprintf(stderr, "%s: protocol error: no band designator\n", me);
> +			drain(&outbuf);
> +			fprintf(stderr, "%s: protocol error: no band designator\n",
> +				me);
>  			retval = SIDEBAND_PROTOCOL_ERROR;
>  			break;
>  		}
> @@ -48,7 +59,8 @@ int recv_sideband(const char *me, int in_stream, int out)
>  		len--;
>  		switch (band) {
>  		case 3:
> -			fprintf(stderr, "%s%s\n", PREFIX, buf + 1);
> +			drain(&outbuf);
> +			strbuf_addf(&outbuf, "%s\n", buf + 1);
>  			retval = SIDEBAND_REMOTE_ERROR;
>  			break;
>  		case 2:
> @@ -58,13 +70,12 @@ int recv_sideband(const char *me, int in_stream, int out)
>  			 * Append a suffix to each nonempty line to clear the
>  			 * end of the screen line.
>  			 *
> -			 * The output is accumulated in a buffer and each line
> -			 * is printed to stderr using fprintf() with a single
> -			 * conversion specifier. This is a "best effort"
> -			 * approach to supporting both inter-process atomicity
> -			 * (single conversion specifiers are likely to end up
> -			 * in single atomic write() system calls) and the ANSI
> -			 * control code emulation under Windows.
> +			 * The output is accumulated in a buffer and
> +			 * each line is printed to stderr using
> +			 * fwrite(3).  This is a "best effort"
> +			 * approach to support inter-process atomicity
> +			 * (single fwrite(3) call is likely to end up
> +			 * in single atomic write() system calls).
>  			 */
>  			while ((brk = strpbrk(b, "\n\r"))) {
>  				int linelen = brk - b;
> @@ -75,11 +86,7 @@ int recv_sideband(const char *me, int in_stream, int out)
>  				} else {
>  					strbuf_addf(&outbuf, "%c", *brk);
>  				}
> -				fprintf(stderr, "%.*s", (int)outbuf.len,
> -					outbuf.buf);
> -				strbuf_reset(&outbuf);
> -				strbuf_addf(&outbuf, "%s", PREFIX);
> -
> +				drain(&outbuf);
>  				b = brk + 1;
>  			}
>  
> @@ -90,6 +97,7 @@ int recv_sideband(const char *me, int in_stream, int out)
>  			write_or_die(out, buf + 1, len);
>  			break;
>  		default:
> +			drain(&outbuf);
>  			fprintf(stderr, "%s: protocol error: bad band #%d\n",
>  				me, band);
>  			retval = SIDEBAND_PROTOCOL_ERROR;
> @@ -97,8 +105,7 @@ int recv_sideband(const char *me, int in_stream, int out)
>  		}
>  	}
>  
> -	if (outbuf.len > 0)
> -		fprintf(stderr, "%.*s", (int)outbuf.len, outbuf.buf);
> +	drain(&outbuf);
>  	strbuf_release(&outbuf);
>  	return retval;
>  }
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
