From: "Thomas Perl" <th.perl@gmail.com>
Subject: Re: Pingback/Trackback for Git?
Date: Wed, 4 Jul 2007 11:59:50 +0200
Message-ID: <372f54da0707040259kd034b79ofa41b46611052bee@mail.gmail.com>
References: <372f54da0707030512k79e2dc74m98bf0a690abffc4a@mail.gmail.com>
	 <7vbqeslpnz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 11:59:55 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I61eN-0006id-6d
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 11:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757988AbXGDJ7x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 05:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757567AbXGDJ7x
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 05:59:53 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:47925 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757390AbXGDJ7w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 05:59:52 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2037726wxd
        for <git@vger.kernel.org>; Wed, 04 Jul 2007 02:59:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s5AWgncHyXwmtzKIyIFla3RaacRuDEusTcEhTb30g3NAQo9b5IeSZy4N1YPPT/xcyc5gZppzpSSIKAy2MoeIjspXOIFL6q/RcM+9hQaFX0zAuuMu0Xh2m3JdQLrb1rY1nqz9J2uxoIsn+zDpqpVhAj0cJ4z27smacI4F7PHhgXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YsVpz7aevitwj3aDd8C3xSA1xPBB1rNpSBvNvC6BGrryvOGJdc2SzxvozEd86PQw54yJYSV2dbXWxePQ9v292FrcHEfYeDDjprGnKctL0bOnwPpIybiy98HERiflSSmib8aBTAwqV54BY4OZxdy+uvFw0MjJz82VZmlGlMsbpKM=
Received: by 10.90.75.10 with SMTP id x10mr6967336aga.1183543190830;
        Wed, 04 Jul 2007 02:59:50 -0700 (PDT)
Received: by 10.90.114.20 with HTTP; Wed, 4 Jul 2007 02:59:50 -0700 (PDT)
In-Reply-To: <7vbqeslpnz.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51586>

Hello, Junio!

2007/7/4, Junio C Hamano <gitster@pobox.com>:
> It was unclear to me who does what and when in the overall
> picture you envision after reading that page.  You seem to
> assume there is a prominent ping/trackback repository that
> everybody who is interested looks at.  Who updates it?  When?
> With what?  How does the namespace inside that repository
> managed, if managed in any way?  Given a project name, how does
> one learn which pick/grackback repository (and perhaps which
> branch) to go to to learn the current status about it?

Every repository keeps track of the pingbacks it receives. The
simplest way of storing all pingbacks would be a simple text file that
lists one repository per line in a URL, i.e.

http://git.server.com/repos/game.git
git://mirrors.git-hosting.com/ga/game.git
http://johnny.org/my-projects/game.git
http://universityx.edu/~bob/src/game.git

If a user clones a repository, it can copy this trackback list. Git
can also optionally use this list to fetch objects from multiple
servers to increase performance (imagine an upstream git:// repository
with a forked http:// repository that has packs, the client could use
the git:// repository for fetching as much single object as possible
and only using the forked repository for all objects not yet found in
the upstream repository).

Sending a pingback should append the pinging repository URL to the
pinged repository's list (see above). Before appending the URL, the
pinged repository should check if the URL exists and if there is a Git
repository at the given URL and if the pinging repository is based on
the pinged repository.

There is not a single repository with pingbacks/trackbacks, but every
repository has its own list of "related" repositories. So when I'm
interested in the repository from project at URL "X", I can fetch its
repository or only its mirror list and get a list of URLs that also
carry (derived) versions of the project at URL "X".

Of course, your idea with having a centralized repository (that only
stores URLs) would be nice when an upstream Git repository dies to
find some other repository where the data is still available:

1) Clone repository from URL "X"
2) 404 -- not found
3) Get list of mirrors from URL repository
4) Download repository from other URL

But that defeats some gains from a truly distributed vcs, so just
keeping track of a list of  URLs that cloned from this repository
should be enough.
