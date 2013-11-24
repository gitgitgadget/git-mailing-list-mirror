From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: error: git-remote-https died of signal 13
Date: Sun, 24 Nov 2013 23:13:05 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1311242310050.3070@tvnag.unkk.fr>
References: <5290D994.9040505@googlemail.com> <20131124065400.GB5535@sigill.intra.peff.net> <5291F70A.7070508@googlemail.com> <20131124133356.GA3507@sigill.intra.peff.net> <529214D7.1030203@googlemail.com> <20131124155439.GA8047@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 24 23:20:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vki2m-0000rL-Pq
	for gcvg-git-2@plane.gmane.org; Sun, 24 Nov 2013 23:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005Ab3KXWUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Nov 2013 17:20:40 -0500
Received: from giant.haxx.se ([80.67.6.50]:41807 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756Ab3KXWUj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 17:20:39 -0500
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Nov 2013 17:20:39 EST
Received: from giant.haxx.se (dast@localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-4.1) with ESMTP id rAOMD61k020999
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Nov 2013 23:13:06 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id rAOMD5Q2020994;
	Sun, 24 Nov 2013 23:13:05 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20131124155439.GA8047@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238269>

On Sun, 24 Nov 2013, Jeff King wrote:

> Hmm. The fix in curl's 7d80ed64e435155 seems to involve strategically placed 
> calls to ignore SIGPIPE. I wonder if there is another spot that needs 
> similar treatment. It looks like curl_easy_cleanup is covered, though, and 
> that's where I would expect problem to come.

Sounds like a plausible reason.

> It would be interesting to see a backtrace from remote-curl when we get the 
> SIGPIPE. Doing so would be slightly tricky; instrumenting with the patch 
> below may be enough.
>
> Another thought is that the curl fix seems to only kick in when built with 
> openssl support.  I'm not sure I understand how ubuntu's packaging of curl 
> uses gnutls versus openssl for the shared library. That may be related.

I'm only aware of a SIGPIPE problem with openssl that can make it write to the 
socket in some situations when the remote end is no longer there - something 
we can't prevent it from doing.

I *believe* the problem doesn't exist in the similar way when built to use 
gnutls, but I may of course be wrong.

-- 

  / daniel.haxx.se
