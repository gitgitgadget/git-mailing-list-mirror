From: Tor Arntsen <tor@spacetec.no>
Subject: [PATCH] Add Tru64/OSF1 support in Makefile
Date: Tue, 30 Mar 2010 20:22:21 +0200
Message-ID: <d2d39d861003301122p646efc1fj9d88af1893b84b3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001485f8eff2e07b4c048308b5ca
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 30 20:22:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwg57-0000mT-EJ
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 20:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384Ab0C3SWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 14:22:24 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:39111 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855Ab0C3SWX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 14:22:23 -0400
Received: by fxm23 with SMTP id 23so545450fxm.21
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 11:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:received:message-id:subject:from:to
         :content-type;
        bh=6YAw+R0WCIFFQ6BHhzcIrQgbpEkh02iC4gnVZbjjAK8=;
        b=ZAbUqi3NYDMcV8H+/QKlO8mFx/DSqAXRVbVNIApyoGsZWe5+AcbK05Nkq9HgIomf1Z
         qKkpvffUc7+DK2vDjWtat9lPJan5nCm3D8xX6XBx1bA7guBO9OkCxIb38vAmInQAr2hy
         b3ur6fqD9Hue7snE5bKQc2KPMtpnONnSbGjQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=w+UuVTDJz+tszTl9Vp/KxIgpt3nkHSKbGraOyeSYF6ddK+2GCEuTuB82oNOCwy7t3q
         BdU+OBrD5gbnDTF+uA3IlxiEqM/oO6xQ2dZrFX1GnMbDLzd1DCxKM1ntsdR3oU1ZTy4q
         Jdn+U3qzOp64aUEIyEwHYtsjfhzSDxZnI0Gfs=
Received: by 10.239.138.80 with HTTP; Tue, 30 Mar 2010 11:22:21 -0700 (PDT)
X-Google-Sender-Auth: 0e6bd01125e784e7
Received: by 10.239.156.84 with SMTP id l20mr9371hbc.64.1269973341207; Tue, 30 
	Mar 2010 11:22:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143587>

--001485f8eff2e07b4c048308b5ca
Content-Type: text/plain; charset=ISO-8859-1

This patch to Makefile makes git build for me on Tru64/OSF1 V5.1 with
the native compiler.

It needs libcurl installed either in /usr or /usr/local, and ditto for
zlib. The zlib installed on my old Tru64 box is from the original
'apt-like' tachometer repository at hp.com, now gone. That version is
pretty old, so my patch includes 'NO_DEFLATE_BOUND'. tcl/tk (included
standard on Tru64) is 8.2 which is too old, so that one (and thus
'gitk') is also disabled in the patch. If someone has V5.2 or newer
they could check tcl/tk version etc., add some $(uname_R) directives
and adjust as necessary.

The resulting git version is fully working (as far as I can tell), and
now in use for the Tru64 autobuilds at http://curl.haxx.se/auto/
(which just does 'git pull' regularly). And the patch is produced
locally on the Tru64 machine, with git, obviously.

Patch included below, as well as attached (in case of
mailler-mangling). Please let me know if you feel there are any issues
with it.

-Tor

>From d4a5ba0727d7e3a4455320bad641cb34402d16fd Mon Sep 17 00:00:00 2001
From: Tor Arntsen <tor@spacetec.no>
Date: Tue, 30 Mar 2010 19:36:40 +0200
Subject: [PATCH] Add Tru64/OSF1 support in Makefile

Tested with V5.1
Needs libcurl and zlib in /usr/local. zlib may be e.g. the original
Tru64 tachometer-freeware version (1.1.4) or newer.

Signed-off-by: Tor Arntsen <tor@spacetec.no>
---
 Makefile |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 3a6c6ea..8041bde 100644
--- a/Makefile
+++ b/Makefile
@@ -758,6 +758,32 @@ ifeq ($(uname_S),UnixWare)
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
 endif
+ifeq ($(uname_S),OSF1)
+	# Tested with V5.1 w/libcurl and zlib-1.1.4-5 in /usr/local/
+	CC = cc
+	CFLAGS = -O2 -g3
+	SHELL_PATH = /bin/ksh
+	BASIC_CFLAGS += -D_POSIX_C_SOURCE=1 -D_OSF_SOURCE=1
+	BASIC_CFLAGS += -pthread
+	BASIC_CFLAGS += -I/usr/local/include
+	BASIC_LDFLAGS += -L/usr/local/lib
+	NO_STRCASESTR = YesPlease
+	NO_STRTOUMAX = YesPlease
+	NO_STRTOULL = YesPlease
+	NO_STRLCPY = YesPlease
+	NO_MEMMEM = YesPlease
+	NO_PYTHON = YesPlease
+	NO_NSEC = YesPlease
+	NO_OPENSSL = YesPlease
+	NO_UINTMAX_T = YesPlease
+	NO_C99_FORMAT = YesPlease
+	NEEDS_LIBICONV = YesPlease
+	NO_DEFLATE_BOUND = YesPlease
+	# V5.1 has tcl/tk 8.2, which doesn't work.
+	# V5.2 could possibly have a working version (8.4 or newer).
+	NO_TCLTK = YesPlease
+	NO_EXPAT = YesPlease
+endif
 ifeq ($(uname_S),SCO_SV)
 	ifeq ($(uname_R),3.2)
 		CFLAGS = -O2
