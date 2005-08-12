From: Mitchell Blank Jr <mitch@sfgoth.com>
Subject: Re: gitweb - feature request
Date: Fri, 12 Aug 2005 14:16:00 -0700
Message-ID: <20050812211600.GA61428@gaz.sfgoth.com>
References: <20050809193104.GA10858@mars.ravnborg.org> <20050809195818.GA19284@vrfy.org> <1123653220.1183.26.camel@azathoth.hellion.org.uk> <20050810083113.GN49964@gaz.sfgoth.com> <20050812203322.GB9696@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ian Campbell <ijc@hellion.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 23:10:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3gmS-0007mo-Iz
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 23:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbVHLVJ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 17:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVHLVJ3
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 17:09:29 -0400
Received: from gaz.sfgoth.com ([69.36.241.230]:25086 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S932090AbVHLVJ3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2005 17:09:29 -0400
Received: from gaz.sfgoth.com (localhost.sfgoth.com [127.0.0.1])
	by gaz.sfgoth.com (8.12.10/8.12.10) with ESMTP id j7CLG0i0061826;
	Fri, 12 Aug 2005 14:16:00 -0700 (PDT)
	(envelope-from mitch@gaz.sfgoth.com)
Received: (from mitch@localhost)
	by gaz.sfgoth.com (8.12.10/8.12.6/Submit) id j7CLG0ID061825;
	Fri, 12 Aug 2005 14:16:00 -0700 (PDT)
	(envelope-from mitch)
To: Kay Sievers <kay.sievers@vrfy.org>
Content-Disposition: inline
In-Reply-To: <20050812203322.GB9696@vrfy.org>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Fri, 12 Aug 2005 14:16:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Kay Sievers wrote:
> It's 30 now and up to 150 if they are not older than 48 hours.
> We can change the numbers, if you hava a better idea...

Is it really hard to just make it purely time-based (git-rev-list --max-age)?
Think of if Linus is merging with a lot of people and then pushes the results
to the master repository -- suddenly there's, say, 400 new commits since the
last time my aggregator checked 2 hours ago.

> For now it just lists all changed files to the log message, similar to the
> "commit" view. Is that ok, or do we really need the diffstat,

It looks great, thanks!  diffstat would be slightly nicer but not a big
deal.

> It may be
> a bit expensive to generate it for all the commits with every RSS request...

Well if the RSS feed's popularity takes off you'll probably want to *not*
generate it every time and instead serve it from a static file.  This can
be as simple as a Makefile like:

	commits.rss: $(GITDIR)/refs/heads/master
		/path/to/myperlscript.pl $(GITDIR) > commits.rss.NEW && chmod 444 commits.rss.NEW && mv commits.rss.NEW commits.rss

and then call "make -C /my/rss/dir -s -f /path/to/mymakefile.mk" from cron
every minute.

Serving the rss from a static file has the big advantage that a well-behaved
aggregator will only request it if the modification date changed which saves
everyone bandwidth.

-Mitch
