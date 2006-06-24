From: Junio C Hamano <junkio@cox.net>
Subject: Re: PPC SHA-1 Updates in "pu"
Date: Sat, 24 Jun 2006 16:59:16 -0700
Message-ID: <7vd5cyt8a3.fsf@assigned-by-dhcp.cox.net>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net>
	<20060624012202.4822.qmail@science.horizon.com>
	<7vfyhv11ej.fsf@assigned-by-dhcp.cox.net>
	<7vwtb6yip5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606241147480.6483@g5.osdl.org>
	<7vhd2atid1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606241338370.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Jun 25 01:59:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuI2A-0005zG-7s
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 01:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWFXX7S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 19:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWFXX7S
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 19:59:18 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:6825 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751279AbWFXX7R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 19:59:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624235917.HOEE18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 19:59:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606241338370.6483@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 24 Jun 2006 13:42:25 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22554>

Linus Torvalds <torvalds@osdl.org> writes:

> Don't everybody see them?

No.  But I see it now.

> how does that compile for anybody else, when -DSHA1_HEADER isn't set 
> correctly? The quotes have gone missing:
>
> 	-DSHA1_HEADER='ppc/sha1.h' 
>
> don't ask me why.

That is, as usual, caused by careless shell quoting.

        : gitster; PPC_SHA1=YesPlease Meta/Make perl/Makefile
        GIT_VERSION = 1.4.1.rc1.g9adbe
        (cd perl && /usr/bin/perl Makefile.PL \
                        PREFIX="/home/junio/git-test" \
                        DEFINE="-O2 -Wall -Wdeclaration-after-statement
                        -g -fPIC -DSHA1_HEADER='"ppc/sha1.h"'
                        -DGIT_VERSION=\\\"1.4.1.rc1.g9adbe\\\"" \
                        LIBS="libgit.a xdiff/lib.a -lz")
        Unrecognized argument in LIBS ignored: 'libgit.a'
        Unrecognized argument in LIBS ignored: 'xdiff/lib.a'
        Writing Makefile for Git

All options but to use OpenSSL SHA-1 implementation share the
same problem (Meta/Make is a thin "make" wrapper to give USE_PIC
and other C compilation flags):

        : gitster; ARM_SHA1=YesPlease Meta/Make perl/Makefile
        (cd perl && /usr/bin/perl Makefile.PL \
                        PREFIX="/home/junio/git-test" \
                        DEFINE="-O2 -Wall -Wdeclaration-after-statement
                        -g -fPIC -DSHA1_HEADER='"arm/sha1.h"'
                        -DGIT_VERSION=\\\"1.4.1.rc1.g9adbe\\\"" \
                        LIBS="libgit.a xdiff/lib.a -lz")
        Unrecognized argument in LIBS ignored: 'libgit.a'
        Unrecognized argument in LIBS ignored: 'xdiff/lib.a'
        Writing Makefile for Git

        : gitster; MOZILLA_SHA1=YesPlease Meta/Make perl/Makefile
        (cd perl && /usr/bin/perl Makefile.PL \
                        PREFIX="/home/junio/git-test" \
                        DEFINE="-O2 -Wall -Wdeclaration-after-statement
                        -g -fPIC -DSHA1_HEADER='"mozilla-sha1/sha1.h"'
                        -DGIT_VERSION=\\\"1.4.1.rc1.g9adbe\\\"" \
                        LIBS="libgit.a xdiff/lib.a -lz")
        Unrecognized argument in LIBS ignored: 'libgit.a'
        Unrecognized argument in LIBS ignored: 'xdiff/lib.a'
        Writing Makefile for Git
