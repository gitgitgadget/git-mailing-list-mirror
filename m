From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] Documentation/technical/api-fswatch.txt: start with
 outline
Date: Tue, 12 Mar 2013 05:55:19 -0400
Message-ID: <20130312095519.GA12170@sigill.intra.peff.net>
References: <1362946623-23649-1-git-send-email-artagnon@gmail.com>
 <20130311170542.GB4167@sandbox-ub.fritz.box>
 <CALkWK0m+CS25=Z91y90z49g4GK+b7oFugiXoH0h0J6P-yQXRCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Git List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 12 10:55:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFLvz-0000ug-SF
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 10:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447Ab3CLJzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 05:55:23 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49467 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932379Ab3CLJzW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 05:55:22 -0400
Received: (qmail 25140 invoked by uid 107); 12 Mar 2013 09:57:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Mar 2013 05:57:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Mar 2013 05:55:19 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0m+CS25=Z91y90z49g4GK+b7oFugiXoH0h0J6P-yQXRCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217941>

On Tue, Mar 12, 2013 at 03:13:39PM +0530, Ramkumar Ramachandra wrote:

> Heiko Voigt wrote:
> > While talking about platform independence. How about Windows? AFAIK
> > there are no file based sockets. How about using shared memory, thats
> > available, instead? It would greatly reduce the needed porting effort.
> 
> What about the git credential helper: it uses UNIX sockets, no?  How
> does git-credential-winstore [1] work?

No, the main credential protocol happens over pipes to a child process's
stdin/stdout. The credential-cache helper does use unix sockets (since
it needs to contact a long-running daemon that caches the credentials),
and AFAIK is not available under Windows (but that's OK, because
Windows-specific helpers that use secure storage are better anyway).

When I introduced credential-cache, I recall somebody mentioned that
there is some Windows-equivalent IPC that can be used to emulate unix
domain sockets. The calls aren't the same, but as long as your
requirements are basically "get messages to/from the daemon", you can
probably abstract away the details on a per-platform basis.

Unfortunately I can't seem to find the original message or any details
in the archive (and I know next to nothing about Windows IPC).

-Peff