-- 
1.7.0.3.313.g87b3c.dirty

--001485f8eff2e07b4c048308b5ca
Content-Type: application/octet-stream; 
	name="0001-Add-Tru64-OSF1-support-in-Makefile.patch"
Content-Disposition: attachment; 
	filename="0001-Add-Tru64-OSF1-support-in-Makefile.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

RnJvbSBkNGE1YmEwNzI3ZDdlM2E0NDU1MzIwYmFkNjQxY2IzNDQwMmQxNmZkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUb3IgQXJudHNlbiA8dG9yQHNwYWNldGVjLm5vPgpEYXRlOiBU
dWUsIDMwIE1hciAyMDEwIDE5OjM2OjQwICswMjAwClN1YmplY3Q6IFtQQVRDSF0gQWRkIFRydTY0
L09TRjEgc3VwcG9ydCBpbiBNYWtlZmlsZQoKVGVzdGVkIHdpdGggVjUuMQpOZWVkcyBsaWJjdXJs
IGFuZCB6bGliIGluIC91c3IvbG9jYWwuIHpsaWIgbWF5IGJlIGUuZy4gdGhlIG9yaWdpbmFsClRy
dTY0IHRhY2hvbWV0ZXItZnJlZXdhcmUgdmVyc2lvbiAoMS4xLjQpIG9yIG5ld2VyLgoKU2lnbmVk
LW9mZi1ieTogVG9yIEFybnRzZW4gPHRvckBzcGFjZXRlYy5ubz4KLS0tCiBNYWtlZmlsZSB8ICAg
MjYgKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0
aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9NYWtlZmlsZSBiL01ha2VmaWxl
CmluZGV4IDNhNmM2ZWEuLjgwNDFiZGUgMTAwNjQ0Ci0tLSBhL01ha2VmaWxlCisrKyBiL01ha2Vm
aWxlCkBAIC03NTgsNiArNzU4LDMyIEBAIGlmZXEgKCQodW5hbWVfUyksVW5peFdhcmUpCiAJTk9f
U1RSQ0FTRVNUUiA9IFllc1BsZWFzZQogCU5PX01FTU1FTSA9IFllc1BsZWFzZQogZW5kaWYKK2lm
ZXEgKCQodW5hbWVfUyksT1NGMSkKKwkjIFRlc3RlZCB3aXRoIFY1LjEgdy9saWJjdXJsIGFuZCB6
bGliLTEuMS40LTUgaW4gL3Vzci9sb2NhbC8KKwlDQyA9IGNjCisJQ0ZMQUdTID0gLU8yIC1nMwor
CVNIRUxMX1BBVEggPSAvYmluL2tzaAorCUJBU0lDX0NGTEFHUyArPSAtRF9QT1NJWF9DX1NPVVJD
RT0xIC1EX09TRl9TT1VSQ0U9MQorCUJBU0lDX0NGTEFHUyArPSAtcHRocmVhZAorCUJBU0lDX0NG
TEFHUyArPSAtSS91c3IvbG9jYWwvaW5jbHVkZQorCUJBU0lDX0xERkxBR1MgKz0gLUwvdXNyL2xv
Y2FsL2xpYgorCU5PX1NUUkNBU0VTVFIgPSBZZXNQbGVhc2UKKwlOT19TVFJUT1VNQVggPSBZZXNQ
bGVhc2UKKwlOT19TVFJUT1VMTCA9IFllc1BsZWFzZQorCU5PX1NUUkxDUFkgPSBZZXNQbGVhc2UK
KwlOT19NRU1NRU0gPSBZZXNQbGVhc2UKKwlOT19QWVRIT04gPSBZZXNQbGVhc2UKKwlOT19OU0VD
ID0gWWVzUGxlYXNlCisJTk9fT1BFTlNTTCA9IFllc1BsZWFzZQorCU5PX1VJTlRNQVhfVCA9IFll
c1BsZWFzZQorCU5PX0M5OV9GT1JNQVQgPSBZZXNQbGVhc2UKKwlORUVEU19MSUJJQ09OViA9IFll
c1BsZWFzZQorCU5PX0RFRkxBVEVfQk9VTkQgPSBZZXNQbGVhc2UKKwkjIFY1LjEgaGFzIHRjbC90
ayA4LjIsIHdoaWNoIGRvZXNuJ3Qgd29yay4KKwkjIFY1LjIgY291bGQgcG9zc2libHkgaGF2ZSBh
IHdvcmtpbmcgdmVyc2lvbiAoOC40IG9yIG5ld2VyKS4KKwlOT19UQ0xUSyA9IFllc1BsZWFzZQor
CU5PX0VYUEFUID0gWWVzUGxlYXNlCitlbmRpZgogaWZlcSAoJCh1bmFtZV9TKSxTQ09fU1YpCiAJ
aWZlcSAoJCh1bmFtZV9SKSwzLjIpCiAJCUNGTEFHUyA9IC1PMgotLSAKMS43LjAuMy4zMTMuZzg3
YjNjLmRpcnR5Cgo=
--001485f8eff2e07b4c048308b5ca--
