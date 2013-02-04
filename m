From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Verify Content-Type from smart HTTP servers
Date: Mon, 4 Feb 2013 03:38:24 -0500
Message-ID: <20130204083824.GB30835@sigill.intra.peff.net>
References: <7v38xhf1i3.fsf@alter.siamese.dyndns.org>
 <20130201085248.GA30644@sigill.intra.peff.net>
 <7vip6bc3e1.fsf@alter.siamese.dyndns.org>
 <20130201185827.GA22919@sigill.intra.peff.net>
 <7va9rk5z02.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 09:38:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2HZj-0005QT-5s
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 09:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940Ab3BDIi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 03:38:28 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59935 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753526Ab3BDIi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 03:38:27 -0500
Received: (qmail 16861 invoked by uid 107); 4 Feb 2013 08:39:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 04 Feb 2013 03:39:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Feb 2013 03:38:24 -0500
Content-Disposition: inline
In-Reply-To: <7va9rk5z02.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215368>

On Sun, Feb 03, 2013 at 11:17:33PM -0800, Junio C Hamano wrote:

> Does this look good to both of you (relative to Shawn's patch)?
> 
>  remote-curl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/remote-curl.c b/remote-curl.c
> index e6f3b63..933c69a 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -134,14 +134,14 @@ static struct discovery* discover_refs(const char *service)
>  	last->buf_alloc = strbuf_detach(&buffer, &last->len);
>  	last->buf = last->buf_alloc;
>  
> -	if (maybe_smart && 5 <= last->len && last->buf[4] == '#') {
> +	strbuf_addf(&exp, "application/x-%s-advertisement", service);
> +	if (maybe_smart &&
> +	    (5 <= last->len && last->buf[4] == '#') &&
> +	    !strbuf_cmp(&exp, &type)) {
>  		/*
>  		 * smart HTTP response; validate that the service
>  		 * pkt-line matches our request.
>  		 */
> -		strbuf_addf(&exp, "application/x-%s-advertisement", service);
> -		if (strbuf_cmp(&exp, &type))
> -			die("invalid content-type %s", type.buf);
>  		if (packet_get_line(&buffer, &last->buf, &last->len) <= 0)
>  			die("%s has invalid packet header", refs_url);
>  		if (buffer.len && buffer.buf[buffer.len - 1] == '\n')

Yeah, I think that's fine. Thanks.

-Peff
