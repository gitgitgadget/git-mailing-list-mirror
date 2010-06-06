From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 1/4] sha1_name: creating context cache
Date: Sun, 6 Jun 2010 18:15:57 -0400
Message-ID: <20100606221557.GF6993@coredump.intra.peff.net>
References: <1275823848-7151-1-git-send-email-clement.poulain@ensimag.imag.fr>
 <1275823848-7151-2-git-send-email-clement.poulain@ensimag.imag.fr>
 <vpqpr045f46.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>, git@vger.kernel.org,
	spearce@spearce.org, drizzd@aon.at,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 07 00:16:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLO8V-0001j2-PO
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 00:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295Ab0FFWQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 18:16:00 -0400
Received: from peff.net ([208.65.91.99]:51740 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753728Ab0FFWQA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 18:16:00 -0400
Received: (qmail 12496 invoked by uid 107); 6 Jun 2010 22:16:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 06 Jun 2010 18:16:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Jun 2010 18:15:57 -0400
Content-Disposition: inline
In-Reply-To: <vpqpr045f46.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148553>

On Sun, Jun 06, 2010 at 05:56:41PM +0200, Matthieu Moy wrote:

> > +struct object_resolve_context {
> > +	unsigned char tree[20];
> > +	char path[PATH_MAX];
> > +	unsigned mode;
> > +};
> > +extern struct object_resolve_context object_context;
> 
> Is it really a good idea to make this a global variable? As I
> understand it, the semantics of this variable is that it contains
> information on the last sha1 name parsed (BTW, you probably want to
> add a comment here explaining that). Wouldn't it be more robust to
> have this value returned by the function doing the parsing?

This is straight from my earlier patch, but I think I said in that
thread that it could use some cleaning up. You added the 'mode' field,
but it probably makes sense to then get rid of the distinction between
get_sha1 and get_sha1_with_mode, and just have:

  get_sha1_with_context(const char *name, unsigned char *sha1, struct
                        object_resolve_context *orc) {
     /* basically get_sha1_with_mode, but set mode in orc */
  }
  get_sha1(const char *name, unsigned char *sha1) {
         struct object_resolve_context orc; /* to be thrown away */
         return get_sha1_with_context(name, sha1, &orc);
  }

-Peff
