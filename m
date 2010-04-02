From: Frans Pop <elendil@planet.nl>
Subject: 'git gc --aggressive' effectively unusable
Date: Sat, 3 Apr 2010 00:05:35 +0200
Message-ID: <201004030005.35737.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 03 00:20:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxpDb-0001Z2-Lc
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 00:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433Ab0DBWTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 18:19:55 -0400
Received: from Cpsmtpm-eml109.kpnxchange.com ([195.121.3.13]:58365 "EHLO
	CPSMTPM-EML109.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755238Ab0DBWTx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 18:19:53 -0400
X-Greylist: delayed 856 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Apr 2010 18:19:53 EDT
Received: from aragorn.fjphome.nl ([77.166.180.99]) by CPSMTPM-EML109.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Sat, 3 Apr 2010 00:05:35 +0200
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-OriginalArrivalTime: 02 Apr 2010 22:05:35.0933 (UTC) FILETIME=[9F217ED0:01CAD2B0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143858>

Note: this is on a different repo from the 'git reflog expire --all' I
reported a bit earlier.

I have a git-svn checkout of a subversion repo which I wanted to compress
as much as possible. 'git gc --aggressive' starts to run fairly well, but
eats more and more memory and gets slower and slower. After it gets to
about 45% or 50% progress slows down noticeably and so far I haven't had
the patience to let it finish (40 minutes is already way too long).

A regular 'git gc' run completes without any problems.

$ du -sh .git/
612M    .git/

Special about this repo is that it contains two huge objects [1], which
could maybe be a factor:
     size    pack  SHA
- packages/po/sublevel4/da.po:
     495661  4654  801cd6451ece536c0ab41f79e09fc52efdf3361f
- packages/arch/powerpc/quik-installer/debian/po/da.po
     149515  1403  83a787b20817dc4d72db052de4055e7a7c9221d7  

Below some output from top and of the progress of the command showing the
problem. Check the change in number of compressed objects against the
timestamps from top.

Cheers,
FJP

[1] Caused by a bug in a script a couple of years back.

$ git gc --aggressive

Counting objects: 843342, done.
Delta compression using up to 2 threads.
Compressing objects:  53% (449663/836424)

top - 22:55:02 up 18 min,  1 user,  load average: 1.83, 1.68, 1.07
Tasks: 161 total,   1 running, 160 sleeping,   0 stopped,   0 zombie
Cpu0  : 91.4%us,  0.7%sy,  0.0%ni,  1.3%id,  6.6%wa,  0.0%hi,  0.0%si,  0.0%st
Cpu1  : 97.7%us,  0.3%sy,  0.0%ni,  1.3%id,  0.7%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:   2034284k total,  2018288k used,    15996k free,    10188k buffers
Swap:  2097148k total,    22612k used,  2074536k free,   449444k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5861 fjp       20   0 1775m 1.3g 194m S  188 66.7  21:10.89 git


Counting objects: 843342, done.
Delta compression using up to 2 threads.
Compressing objects:  58% (486001/836424)

top - 23:00:12 up 23 min,  1 user,  load average: 1.96, 1.84, 1.30
Tasks: 158 total,   2 running, 156 sleeping,   0 stopped,   0 zombie
Cpu0  : 98.3%us,  0.7%sy,  0.0%ni,  0.7%id,  0.3%wa,  0.0%hi,  0.0%si,  0.0%st
Cpu1  : 87.4%us,  1.7%sy,  0.0%ni,  0.0%id, 10.6%wa,  0.0%hi,  0.3%si,  0.0%st
Mem:   2034284k total,  2017516k used,    16768k free,     4696k buffers
Swap:  2097148k total,    22572k used,  2074576k free,   336944k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5861 fjp       20   0 1903m 1.4g 172m S  182 71.4  30:37.58 git


Counting objects: 843342, done.
Delta compression using up to 2 threads.
Compressing objects:  61% (515958/836424)

top - 23:05:56 up 29 min,  1 user,  load average: 1.68, 1.85, 1.48
Tasks: 159 total,   1 running, 158 sleeping,   0 stopped,   0 zombie
Cpu0  : 86.7%us,  1.7%sy,  0.0%ni,  2.0%id,  9.7%wa,  0.0%hi,  0.0%si,  0.0%st
Cpu1  : 96.7%us,  0.0%sy,  0.0%ni,  0.7%id,  2.7%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:   2034284k total,  2018644k used,    15640k free,     2748k buffers
Swap:  2097148k total,    24312k used,  2072836k free,   343256k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5861 fjp       20   0 1903m 1.4g 189m S  176 72.3  40:29.50 git
