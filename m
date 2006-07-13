From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH 2/5] daemon: if one of the standard fds is missing open it to /dev/null
Date: Thu, 13 Jul 2006 18:03:26 +0200
Message-ID: <E1G13ew-0005Iv-ST@moooo.ath.cx>
References: <E1G0zj7-0001c1-8q@moooo.ath.cx> <E1G0znB-0002IO-61@moooo.ath.cx> <118833cc0607130837u30c58d53lc785f56d45ef970c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 18:03:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G13f6-0003mc-Rd
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 18:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWGMQDc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 12:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWGMQDc
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 12:03:32 -0400
Received: from moooo.ath.cx ([85.116.203.178]:19361 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751053AbWGMQDb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 12:03:31 -0400
To: Morten Welinder <mwelinder@gmail.com>
Mail-Followup-To: Morten Welinder <mwelinder@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <118833cc0607130837u30c58d53lc785f56d45ef970c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23839>

Morten Welinder <mwelinder@gmail.com> wrote:
> >+               if (devnull == -1 &&
> >+                       (devnull = open("/dev/null", O_RDWR, 0)) == -1)
> >+                       die("open /dev/null failed: %s", strerror(errno));
> >+               if (dup2(devnull, i) != i)
> >+                       die("dup2 failed: %s", strerror(errno));
> 
> "die" probably won't work well at this point.
At least with --syslog there will be an error message in the logs.
If the user does not use --syslog and closes fd 2 it is just his own
fault imho.

> Should git (and most other programs) do something like this in general?
> fprintf will happily write to fd=2 regardless of whether that is some critical
> file you opened.
I thought of that too.  It might be not that important because I
cannot think of anyway that this could happen accidentally or could be
exploited.
