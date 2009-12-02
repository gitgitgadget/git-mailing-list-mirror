From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH/RFC 01/11] mingw: add network-wrappers for daemon
Date: Wed, 2 Dec 2009 14:01:00 +0100
Message-ID: <40aa078e0912020501v9378c37l106e1e23b5e7b43d@mail.gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
	 <1259196260-3064-2-git-send-email-kusmabite@gmail.com>
	 <alpine.DEB.2.00.0911261015140.14228@cone.home.martin.st>
	 <40aa078e0911260246j47fa36d5t421de7c1d07d5cca@mail.gmail.com>
	 <alpine.DEB.2.00.0911261250180.14228@cone.home.martin.st>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	dotzenlabs@gmail.com, Johannes Sixt <j6t@kdbg.org>
To: =?ISO-8859-1?Q?Martin_Storsj=F6?= <martin@martin.st>
X-From: git-owner@vger.kernel.org Wed Dec 02 14:01:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFopQ-0001MU-4Q
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 14:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925AbZLBNA4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Dec 2009 08:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753822AbZLBNA4
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 08:00:56 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:53500 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbZLBNAz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Dec 2009 08:00:55 -0500
Received: by ewy19 with SMTP id 19so197102ewy.21
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 05:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=y6xKHte9zzT4BghYb3crRiuIosV+Tq+7vh4fPQuE5dw=;
        b=UtPbtrZFSHIEEf8MhFYNWZNOhuGGJ6rbjmkcyfVgylxjAEZJAybwSeAgIZfdHPglP1
         1u8b1PN7I7OC2slY2/eLC31gfgxGkmRvU0+d2iYPCGgZxCL0K1N3S46hxgSsoJ0Td8dU
         hy7eM/uu0my7oLOyDq0O5oqlhb3YEqgB87DDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=eqEzBa009muCR3YeqlNAS0DUf89njnCjGD2ts5HLOjQjiFltQ3t0+G1IrmGZGbVoRg
         SZQCClItoxcg1WcF2y1R088QXWuM5XP+pQjx69+GhRPgyH3jMgyB2P8kRem84biLpp7n
         UHtEDx436ooBo4oujEwsUTDTcG8ZrZcHKeO6E=
Received: by 10.216.89.129 with SMTP id c1mr30377wef.35.1259758860482; Wed, 02 
	Dec 2009 05:01:00 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0911261250180.14228@cone.home.martin.st>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134332>

(CC'ing Hannes, as he seems to be the original author of our poll()-emu=
lation)

On Thu, Nov 26, 2009 at 12:03 PM, Martin Storsj=F6 <martin@martin.st> w=
rote:
> On Thu, 26 Nov 2009, Erik Faye-Lund wrote:
>
>> Yeah, I saw your patches, and realized that I needed to rebase my wo=
rk
>> at some point, but none of the repos I usually pull from seems to
>> contain the patches yet. Rebasing will be a requirement before this
>> can be applied for sure.
>
> Ok, great! I tried applying it on the latest master, and it wasn't to=
o
> much of work.

I've finally gotten around to doing the same now, thanks for the heads =
up :)

> This causes problems with the mingw poll() replacement, which has a
> special case for polling one single fd - otherwise it tries to use so=
me
> emulation that currently only works for pipes. I didn't try to make a=
ny
> proper fix for this though. I tested git-daemon by hacking it to list=
en on
> only one of the sockets, and that worked well for both v4 and v6.
>
>
> So, in addition to the getaddrinfo patch I sent, the mingw poll()
> replacement needs some updates to handle polling multiple sockets. Ex=
cept
> from that, things seem to work, at a quick glance.
>

Thanks a lot for helping out! I'm seeing the same issue here when
running on Vista:
$ ./git-daemon.exe --base-path=3D/c/Users/Erik/src/ --export-all
error: PeekNamedPipe failed, GetLastError: 1
[3656] Poll failed, resuming: Invalid argument
error: PeekNamedPipe failed, GetLastError: 1
[3656] Poll failed, resuming: Invalid argument
=2E..

If I hack the poll()-emulation to never enter the PeekNamedPipe
code-path seems to make it work with IPv6 here, but this is obviously
not the correct solution as it breaks pipe-polling:
--->8---
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -360,7 +360,7 @@ int poll(struct pollfd *ufds, unsigned int nfds, in=
t timeout
         * input is available and let the actual wait happen when the
         * caller invokes read().
         */
-       if (nfds =3D=3D 1) {
+       if (1) {
                if (!(ufds[0].events & POLLIN))
                        return errno =3D EINVAL, error("POLLIN not set"=
);
                ufds[0].revents =3D POLLIN;
--->8---

I'm not very familiar with poll(), but if I understand the man-pages
correctly it's waiting for events on file descriptors, and is in our
case used to check for incoming connections, right? If so, I see three
possible ways forward: (1) extending our poll()-emulation to handle
multiple sockets, (2) change daemon.c to check one socket at the time,
and (3) using select() instead of poll().

(1) seems like the "correct" but tricky thing to do, (2) like the
"easy" but nasty thing to do. However, (3) strikes me as the least
dangerous thing to do ;)

=46or (1), there's also a WSAPoll() function in Windows, but I'm not
sure how to figure out if an fd is a socket or a pipe. There's also
WaitForMultipleObjects.

Here's a quick stab at (3). It seems to work fine under Windows. Not
tested on other platforms, though.

--->8---
--- a/daemon.c
+++ b/daemon.c
@@ -812,26 +812,22 @@ static int socksetup(char *listen_addr, int liste=
n_port, i
nt **socklist_p)

 static int service_loop(int socknum, int *socklist)
 {
-       struct pollfd *pfd;
-       int i;
-
-       pfd =3D xcalloc(socknum, sizeof(struct pollfd));
-
-       for (i =3D 0; i < socknum; i++) {
-               pfd[i].fd =3D socklist[i];
-               pfd[i].events =3D POLLIN;
-       }
-
        signal(SIGCHLD, child_handler);

        for (;;) {
                int i;
+               fd_set fds;
+               struct timeval timeout =3D { 0, 0 };

                check_dead_children();

-               if (poll(pfd, socknum, -1) < 0) {
+               FD_ZERO(&fds);
+               for (i =3D 0; i < socknum; i++)
+                       FD_SET(socklist[i], &fds);
+
+               if (select(0, &fds, NULL, NULL, &timeout) > 0) {
                        if (errno !=3D EINTR) {
-                               logerror("Poll failed, resuming: %s",
+                               logerror("select() failed, resuming: %s=
",
                                      strerror(errno));
                                sleep(1);
                        }
@@ -839,10 +835,10 @@ static int service_loop(int socknum, int *socklis=
t)
                }

                for (i =3D 0; i < socknum; i++) {
-                       if (pfd[i].revents & POLLIN) {
+                       if (FD_ISSET(socklist[i], &fds)) {
                                struct sockaddr_storage ss;
                                socklen_t sslen =3D sizeof(ss);
-                               int incoming =3D accept(pfd[i].fd,
(struct sockaddr *)&ss, &sslen);
+                               int incoming =3D accept(socklist[i],
(struct sockaddr *)&ss, &sslen);
                                if (incoming < 0) {
                                        switch (errno) {
                                        case EAGAIN:
@@ -854,6 +850,7 @@ static int service_loop(int socknum, int *socklist)
                                        }
                                }
                                handle(incoming, (struct sockaddr *)&ss=
, sslen);

+                               break;
                        }
                }
        }
--->8---

--=20
Erik "kusma" Faye-Lund
