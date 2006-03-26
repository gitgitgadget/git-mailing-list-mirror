From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/4] send-email: Change from Mail::Sendmail to Net::SMTP
Date: Sat, 25 Mar 2006 16:54:24 -0800
Message-ID: <20060326005424.GA1773@localdomain>
References: <11432834101430-git-send-email-normalperson@yhbt.net> <11432834102700-git-send-email-normalperson@yhbt.net> <20060325235859.GO26071@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git <git@vger.kernel.org>,
	Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Sun Mar 26 01:54:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNJWW-0008NZ-Nb
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 01:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWCZAy0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 19:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWCZAy0
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 19:54:26 -0500
Received: from hand.yhbt.net ([66.150.188.102]:19854 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932167AbWCZAyZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 19:54:25 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 55A5E2DC033;
	Sat, 25 Mar 2006 16:54:24 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 25 Mar 2006 16:54:24 -0800
To: Ryan Anderson <ryan@michonline.com>
Content-Disposition: inline
In-Reply-To: <20060325235859.GO26071@mythryan2.michonline.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18012>

Ryan Anderson <ryan@michonline.com> wrote:
> On Sat, Mar 25, 2006 at 02:43:30AM -0800, Eric Wong wrote:
> > Net::SMTP is in the base Perl distribution, so users are more
> > likely to have it.  Net::SMTP also allows reusing the SMTP
> > connection, so sending multiple emails is faster.
> 
> Overall, I like this set of cleanups, just one thing struck me as,
> "why?"
> 
> >  	if ($quiet) {
> > -		printf "Sent %s\n", $subject;
> > +		print "Sent $subject\n";
> 
> This seems to be a pointless change, and actually, might be long-term
> counterproductive.

Force of habit, I think.  I originally rewrote that portion but thought
I reverted it back to the way it was.  Besides, it's even slightly
faster this way :)  It could still be faster(!) if I just printed a list
(like below).

> Assumption: Eventually, we're going to want to internationalize git.
> 
> If that is true, we'll eventually do something like this to lines like
> that:
> 	printf( gettext("Send %s\n"), $subject);
> 
> The alternative:
> 	print gettext("Send $subject\n");
> does not work.

print gettext('Send '),$subject,"\n";

> (The line that xgettext will see is 'Send $subject\n', but when the
> program actually runs, gettext will see the interpolated version, which
> fails.)
> 
> Internationalization may still be a ways off, but I think we're reaching
> the point where it might be something we care to think about.

-- 
Eric Wong
