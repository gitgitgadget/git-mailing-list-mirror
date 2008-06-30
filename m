From: Jeff King <peff@peff.net>
Subject: Re: diff/Checking out by date specification
Date: Mon, 30 Jun 2008 01:21:05 -0400
Message-ID: <20080630052105.GA21954@sigill.intra.peff.net>
References: <486843C3.30402@rea-group.com> <20080630032744.GA18930@sigill.intra.peff.net> <48686339.60205@rea-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Toby Corkindale <toby.corkindale@rea-group.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 07:22:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDBqf-0005qy-9M
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 07:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbYF3FVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 01:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbYF3FVJ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 01:21:09 -0400
Received: from peff.net ([208.65.91.99]:2036 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777AbYF3FVI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 01:21:08 -0400
Received: (qmail 25160 invoked by uid 111); 30 Jun 2008 05:21:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 30 Jun 2008 01:21:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jun 2008 01:21:05 -0400
Content-Disposition: inline
In-Reply-To: <48686339.60205@rea-group.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86872>

On Mon, Jun 30, 2008 at 02:38:17PM +1000, Toby Corkindale wrote:

> I think it would be good if you could give a couple of examples, such as:
> How would I go about checking out the code at the state it was in at,  
> say, 2008-01-01?
> Or how one can get a diff between 2008-01-01 and 2008-01-08?
>
> (I note that "git-diff --until=2008-01-08 --since=2008-01-01" fails, as  
> does "git-checkout --until=2008-01-08")

That is a little bit trickier, since there is a not a convenient syntax
for selecting a particular revision by commit time. So you _can_ do
this:

  git diff \
    `git rev-list -1 --until=2008-01-01 HEAD` \
    `git rev-list -1 --until=2008-01-08 HEAD`

But that isn't quite what you want either. Remember that history can
follow many branches simultaneously. So what we are saying with
"--until" here is "show me all the commits that happened before this
time", and then we use "-1" to say "pick the first one." So you are
really picking two points in time that are close to what you want, and
then diffing the two states.

Depending on what you want to do, that may be enough. But more likely,
you are interested in the actual shape of history, so looking at the
individual commits with something like "gitk --since=2008-01-01
--until=2008-01-08" is probably going to be more instructive.

-Peff
