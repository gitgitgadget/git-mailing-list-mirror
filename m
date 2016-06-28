Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F9142018A
	for <e@80x24.org>; Tue, 28 Jun 2016 18:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230AbcF1S3A (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 14:29:00 -0400
Received: from alt13.smtp-out.videotron.ca ([135.19.0.26]:3569 "EHLO
	alt12.smtp-out.videotron.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751017AbcF1S27 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2016 14:28:59 -0400
Received: from yoda.home ([96.23.157.65])
	by Videotron with SMTP
	id HxkmbesDjHh2dHxkobtDh7; Tue, 28 Jun 2016 14:28:58 -0400
X-Authority-Analysis: v=2.1 cv=Lv0ysipc c=1 sm=1 tr=0
 a=keA3yYpnlypCNW5BNWqu+w==:117 a=keA3yYpnlypCNW5BNWqu+w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=pD_ry4oyNxEA:10 a=dg4UtMH5AAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
 a=m1-BmCBcJ1YEn9BM1NQA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
 a=byNfn09xH3PuSfgbYLsR:22 a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
Received: from xanadu.home (xanadu.home [192.168.2.2])
	by yoda.home (Postfix) with ESMTPSA id DB72B2DA0200;
	Tue, 28 Jun 2016 14:28:56 -0400 (EDT)
Date:	Tue, 28 Jun 2016 14:28:56 -0400 (EDT)
From:	Nicolas Pitre <nico@fluxnic.net>
To:	Junio C Hamano <gitster@pobox.com>
cc:	Lukas Fleischer <lfleischer@lfos.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Refactor recv_sideband()
In-Reply-To: <xmqqlh1p89mo.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.20.1606281422500.24439@knanqh.ubzr>
References: <20160613195224.13398-1-lfleischer@lfos.de> <20160628043526.19403-1-lfleischer@lfos.de> <xmqqa8i59rph.fsf@gitster.mtv.corp.google.com> <xmqq60st9qg5.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.20.1606281334030.24439@knanqh.ubzr>
 <xmqqlh1p89mo.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfHapCGIrCY6EJ9o9t8U3AxziuRi2+kSihhXHgj1IJ+YP2ywqxUjORDdlxEt8Hgeu+QO+pc7G+Ca3OZ2ApkZ0mKDUU2xJWy3pdeIz28JJW09oL7/zqT0D
 tXmHrCKNWS8xFr5dIUN4Nb+2XA+6eMkuTbPNMnOaTNxlMCNh7bDkVoH+6IjU+o5yxv18Ahh+iET0furY3K2C1c1chiPL4tov8O4uKduLWx9UjTLQb4ERQRZG
 iBcNfszYVALgdqaLRsY5ivyYwe0dWT/Wm8piv+zOO7E=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, 28 Jun 2016, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> >> When we exit the loop because we set retval to a non-zero value,
> >> should we still drain the outbuf?
> >
> > I would think so.  Anything that the remote sent before any error should 
> > be printed nevertheless.  The clue for the error might be in the pending 
> > buffer.
> >
> > However in this case the actual error printout and the pending buffer 
> > will appear reversed.
> >
> > So what I'd suggest is actually something like this:
> >
> >             if (len < 1) {
> >                     strbuf_addf(&outbuf, "\n%s: protocol error: no band designator\n", me);
> >                     retval = SIDEBAND_PROTOCOL_ERROR;
> >                     break;
> >
> > And so on for the other error cases.
> 
> Makes sense.
> 
> Here is what I have as a "SQUASH" on top of Lukas's change to be
> queued on 'pu'.

Looks good to me.

Acked-by: Nicolas Pitre <nico@linaro.org>

> It appears that a few tests get their expectations broken, with or
> without this "SQUASH" change, though X-<.

Without this, the error and remaining buffer would be reversed as 
mentioned previously.  With this, the order is restored, but a newline 
is added to unterminated lines whereas the error was simply appended to 
the output before Lukas' patch.

In any case the new behavior is probably better and I'd simply adjust 
the test expectations.


> 
>  sideband.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/sideband.c b/sideband.c
> index 226a8c2..082dfc6 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -33,13 +33,15 @@ int recv_sideband(const char *me, int in_stream, int out)
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
> +			strbuf_addf(&outbuf,
> +				    "\n%s: protocol error: no band designator\n",
> +				    me);
>  			retval = SIDEBAND_PROTOCOL_ERROR;
>  			break;
>  		}
> @@ -48,7 +50,7 @@ int recv_sideband(const char *me, int in_stream, int out)
>  		len--;
>  		switch (band) {
>  		case 3:
> -			fprintf(stderr, "%s%s\n", PREFIX, buf + 1);
> +			strbuf_addf(&outbuf, "\n%s%s\n", PREFIX, buf + 1);
>  			retval = SIDEBAND_REMOTE_ERROR;
>  			break;
>  		case 2:
> @@ -58,13 +60,12 @@ int recv_sideband(const char *me, int in_stream, int out)
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
> @@ -75,8 +76,7 @@ int recv_sideband(const char *me, int in_stream, int out)
>  				} else {
>  					strbuf_addf(&outbuf, "%c", *brk);
>  				}
> -				fprintf(stderr, "%.*s", (int)outbuf.len,
> -					outbuf.buf);
> +				fwrite(outbuf.buf, 1, outbuf.len, stderr);
>  				strbuf_reset(&outbuf);
>  				strbuf_addf(&outbuf, "%s", PREFIX);
>  
> @@ -90,15 +90,15 @@ int recv_sideband(const char *me, int in_stream, int out)
>  			write_or_die(out, buf + 1, len);
>  			break;
>  		default:
> -			fprintf(stderr, "%s: protocol error: bad band #%d\n",
> +			strbuf_addf(&outbuf, "\n%s: protocol error: bad band #%d\n",
>  				me, band);
>  			retval = SIDEBAND_PROTOCOL_ERROR;
>  			break;
>  		}
>  	}
>  
> -	if (outbuf.len > 0)
> -		fprintf(stderr, "%.*s", (int)outbuf.len, outbuf.buf);
> +	if (outbuf.len)
> +		fwrite(outbuf.buf, 1, outbuf.len, stderr);
>  	strbuf_release(&outbuf);
>  	return retval;
>  }
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
