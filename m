From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: Submodules can't work recursively because Git implements
	policy?
Date: Mon, 6 Apr 2009 15:56:18 +0200
Message-ID: <20090406135618.GA17793@pvv.org>
References: <33f4f4d70904060642m25b2cff8nafed433eeabfb6c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Users List <git@vger.kernel.org>
To: Klas Lindberg <klas.lindberg@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 15:59:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqpKj-00084C-E9
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 15:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754415AbZDFN4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 09:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754355AbZDFN4W
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 09:56:22 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:45928 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157AbZDFN4W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 09:56:22 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LqpJC-0000E8-Jq; Mon, 06 Apr 2009 15:56:18 +0200
Content-Disposition: inline
In-Reply-To: <33f4f4d70904060642m25b2cff8nafed433eeabfb6c4@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115832>

On Mon, Apr 06, 2009 at 03:42:31PM +0200, Klas Lindberg wrote:
> On Mon, Apr 6, 2009 at 3:16 PM, Finn Arne Gangstad <finnag@pvv.org> wrote:
> 
> > git submodule update just does "git fetch" and hopes that the required
> > commit appears. In practice this means that you (may) need to invent a
> > tag or a branch for all the submodules, otherwise they are not
> > fetchable.
> >
> > This bit us pretty hard when we tried to use submodules earlier, so we
> > gave up. Maybe some day...
> 
> It "hopes" to find them?

Perhaps "hopes" is a loaded word, "expects" at least. The code just
does the equivalent of "git fetch; git checkout <sha-1> || die .. "

>  This is actually my other reason for bringing
> the whole SHA key fetching thing up. From what I can see, it is not
> possible to implement submodules sensibly without support for fetching
> SHA keys. I.e. I want fetch, checkout and every other command to
> recurse as needed in the presence of submodules. This limitation
> forces me to implement a whole CM tool where none should be necessary.

Yes, I could not agree more.  You may also end up writing some really
complicated wrappers around git push to get things going (where do you
push, for example). We made some interesting "concept art" around this
last year at $dayjob, but decided to drop it.

> It appears to me that the security concern (being able to hide commits
> by making them unreachable from a named reference) is actually a
> policy decision and not a technical one. On what grounds does Git
> decide for me how to handle security concerns? It just seems more
> important to be able to have recursive submodule behaviour than to
> provide band aid for careless users.

Maybe the security concerns could be handled by adding some
functionality to (quickly) get rid of unwanted commits?

> Out of curiosity: Is it really possible to change the value of an
> already pushed tag? Can you only do the hiding trick with branches?

Yes, but if you modify a tag, you get additional complications. In
particular, no one will ever try to refetch the tag, so everyone who
has already fetched it will have a permanently broken tag.

- Finn Arne
