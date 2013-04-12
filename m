From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Git crash in Ubuntu 12.04
Date: Fri, 12 Apr 2013 18:05:25 +0400
Message-ID: <20130412180525.aa5b8eacd691a427244d6ab5@domain007.com>
References: <CAJiNi_FfU9Gsr2D9CcC0wWwgO1oKBXwxp87-wBUJBU2kyGaQNQ@mail.gmail.com>
	<87mwt6ltia.fsf@linux-k42r.v.cablecom.net>
	<CAJiNi_EgjgKs7oNJyGcamUFz=ARDAuBTb+bJ0uVsPFBMbZF3YA@mail.gmail.com>
	<20130411170659.a35d2c581cf34ade13448bfa@domain007.com>
	<CAJiNi_Gju2aJkVJJmoxnEAubfPvjaVhVF6DisaLn5kUJ3YRD=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
To: Sivaram Kannan <siva.devel@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 16:05:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQebv-0007sA-N7
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 16:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290Ab3DLOFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 10:05:47 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:46844 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab3DLOFq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 10:05:46 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r3CE5PBD003873;
	Fri, 12 Apr 2013 18:05:26 +0400
In-Reply-To: <CAJiNi_Gju2aJkVJJmoxnEAubfPvjaVhVF6DisaLn5kUJ3YRD=w@mail.gmail.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220980>

On Fri, 12 Apr 2013 18:58:24 +0530
Sivaram Kannan <siva.devel@gmail.com> wrote:

> > ^^^ Try to issue the
> >
> > $ ulimit -c unlimited
> 
> Have set the git user's crash limit to 1GB in
> /etc/security/limits.conf and still getting the same error when
> issuing gdb to the crash file.

Yep, suppsedly in Ubuntu it's not that easy to just get a plain old
coredump file -- see below.

> > command in your shell before attempting the cloning -- this should
> > remove the upper limit on the core file size.  And try look for the
> > core file in the current directory after the crash occurs.  I'm not
> > sure Ubuntu's "crash interceptor" won't kick in, but just in case...
> 
> You mean, /usr/bin/git? crash file for git is getting created each
> time it crashes in /var/crash.
> 
> Can you please tell me what else I could try?

Googling for "ubuntu+disable+crash" turns up that your Git crashes are
handled by a system-wide tool called "apport" [1].

Considering this, I would try to explore two routes:

* [1] Tells that apport has a special tool, apport-retrace, which is
  said to be able to download available matching debug packages, if
  any, and generate the stack traces.  Basically this would do what
  Thomas advised you to attempt to do using GDB.

* Try to disable apprort permanently and then crash Git normally,
  so that apport does not interfere with the crash and the kernel is
  able to generate a regular core file in your current directory.
  Be sure to verify the core-file-size limit has a sensibly large
  value in your shell before attempting to do that.

> Would upgrading to the 1.8.2.1 - latest in Ubuntu PPA would help?

Yes, this is a viable way to try solving the problem.
*But* there's a downside: the crash you're experiencing might affect
later Git versions as well as yours.  And if you just throw your hands
there, the bug will continue to be unfixed.  Hence I urge you to be a
good F/OSS user and help the Git devs investigate the case.

1. https://wiki.ubuntu.com/Apport
