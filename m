From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: Re: [PATCH] make __git_ps1 accept a third parameter in pcmode
Date: Wed, 26 Dec 2012 21:19:44 +0100
Message-ID: <20121226201944.GA15039@xs4all.nl>
References: <7vvcbpp846.fsf@alter.siamese.dyndns.org>
 <20121226191505.GA29210@simaj.xs4all.nl>
 <7vmwx0oavn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: piotr.krukowiecki@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 26 21:20:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnxT4-00040i-4h
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 21:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463Ab2LZUU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 15:20:28 -0500
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:1710 "EHLO
	smtp-vbr6.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab2LZUU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 15:20:27 -0500
Received: from xs8.xs4all.nl (xs8.xs4all.nl [194.109.21.8])
	by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id qBQKJmw0058989
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 26 Dec 2012 21:19:53 +0100 (CET)
	(envelope-from osimon@xs4all.nl)
Received: from xs8.xs4all.nl (IDENT:1251136@localhost [127.0.0.1])
	by xs8.xs4all.nl (8.14.3/8.14.3/Debian-9.4) with ESMTP id qBQKJkdp016897;
	Wed, 26 Dec 2012 21:19:46 +0100
Received: (from osimon@localhost)
	by xs8.xs4all.nl (8.14.3/8.14.3/Submit) id qBQKJimk016882;
	Wed, 26 Dec 2012 21:19:44 +0100
Content-Disposition: inline
In-Reply-To: <7vmwx0oavn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212148>

* Junio C Hamano <gitster@pobox.com> [2012-12-26 11:45:48 -0800]:

> Simon Oosthoek <s.oosthoek@xs4all.nl> writes:
> 
> > The optional third parameter when __git_ps1 is used in
> > PROMPT_COMMAND mode as format string for printf to further
> > customize the way the git status string is embedded in the
> > user's PS1 prompt.
> >
> > Signed-off-by: Simon Oosthoek <s.oosthoek@xs4all.nl>
> > ---
> 
> Thanks.
> 
> If we do not care about the existing users (and in this case,
> because PROMPT_COMMAND mode is in no released version, we could
> declare there is no existing user), another and simpler approach is
> to just drop " (" and ")" altogether and have the user give these as
> part of the pre/post strings.
> 

The problem with doing it in pre-post is when inside non-git directories. You want to avoid any gitstring output, including the brackets, when not inside a repository.

Doing it all in the third parameter is perhaps a better approach, but then it becomes mandatory instead of optional.

> Or we could go the other way and drop "pre/post" strings, making
> them part of the printf_format string.  Perhaps that might be a
> better interface in the longer term.  Then people can use the same
> "<pre>%s<post>" format string and do either of these:
> 
> 	PS1=$(__git_ps1 "<pre>%s<post>")
> 	PROMPT_COMMAND='PS1=$(__git_ps1 "<pre>%s<post>")'
> 
> without __git_ps1 having a special "prompt command" mode, no?

But how to determine which mode to use?
In pcmode, you must set the PS1, in command-subsitute mode, you must print a formatted gitstring.

> 
> I have a feeling that I am missing something major, though...

I think the fundamentally different way of setting the PS1 between the two modes is very confusing. Which is why I originally made a different function (with duplicated code) for both modes.


> 
> >  				if [ "$w" = "*" ]; then
> > -					PS1="$PS1\[$bad_color\]$w"
> > +					gitstring="$gitstring\[$bad_color\]$w"
> >  				fi
> 
> Every time I looked at this line, I wondered why '*' state is
> "bad".  Does a user go into any "bad" state by having a dirty
> working tree?  Same for untracked ($u) and detached.  These are all
> perfectly normal part of a workflow, so while choice of red may be
> fine to attract attention, calling it "bad" sounds misguided.


Well, I'm most often a really casual user of git and to make this function work the way I want to, I found out by trial-and-error that this was a way to test whether it's time to colour the string red or green ;-)

I'm very open to better ways to determine the colour modes. Anyway, the colours are now more or less the same as what git itself uses when printing the status with colour hints in git status.

Cheers

Simon
