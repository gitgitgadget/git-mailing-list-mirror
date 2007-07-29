From: Theodore Tso <tytso@mit.edu>
Subject: Re: What's in git.git (stable)
Date: Sat, 28 Jul 2007 23:16:12 -0400
Message-ID: <20070729031612.GB17204@thunk.org>
References: <7v4plqoyg5.fsf@assigned-by-dhcp.cox.net> <7v7iqgtt1j.fsf@assigned-by-dhcp.cox.net> <7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com> <7vy7idydqa.fsf@assigned-by-dhcp.pobox.com> <7v7ipsz7vr.fsf@assigned-by-dhcp.pobox.com> <7vk5tj3bj1.fsf@assigned-by-dhcp.cox.net> <7vzm20q1l7.fsf_-_@assigned-by-dhcp.cox.net> <7vvec4synj.fsf_-_@assigned-by-dhcp.cox.net> <85zm1g3nze.fsf@lola.goethe.zz> <85bqdw27mb.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jul 29 05:16:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEzGh-0005WH-Ie
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 05:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757676AbXG2DQR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 23:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757570AbXG2DQR
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 23:16:17 -0400
Received: from THUNK.ORG ([69.25.196.29]:56669 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757348AbXG2DQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 23:16:16 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IEzOm-0007to-I4; Sat, 28 Jul 2007 23:24:52 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1IEzGO-0001H0-Uy; Sat, 28 Jul 2007 23:16:12 -0400
Content-Disposition: inline
In-Reply-To: <85bqdw27mb.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54077>

On Sat, Jul 28, 2007 at 11:35:40AM +0200, David Kastrup wrote:
> David Kastrup <dak@gnu.org> writes:
> 
> > If you use the desktop package, this means that you get a bear of a
> > startup time while a _new_ instance of Emacs gets loaded against the
> > wishes of the setup, and the command line parameters will be
> > interpreted relatively to the last file restored into the desktop
> > rather than the current directory (arguably a bug in the desktop
> > package which I plan to fix eventually, but in the meantime the
> > current package is farspread).
> 
> I can't reproduce anything similar outside of mergetool, so it appears
> more likely that mergetool is passing wrong relative file names.

See my recent posting on this issue.  The problem is that the desktop
package fundamentally changes how emacs behaves when it starts up.
And in order to fix it we will need to change git-mergetool to do an
"emacs --version", parse the version number, and then start changing
how it calls emacs (and if you *really* want to use emacsclient,
whether it can use emacsclient) based on the version of emacs which is
installed as the default for the user.  It's going to be really messy,
and fundamentally, emacs as used by people who are using the desktop
package really wants to be the center of the universe, instead of
something which gets called to run a "merge application".  Testing to
make sure this works on every single emacs version/variant, and every
single user's weird-sh*t startup scripts isn't something I'm looking
forward to.

So I really am beginning to think the right answer is to give up on
using git-mergetool to support anything other than basic emacs users
(who just use emacs as an editor, what a concept), and for the H4rd
C0re emacs l33t, they can use a contrib/git-mergetool.el that does
everything inside emacs.  Since these are the people who want emacs to
be their desktop, their shell, *and* their window manager, they will
probably be happier that way....

						- Ted
