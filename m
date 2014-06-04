From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: [PATCH] Add a Windows-specific fallback to
 getenv("HOME");
Date: Wed, 4 Jun 2014 17:56:23 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1406041749590.14982@s15462909.onlinehome-server.info>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com> <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com> <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info>
 <CABPQNSavYCrdUDyNru-HHMFkdgDRvaCp++f8ZgGKv07sS0eXGQ@mail.gmail.com> <alpine.DEB.1.00.1406041725460.14982@s15462909.onlinehome-server.info> <20140604154503.GB22681@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Jun 04 17:56:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsDYF-0007XR-NJ
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 17:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbaFDP41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 11:56:27 -0400
Received: from mout.gmx.net ([212.227.15.15]:53168 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751945AbaFDP40 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 11:56:26 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0MC4R6-1X13Em1LSC-008ujD;
 Wed, 04 Jun 2014 17:56:24 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20140604154503.GB22681@camelia.ucw.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:FBStTmFBwY9fJxcDBY5gQ1gxHxac1hbTpVl0FW5KU4VFxs8rWLI
 HWMglQHDqb7A0oZoD6dfx7Urg9osY6cgzQO1Q4xZC6fb5fjdGT45yu30FthGmQITeXsw92D
 WsLW3B26tO6BjdayZr4MwMkEhdJklv3rtNOxtUPHAYa76M3uK13kA3xTX7fV7VnG2aO76Ff
 cqlbTq2emOU73rcvZpwkg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250743>

Hi Stepan,

On Wed, 4 Jun 2014, Stepan Kasal wrote:

> > > On Wed, Jun 4, 2014 at 5:14 PM, Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
> > > > No. Git is not always called through Bash or the git-wrapper,
> > > > unfortunately.
> 
> but you have to admit, that in most cases it is called through bash or
> the git wrapper.

It would seem so. But the plan was always to make the user experience on
Windows less abysmal than now (I just do not have enough time these days
to pursue that goal myself), which includes the goal to make git.exe the
main entrance point, not Bash nor the git-wrapper.

> > The problem arises whenever git.exe calls subprocesses. You can pollute
> > the environment by setting HOME, I do not recall the details, but I
> > remember that we had to be very careful *not* to do that, hence the patch.
> > Sorry, has been a long time.
> 
> Yeah, memories.

*Very* vague. Sorry.

> Is this experience still valid?  How many users do profit from this,
> using c:/Program\ Files \(86\)/bin/git.exe instead of c:/Program\ Files
> \(86\)/cmd/git.exe, either by pure luck or intentionally?

Keep in mind that the most problems were introduced by the fact that
USERPROFILE disagrees with HOMEDRIVE\HOMEPATH at times.

> It seems that we should keep the patch, to minimize surprise if
> bin/git.exe is used directly.

I am also in favor of keeping the patch because it introduces a bit of
documentation. It says pretty precisely what it wants and allows
platform-specific handling without having to play games with the
environment, as was suggested earlier.

And of course you cannot deny that it had four years of testing. The HOME
problems never came back after we included this patch.

> But we should probably make it consistent with other places:
> - $HOMEDRIVE$HOMEPATH (without the slash)
> - $USERPROFILE if the above dir does not exist.
> - setenv HOME instead of wrapper

Possibly. But again, it is hard to argue with four years of testing. Any
change you make now will lack that kind of vetting.

> We can make this change for msysGit 2.0.0 only, so that we do not
> break 1.9.4 ;-)

So we can break 2.0.0! ;-)

Actually, 2.0.0 for Windows needs to wait a little longer (it is a little
bit unfortunate that we could not coordinate it with upstream) because the
plan is to switch to mingwGitDevEnv for said release. No more msysGit.
Like, bu-bye. Thanks for all the fish.

Ciao,
Dscho
