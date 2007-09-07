From: Theodore Tso <tytso@mit.edu>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 7 Sep 2007 02:15:54 -0400
Message-ID: <20070907061554.GB30161@thunk.org>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org> <a1bbc6950709061808q85cf75co75f2331dc2bdbcbe@mail.gmail.com> <alpine.LFD.0.999.0709070212300.5626@evo.linux-foundation.org> <a1bbc6950709062009x59a41cb7re6051739c11e370c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 08:16:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITX8c-00080J-PM
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 08:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbXIGGQN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 02:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757311AbXIGGQN
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 02:16:13 -0400
Received: from thunk.org ([69.25.196.29]:34253 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752216AbXIGGQM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 02:16:12 -0400
Received: from root (helo=tinytim.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1ITXHQ-0004Pz-7m; Fri, 07 Sep 2007 02:25:24 -0400
Received: from tytso by tinytim.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1ITX8E-0006Wl-LO; Fri, 07 Sep 2007 02:15:54 -0400
Content-Disposition: inline
In-Reply-To: <a1bbc6950709062009x59a41cb7re6051739c11e370c@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57983>

On Thu, Sep 06, 2007 at 08:09:23PM -0700, Dmitry Kakurin wrote:
> > Total BS. The string/memory management is not at all relevant. Look at the
> > code (I bet you didn't). This isn't the important, or complex part.
> 
> Not only have I looked at the code, I've also debugged it quite a bit.
> Granted most of my problems had to do with handling paths on Windows
> (i.e. string manipulations).

I consider string manipulation to be one of the places where C++ is a
total disaster.  It's way to easy for idiots to do something like this:

	a = b + "/share/" + c + serial_num;

where you can have absolutely no idea how many memory allocations are
done, due to type coercions, overloaded operators (good God, you can
overload the comma operator in C++!!!), and then when something like
that ends up in an inner loop, the result is a disaster from a
performance point of view, and it's not even obvious *why*!

> My goal is to *use* Git. When something does not work *for me* I want
> to be able to fix it (and contribute the fix) in *shortest time
> possible* and with *minimal efforts*. As for me it's a diversion from
> my main activities.

Yes, and if you contribute something the shortest time possible, and
it ends up being crap, who gets to rewrite it and fix it?  I've seen
too many C++ programs which get this kind of crap added, and it's not
noticed right away (because C++ is really good at hiding such
performance killers so they are not visible), and then later on, it's
even harder to find the performance problems and fix them.

> Now, I realize that I'm a very infrequent contributor to Git, but I
> want my opinion to be heard.

And if git were written in C++, it's precisely the infrequent
contributors (who are in a hurry, who only care about the quick hack
to get them going, and not about the long-term maintainability and
performance of the package) that are be in the position to do the
most damage...

						- Ted
