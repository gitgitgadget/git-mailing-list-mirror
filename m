From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: "make test" works again (sort-of) on cygwin.
Date: Thu, 03 Jul 2008 18:44:28 +0100
Message-ID: <486D0FFC.5090308@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 03 19:50:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KESwe-0008AG-CN
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 19:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982AbYGCRsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 13:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754976AbYGCRsh
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 13:48:37 -0400
Received: from anchor-post-37.mail.demon.net ([194.217.242.87]:55885 "EHLO
	anchor-post-37.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754982AbYGCRsf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jul 2008 13:48:35 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-37.mail.demon.net with esmtp (Exim 4.68)
	id 1KESv4-0003Kh-Nz; Thu, 03 Jul 2008 17:48:35 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87299>

Hi *,

Having upgraded to version 1.5.6 (via tarball), I can "make test" once
again, without crashing my machine. (well, it grinds to a halt, so that
I have to pull the power cord, followed by the battery!) I have been
unable to do that since v1.5.3!

I spent many hours (not recently) trying to determine the reason for
the crash, but it seems to be essentially "random gremlins" :-)
However, since I mostly use Linux, I've not been very motivated to
find a solution, particularly when git works fine (touch wood) when
used for real work. (i.e. only "make test" crashes my machine).
Also, as Alex and Shawn have not reported problems, I have assumed
it is something specific to my environment. Dunno.

Anyhow, the "sort-of" in the subject line, relates to the fact that
I am seeing some test failures.  In particular, all tests in
t0004-unwritable.sh and tests 21->24 in t3700-add.sh. All of these
tests involve chmod/permissions ...

I haven't spent too long trying to debug this, but looking at the
first (actually second) test in t0004, I did an strace on git-write-tree.
After wading through the output, it seems that cygwin allows mkdir()
to succeed in the (un-writable) .git/object directory; eg. when
writing the tree object 47d832... it succeeds in making the 47 directory
(which does have write permission) followed by the d832... file.
So I tried this by hand:

    $ mkdir obj
    $ chmod a-w obj
    $ echo file >obj/file
    bash: obj/file: Permission denied
    $ mkdir obj/dir
    $

OK.

[Junio, in the tarball, the test files t5304-prune.sh and
t7610-mergetool.sh do not have the executable bit set]

ATB,

Ramsay Jones
