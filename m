From: Jeff King <peff@peff.net>
Subject: Re: how to know this commit is merged by whic commit
Date: Wed, 13 Jun 2012 17:34:35 -0400
Message-ID: <20120613213435.GA25301@sigill.intra.peff.net>
References: <CAHsH0E9HooVsAq8NhWm-OSk7gSPFMmoYHsArtYqhwTmE0ngwjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: lei yang <yanglei.fage@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 23:34:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SevDD-0005hv-KR
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 23:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607Ab2FMVek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 17:34:40 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:52229
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754529Ab2FMVei (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 17:34:38 -0400
Received: (qmail 9921 invoked by uid 107); 13 Jun 2012 21:34:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Jun 2012 17:34:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jun 2012 17:34:35 -0400
Content-Disposition: inline
In-Reply-To: <CAHsH0E9HooVsAq8NhWm-OSk7gSPFMmoYHsArtYqhwTmE0ngwjA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199949>

On Thu, Jun 14, 2012 at 12:50:59AM +0800, lei yang wrote:

> I have a question as the title indicate. assume the commmit id is
> ee5r3343. how to know this commit is merged by  which commit?

There is not one answer to "which commit"; there may be an infinite
number of commits which merge it into something else. The best you can
do is start at some point (e.g., the tip of "master") and walk backwards
looking for commits which merge it (and you still may find multiple, if
the commit was merged into two other lines of development, each of which
was merged into your starting point). There is not an option to do this
search automatically, so you would have to use grep, like:

  git log --format='%H %P' |
  grep " $commit" |
  cut -d' ' -f1

which will list the id of all commits (%H) for which $commit appears in
the list of parents (%P).

-Peff

PS You didn't give any background on your problem, but you may also find
   "git tag --contains" and "git branch --contains" useful.
