From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] Implementing git config handling in Git.pm
Date: Mon, 21 May 2007 01:14:14 +0200
Message-ID: <20070520231413.GE4489@pasky.or.cz>
References: <20070520225953.GK4085@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Mon May 21 01:14:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpubX-0004lz-Rh
	for gcvg-git@gmane.org; Mon, 21 May 2007 01:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758087AbXETXOR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 19:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758151AbXETXOR
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 19:14:17 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45200 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758087AbXETXOR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 19:14:17 -0400
Received: (qmail 11802 invoked by uid 2001); 21 May 2007 01:14:14 +0200
Content-Disposition: inline
In-Reply-To: <20070520225953.GK4085@planck.djpig.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47951>

  Hi,

On Mon, May 21, 2007 at 12:59:54AM CEST, Frank Lichtenheld wrote:
> Possible Solutions:
>  1) Call git-config.
>    Pro: Easy to implement
>    Contra: Violates at least target 2. Neither git-config --get nor
>    git-config --list offer a complete and safe view on the config
>    file. Just try including = in a subsection name (--list) or newlines in
>    a value (both) to see what I mean.
>  2) Extend git-config to give a machine parsable output and then
>     proceed with solution 1
>    Pro: Still reasonably easy to implement (?). Would benefit
>     other scripts, too.
>    Contra: Neither the fastest nor the most flexible
>     solution.

  Yes, this might be fine for you. The argument for 4 (implementing our
own in Perl) is that we would like it to be _real_ fast for gitweb
(especially the summary page needs to look at each repository). But it
would be a question of a benchmark to look really how much would calling
git-config slow us down. So as at least a proof-of-concept and initial
implementation I think this is more than fine, and we can proceed to
implement our own parser only when it's clearly needed.

>  3) Try to use the C code from config.c directly.
>    Pro: Probably the fastest solution due to avoiding the
>     forks.
>    Contra: Probably a bit more complex (any XS experts here?),
>     both to implement and to maintain.

  There was various trouble with XS in the past, and I think the general
feel was that we want to get back to using XS again sometime, but only
when Git will be reasonably libified (to support multiple repositories
at once, etc.).

>  4) Implement an own git config parser in Perl
>    Pro: Might be actually easier than 3 and faster than 2
>    Contra: See target 3

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
