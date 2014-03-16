From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] mv: prevent mismatched data when ignoring errors.
Date: Sat, 15 Mar 2014 22:00:19 -0400
Message-ID: <20140316020018.GA20019@sigill.intra.peff.net>
References: <20140308183501.GH18371@serenity.lan>
 <1394306499-50871-1-git-send-email-sandals@crustytoothpaste.net>
 <8738ijzbue.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Guillaume Gelin <contact@ramnes.eu>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sun Mar 16 03:00:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WP0NH-0000sK-Qv
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 03:00:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755031AbaCPCAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 22:00:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:40323 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754908AbaCPCAV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 22:00:21 -0400
Received: (qmail 3442 invoked by uid 102); 16 Mar 2014 02:00:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 15 Mar 2014 21:00:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Mar 2014 22:00:19 -0400
Content-Disposition: inline
In-Reply-To: <8738ijzbue.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244177>

On Sat, Mar 15, 2014 at 05:05:29PM +0100, Thomas Rast wrote:

> > diff --git a/builtin/mv.c b/builtin/mv.c
> > index f99c91e..b20cd95 100644
> > --- a/builtin/mv.c
> > +++ b/builtin/mv.c
> > @@ -230,6 +230,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
> >  					memmove(destination + i,
> >  						destination + i + 1,
> >  						(argc - i) * sizeof(char *));
> > +					memmove(modes + i, modes + i + 1,
> > +						(argc - i) * sizeof(char *));
> 
> This isn't right -- you are computing the size of things to be moved
> based on a type of char*, but 'modes' is an enum.
> 
> (Valgrind spotted this.)

Maybe using sizeof(*destination) and sizeof(*modes) would make this less
error-prone?

-Peff
