From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Pretty format specifier for commit count?
Date: Mon, 19 Jan 2015 17:17:25 -0800
Message-ID: <20150120011724.GA1944@thin>
References: <20150119012926.GA24004@thin>
 <54BD0C85.1070001@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 02:17:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDNRo-0003oI-OW
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 02:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbbATBRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2015 20:17:32 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:54092 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbbATBRb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2015 20:17:31 -0500
Received: from mfilter21-d.gandi.net (mfilter21-d.gandi.net [217.70.178.149])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 71A06172070;
	Tue, 20 Jan 2015 02:17:29 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter21-d.gandi.net
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter21-d.gandi.net (mfilter21-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id O3u080KGoSr6; Tue, 20 Jan 2015 02:17:28 +0100 (CET)
X-Originating-IP: 50.43.58.154
Received: from thin (static-50-43-58-154.bvtn.or.frontiernet.net [50.43.58.154])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 2BA32172055;
	Tue, 20 Jan 2015 02:17:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <54BD0C85.1070001@drmicha.warpmail.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262646>

On Mon, Jan 19, 2015 at 02:54:13PM +0100, Michael J Gruber wrote:
> Josh Triplett schrieb am 19.01.2015 um 02:29:
> > I'd like to use git-log to generate a Debian changelog file (with one
> > entry per commit), which has entries like this:
> > 
> > package-name (version-number) unstable; urgency=low
> > 
> >  * ...
> > 
> >  -- Example Person <person@example.org>  RFC822-date
> > 
> > Since I'm intentionally generating one entry per commit, I can generate
> > *almost* all of this with git log:
> > 
> > git log --pretty='format:packagename (FIXME) unstable; urgency=low%n%n  * %s%n%w(0,4,4)%+b%w(0,0,0)%n -- %an <%ae>  %aD%n'
> > 
> > This produces entries like this:
> > 
> > packagename (FIXME) unstable; urgency=low
> > 
> >   * Example change
> > 
> >     Long description of example change.
> > 
> >  -- Josh Triplett <josh@joshtriplett.org>  Thu, 8 Jan 2015 16:36:52 -0800
> > 
> > packagename (FIXME) unstable; urgency=low
> > 
> >   * Initial version
> > 
> >  -- Josh Triplett <josh@joshtriplett.org>  Thu, 8 Jan 2015 16:36:51 -0800
> > 
> > Would it be possible to add a format specifier producing a commit count,
> > similar to that provided by git-describe?  Such a specifier would allow
> > filling in the version number in the format above (replacing the FIXME).
> > (Note that the version numbers need to monotonically increase; otherwise
> > I would just use the commit hash as the version numer.)
> > 
> > - Josh Triplett
> > 
> 
> Can you be a bit more specific about the type count that you are after?
> "git describe" counts commits since the most recent tag (possibly within
> a specific subset of all tags). Is that your desired format?

That might work, since the repository in question has no tags; I'd
actually like "commits since root commit".

I could imagine scenarios in which both "most recent tag" and "commits
since most recent tag" would be useful format specifiers; however, for
this use case, I'm looking for "commits since root commit".

> (I won't suggest scripting around rev-list, describe and log -1 because
> you know that already...)

Right.  Though as far as I can tell, git describe doesn't actually do
what I'm looking for.  rev-list --count $commit does (though that'd be
N**2), as would something like rev-list --reverse HEAD | nl | while read
count hash ; do ..., but I'd like to do better than that.

- Josh Triplett
