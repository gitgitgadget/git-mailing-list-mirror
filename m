From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Support caching projects list
Date: Mon, 17 Mar 2008 18:40:50 +0100
Message-ID: <20080317174050.GB10335@machine.or.cz>
References: <20080313231413.27966.3383.stgit@rover> <m3hcf9y02p.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 18:42:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbJLF-0000M6-TI
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 18:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbYCQRkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 13:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752970AbYCQRky
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 13:40:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44617 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752907AbYCQRkx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 13:40:53 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id CA38D393BAF9; Mon, 17 Mar 2008 18:40:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <m3hcf9y02p.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77448>

  Hi,

On Fri, Mar 14, 2008 at 05:14:51AM -0700, Jakub Narebski wrote:
> Petr Baudis <pasky@suse.cz> writes:
> [...]
> > +	if ($cache_lifetime and -f $cache_file
> > +	    and stat($cache_file)->mtime + $cache_lifetime * 60 > time()
> > +	    and open (my $fd, $cache_file)) {
> > +		$stale = time() - stat($cache_file)->mtime;
> > +		my @dump = <$fd>;
> > +		close $fd;
> > +		# Hack zone start
> > +		my $VAR1;
> > +		eval join("\n", @dump);
> > +		@projects = @$VAR1;
> > +		# Hack zone end
> 
> Why do you read line by line, only to join it, i.e.
>   my @dump = <$fd>; ... join("\n", @dump);
> instead of slurping all file in one go:
>   local $/ = undef; my $dump = <$fd>; ... $dump;
> 
> Besides, why do you use Data::Dumper instead of Storable? Both are
> distributed with Perl; well, at least both are in perl-5.8.6-24.

  no particular reason - I simply never heard about Storable. I learned
Perl too long ago it seems. ;-)

> [...]
> > -	git_project_list_body(\@list, $order);
> > +	git_project_list_body(\@list, $order, undef, undef, undef, undef, $projlist_cache_lifetime);
> 
> This is ugly. Why not use hash for "named parameters", as it is done
> in a few separate places in gitweb (search for '%opts')?

  I agree - I was simply too lazy to make another patch. :-)

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
