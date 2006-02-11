From: Petr Baudis <pasky@suse.cz>
Subject: Re: Make "git clone" less of a deathly quiet experience
Date: Sat, 11 Feb 2006 14:33:40 +0100
Message-ID: <20060211133340.GS31278@pasky.or.cz>
References: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org> <7vwtg2o37c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 11 14:34:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7uso-0001jV-7E
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 14:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWBKNdL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 08:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWBKNdL
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 08:33:11 -0500
Received: from w241.dkm.cz ([62.24.88.241]:19596 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751425AbWBKNdJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2006 08:33:09 -0500
Received: (qmail 30127 invoked by uid 2001); 11 Feb 2006 14:33:40 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtg2o37c.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15944>

BTW, some historical (from the very channel beginning) logs of #git for
fun, profit and late night reading are available at
http://pasky.or.cz/~pasky/cp/%23git/, e.g. the 2006-02-10 early morning
features the King Penguin explaining the deepness and intricacies of
pack files construction! Don't miss the opportunity!

New files won't be world-readable by default, but I hope to get some
irclogger with cutesy web interface set up for #git.


Dear diary, on Sat, Feb 11, 2006 at 06:48:55AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Anyway, _something_ like this is definitely needed. It could certainly be 
> > better (if it showed the same kind of thing that git-unpack-objects did, 
> > that would be much nicer, but would require parsing the object stream as 
> > it comes in). But this is  big step forward, I think.
> >
> > Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> > ---
> >
> > Comments? Hate-mail? Improvements?
> 
> It probably should default to quiet if (!isatty(1)).

isatty(2) or something, 1 is in practice always a ref generator. Perhaps
it would be better not to clutter stderr, though; what about directly
opening /dev/tty? Does Cygwin support that?

> The real improvement, independent of this client-side patch,
> would be to reuse recently generated packs, but that needs
> writable cache directory on the server side.  Another thing that
> I stumbled upon last time I tried it was that it did not look
> totally trivial to modify the csum-file interface so that I can
> splice the output from it into two different destinations (one
> to cachefile, the other to the consumer).

Yes, I said that on IRC yesterday as well. I don't think even a cache is
needed; just look at the repository and say:

	* while there are packs containing only objects we are going to
	  send, pick the largest one and send it as-is.
	* if there is a pack with more than a 75% (totally arbitrary)
	  overlap with the objects we are going to send, send it as-is.
	* pack the loose objects.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
