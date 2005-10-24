From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: daemon.c broken on OpenBSD
Date: 23 Oct 2005 21:06:23 -0700
Message-ID: <867jc336f4.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Oct 24 06:06:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETtbW-000463-8m
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 06:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbVJXEG3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 00:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbVJXEG3
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 00:06:29 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:5138 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750966AbVJXEG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2005 00:06:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 886678F940
	for <git@vger.kernel.org>; Sun, 23 Oct 2005 21:06:24 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 11990-01-12 for <git@vger.kernel.org>;
 Sun, 23 Oct 2005 21:06:24 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 207478F945; Sun, 23 Oct 2005 21:06:24 -0700 (PDT)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.12.13.4; tzolkin = 1 Kan; haab = 2 Zac
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10527>


Wow.

    gcc -o daemon.o -c -g -O2 -Wall -I/usr/local/include -L/usr/local/lib -Dstrcasestr=gitstrcasestr -DNO_STRCASESTR=1 -DSHA1_HEADER='<openssl/sha.h>' daemon.c
    In file included from /usr/include/sys/poll.h:54,
                     from daemon.c:7:
    /usr/include/ctype.h:67: error: syntax error before ']' token
    /usr/include/ctype.h:68: error: syntax error before ']' token
    /usr/include/ctype.h:70: error: syntax error before ']' token
    /usr/include/ctype.h:75: error: syntax error before ']' token
    /usr/include/ctype.h:78: error: syntax error before '(' token
    /usr/include/ctype.h:79: error: syntax error before '(' token
    /usr/include/ctype.h:93: error: syntax error before "c"
    In file included from /usr/include/sys/poll.h:54,
                     from daemon.c:7:
    /usr/include/ctype.h:91:1: unterminated #if
    /usr/include/ctype.h:40:1: unterminated #ifndef
    In file included from daemon.c:7:
    /usr/include/sys/poll.h:53:1: unterminated #ifndef
    /usr/include/sys/poll.h:28:1: unterminated #ifndef
    gmake: *** [daemon.o] Error 1

Apparently something in the early lines of daemon.c (before line 7)
is defining something that breaks the core /usr/include/ctype.h.

Lines 66 to 68 of ctype.h look like:

    #if defined(__GNUC__) || defined(_ANSI_LIBRARY) || defined(lint)
    int	isalnum(int);
    int	isalpha(int);

If that rings a bell, help me out here.  I'm guessing "isalnum" is getting
defined (wrongly).  Yeah, looks like in cache.h.  Why is this getting
defined?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
