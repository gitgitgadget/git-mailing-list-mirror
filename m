From: Jeff King <peff@peff.net>
Subject: Re: git pull & git gc
Date: Thu, 19 Mar 2015 00:34:37 -0400
Message-ID: <20150319043437.GA30331@peff.net>
References: <55098A49.1020003@aegee.org>
 <CACsJy8AtoeSv7uZc3P2xXN0A15gpj-OUTRyNhMe__=HqtTkD2Q@mail.gmail.com>
 <CACsJy8DCdF1YmfFF1aCuhMJ0v4+FW7EkDiwBnBF2OFhE=kcbFg@mail.gmail.com>
 <20150318145815.GN1369@serenity.lan>
 <20150318210458.GA3376@peff.net>
 <CACsJy8AJfx8id+oHmhsLODBJeNLgRqD+5B295TtS+c-hrC5raQ@mail.gmail.com>
 <20150319012722.GA26867@peff.net>
 <CACsJy8CUbe4-f4rpieAKYzHb4rpKg8JW+uXB5yA4c1HFG6r4dg@mail.gmail.com>
 <20150319042050.GA29999@peff.net>
 <CACsJy8B3zyf7mCigQSGXOKLcR9s3=VKkxEe4PuSraS6qb-rjcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>,
	=?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 05:34:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYSAP-0001OA-2e
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 05:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbbCSEek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 00:34:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:35034 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750731AbbCSEek (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 00:34:40 -0400
Received: (qmail 1129 invoked by uid 102); 19 Mar 2015 04:34:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 23:34:40 -0500
Received: (qmail 10028 invoked by uid 107); 19 Mar 2015 04:34:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 00:34:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2015 00:34:37 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8B3zyf7mCigQSGXOKLcR9s3=VKkxEe4PuSraS6qb-rjcA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265784>

On Thu, Mar 19, 2015 at 11:29:57AM +0700, Duy Nguyen wrote:

> > That omits the "N objects left over" information. Which I think may be
> > useful, because otherwise the rule is basically "don't do another gc at
> > all for X time units". That's OK for most use, but it has its own corner
> > cases.
> 
> True. But saving "N objects left over" in a file also has a corner
> case. If the user "prune --expire=now" manually, the next 'gc --auto'
> still thinks we have that many leftovers and keeps delaying gc for
> some more time. Unless we make 'prune' (or any other commands that
> delete leftovers) to also delete this file. Yeah maybe saving this
> info in a file will work.

I assumed that the user would not run prune manually, but would run "git
gc --prune=now". And yeah, definitely any time gc runs, it should update
the file (if there are fewer than `gc.auto` objects, I think it could
just delete the file).

We could also apply that rule any run of "git prune", but my mental
model is that "git gc" is the magical porcelain that will do this stuff
for you, and "git prune" is the plumbing that users shouldn't need to
call themselves. I don't know if that model is shared by users, though. :)

-Peff
