From: Jeff King <peff@peff.net>
Subject: Re: can not clone via git:// anymore
Date: Wed, 4 Mar 2009 09:24:59 -0500
Message-ID: <20090304142459.GB17874@coredump.intra.peff.net>
References: <49AE64F2.1090405@cetrtapot.si> <49AE7B23.1070008@drmicha.warpmail.net> <49AE8208.7090204@cetrtapot.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
X-From: git-owner@vger.kernel.org Wed Mar 04 15:26:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Les3T-0003Wp-Ea
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 15:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbZCDOZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 09:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbZCDOZJ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 09:25:09 -0500
Received: from peff.net ([208.65.91.99]:39177 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227AbZCDOZI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 09:25:08 -0500
Received: (qmail 24786 invoked by uid 107); 4 Mar 2009 14:25:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 04 Mar 2009 09:25:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Mar 2009 09:24:59 -0500
Content-Disposition: inline
In-Reply-To: <49AE8208.7090204@cetrtapot.si>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112216>

On Wed, Mar 04, 2009 at 02:28:40PM +0100, Hinko Kocevar wrote:

> git-daemon was/is running:
> 
> CETRTAPOT\zidarhw@zidar:~$ ps -ef | grep git
> root      3207     1  0 14:15 ?        00:00:00 runsvdir -P /etc/service log: d user: `gitlog:adm'?chown: invalid user: `gitlog:adm'?chown: invalid user: `gitlog:adm'?chown: invalid user: `gitlog:adm'?chown: invalid user: `gitlog:adm'?chown: invalid user: `gitlog:adm'?chown: invalid user: `gitlog:adm'?chown: invalid user: `gitlog:adm'?chown: invalid user: `gitlog:adm'?chown: invalid user: `gitlog:adm'?chown: invalid user: `gitlog:adm'?chown: invalid user: `gitlog:adm'?
> root      3208  3207  0 14:15 ?        00:00:00 runsv git-daemon
> root      3373  3208  0 14:16 ?        00:00:00 git-daemon --verbose --base-path=/var/cache /var/cache/git
> 11418     3399  2762  0 14:16 pts/0    00:00:00 grep git

See all the runsvdir errors? That probably means that git-daemon's log
output is going nowhere, since the log is not running. Which means
eventually the pipe from git-daemon to the log will get full, and
git-daemon will block writing out the log. And then stop dealing with
requests.

So even if restarting helps now, it may fill up again unless you fix the
logging problem (presumably by creating the right "gitlog" user).

-Peff
