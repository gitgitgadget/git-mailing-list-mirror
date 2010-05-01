From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH 0/3] git over TLS (gits://) support
Date: Sat,  1 May 2010 20:09:48 +0300
Message-ID: <1272733791-11341-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 01 19:12:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8GEz-0005jH-GJ
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 19:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897Ab0EARM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 13:12:27 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:59857 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641Ab0EARM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 13:12:26 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 7E71018CF00
	for <git@vger.kernel.org>; Sat,  1 May 2010 20:12:24 +0300 (EEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A02AB85A594; Sat, 01 May 2010 20:12:24 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 6F1C12BD47
	for <git@vger.kernel.org>; Sat,  1 May 2010 20:12:23 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.rc2.10.g714149
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146090>

This is newer version of gits:// client side support.

git over TLS (gits://) is authenticated smart transport that passes
git:// protocol over TLS.

Supported authentication modes:
- Username/Password (SRP)
- OpenPGP keypairs
- SSH keypairs (/w ssh-agent support)

The patch is split to three parts due to its size. Especially the
authentication parts are large (and the parts used to deal with
the connection with server are also large).

The repository (containing server code and selfstanding version of
client code is at): http://repo.or.cz/w/git-daemon2.git/

Ilari Liusvaara (3):
  git over TLS (gits://) support (part 1)
  git over TLS (gits://) support (part 2)
  git over TLS (gits://) support (part 3)

 Makefile                                     |   25 +-
 git-over-tls/.gitignore                      |    5 +
 git-over-tls/Makefile                        |   45 +
 git-over-tls/base64.c                        |  171 +++
 git-over-tls/base64.h                        |   21 +
 git-over-tls/cbuffer.c                       |  504 ++++++++
 git-over-tls/cbuffer.h                       |  304 +++++
 git-over-tls/certificate.c                   |  306 +++++
 git-over-tls/certificate.h                   |   28 +
 git-over-tls/connect.c                       |  275 +++++
 git-over-tls/connect.h                       |   17 +
 git-over-tls/genkeypair.c                    |   38 +
 git-over-tls/gensrpverifier.c                |  377 ++++++
 git-over-tls/getkeyid.c                      |  179 +++
 git-over-tls/gits-send-special-command       |   22 +
 git-over-tls/gits-send-special-command-nourl |   23 +
 git-over-tls/home.c                          |  229 ++++
 git-over-tls/home.h                          |   71 ++
 git-over-tls/hostkey.c                       |   81 ++
 git-over-tls/hostkey.h                       |   15 +
 git-over-tls/keypairs.c                      |   60 +
 git-over-tls/keypairs.h                      |   16 +
 git-over-tls/main.c                          |  684 +++++++++++
 git-over-tls/misc.c                          |   15 +
 git-over-tls/misc.h                          |   27 +
 git-over-tls/mkcert.c                        |  474 ++++++++
 git-over-tls/pem.c                           |  362 ++++++
 git-over-tls/pem.h                           |   16 +
 git-over-tls/pem_decrypt.c                   |  203 ++++
 git-over-tls/pem_decrypt.h                   |    9 +
 git-over-tls/prompt.c                        |  100 ++
 git-over-tls/prompt.h                        |   18 +
 git-over-tls/srp_askpass.c                   |  110 ++
 git-over-tls/srp_askpass.h                   |   16 +
 git-over-tls/ssh.c                           |  635 ++++++++++
 git-over-tls/ssh.h                           |   18 +
 git-over-tls/ssh_localkey.c                  |  435 +++++++
 git-over-tls/ssh_localkey.h                  |   18 +
 git-over-tls/user.c                          | 1597 ++++++++++++++++++++++++++
 git-over-tls/user.h                          |  367 ++++++
 40 files changed, 7913 insertions(+), 3 deletions(-)
 create mode 100644 git-over-tls/.gitignore
 create mode 100644 git-over-tls/Makefile
 create mode 100644 git-over-tls/base64.c
 create mode 100644 git-over-tls/base64.h
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
 create mode 100755 git-over-tls/gits-send-special-command-nourl
 create mode 100644 git-over-tls/home.c
 create mode 100644 git-over-tls/home.h
 create mode 100644 git-over-tls/hostkey.c
 create mode 100644 git-over-tls/hostkey.h
 create mode 100644 git-over-tls/keypairs.c
 create mode 100644 git-over-tls/keypairs.h
 create mode 100644 git-over-tls/main.c
 create mode 100644 git-over-tls/misc.c
 create mode 100644 git-over-tls/misc.h
 create mode 100644 git-over-tls/mkcert.c
 create mode 100644 git-over-tls/pem.c
 create mode 100644 git-over-tls/pem.h
 create mode 100644 git-over-tls/pem_decrypt.c
 create mode 100644 git-over-tls/pem_decrypt.h
 create mode 100644 git-over-tls/prompt.c
 create mode 100644 git-over-tls/prompt.h
 create mode 100644 git-over-tls/srp_askpass.c
 create mode 100644 git-over-tls/srp_askpass.h
 create mode 100644 git-over-tls/ssh.c
 create mode 100644 git-over-tls/ssh.h
 create mode 100644 git-over-tls/ssh_localkey.c
 create mode 100644 git-over-tls/ssh_localkey.h
 create mode 100644 git-over-tls/user.c
 create mode 100644 git-over-tls/user.h
