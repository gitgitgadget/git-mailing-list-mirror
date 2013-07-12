From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: Cygwin, git and x: directory
Date: Fri, 12 Jul 2013 15:42:13 +0300
Message-ID: <20130712124213.GL14578@lakka.kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: cygwin@cygwin.com
X-From: git-owner@vger.kernel.org Fri Jul 12 14:42:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxcg0-00006S-RD
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 14:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932994Ab3GLMmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 08:42:17 -0400
Received: from mail.kapsi.fi ([217.30.184.167]:50737 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932937Ab3GLMmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 08:42:16 -0400
Received: from lakka.kapsi.fi ([2001:1bc8:1004::1] ident=Debian-exim)
	by mail.kapsi.fi with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <mikko.rapeli@iki.fi>)
	id 1Uxcfu-000879-2m; Fri, 12 Jul 2013 15:42:14 +0300
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.72)
	(envelope-from <mikko.rapeli@iki.fi>)
	id 1Uxcfu-0004Co-0B; Fri, 12 Jul 2013 15:42:13 +0300
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2001:1bc8:1004::1
X-SA-Exim-Mail-From: mikko.rapeli@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230197>

(please Cc: me in replies, not subscribed to the lists)

Hi Cygwin and git developers,

Does following scenario show signs of bugs in Cygwin and/or git?

# setup git repo
$ cd /tmp
$ mkdir foo && cd foo
$ git init

# create x: directory
$ mkdir x:
$ ls
x:

# create Windows X: drive, cygwin utils can work with both unix and dos style
# path names
$ mkdir c:/temp/bar
$ subst x: c:/temp/bar
$ touch x:/file.txt
$ ls x:/
file.txt

# clean git tree from non-tracked files
$ git clean -d -x -f
Removing x:/

# observe results, git did rm -rf on the X drive instead of the local
# directory named x:
$ ls
x:
$ file x\:
x:: directory
$ ls x:/
ls: cannot access x:/: No such file or directory
$ ls c:/temp/bar
ls: cannot access c:/temp/bar: No such file or directory
$ subst
X:\: => C:\temp\bar

In real life CMake created C: file in a build tree -- which is also a bug
but a separate one -- which resulted in obviously catastrophic results.

-Mikko
