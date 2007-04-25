From: Tim Ansell <mithro@mithis.com>
Subject: Problem with git-daemon and mmap.
Date: Wed, 25 Apr 2007 16:21:15 +0930
Organization: MITHIS
Message-ID: <1177483875.12689.22.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 25 09:13:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgbgS-0003B7-UW
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 09:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423248AbXDYHM6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 03:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423249AbXDYHM6
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 03:12:58 -0400
Received: from lester.mithis.com ([69.60.120.93]:33745 "EHLO lester.mithis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423248AbXDYHM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 03:12:57 -0400
X-Greylist: delayed 1275 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Apr 2007 03:12:57 EDT
Received: from [10.1.50.1] (ppp246-117.static.internode.on.net [203.122.246.117])
	by lester.mithis.com (Postfix) with ESMTP id 8ECCDB2BF
	for <git@vger.kernel.org>; Wed, 25 Apr 2007 02:51:18 -0400 (EDT)
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45502>

Hello,

I am trying to use git-daemon on a Debian stable machine. We converted
our repositories from darcs to git using tailor (which seemed to work
well). Most of the repositories work fine, however our web repository
which is quite large (about ~126Mb) is causing problems when trying to
clone via git-daemon.

The repository is public, you can find our gitweb here
 http://git.thousandparsec.net/gitweb/gitweb.cgi?p=web.git;a=summary

You can clone using the following URLs,
 http://git.thousandparsec.net/git/web.git
 git://git.thousandparsec.net/git/web.git
 git+ssh://<username>@git.thousandparsec.net/git/web.git

I can clone the repository fine locally (using both cg-clone and
git-clone) and with both git+ssh:// and http://

When trying to clone via git-daemon the git-daemon process dies with an
the following error (in the git-daemon logs - timestamps trimmed to make
the log more readable),

[30957] Connection from 203.122.246.117:20108
[30957] Extended attributes (29 bytes) exist
<host=git.thousandparsec.net>
[30957] Request upload-pack for '/git/web.git'
fatal: Out of memory? mmap failed: Bad file descriptor
error: git-upload-pack: git-rev-list died with error.
fatal: git-upload-pack: aborting due to possible repository corruption
on the remote side.
[30957] Disconnected (with error)

On the client side you see,
<snip>
remote: Generating pack...
remote: aborting due to possible repository corruption on the remote
side.
fatal: early EOF
fatal: index-pack died with error code 128
<snip>

After chatting with people on #git (on freenode) I was able to produce a
strace for this, you can find a copy of this strace log here,
http://www.thousandparsec.net/~tim/strace.log

The machine as only 512mb of Ram. It isn't running much else apart from
a few websites served via apache. Here is some more (hopefully useful)
information about the machine,
verbal:~# cat /proc/meminfo 
MemTotal:       500536 kB
MemFree:         20556 kB
<snip>
SwapTotal:     1542232 kB
SwapFree:      1542200 kB

verbal:~# dpkg --list | grep git
ii  cogito                           0.18.2-1
version control system
ii  git-core                         1.5.1.1-1
fast, scalable, distributed revision control
ii  git-daemon-run                   1.5.1.1-1
fast, scalable, distributed revision control
ii  gitweb                           1.5.1.1-1
fast, scalable, distributed revision control

verbal:~# git --version
git version 1.5.1.1

Hopefully this gives you enough information to track down this bug. I'm
happy to provide more information if needed. I'll also be on #git, but
I'm in Australia so you might have a hard time catching me.

 
Thank you for your time.

Tim Ansell
--
http://blog.mithis.net/ - Mithro Rants about Stuff
