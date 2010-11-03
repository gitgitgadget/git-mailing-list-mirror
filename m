From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v6 00/16] daemon-win32
Date: Wed,  3 Nov 2010 17:31:18 +0100
Message-ID: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 17:31:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDgFV-0001ZU-UT
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 17:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755698Ab0KCQbm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Nov 2010 12:31:42 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55502 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab0KCQbk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 12:31:40 -0400
Received: by eye27 with SMTP id 27so386169eye.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 09:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=g9uXbTg5ZJsVjSpsfn/BuO6ka1CuIj4Wn6/w6+1yDSA=;
        b=DVj/sr0LUReZQ2Ra5xrPAwJyOcwGKc9/xbnhZwVX60gSRSe/qvRjFq8Cx9TgnW5sqq
         QAmhDMQJnG4isRsCcGaJQ/RQ6q9yRWGp3wuFz79vVHhY073oZyY2jqvRzF52m9lRh/nn
         WdoibfOG2f4nchSGq+dDEU4Nd9P7iPeFPUmJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=JCwb2IeaHfAS9N8fFovaF/Gk7YIZ5mBoQzPaDyO2AADA4IpSZ4/Gh+qpRw8gNy7mF6
         2hzwo6ZozTLOgt5fhPY/ABq4zI9pt8upKtL6LcZH0mvaMWPqkQwC1SUTayvK58IbgHsr
         e8CYRdpYSamoN+/QPtMpL5wEa7h7vUpemcyMk=
Received: by 10.213.16.69 with SMTP id n5mr4684256eba.26.1288801899265;
        Wed, 03 Nov 2010 09:31:39 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id q58sm6704049eeh.9.2010.11.03.09.31.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 09:31:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.msysgit.0.2.g22c0a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160609>

Here's hopefully the last iteration of this series. The previous versio=
n
only got a single complain about a typo in the subject of patch 14/15, =
so
it seems like most controversies have been settled.

This time the series has been rebased to junio's master branch, as the
'as/daemon-multi-listen' topic has been merged there.

The series can also be pulled from the 'win32-daemon-v6' tag in
git://repo.or.cz/git/kusma.git

Erik Faye-Lund (12):
  inet_ntop: fix a couple of old-style decls
  mingw: use real pid
  mingw: support waitpid with pid > 0 and WNOHANG
  mingw: add kill emulation
  daemon: use run-command api for async serving
  daemon: use full buffered mode for stderr
  daemon: get remote host address from root-process
  mingw: import poll-emulation from gnulib
  mingw: use poll-emulation from gnulib
  daemon: use socklen_t
  daemon: make --inetd and --detach incompatible
  daemon: opt-out on features that require posix

Martin Storsj=C3=B6 (1):
  Improve the mingw getaddrinfo stub to handle more use cases

Mike Pape (3):
  mingw: add network-wrappers for daemon
  mingw: implement syslog
  compat: add inet_pton and inet_ntop prototypes

 Documentation/git-daemon.txt |    3 +-
 Makefile                     |   23 ++-
 compat/inet_ntop.c           |   22 +--
 compat/inet_pton.c           |    8 +-
 compat/mingw.c               |  232 +++++++++++------
 compat/mingw.h               |   41 ++--
 compat/win32/sys/poll.c      |  596 ++++++++++++++++++++++++++++++++++=
++++++++
 compat/win32/sys/poll.h      |   53 ++++
 compat/win32/syslog.c        |   72 +++++
 compat/win32/syslog.h        |   20 ++
 daemon.c                     |  250 ++++++++++--------
 git-compat-util.h            |   11 +-
 12 files changed, 1103 insertions(+), 228 deletions(-)
 create mode 100644 compat/win32/sys/poll.c
 create mode 100644 compat/win32/sys/poll.h
 create mode 100644 compat/win32/syslog.c
 create mode 100644 compat/win32/syslog.h

--=20
1.7.3.2.161.gd6e00
