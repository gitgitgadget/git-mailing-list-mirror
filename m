From: Joi Ellis <gyles19@visi.com>
Subject: Chicken/egg problem building from a 'git clone'
Date: Fri, 6 Feb 2009 04:09:24 +0000 (UTC)
Message-ID: <loom.20090206T035001-370@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 05:17:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVI9F-00086Y-0w
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 05:17:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbZBFEPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 23:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbZBFEPF
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 23:15:05 -0500
Received: from main.gmane.org ([80.91.229.2]:37935 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259AbZBFEPE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 23:15:04 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LVI7L-0005Ch-40
	for git@vger.kernel.org; Fri, 06 Feb 2009 04:15:03 +0000
Received: from 12.31.157.50 ([12.31.157.50])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 04:15:03 +0000
Received: from gyles19 by 12.31.157.50 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 04:15:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 12.31.157.50 (Opera/9.63 (X11; Linux i686; U; en) Presto/2.1.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108650>

I have an elderly laptop.  I can build and install git using a tarball.  I 
original installed git 1.6.0.  This evening I noticed 1.6.1 was availble, and I 
decided to try building from the git repository using 'git clone' as described 
in the git home page.   And to jump ahead of myself, I want to point out that 
1.6.1 will build from the tarball.  However...

The workspace I get using 'git clone' does not provide a configure file.  And 
because my laptop isn't running a bleeding edge distribution, my build tools 
are older than you'd expect, so...

"make all" fails becuase my libaries are old:

    LINK git-fast-import
fast-import.o: In function `store_object':
/usr/local/src/git/git/fast-import.c:1086: undefined reference to `deflateBound'
/usr/local/src/git/git/fast-import.c:1109: undefined reference to `deflateBound'

"make configure" fails because my autoconf is too old.

    GEN configure
Usage: autoconf [-h] [--help] [-m dir] [--macrodir=dir]
       [-l dir] [--localdir=dir] [--version] [template-file]
make: *** [configure] Error 1

This found an issue with the Makefile, because my autoconf is sooo old, it's 
puking on the configure target build command, in part:

  autoconf -o $@ $<+ && \

because this old autoconf doesn't have a -o parameter.  If I change the
Makefile to:

  autoconf $<+ >$@ && \

Then the error becomes
    GEN configure
FATAL ERROR: Autoconf version 2.59 or higher is required for this script
make: *** [configure] Error 2

which is closer to what you intended.  I'm not sure what difference it makes 
between specifying -o and simply letting it default.

Anyway, would it break anything to have a 'configure' script provided as part 
of the clone pull?  It's provided in the tarball, and if I copy the 1.6.1 
configure script into my git workspace and run it, it seems to build.  I'm just 
not sure I trust it to be up-to-date with the configure script you folks can 
generate with your modern build tools using 'make configure'.

I realize the configure script is technically a build target but not having it 
does cause this chicken-egg issue on older platforms.
