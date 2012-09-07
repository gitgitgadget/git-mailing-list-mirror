From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH/RFC v4 02/13] read-cache.c: Re-read index if index file changed
Date: Fri, 7 Sep 2012 09:22:33 +0200
Message-ID: <000c01cd8cc9$8cd1fea0$a675fbe0$@schmitz-digital.de>
References: <001d01cd82db$0dc00870$29401950$@schmitz-digital.de> <20120827093930.GC26470@tommy-fedora.surfnet.iacbox>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Thomas Gummerer'" <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 09:22:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9stv-0005ve-1s
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 09:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756841Ab2IGHWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 03:22:44 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:50282 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab2IGHWn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 03:22:43 -0400
Received: from DualCore (dsdf-4d0a1723.pool.mediaWays.net [77.10.23.35])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0LvkMO-1TdVcL1ImS-017Xcx; Fri, 07 Sep 2012 09:22:41 +0200
In-Reply-To: <20120827093930.GC26470@tommy-fedora.surfnet.iacbox>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQGCOLF7dROPgCk4XXHax59X6TAUWAK5JiCBl/9WSJA=
Content-Language: de
X-Provags-ID: V02:K0:7TQWm2ufqp1JJkoRLmyVVz3XihVy9QUV1KxJ8h7253+
 Hrrp6VKI/lJ/9P9Fnyh6bvex4fXSDNSZEQ/RaaqRkPQMbgV1pk
 7oDjUaQgm2YbpUh0c1QeSkdbKokWTqOR/T7tjtQUwpgtopK9vt
 yhdxKOe83CobryUK4mLZm8yvip71MQ39SgED1yUsnFjQQdpG5X
 eXRIc3c6BU8sYOGv4c2gvlDJOKXfzsQxjcUsxWAqvGjuHDr4wt
 MQu+TVc9BiHNFZRcWMQQSbfTCXsqMuNLReIWgmQbEn2eRkWFGM
 gca+sS3l0lJrbwa63i7hKZSrHIZF5E5ktpb3QOLtnV2PXgRt5k
 MQXYxSpjvs+WAIqD5GTGvqkc4dnAZ5UmEolEfuUUwUoxWItmNe
 CmHNwzSu44rrQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204948>

> From: Thomas Gummerer [mailto:t.gummerer@gmail.com]
> Sent: Monday, August 27, 2012 11:40 AM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH/RFC v4 02/13] read-cache.c: Re-read index if index file changed
> 
> On 08/25, Joachim Schmitz wrote:
> > "Thomas Gummerer" <t.gummerer@gmail.com> schrieb im Newsbeitrag news:<1345111129-6925-3-git-send-email-
> t.gummerer@gmail.com>...
> > > [...]
> > > +		usleep(10*1000);
> >
> > usleep() is not available to anybody, e.g. it is not in HP NonStop (not in every case at least)
> >
> > Bye, Jojo
> >
> Thanks for noticing, will be fixed in the re-roll.

Instead of

usleep(10*1000);

You could use

poll(NULL, 0, 10); 

instead, similar to what help.c is doing

This may need a fix in compat/win32/poll.c though:

diff --git a/compat/win32/poll.c b/compat/win32/poll.c
--- a/compat/win32/poll.c
+++ b/compat/win32/poll.c
@@ -350,7 +350,7 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)

   /* EFAULT is not necessary to implement, but let's do it in the
      simplest case. */
-  if (!pfd)
+  if (!pfd && nfd)
     {
       errno = EFAULT;
       return -1;

That fix would be needed anyhow...

Bye, Jojo
