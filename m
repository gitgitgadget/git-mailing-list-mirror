From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: [GSoC update extra!] git-remote-svn: Week 13
Date: Fri, 6 Aug 2010 00:43:28 +1000
Message-ID: <0C6B8C5E-15BA-43AD-B2F2-914F39EA6046@cordelta.com>
References: <20100730190124.GA2995@kytes>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 16:54:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh1pn-0007JU-3V
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 16:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933326Ab0HEOyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 10:54:09 -0400
Received: from ironport1-mx.cbr1.mail-filtering.com.au ([203.88.115.241]:51329
	"EHLO ironport1-mx.cbr1.mail-filtering.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754060Ab0HEOyH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 10:54:07 -0400
X-Greylist: delayed 629 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Aug 2010 10:54:07 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAJdqWkzLWHsF/2dsb2JhbACgOHG8X4hNhToE
X-IronPort-AV: E=Sophos;i="4.55,321,1278252000"; 
   d="scan'208";a="216710438"
Received: from node2.alpha.aussiehq.net.au ([203.88.123.5])
  by ironport1-mta.cbr1.mail-filtering.com.au with ESMTP; 06 Aug 2010 00:43:30 +1000
Received: (qmail 28128 invoked from network); 6 Aug 2010 00:43:29 +1000
Received: from d110-33-90-139.mit3.act.optusnet.com.au (HELO ?192.168.1.2?) (110.33.90.139)
  by node2.alpha.aussiehq.net.au with SMTP; 6 Aug 2010 00:43:29 +1000
In-Reply-To: <20100730190124.GA2995@kytes>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152661>

Hi,

> I just got a proof-of-concept loader for Subversion working. It just
> about works for a very small reduced case. I'll still have to hammer
> it into shape for to handle various cases [1]. In the meantime, we
> also have to start working on doing the inverse of what
> svn-dump-fast-export does: convert a Git fast-export stream to a
> Subversion dumpfile.
> 
> David: Can you estimate how challenging the task is going to be?

Ram, sorry for the late reply, I've been rather sick this week.

Assuming that the fast-export stream will be already linearised...
I think it will be more complex than svn-fe even with that constraint.
The reason being that going from git to subversion there is a
general increase in redundant data.
While svn-fe preserves much of the redundancy of the original svn
dump stream, git is able to eliminate much of it.
On the other hand, to produce an svn dump stream we may need
to repeat elements encountered earlier in the fast-export stream.
We may be able to achieve a simple implementation by placing
further restrictions on the form of the fast-export stream.

> [1]: I'm working on it directly in trunk. You can find the latest code
> in subversion/svnrdump in the Subversion trunk.
> 
> -- Ram

On a related note, I've found a defect in the svn dump stream design.
Truncation of an svn dump may result in a valid stream with an
incomplete trailing commit. Even more fun is that when svnrdump
encounters an error in the middle of handling a commit, it will likely
produce such a stream. I broked my ASF mirror by loading an
incomplete incremental dump. :(

TODO: cross-post the last paragraph to svn-dev.

-- David Barr.
