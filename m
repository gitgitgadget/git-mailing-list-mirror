From: Stephen & Linda Smith <ischis2@cox.net>
Subject: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sat, 05 Jan 2013 19:04:42 -0700
Message-ID: <2491041.bQ51Qu8HcA@thunderbird>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: mlevedahl@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 04:20:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trgn0-000594-2B
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 04:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371Ab3AFDUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 22:20:14 -0500
Received: from eastrmfepi107.cox.net ([68.230.241.203]:40969 "EHLO
	eastrmfepi107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755133Ab3AFDUM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 22:20:12 -0500
X-Greylist: delayed 4534 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Jan 2013 22:20:12 EST
Received: from eastrmimpo110 ([68.230.241.223]) by eastrmfepo203.cox.net
          (InterMail vM.8.01.04.00 201-2260-137-20101110) with ESMTP
          id <20130106020437.YIBP21186.eastrmfepo203.cox.net@eastrmimpo110>
          for <git@vger.kernel.org>; Sat, 5 Jan 2013 21:04:37 -0500
Received: from thunderbird ([24.251.82.172])
	by eastrmimpo110 with cox
	id kS4C1k00M3j4oj401S4DEf; Sat, 05 Jan 2013 21:04:37 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020207.50E8DBB5.005F,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=N5Wr5hBB c=1 sm=1
 a=+a/fVzVtFbLp+jmGrq7Gkg==:17 a=HhTkiSSM8msA:10 a=IMfaUFWDbI0A:10
 a=G8Uczd0VNMoA:10 a=kj9zAlcOel0A:10 a=kviXuzpPAAAA:8 a=xKaGd1yPDtAA:10
 a=mqSZOu_dykMTFNddHKcA:9 a=CjuIK1q_8ugA:10 a=+a/fVzVtFbLp+jmGrq7Gkg==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.localnet (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 9A1A914093C;
	Sat,  5 Jan 2013 19:04:42 -0700 (MST)
User-Agent: KMail/4.9.3 (Linux/3.5.0-21-generic; KDE/4.9.3; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212746>

 Commit 9fca6cffc05321445b59c91e8f8d308f41588b53 message states that
 the macro was being renamed for clarity. The patch also changes a define.

This change causes the code to not compile on cygwin 1.7.14.

 I narrowed the problem to this patch by bisecting commits between v1.8.0 and 
1.8.1

Here is the error sequence:

    CC compat/cygwin.o
In file included from compat/../git-compat-util.h:90,
                 from compat/cygwin.c:9:
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:103:2: 
warning: #warning "fd_set and associated macros have been defined in sys/types.      
This may cause runtime problems with W32 sockets"
In file included from /usr/include/sys/socket.h:16,
                 from compat/../git-compat-util.h:131,
                 from compat/cygwin.c:9:
/usr/include/cygwin/socket.h:29: error: redefinition of `struct sockaddr'
/usr/include/cygwin/socket.h:41: error: redefinition of `struct 
sockaddr_storage'
In file included from /usr/include/sys/socket.h:16,
                 from compat/../git-compat-util.h:131,
                 from compat/cygwin.c:9:
/usr/include/cygwin/socket.h:59: error: redefinition of `struct linger'
In file included from compat/../git-compat-util.h:131,
                 from compat/cygwin.c:9:
/usr/include/sys/socket.h:30: error: conflicting types for 'accept'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:536: 
error: previous declaration of 'accept' was here
/usr/include/sys/socket.h:30: error: conflicting types for 'accept'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:536: 
error: previous declaration of 'accept' was here
/usr/include/sys/socket.h:32: error: conflicting types for 'bind'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:537: 
error: previous declaration of 'bind' was here
/usr/include/sys/socket.h:32: error: conflicting types for 'bind'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:537: 
error: previous declaration of 'bind' was here
/usr/include/sys/socket.h:33: error: conflicting types for 'connect'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:539: 
error: previous declaration of 'connect' was here
/usr/include/sys/socket.h:33: error: conflicting types for 'connect'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:539: 
error: previous declaration of 'connect' was here
/usr/include/sys/socket.h:34: error: conflicting types for 'getpeername'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:541: 
error: previous declaration of 'getpeername' was here
/usr/include/sys/socket.h:34: error: conflicting types for 'getpeername'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:541: 
error: previous declaration of 'getpeername' was here
/usr/include/sys/socket.h:35: error: conflicting types for 'getsockname'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:542: 
error: previous declaration of 'getsockname' was here
/usr/include/sys/socket.h:35: error: conflicting types for 'getsockname'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:542: 
error: previous declaration of 'getsockname' was here
/usr/include/sys/socket.h:36: error: conflicting types for 'listen'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:546: 
error: previous declaration of 'listen' was here
/usr/include/sys/socket.h:36: error: conflicting types for 'listen'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:546: 
error: previous declaration of 'listen' was here
/usr/include/sys/socket.h:37: error: conflicting types for 'recv'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:547: 
error: previous declaration of 'recv' was here
/usr/include/sys/socket.h:37: error: conflicting types for 'recv'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:547: 
error: previous declaration of 'recv' was here
/usr/include/sys/socket.h:39: error: conflicting types for 'recvfrom'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:548: 
error: previous declaration of 'recvfrom' was here
/usr/include/sys/socket.h:39: error: conflicting types for 'recvfrom'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:548: 
error: previous declaration of 'recvfrom' was here
/usr/include/sys/socket.h:41: error: conflicting types for 'send'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:549: 
error: previous declaration of 'send' was here
/usr/include/sys/socket.h:41: error: conflicting types for 'send'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:549: 
error: previous declaration of 'send' was here
/usr/include/sys/socket.h:44: error: conflicting types for 'sendto'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:550: 
error: previous declaration of 'sendto' was here
/usr/include/sys/socket.h:44: error: conflicting types for 'sendto'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:550: 
error: previous declaration of 'sendto' was here
/usr/include/sys/socket.h:46: error: conflicting types for 'setsockopt'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:551: 
error: previous declaration of 'setsockopt' was here
/usr/include/sys/socket.h:46: error: conflicting types for 'setsockopt'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:551: 
error: previous declaration of 'setsockopt' was here
/usr/include/sys/socket.h:48: error: conflicting types for 'getsockopt'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:543: 
error: previous declaration of 'getsockopt' was here
/usr/include/sys/socket.h:48: error: conflicting types for 'getsockopt'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:543: 
error: previous declaration of 'getsockopt' was here
/usr/include/sys/socket.h:49: error: conflicting types for 'shutdown'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:552: 
error: previous declaration of 'shutdown' was here
/usr/include/sys/socket.h:49: error: conflicting types for 'shutdown'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:552: 
error: previous declaration of 'shutdown' was here
/usr/include/sys/socket.h:50: error: conflicting types for 'socket'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:553: 
error: previous declaration of 'socket' was here
/usr/include/sys/socket.h:50: error: conflicting types for 'socket'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:553: 
error: previous declaration of 'socket' was here
/usr/include/sys/socket.h:53: error: conflicting types for 'getservbyname'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:557: 
error: previous declaration of 'getservbyname' was here
/usr/include/sys/socket.h:53: error: conflicting types for 'getservbyname'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:557: 
error: previous declaration of 'getservbyname' was here
In file included from compat/../git-compat-util.h:135,
                 from compat/cygwin.c:9:
/usr/include/sys/select.h:31: error: conflicting types for 'select'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:632: 
error: previous declaration of 'select' was here
/usr/include/sys/select.h:31: error: conflicting types for 'select'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:632: 
error: previous declaration of 'select' was here
In file included from /usr/include/netinet/in.h:14,
                 from compat/../git-compat-util.h:137,
                 from compat/cygwin.c:9:
/usr/include/cygwin/in.h:30: error: parse error before numeric constant
/usr/include/cygwin/in.h:35: error: parse error before numeric constant
/usr/include/cygwin/in.h:37: error: parse error before numeric constant
/usr/include/cygwin/in.h:76: error: parse error before numeric constant
/usr/include/cygwin/in.h:115: error: redefinition of `struct in_addr'
/usr/include/cygwin/in.h:116: error: parse error before '.' token
/usr/include/cygwin/in.h:184: error: redefinition of `struct sockaddr_in'
In file included from /usr/include/cygwin/in.h:250,
                 from /usr/include/netinet/in.h:14,
                 from compat/../git-compat-util.h:137,
                 from compat/cygwin.c:9:
/usr/include/asm/byteorder.h:26: error: conflicting types for 'ntohl'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:629: 
error: previous declaration of 'ntohl' was here
/usr/include/asm/byteorder.h:26: error: conflicting types for 'ntohl'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:629: 
error: previous declaration of 'ntohl' was here
/usr/include/asm/byteorder.h:27: error: conflicting types for 'ntohs'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:631: 
error: previous declaration of 'ntohs' was here
/usr/include/asm/byteorder.h:27: error: conflicting types for 'ntohs'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:631: 
error: previous declaration of 'ntohs' was here
/usr/include/asm/byteorder.h:28: error: conflicting types for 'htonl'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:628: 
error: previous declaration of 'htonl' was here
/usr/include/asm/byteorder.h:28: error: conflicting types for 'htonl'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:628: 
error: previous declaration of 'htonl' was here
/usr/include/asm/byteorder.h:29: error: conflicting types for 'htons'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:630: 
error: previous declaration of 'htons' was here
/usr/include/asm/byteorder.h:29: error: conflicting types for 'htons'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:630: 
error: previous declaration of 'htons' was here
In file included from compat/../git-compat-util.h:139,
                 from compat/cygwin.c:9:
/usr/include/arpa/inet.h:22: error: conflicting types for 'inet_addr'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:544: 
error: previous declaration of 'inet_addr' was here
/usr/include/arpa/inet.h:22: error: conflicting types for 'inet_addr'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:544: 
error: previous declaration of 'inet_addr' was here
/usr/include/arpa/inet.h:28: error: conflicting types for 'inet_ntoa'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:545: 
error: previous declaration of 'inet_ntoa' was here
/usr/include/arpa/inet.h:28: error: conflicting types for 'inet_ntoa'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:545: 
error: previous declaration of 'inet_ntoa' was here
In file included from compat/../git-compat-util.h:140,
                 from compat/cygwin.c:9:
/usr/include/netdb.h:79: error: redefinition of `struct hostent'
/usr/include/netdb.h:93: error: redefinition of `struct netent'
/usr/include/netdb.h:100: error: redefinition of `struct servent'
/usr/include/netdb.h:108: error: redefinition of `struct protoent'
/usr/include/netdb.h:139: error: conflicting types for 'WSAGetLastError'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:594: 
error: previous declaration of 'WSAGetLastError' was here
/usr/include/netdb.h:139: error: conflicting types for 'WSAGetLastError'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:594: 
error: previous declaration of 'WSAGetLastError' was here
/usr/include/netdb.h:192: error: conflicting types for 'gethostbyaddr'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:554: 
error: previous declaration of 'gethostbyaddr' was here
/usr/include/netdb.h:192: error: conflicting types for 'gethostbyaddr'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:554: 
error: previous declaration of 'gethostbyaddr' was here
/usr/include/netdb.h:193: error: conflicting types for 'gethostbyname'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:555: 
error: previous declaration of 'gethostbyname' was here
/usr/include/netdb.h:193: error: conflicting types for 'gethostbyname'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:555: 
error: previous declaration of 'gethostbyname' was here
/usr/include/netdb.h:199: error: conflicting types for 'getprotobyname'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:559: 
error: previous declaration of 'getprotobyname' was here
/usr/include/netdb.h:199: error: conflicting types for 'getprotobyname'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:559: 
error: previous declaration of 'getprotobyname' was here
/usr/include/netdb.h:200: error: conflicting types for 'getprotobynumber'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:558: 
error: previous declaration of 'getprotobynumber' was here
/usr/include/netdb.h:200: error: conflicting types for 'getprotobynumber'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:558: 
error: previous declaration of 'getprotobynumber' was here
/usr/include/netdb.h:203: error: conflicting types for 'getservbyport'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:556: 
error: previous declaration of 'getservbyport' was here
/usr/include/netdb.h:203: error: conflicting types for 'getservbyport'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:556: 
error: previous declaration of 'getservbyport' was here
Makefile:2384: recipe for target `compat/cygwin.o' failed
make: *** [compat/cygwin.o] Error 1
