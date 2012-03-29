From: Jeff King <peff@peff.net>
Subject: Re: GSoC - Designing a faster index format
Date: Thu, 29 Mar 2012 05:45:54 -0400
Message-ID: <20120329094554.GA11603@sigill.intra.peff.net>
References: <CACsJy8C=4WaN4MZrZMaD3FqZrF2jCP5sm0F0SpDvzQnYfka9Ew@mail.gmail.com>
 <CAKTdtZkpjVaBSkcieojKj+V7WztT3UDzjGfXyghY=S8mq+X9zw@mail.gmail.com>
 <CACsJy8D85thmK_5jLC7MxJtsitLr=zphKiw2miwPu7Exf7ty=Q@mail.gmail.com>
 <CAKTdtZkx+7iU5T4oBNDEx-A5cgZCLU9ocdXmC9jRbD39J1zb3Q@mail.gmail.com>
 <87iphrjv23.fsf@thomas.inf.ethz.ch>
 <CACsJy8CsdZpQUQ7ydM1fOpSomm6+LyACCR83ccncVtUk+HbLKA@mail.gmail.com>
 <CAJo=hJsPgUZi2qMc5aDUn0+o5=9n7pBS+yWBASfqtov8WuFBRA@mail.gmail.com>
 <CAKTdtZngYaTCwd5cri=XjUu3-o44ECjDotrDBNxqYL-Kcsosnw@mail.gmail.com>
 <CAFfmPPM_GOkOp6-tE2=YxdrZq6TL3s4EgOjXdRKf8+ffMD29xg@mail.gmail.com>
 <CACsJy8BfCpH3jtfaOyyAgjH3P5fv4FYjboqjoFYF2GiG44TmoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Barr <davidbarr@google.com>,
	elton sky <eltonsky9404@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 11:46:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDBvm-0004YR-4Z
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 11:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758300Ab2C2JqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 05:46:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39140
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796Ab2C2JqC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 05:46:02 -0400
Received: (qmail 29894 invoked by uid 107); 29 Mar 2012 09:46:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Mar 2012 05:46:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2012 05:45:54 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8BfCpH3jtfaOyyAgjH3P5fv4FYjboqjoFYF2GiG44TmoA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194243>

On Tue, Mar 27, 2012 at 01:33:33PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Tue, Mar 27, 2012 at 10:34 AM, David Barr <davidbarr@google.com> wrote:
> > Another implementation in this general class is TinyCDB[1].
> > It is <1600 lines of plain C. Too few to be complete?
> > It is a derivative of DJB's CDB[2].
> >
> > [1] http://www.corpit.ru/mjt/tinycdb.html
> 
> "CDB is a constant database, that is, it cannot be updated at a
> runtime, only rebuilt.". It does not sound promising to me. I have not
> read the description carefully though.

No, you are right. I did some work with cdb many years ago. It optimizes
for lookup by spending time building an optimal hash table at generation
time. There is no way to add or modify an entry short of rewriting the
complete contents of the database, which is exactly what we are trying
to get away from with the current index format.

-Peff
