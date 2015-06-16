From: Tad Hardesty <tad@platymuus.com>
Subject: 'git status -z' missing separators on OSX
Date: Tue, 16 Jun 2015 18:21:56 -0500
Message-ID: <5580AF94.6090801@platymuus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 01:42:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z50UU-00013S-4y
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 01:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbbFPXlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 19:41:36 -0400
Received: from txofep01.suddenlink.net ([208.180.40.71]:45018 "EHLO
	txofep01.suddenlink.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbbFPXle (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 19:41:34 -0400
X-Greylist: delayed 1198 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jun 2015 19:41:34 EDT
Received: from [192.168.1.41] (really [74.194.137.165])
          by txofep02.suddenlink.net
          (InterMail vM.8.04.03.20 201-2389-100-164-20150330) with ESMTP
          id <20150616232135.JWMD12816.txofep02.suddenlink.net@[192.168.1.41]>
          for <git@vger.kernel.org>; Tue, 16 Jun 2015 18:21:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
X-Cloudmark-Analysis: v=2.1 cv=JvB/raIC c=1 sm=0 tr=0 a=wPuOwISMbD0A:10 a=IkcTkHD0fZMA:10 a=oTt4DmRMAAAA:8 a=8LaAqv5HAAAA:8 a=XAFQembCKUMA:10 a=5Tg4r25XAAAA:8 a=PF_oduQi6pg6K4IMhFEA:9 a=QEXdDO2ut3YA:10 a=KgsXq9Tu5zEA:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271805>

I have been experiencing a problem where git on OSX prints incorrect
output to the `git status -z` command, where instead of NUL separators
records are simply not separated. This is causing problems with IDE
integration. While I have a workaround involving manually replacing \n
with \0, it would be nice to identify and fix the root issue.

Here's a terminal session showing the problem:
~$ mkdir test && cd test
~/test$ git init
Initialized empty Git repository in /Users/thardesty/test/.git/
~/test (master #)$ touch a b
~/test (master #)$ ls
a b
~/test (master #)$ git status -z | hexdump -C
00000000  3f 3f 20 61 3f 3f 20 62                           |?? a?? b|
00000008
~/test (master #)$ git add a b
~/test (master #)$ git status -z | hexdump -C
00000000  41 20 20 61 41 20 20 62                           |A  aA  b|
00000008
~/test (master #)$ git status --porcelain | hexdump -C
00000000  41 20 20 61 0a 41 20 20  62 0a                    |A  a.A  b.|
0000000a
~/test (master #)$ git --version
git version 2.4.3
~/test (master #)$ uname -a
Darwin HA002070 14.3.0 Darwin Kernel Version 14.3.0: Mon Mar 23 11:59:05
PDT 2015; root:xnu-2782.20.48~5/RELEASE_X86_64 x86_64

As shown, --porcelain prints a newline but -z yields no separator at all.

The Mac is running OS X Yosemite 10.10.3. I have tried git 2.3.2 from
Apple, git 2.4.2 from brew, and git 2.4.3 from brew, git-scm.org, and
self-compiled, and these all exhibit the problem. Some helpful folks on
the #git IRC tried the commands for me and didn't see any problems, but
I temporarily blanked all my configuration files and that didn't help. I
double-checked and git on Linux has the correct behavior.

Thanks for any help.
