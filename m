From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v5 00/16] daemon-win32
Date: Fri, 22 Oct 2010 02:35:11 +0200
Message-ID: <1287707727-5780-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com, jrnieder@gmail.com, schwab@linux-m68k.org,
	patthoyts@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 02:36:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P95cJ-0002PL-0s
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 02:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755061Ab0JVAgO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 20:36:14 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59343 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555Ab0JVAgN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 20:36:13 -0400
Received: by ewy7 with SMTP id 7so377562ewy.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 17:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=QHCFhHu3GuIN8Ql6MxrmLDK1tF0FiYFWl/kzQulpc4I=;
        b=tKMZJrySNA3l95L8EGZRFEHbNm2tcO3yyhdzDagCe5NtirpwQIjZEbASBZxdhGvrVc
         BSyjEA95ihkEkBR5l5x3a+Jy69odQGcX3NTZYgqh3JZYKzqjC7sE0WdMg/XApXIMdb5p
         zY5y4WOD6RWdmokn9tYsjMGwwIVP45SVQVbQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=iUAAMXTn48BEEimlDX8G7N5x8hbsKd8EyIn2RuGGTJXYoWutepYi5tzGAXJ/MZn6F6
         AO59nz9S67XBm0bErSiVpgXk9oELGzkRatxxXrHBfzKHTTkm0Bjh447UdemcVvuNp6Gl
         a2Eqmlr9t7Qg0XzjHPTon0tltJUlM345oC7vE=
Received: by 10.213.12.201 with SMTP id y9mr2539050eby.18.1287707771296;
        Thu, 21 Oct 2010 17:36:11 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id q58sm2487828eeh.3.2010.10.21.17.36.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 17:36:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159612>

OK, here's the latest iteration of this series. The changes from
the last round is:

* 02/16 has a better commit message, describing the issue a bit
  more in detail.
* 08/16 has been fixed up in style, as suggested bu Junio. A typo
  (a '0' had turned into a '1' somehow) has been corrected, as
  spotted by Jonathan.
* 11/16 has gotten it's output-format back, by using REMOTE_ADDR
  (and a introducing a REMOTE_PORT).
* 15/16 is new, and documents (and enforce) some mutually exclusive
  command-line switches.
* 16/16 has greatly gotten it's mess cleaned up. Now there's
  no ifdefs in main() anymore.

The current version can also be pulled from:
git://repo.or.cz/git/kusma.git win32-daemon-v5

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
  daemon: make --inetd and --detcach incompatible
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
 daemon.c                     |  252 ++++++++++--------
 git-compat-util.h            |   11 +-
 12 files changed, 1105 insertions(+), 228 deletions(-)
 create mode 100644 compat/win32/sys/poll.c
 create mode 100644 compat/win32/sys/poll.h
 create mode 100644 compat/win32/syslog.c
 create mode 100644 compat/win32/syslog.h

--=20
1.7.3.1.199.g72340
