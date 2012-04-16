From: Jeff King <peff@peff.net>
Subject: Re: Pushing to a remote repo from a remote repo?
Date: Mon, 16 Apr 2012 10:47:26 -0400
Message-ID: <20120416144726.GA13688@sigill.intra.peff.net>
References: <CAAnwhhWTcfOi+qqXPnGNXSKHbFh5L=+6eSKaaex5mq6VTwSxEw@mail.gmail.com>
 <1334444541.7825.1.camel@beez.lab.cmartin.tk>
 <CAAnwhhXPs0+GPExMu8TP0jbctMamg6FZW2ndcQMJbtqGetfyZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Brian Cardarella <brian@dockyard.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 16:47:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJnDU-0003bC-1O
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 16:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754460Ab2DPOrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 10:47:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36221
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753673Ab2DPOre (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 10:47:34 -0400
Received: (qmail 23904 invoked by uid 107); 16 Apr 2012 14:47:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Apr 2012 10:47:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Apr 2012 10:47:26 -0400
Content-Disposition: inline
In-Reply-To: <CAAnwhhXPs0+GPExMu8TP0jbctMamg6FZW2ndcQMJbtqGetfyZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195638>

On Sat, Apr 14, 2012 at 07:16:36PM -0400, Brian Cardarella wrote:

> Yes, I assumed the bits need to come through my system. I want to
> avoid cloning, pushing, then removing the repo. But it seems that is
> not possible. Thank you.

This isn't really a git problem, but rather a network proxying problem.
You could solve it with netcat and ssh like:

  # forward port 5001 on our local box to ssh on the "source" box
  nc -lp 5001 -c 'nc $source 22' &

  # forward port 5001 on the destination box to our local forward,
  # and then start the clone
  ssh -R 5001:localhost:5001 $dest \
    'git clone ssh://localhost:5001/path/to/repo'

If the repository is accessible by http, then you can easily tweak it to
forward to port 80. If, for some reason, you prefer push rather than
fetch, you can create the tunnels in the reverse direction.

-Peff
