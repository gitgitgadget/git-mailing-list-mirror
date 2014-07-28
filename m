From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 02/10] unix-sockets: use strbuf_getcwd()
Date: Mon, 28 Jul 2014 14:51:09 -0400
Message-ID: <20140728185109.GB11265@peff.net>
References: <53D694A2.8030007@web.de>
 <53D695A4.2030403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 20:51:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBq18-0003ut-Ou
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 20:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbaG1SvS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2014 14:51:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:41911 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751553AbaG1SvO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 14:51:14 -0400
Received: (qmail 26824 invoked by uid 102); 28 Jul 2014 18:51:14 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Jul 2014 13:51:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jul 2014 14:51:09 -0400
Content-Disposition: inline
In-Reply-To: <53D695A4.2030403@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254346>

On Mon, Jul 28, 2014 at 08:25:40PM +0200, Ren=C3=A9 Scharfe wrote:

> Instead of using a PATH_MAX-sized buffer, which can be too small on s=
ome
> file systems, use strbuf_getcwd(), which handles any path getcwd()
> returns.  Also preserve the errno set by strbuf_getcwd() instead of
> setting it to ENAMETOOLONG; that way a more appropriate error message
> can be shown based on the actual reason for failing.
>=20
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  unix-socket.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/unix-socket.c b/unix-socket.c
> index 91bd6b8..19ed48b 100644
> --- a/unix-socket.c
> +++ b/unix-socket.c
> @@ -18,12 +18,12 @@ static int chdir_len(const char *orig, int len)
>  }
> =20
>  struct unix_sockaddr_context {
> -	char orig_dir[PATH_MAX];
> +	char *orig_dir;
>  };

I would have expected this to just convert to a strbuf. I guess, though
that you were making this...

> =20
>  static void unix_sockaddr_cleanup(struct unix_sockaddr_context *ctx)
>  {
> -	if (!ctx->orig_dir[0])
> +	if (!ctx->orig_dir)
>  		return;

=2E..a little nicer by using the pointer to check for validity. Looks g=
ood
to me.

-Peff
