From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 10/21] hash-object: read --stdin-paths with
 strbuf_getline()
Date: Fri, 15 Jan 2016 15:23:18 -0500
Message-ID: <20160115202318.GD11301@sigill.intra.peff.net>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-11-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 21:23:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKAu5-0002Wr-7x
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 21:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755302AbcAOUXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 15:23:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:54627 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752809AbcAOUXV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 15:23:21 -0500
Received: (qmail 10400 invoked by uid 102); 15 Jan 2016 20:23:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 15:23:20 -0500
Received: (qmail 23454 invoked by uid 107); 15 Jan 2016 20:23:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 15:23:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2016 15:23:18 -0500
Content-Disposition: inline
In-Reply-To: <1452815916-6447-11-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284209>

On Thu, Jan 14, 2016 at 03:58:25PM -0800, Junio C Hamano wrote:

> The list of paths could have been written with a DOS editor.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/hash-object.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/hash-object.c b/builtin/hash-object.c
> index 3bc5ec1..ff20395 100644
> --- a/builtin/hash-object.c
> +++ b/builtin/hash-object.c
> @@ -60,7 +60,7 @@ static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
>  {
>  	struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
>  
> -	while (strbuf_getline_lf(&buf, stdin) != EOF) {
> +	while (strbuf_getline(&buf, stdin) != EOF) {
>  		if (buf.buf[0] == '"') {
>  			strbuf_reset(&nbuf);
>  			if (unquote_c_style(&nbuf, buf.buf, NULL))

The implication here is that the paths cannot have a trailing CR unless
they are quoted. I think that is probably OK. We quote such a case
ourselves, and while it's _possible_ for somebody to feed us arbitrary
output that they generated themselves, I would argue that anybody not
quoting CR is generating bogus output.

-Peff
