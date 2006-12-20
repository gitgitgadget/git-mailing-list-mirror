X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: [BUG] daemon.c blows up on OSX (was Re: What's in git.git (stable), and Announcing GIT 1.4.4.3)
Date: 20 Dec 2006 14:20:42 -0800
Message-ID: <86irg6yzt1.fsf_-_@blue.stonehenge.com>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86vek6z0k2.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 22:20:55 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 925 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 17:20:44 EST
x-mayan-date: Long count = 12.19.13.16.7; tzolkin = 8 Manik; haab = 0 Kankin
In-Reply-To: <Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
Original-Lines: 31
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34971>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx9nu-0002Wj-E3 for gcvg-git@gmane.org; Wed, 20 Dec
 2006 23:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030382AbWLTWUp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 17:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030385AbWLTWUp
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 17:20:45 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:31875 "EHLO
 blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030382AbWLTWUo (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 17:20:44 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id E0B9C8FA6E; Wed, 20 Dec 2006 14:20:42 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 04744-03-20; Wed, 20 Dec 2006 14:20:42 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 640898FA70;
 Wed, 20 Dec 2006 14:20:42 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

>> Is this really in master?  I'm still seeing one-hour times on
>> my Mac, using 8336afa563fbeff35e531396273065161181f04c.

Linus> Master right  now is at 54851157ac.

Yeah, 54 objects just pulled down.  Here we go.  Time for a test...

Nope... can't compile:

    gcc -o daemon.o -c -g -O2 -Wall  -I/sw/include -I/opt/local/include -DSHA1_HEADER='<openssl/sha.h>' -DNO_STRLCPY daemon.c
    daemon.c: In function 'parse_extra_args':
    daemon.c:414: warning: implicit declaration of function 'strncasecmp'
    daemon.c: In function 'socksetup':
    daemon.c:766: error: 'NI_MAXSERV' undeclared (first use in this function)
    daemon.c:766: error: (Each undeclared identifier is reported only once
    daemon.c:766: error: for each function it appears in.)
    daemon.c:766: warning: unused variable 'pbuf'
    daemon.c: In function 'serve':
    daemon.c:970: warning: implicit declaration of function 'initgroups'
    make: *** [daemon.o] Error 1

This smells like we've seen this before.  Regression introduced with
some of the cleanup?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
