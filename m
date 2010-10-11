From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v4 00/15] daemon-win32
Date: Mon, 11 Oct 2010 23:50:14 +0200
Message-ID: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 11 23:51:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5QH2-0005d5-QQ
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 23:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756346Ab0JKVvG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Oct 2010 17:51:06 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36668 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756092Ab0JKVvE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 17:51:04 -0400
Received: by ewy20 with SMTP id 20so833577ewy.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 14:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=rHK0xzBXeh6cCwQHvTmWoyzdo7Nv+grj+r9WmMvCWUc=;
        b=xZLRTlZGONZcJYl19MiH40wjOO3V4cgQwe3ys0ks5JVLO/buvZm5J72AHUtyGHa9da
         7aKa1IzUZrZN9V7CvwmWMgzjaDV+bk/DKCruHBXHfJW0eBF9FcWjLP7eYLo4e8vDLAFP
         uC0XhRLOoZ2amH3ugi5jk5SxlhE+tNJOr6/PE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=ar3rbdUCphsSKAKXJNgagWO1LUnhomant4VRVFIXgPWLVvkqW00dKweXX3OwgM9bCb
         tLfJPYEXi4nlQrcSQu+VFP5Cqmczl15lPb51tYvyZvAuVSSUV01CYR2FzRN5tB5jjAyS
         PiwaTjf4qZNNZg7D3mDkU50dJPqxm6/gTzjJQ=
Received: by 10.213.101.1 with SMTP id a1mr2007416ebo.82.1286833862926;
        Mon, 11 Oct 2010 14:51:02 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id p53sm4224420eeh.13.2010.10.11.14.51.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 14:51:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158792>

OK, here's v3 of this series. Since the last version, the following
things were done:
* 01/14 has the error-path cleaned up, as suggested by Eric Sunshine
* 02/14 now supports any vararg input, and escapes "%1" to "% 1" to
  avoid a limitation ni ReportEvent(). The code has also been moved
  to compat/win32/syslog.[ch], since it's fairly self contained and
  it's not strictly speaking a mingw-specific thing.
* 05/14 now has an extended commit message, detailing the rationale
  a bit more
* 08/14 has been fixed up as suggested by Eric Sunshine
* 11/14 has been fixed up to remove code left dead by the previous
  version
* 12/14 has a better commit message, including an explanation on
  how to update the code. The sources have also been moved to
  compat/win32/sys/poll.[ch], which is where git usually looks for
  the poll-header.
* 14/14 has been split out into 14/15 and 15/15, because it
  contained some left-over changes (unsigned int -> socklen_t). The
  left-over code is 14/15.
* 15/15 have the _POSIX_VERSION-check replaced with a check for
  NO_POSIX_GOODIES. It has been changed back to opt-out, since I
  don't want to have to deal with figuring out what platforms it
  will work for or not. Currently all platforms except from Windows
  supports all posix-"goodies", but it should be easy to opt-out
  for a future plaform.

Erik Faye-Lund (11):
  inet_ntop: fix a couple of old-style decls
  mingw: use real pid
  mingw: support waitpid with pid > 0 and WNOHANG
  mingw: add kill emulation
  daemon: use run-command api for async serving
  daemon: use full buffered mode for stderr
  daemon: report connection from root-process
  mingw: import poll-emulation from gnulib
  mingw: use poll-emulation from gnulib
  daemon: use socklen_t
  daemon: opt-out on features that require posix

Martin Storsj=C3=B6 (1):
  Improve the mingw getaddrinfo stub to handle more use cases

Mike Pape (3):
  mingw: add network-wrappers for daemon
  mingw: implement syslog
  compat: add inet_pton and inet_ntop prototypes

 Makefile                |   23 ++-
 compat/inet_ntop.c      |   22 +--
 compat/inet_pton.c      |    8 +-
 compat/mingw.c          |  232 +++++++++++++------
 compat/mingw.h          |   41 ++--
 compat/win32/sys/poll.c |  596 +++++++++++++++++++++++++++++++++++++++=
++++++++
 compat/win32/sys/poll.h |   53 +++++
 compat/win32/syslog.c   |   72 ++++++
 compat/win32/syslog.h   |   20 ++
 daemon.c                |  199 +++++++++-------
 git-compat-util.h       |   11 +-
 11 files changed, 1067 insertions(+), 210 deletions(-)
 create mode 100644 compat/win32/sys/poll.c
 create mode 100644 compat/win32/sys/poll.h
 create mode 100644 compat/win32/syslog.c
 create mode 100644 compat/win32/syslog.h

--=20
1.7.3.1.199.g72340
