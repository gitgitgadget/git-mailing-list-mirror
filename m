From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH/RFC 01/11] mingw: add network-wrappers for daemon
Date: Wed, 2 Dec 2009 20:34:09 +0100
Message-ID: <200912022034.09266.j6t@kdbg.org>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com> <alpine.DEB.2.00.0911261250180.14228@cone.home.martin.st> <40aa078e0912020501v9378c37l106e1e23b5e7b43d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Martin =?iso-8859-1?q?Storsj=F6?= <martin@martin.st>,
	msysgit@googlegroups.com, git@vger.kernel.org, dotzenlabs@gmail.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Dec 02 20:34:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFuyB-0006Cc-P4
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 20:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755493AbZLBTeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 14:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753696AbZLBTeV
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 14:34:21 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:50124 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755329AbZLBTeU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 14:34:20 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9C3E1CDF96;
	Wed,  2 Dec 2009 20:34:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 5892B19F60D;
	Wed,  2 Dec 2009 20:34:09 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <40aa078e0912020501v9378c37l106e1e23b5e7b43d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134381>

On Mittwoch, 2. Dezember 2009, Erik Faye-Lund wrote:
> I'm not very familiar with poll(), but if I understand the man-pages
> correctly it's waiting for events on file descriptors, and is in our
> case used to check for incoming connections, right? If so, I see three
> possible ways forward: (1) extending our poll()-emulation to handle
> multiple sockets, (2) change daemon.c to check one socket at the time,
> and (3) using select() instead of poll().
>
> (1) seems like the "correct" but tricky thing to do, (2) like the
> "easy" but nasty thing to do. However, (3) strikes me as the least
> dangerous thing to do ;)
>
> For (1), there's also a WSAPoll() function in Windows, but I'm not
> sure how to figure out if an fd is a socket or a pipe. There's also
> WaitForMultipleObjects.

GetFileType() returns FILE_TYPE_PIPE for both pipes and sockets. But once you 
know this, you can use getsockopt(): If it succeeds, it is a socket, and in 
this case, assume that poll() was called from git-daemon, i.e. all polled-for 
fds are sockets and you can select().

-- Hannes
