From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: Smart fetch via HTTP?
Date: Fri, 18 May 2007 14:56:07 -0700
Message-ID: <20070518215607.GT24644@ca-server1.us.oracle.com>
References: <20070515201006.GD3653@efreet.light.src> <20070517124006.GO4489@pasky.or.cz> <vpqlkfnipjl.fsf@bauges.imag.fr> <alpine.LFD.0.98.0705181123590.3890@woody.linux-foundation.org> <20070518190159.GS24644@ca-server1.us.oracle.com> <alpine.LFD.0.98.0705181312060.3890@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 18 23:57:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpARo-00072q-N2
	for gcvg-git@gmane.org; Fri, 18 May 2007 23:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760952AbXERV5K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 17:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760848AbXERV5J
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 17:57:09 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:62023 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759025AbXERV5I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 17:57:08 -0400
Received: from rgmsgw02.us.oracle.com (rgmsgw02.us.oracle.com [138.1.186.52])
	by agminet01.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id l4ILu8KP030834;
	Fri, 18 May 2007 16:56:08 -0500
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.48.5])
	by rgmsgw02.us.oracle.com (Switch-3.2.4/Switch-3.2.4) with ESMTP id l4ILu7dF011491
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 18 May 2007 15:56:08 -0600
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.63)
	(envelope-from <joel.becker@oracle.com>)
	id 1HpAQh-0001A2-Dx; Fri, 18 May 2007 14:56:07 -0700
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0705181312060.3890@woody.linux-foundation.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47662>

On Fri, May 18, 2007 at 01:13:36PM -0700, Linus Torvalds wrote:
> If it's _just_ the initial GET/CONNECT strings, yeah, we could probably 
> easily make the git-daemon just ignore them. That shouldn't be a problem.
> 
> But if there's anything *else* required, it gets uglier much more quickly.

	With CONNECT, there isn't anything.  That is, your
GIT_PROXY_COMMAND handles talking to the proxy, then gives git itself a
raw data pipe.  My proxy allows CONNECT to 9418, and that's how I use it
today.
	If you tried to make POST work (It'd be POST, not GET, as you
need to connect up the sending side), either apache would have to front
it for us, or "git-daemon --http" would have to accept the HTTP headers
on before the input, and output a proper HTTP response before sending
output.  Seeing the headers would allow for us to vhost, even.
	Hmm, but the proxy may not allow two-way communication.  Does
the git protocol have more than one round-trip?  That is:

Client:
    POST http://server.git.host:80/projects/thisproject HTTP/1.1
    Host: server.git.host

    fetch-pack <sha1>
    EOF

Server:
    200 OK HTTP/1.1
    
    <data>
    EOF

should work, I'd think.

Joel


-- 

"Ninety feet between bases is perhaps as close as man has ever come
 to perfection."
	- Red Smith

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
