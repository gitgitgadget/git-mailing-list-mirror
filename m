From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/4] use strbuf_getcwd() to get the current working
 directory without fixed-sized buffers
Date: Tue, 22 Jul 2014 06:43:52 -0400
Message-ID: <20140722104352.GB29607@peff.net>
References: <53CBF277.3090101@web.de>
 <53CBF332.2050301@web.de>
 <20140721023312.GC22750@peff.net>
 <53CD4975.8050002@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 22 12:44:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9XY7-0004sp-0q
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 12:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350AbaGVKnz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jul 2014 06:43:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:38128 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752391AbaGVKny (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 06:43:54 -0400
Received: (qmail 22942 invoked by uid 102); 22 Jul 2014 10:43:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 Jul 2014 05:43:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jul 2014 06:43:52 -0400
Content-Disposition: inline
In-Reply-To: <53CD4975.8050002@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254010>

On Mon, Jul 21, 2014 at 07:10:13PM +0200, Ren=C3=A9 Scharfe wrote:

> Probably.  And I was so glad to have found an example case for getcwd
> without dying and without touching the get-there-and-back cases. :) G=
uess
> I'll have to look closer at setup.c and perhaps unix-socket.c for a
> replacement.

I think just:

  const char *x =3D xgetcwd();
  setenv(GIT_DIR_ENVIRONMENT, x, 0);
  free(x);

would be enough?

> By the way: Simply setting $GIT_DIR to "." probably won't work in the=
 two
> cases, I guess?

It might, but I'd be a little wary. For example, for the call in
init_db, would we later then chdir to the working tree in order to do a
checkout (since init_db is part of a clone)? Even if it works now, it
seems like a bit of an accident waiting to happen.

-Peff
