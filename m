From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: Smart fetch via HTTP?
Date: Fri, 18 May 2007 12:01:59 -0700
Message-ID: <20070518190159.GS24644@ca-server1.us.oracle.com>
References: <20070515201006.GD3653@efreet.light.src> <20070517124006.GO4489@pasky.or.cz> <vpqlkfnipjl.fsf@bauges.imag.fr> <alpine.LFD.0.98.0705181123590.3890@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 18 21:03:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp7jv-00069e-7o
	for gcvg-git@gmane.org; Fri, 18 May 2007 21:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756611AbXERTDG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 15:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758755AbXERTDF
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 15:03:05 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:52946 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758526AbXERTDE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 15:03:04 -0400
Received: from rgmsgw01.us.oracle.com (rgmsgw01.us.oracle.com [138.1.186.51])
	by rgminet01.oracle.com (Switch-3.2.4/Switch-3.1.6) with ESMTP id l4IJ21Hr009566;
	Fri, 18 May 2007 13:02:01 -0600
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.48.5])
	by rgmsgw01.us.oracle.com (Switch-3.2.4/Switch-3.2.4) with ESMTP id l4IJ20cd008842
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 18 May 2007 13:02:00 -0600
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.63)
	(envelope-from <joel.becker@oracle.com>)
	id 1Hp7iB-0005y9-QM; Fri, 18 May 2007 12:01:59 -0700
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0705181123590.3890@woody.linux-foundation.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47632>

On Fri, May 18, 2007 at 11:27:22AM -0700, Linus Torvalds wrote:
> Well, we could try to support the git protocol over port 80..
> 
> IOW, it's probably easier to try to get people to use
> 
> 	git clone git://some.host:80/project
> 
> and just run git-daemon on port 80, than it is to try to set of magic cgi 
> scripts etc.

	Can we tech the git-daemon to parse the HTTP headers
(specifically, the URL) and return the appropriate HTTP response?

> And yes, I do realize that in theory you can have http-aware firewalls 
> that expect to see the normal http sequences in the first few packets in 
> order to pass things through, but I seriously doubt it's very common.

	It's not about packet scanning, it's about GET vs CONNECT.  If
the proxy allows GET but not CONNECT, it's going to forward the HTTP
protocol to the server, and git-daemon is going to see "GET /project
HTTP/1.1" as its first input.  Now, perhaps we can cook that up behind
some apache so that apache handles vhosting the URL, then calls
git-daemon which can take the stdin.  So we'd be doing POST, not GET.
	On the other hand, if the proxy allows CONNECT, there is no
scanning for HTTP sequences done by the proxy.  It just allows all raw
data (as it figures you're doing SSL).
	A normal company needs to have their firewall allow CONNECT to
9418.  Then git proxying over HTTP is possible to a standard git-daemon.

Joel

-- 

"The first requisite of a good citizen in this republic of ours
 is that he shall be able and willing to pull his weight."
	- Theodore Roosevelt

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
