From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 05/10] abspath: convert real_path_internal() to strbuf
Date: Mon, 28 Jul 2014 15:16:49 -0400
Message-ID: <20140728191649.GE11265@peff.net>
References: <53D694A2.8030007@web.de>
 <53D6964E.1070100@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 21:17:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBqPp-0005av-T4
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 21:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbaG1TQy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2014 15:16:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:41946 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750956AbaG1TQy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 15:16:54 -0400
Received: (qmail 28417 invoked by uid 102); 28 Jul 2014 19:16:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Jul 2014 14:16:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jul 2014 15:16:49 -0400
Content-Disposition: inline
In-Reply-To: <53D6964E.1070100@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254350>

On Mon, Jul 28, 2014 at 08:28:30PM +0200, Ren=C3=A9 Scharfe wrote:

> @@ -60,26 +58,22 @@ static const char *real_path_internal(const char =
*path, int die_on_error)
>  			goto error_out;
>  	}
> =20
> -	if (strlcpy(buf, path, PATH_MAX) >=3D PATH_MAX) {
> -		if (die_on_error)
> -			die("Too long path: %.*s", 60, path);
> -		else
> -			goto error_out;
> -	}
> +	strbuf_init(&sb, 0);
> +	strbuf_addstr(&sb, path);

As with the other patch I just mentioned, should this be strbuf_reset,
not strbuf_init? We want to reset the static buffer back to zero-size,
not throw it away and leak whatever was there.

-Peff
