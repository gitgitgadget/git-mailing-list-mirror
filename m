From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Wed, 13 Jan 2010 15:19:44 +0200
Message-ID: <1263388786-6880-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 14:19:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV38c-00074H-40
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 14:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368Ab0AMNTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 08:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754309Ab0AMNTu
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 08:19:50 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:54065 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386Ab0AMNTu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 08:19:50 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 987BA8C0C4
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 15:19:48 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A002839678C; Wed, 13 Jan 2010 15:19:48 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 7566027D93
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 15:19:47 +0200 (EET)
X-Mailer: git-send-email 1.6.6.102.gd6f8f.dirty
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136816>

This is client-side support for Git-over-TLS (gits://). gits:// is
version of git:// protocol layered on top of TLS (Transport Layer
Security). If using TLS, it is autenticated transport supporing
fetching, pushing and remote archive (plus special commands that
have server-dependent meaning).

Needs GnuTLS, and adds new make option NO_GNUTLS that disables builing
this code.

Supported underlying stream transports include TCP/IP, TCP/IPv6 and
Unix domain sockets (including Linux abstract namespace).

Supported authentication mechanisms include passwords, keypairs and on
some platforms Unix authentication if using unix domain sockets. Server
is authenticated using keypair (hostkey).

The patch is split into two parts because it would be otherwise be
too large for this list. Included are all the needed client side
utilities (some of them run gpg internally).

The main repo for gits:// implementation is 
git://repo.or.cz/git-daemon2.git , which includes selfstanding client
code and server code.

Ilari Liusvaara (2):
  Git-over-TLS (gits://) client side support (part 1 of 2)
  Git-over-TLS (gits://) client side support (part 2 of 2)

 Makefile                               |   23 +-
 git-over-tls/.gitignore                |    5 +
 git-over-tls/Makefile                  |   46 ++
 git-over-tls/cbuffer.c                 |  504 ++++++++++++
 git-over-tls/cbuffer.h                 |  304 +++++++
 git-over-tls/certificate.c             |  306 +++++++
 git-over-tls/certificate.h             |   28 +
 git-over-tls/connect.c                 |  263 ++++++
 git-over-tls/connect.h                 |   14 +
 git-over-tls/genkeypair.c              |   38 +
 git-over-tls/gensrpverifier.c          |  372 +++++++++
 git-over-tls/getkeyid.c                |  118 +++
 git-over-tls/gits-send-special-command |   22 +
 git-over-tls/home.c                    |   47 ++
 git-over-tls/home.h                    |   13 +
 git-over-tls/hostkey.c                 |  116 +++
 git-over-tls/hostkey.h                 |   15 +
 git-over-tls/hostkeymanager.c          |  305 +++++++
 git-over-tls/keypairs.c                |   60 ++
 git-over-tls/keypairs.h                |   16 +
 git-over-tls/main.c                    |  460 +++++++++++
 git-over-tls/misc.c                    |   15 +
 git-over-tls/misc.h                    |   27 +
 git-over-tls/mkcert.c                  |  507 ++++++++++++
 git-over-tls/prompt.c                  |  100 +++
 git-over-tls/prompt.h                  |   18 +
 git-over-tls/srp_askpass.c             |   90 ++
 git-over-tls/srp_askpass.h             |   14 +
 git-over-tls/user.c                    | 1384 ++++++++++++++++++++++++++++++++
 git-over-tls/user.h                    |  357 ++++++++
 30 files changed, 5585 insertions(+), 2 deletions(-)
 create mode 100644 git-over-tls/.gitignore
 create mode 100644 git-over-tls/Makefile
 create mode 100644 git-over-tls/cbuffer.c
 create mode 100644 git-over-tls/cbuffer.h
 create mode 100644 git-over-tls/certificate.c
 create mode 100644 git-over-tls/certificate.h
 create mode 100644 git-over-tls/connect.c
 create mode 100644 git-over-tls/connect.h
 create mode 100644 git-over-tls/genkeypair.c
 create mode 100644 git-over-tls/gensrpverifier.c
 create mode 100644 git-over-tls/getkeyid.c
 create mode 100755 git-over-tls/gits-send-special-command
 create mode 100644 git-over-tls/home.c
 create mode 100644 git-over-tls/home.h
 create mode 100644 git-over-tls/hostkey.c
 create mode 100644 git-over-tls/hostkey.h
 create mode 100644 git-over-tls/hostkeymanager.c
 create mode 100644 git-over-tls/keypairs.c
 create mode 100644 git-over-tls/keypairs.h
 create mode 100644 git-over-tls/main.c
 create mode 100644 git-over-tls/misc.c
 create mode 100644 git-over-tls/misc.h
 create mode 100644 git-over-tls/mkcert.c
 create mode 100644 git-over-tls/prompt.c
 create mode 100644 git-over-tls/prompt.h
 create mode 100644 git-over-tls/srp_askpass.c
 create mode 100644 git-over-tls/srp_askpass.h
 create mode 100644 git-over-tls/user.c
 create mode 100644 git-over-tls/user.h
