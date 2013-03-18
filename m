From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] remote.c: introduce a way to have different remotes
 for fetch/ push
Date: Mon, 18 Mar 2013 10:58:34 -0400
Message-ID: <20130318145834.GA24095@sigill.intra.peff.net>
References: <1363612575-7340-1-git-send-email-artagnon@gmail.com>
 <1363612575-7340-3-git-send-email-artagnon@gmail.com>
 <20130318143121.GB23075@sigill.intra.peff.net>
 <CALkWK0mc3HN4jT24QKP2Bt49fPtSd4=3wO0xFA7-4gt2n7ih-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 15:59:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHbWj-00029L-L3
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 15:59:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860Ab3CRO6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 10:58:38 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56144 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751459Ab3CRO6i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 10:58:38 -0400
Received: (qmail 18096 invoked by uid 107); 18 Mar 2013 15:00:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Mar 2013 11:00:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2013 10:58:34 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0mc3HN4jT24QKP2Bt49fPtSd4=3wO0xFA7-4gt2n7ih-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218422>

On Mon, Mar 18, 2013 at 08:26:46PM +0530, Ramkumar Ramachandra wrote:

> > Can we get rid of this duplication by having remote_get_1 take a
> > service-specific default argument? And then each service calls it like:
> >
> >   struct remote *remote_get(const char *name)
> >   {
> >           read_config();
> >           return remote_get_1(name, NULL);
> >   }
> >
> >   struct remote *pushremote_get(const char *name)
> >   {
> >           read_config();
> >           return remote_get_1(name, pushremote_name);
> >   }
> 
> Thanks for the dose of sanity.  While at it, why not move
> read_config() to remote_get_1() as well?

Because it sets pushremote_name, and therefore you would just be passing
NULL if read_config has not been run yet. But if you made it:

  return remote_get_1(name, &pushremote_name);

that would work.

-Peff
