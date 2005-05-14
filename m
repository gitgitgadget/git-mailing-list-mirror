From: Petr Baudis <pasky@ucw.cz>
Subject: [RFD] Ignore rules
Date: Sat, 14 May 2005 17:30:27 +0200
Message-ID: <20050514153027.GN3905@pasky.ji.cz>
References: <4283CAF8.3050304@dgreaves.com> <20050513231229.GI32232@pasky.ji.cz> <4285B6A8.4080309@dgreaves.com> <7vy8ai2nb6.fsf@assigned-by-dhcp.cox.net> <20050514142421.GG3905@pasky.ji.cz> <42861584.6020601@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, torvalds@osdl.org,
	GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 14 17:31:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWybG-00059K-Gk
	for gcvg-git@gmane.org; Sat, 14 May 2005 17:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVENPap (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 11:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVENPap
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 11:30:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34202 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261401AbVENPac (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 11:30:32 -0400
Received: (qmail 13742 invoked by uid 2001); 14 May 2005 15:30:27 -0000
To: David Greaves <david@dgreaves.com>
Content-Disposition: inline
In-Reply-To: <42861584.6020601@dgreaves.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here, I would like more people to speak up, plaese, especially the
authors of other layers over git than Cogito, since I think it'd be
great if we could agree on common ignore rules format and we could just
call the files ".gitignore" instead of ".cgignore", ".jitignore" etc.


Dear diary, on Sat, May 14, 2005 at 05:13:08PM CEST, I got a letter
where David Greaves <david@dgreaves.com> told me that...
> I was wondering about supporting _both_ globs and re's
> right now my ignore file has a # to precede comment lines

I assume \# will override that?

> maybe re: precedes regexp lines and unadorned lines are globs.

Or maybe even /, which is the common regexp prefix anyway...

To mention it in this mail too, I think leading '!' should do the
"ignore exclude" - that is, it would override any possible previous
ignore decisions about the file. E.g. '!*' would throw away all
previously applied ignore rules.

> However the re's provided by regex(7) are too weedy to be worth
> bothering with.
> If however, there is a serious plan to go to perl, it may be worth
> providing for this now in the ignore syntax.
> 
> Also... you haven't mentioned perl for a while - can you give us an update?
> I personally think we're making life needlessly unpleasant by sticking
> with shell.

If there is still a serious plan, it is much more long-term now, since
shell turns out to keep doing fine and everything we need, and that all
reasonably fast.

That said, I think it's fine to use Perl regexps. I think they rule. :-)
But what do others think? Should we stick with POSIX regexps (I assume
at least extended instead of basic), or go with Perl regexps?

> Additionally this causes problems with sharing the same exclude file as
> used by git.
> However...
> I really think git's exclude file capability and cogito's are different.
> Cogito is aiming to provide full-blown SCM capabilities - git isn't

If we get to agree on some common format, I'm thinking whether it
wouldn't be actually good to extend the --exclude option to support it.
How much of an issue would that be? What do others think?

> I am also concerned that a centralised ignore file is not flexible enough.
> Certainly limiting if we support globs only.
> It may be that you want different rules in different trees - someone on
> lkml mentioned that excludes vary in different parts of the source.
> Eg .s files may be generally ignored - but not in the asm parts of the tree.

I imagine it as (ignore rules applied in this order):

<default ignore list>:

Some builtin ignore list catching files like *.o, *.a and such.
Remember that you can throw it away with !* if you don't like it.

/.git/ignore:

Per-repository ignore list, not version tracked etc; really a local thing.

/.gitignore
/**/.gitignore:

(Applied in the order from the project root to the current directory.)
Version tracked ignore list, which concerns the current directory, BUT
may match pathnames instead of just filenames (but no ..). That is, you
could do something like

	echo '*.o' >.gitignore

to ignore all the object files in the current directory, and

	echo '**.o' >.gitignore

to also ignore the object files in all the subdirectories.


Opinions?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
