From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Cygwin and git 1.5.0
Date: Sat, 03 Mar 2007 18:22:24 +0000
Message-ID: <45E9BCE0.7070704@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <junkio@cox.net>,
	GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 03 20:23:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNZp2-0005rU-Kb
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 20:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbXCCTWz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 14:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030387AbXCCTWz
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 14:22:55 -0500
Received: from anchor-fallback-95.mail.demon.net ([194.217.242.82]:50344 "EHLO
	anchor-fallback-95.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030383AbXCCTWy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Mar 2007 14:22:54 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:2185 "EHLO
	anchor-post-31.mail.demon.net") by anchor-fallback-95.mail.demon.net
	with ESMTP id S472087AbXCCS0L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 18:26:11 +0000
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-31.mail.demon.net with esmtp (Exim 4.42)
	id 1HNYtK-000AwF-4G; Sat, 03 Mar 2007 18:23:35 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41315>

Hi Junio,

At the end of last year I finally bought a new laptop (yay!). Much to my
surprise, I haven't yet got around to installing Linux (The Ubuntu live DVD
is the only one I have found which "works"; but it's so *slow* as to be
unusable, so I still don't know if all my h/w works with it).

However, almost the first thing I did was to install Cygwin, which I have been
using on windows since about beta-20 (back in the days of cygnus solutions).
Cygwin has its problems, but I could not use windows without it.

So naturally I tried building git on Cygwin (copying my git repo over from
my old Linux system). I have to say that, after some initial problems, it
went rather well. (hint: don't use a working directory backed up from Linux
on cygwin; "make clean" didn't - among other things!).

I recently upgraded git using the 1.5.0 tarball. (Yes, since I now have git on
windows, where I can access the internet, I could clone the git repo directly.
However, since I'm still on dial-up, I can't spare the bandwidth. Maybe I will
try shallow clone sometime.)

As far as git 1.5.0 is concerned, the build/test went with only minor problems.
I had to disable test t4016-diff-quote.sh, because it used tabs and LFs in filenames.
I note that Alex Riesen already sent you a patch to cover that, so I won't send
another one.

However, since I like to have "ALL_CFLAGS+= -Werror" in my config.mak file, I had
to get rid of the gcc warnings. This resulted in the following patch series:

[PATCH 1/6] Fix some "printf format" warnings.
[PATCH 2/6] Unset (comment out) NO_C99_FORMAT on Cygwin.
[PATCH 3/6] Fix a "label defined but unreferenced" warning.
[PATCH 4/6] Fix an "implicit function definition" warning.
[PATCH 5/6] Fix some "comparison is always true/false" warnings.
[PATCH 6/6] Fix a "pointer type missmatch" warning.

As I note in the [PATCH 2/6] email, I should have deleted that setting from the
Makefile, rather than commenting it out, but I didn't have the energy to re-do
all the commits/emails. ;-)

The patches are against 1.5.0 tarball which, hopefully, is not so long ago as to
make them impossible to apply. Also, I'm hoping that my mail client (thunderbird 1.5.0.2)
has not caused any whitespace damage. (I can resend as attachments if required).

Also, I noticed that some recent changes seem to have made NO_C99_FORMAT somewhat
redundant. I _suspect_ that the unconditional #include-ing of the C99 headers
<inttypes.h> and (therefore also) <stdint.h>, has made it necessary to use a
compiler/library combination which has pretty good, if not full, C99 support.
IOW, if it has those headers, it almost definitely supports the C99 printf format
specifiers. For example, my old Linux system would not be able to compile the
current git. (Has anybody tried on SunOS 5.8 and 5.9?)

This is not a problem, but I do wonder if it was a conscious decision.

All the Best,

Ramsay Jones
