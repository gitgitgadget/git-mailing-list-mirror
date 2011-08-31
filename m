From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] for-each-ref: add split message parts to %(contents:*).
Date: Wed, 31 Aug 2011 12:42:33 -0400
Message-ID: <20110831164233.GA4356@sigill.intra.peff.net>
References: <4E5CB0D0.7000905@drmicha.warpmail.net>
 <1314781909-19252-1-git-send-email-mgorny@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Aug 31 18:42:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QynsF-0007Mw-P7
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 18:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825Ab1HaQmh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Aug 2011 12:42:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50272
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756322Ab1HaQmh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 12:42:37 -0400
Received: (qmail 4368 invoked by uid 107); 31 Aug 2011 16:43:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 31 Aug 2011 12:43:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Aug 2011 12:42:33 -0400
Content-Disposition: inline
In-Reply-To: <1314781909-19252-1-git-send-email-mgorny@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180480>

On Wed, Aug 31, 2011 at 11:11:49AM +0200, Micha=C5=82 G=C3=B3rny wrote:

> @@ -478,18 +481,20 @@ static void find_subpos(const char *buf, unsign=
ed long sz, const char **sub, con
>  	buf =3D strchr(buf, '\n');
>  	if (!buf) {
>  		*body =3D "";
> +		*signature =3D *body;
>  		return; /* no body */
>  	}
>  	while (*buf =3D=3D '\n')
>  		buf++; /* skip blank between subject and body */
>  	*body =3D buf;
> +	*signature =3D buf + parse_signature(buf, strlen(buf));

Hmm. I had doubts at first that "buf" is guaranteed to be
NUL-terminated, since we are passing around the "sz" parameter (though
note that we also use strchr already). But I think it is OK, as the
buffer comes from read_sha1_file, which defensively NUL-terminates all
objects we get.

Other than that, the patch looks fine. It could use some tests, so I'll
follow up with some:

  [1/2]: t7004: factor out gpg setup
  [2/2]: t6300: test new content:* for-each-ref placeholders

-Peff
