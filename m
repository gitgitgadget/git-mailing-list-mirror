From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 05/10] abspath: convert real_path_internal() to strbuf
Date: Mon, 28 Jul 2014 15:09:46 -0400
Message-ID: <20140728190946.GC11265@peff.net>
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
X-From: git-owner@vger.kernel.org Mon Jul 28 21:09:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBqJ1-0002l1-AS
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 21:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbaG1TJv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2014 15:09:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:41930 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750708AbaG1TJu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 15:09:50 -0400
Received: (qmail 28024 invoked by uid 102); 28 Jul 2014 19:09:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Jul 2014 14:09:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jul 2014 15:09:46 -0400
Content-Disposition: inline
In-Reply-To: <53D6964E.1070100@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254348>

On Mon, Jul 28, 2014 at 08:28:30PM +0200, Ren=C3=A9 Scharfe wrote:

>  static const char *real_path_internal(const char *path, int die_on_e=
rror)
>  {
> -	static char bufs[2][PATH_MAX + 1], *buf =3D bufs[0], *next_buf =3D =
bufs[1];
> +	static struct strbuf sb =3D STRBUF_INIT;

Hrm. I thought at first that this was our usual trick of keeping two
"simultaneous" static buffers, so that we can do:

  printf("paths '%s' and '%s'\n", real_path(foo), real_path(bar));

But it looks like that is not the case, and we only have two for
swapping back and forth as we figure out the answer (but they both need
to be static, because we do not know which one we will return in the
end). Is that right?

-Peff
