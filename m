From: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 3/10] Fix installation of templates on ancient systems.
Date: Wed, 2 Aug 2006 02:03:20 +0100
Message-ID: <00aa01c6b5cf$72231f80$c47eedc1@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00AB_01C6B5D7.D3E78780"
X-From: git-owner@vger.kernel.org Wed Aug 02 03:03:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G858f-0006xh-Aj
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 03:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWHBBDD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 21:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWHBBDD
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 21:03:03 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:37385 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750898AbWHBBDB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 21:03:01 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-35.mail.demon.net with smtp (Exim 4.42)
	id 1G858U-000C1I-Io
	for git@vger.kernel.org; Wed, 02 Aug 2006 01:03:00 +0000
To: <git@vger.kernel.org>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24621>

This is a multi-part message in MIME format.

------=_NextPart_000_00AB_01C6B5D7.D3E78780
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Do not use $(call) for 'shell quoting' paths, and pass DESTDIR down
to the templates makefile.

Signed-off-by: Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
---
 Makefile           |    2 +-
 templates/Makefile |   12 +++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index cde619c..180dbd0 100644
--- a/Makefile
+++ b/Makefile
@@ -662,7 +662,7 @@ install: all
 	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(INSTALL) git$X gitk '$(DESTDIR_SQ)$(bindir_SQ)'
-	$(MAKE) -C templates install
+	$(MAKE) -C templates install DESTDIR=$(DESTDIR)
 	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(GIT_PYTHON_DIR_SQ)'
 	$(INSTALL) $(PYMODULES) '$(DESTDIR_SQ)$(GIT_PYTHON_DIR_SQ)'
 	if test 'z$(bindir_SQ)' != 'z$(gitexecdir_SQ)'; \
diff --git a/templates/Makefile b/templates/Makefile
index 8f7f4fe..9e1ae1a 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -6,11 +6,9 @@ prefix ?= $(HOME)
 template_dir ?= $(prefix)/share/git-core/templates/
 # DESTDIR=
 
-# Shell quote;
-# Result of this needs to be placed inside ''
-shq = $(subst ','\'',$(1))
-# This has surrounding ''
-shellquote = '$(call shq,$(1))'
+# Shell quote (do not use $(call) to accomodate ancient setups);
+DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
+template_dir_SQ = $(subst ','\'',$(template_dir))
 
 all: boilerplates.made custom
 
@@ -43,6 +41,6 @@ clean:
 	rm -rf blt boilerplates.made
 
 install: all
-	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(template_dir))
+	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(template_dir_SQ)'
 	(cd blt && $(TAR) cf - .) | \
-	(cd $(call shellquote,$(DESTDIR)$(template_dir)) && $(TAR) xf -)
+	(cd '$(DESTDIR_SQ)$(template_dir_SQ)' && $(TAR) xf -)
-- 
1.4.1

------=_NextPart_000_00AB_01C6B5D7.D3E78780
Content-Type: text/plain;
	name="P0003.TXT"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="P0003.TXT"

RnJvbSA0OTAzZTU0MmY0MzYxZDA2MzYxMDI3YzEwZTM4NzUwZWVlN2ExMjA4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYW1zYXkgQWxsYW4gSm9uZXMgPHJhbXNheUByYW1zYXkxLmRl
bW9uLmNvLnVrPgpEYXRlOiBTYXQsIDI5IEp1bCAyMDA2IDE3OjI1OjAzICswMTAwClN1YmplY3Q6
IFtQQVRDSCAzLzEwXSBGaXggaW5zdGFsbGF0aW9uIG9mIHRlbXBsYXRlcyBvbiBhbmNpZW50IHN5
c3RlbXMuCgpEbyBub3QgdXNlICQoY2FsbCkgZm9yICdzaGVsbCBxdW90aW5nJyBwYXRocywgYW5k
IHBhc3MgREVTVERJUiBkb3duCnRvIHRoZSB0ZW1wbGF0ZXMgbWFrZWZpbGUuCgpTaWduZWQtb2Zm
LWJ5OiBSYW1zYXkgQWxsYW4gSm9uZXMgPHJhbXNheUByYW1zYXkxLmRlbW9uLmNvLnVrPgotLS0K
IE1ha2VmaWxlICAgICAgICAgICB8ICAgIDIgKy0KIHRlbXBsYXRlcy9NYWtlZmlsZSB8ICAgMTIg
KysrKystLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9NYWtlZmlsZSBiL01ha2VmaWxlCmluZGV4IGNkZTYxOWMuLjE4
MGRiZDAgMTAwNjQ0Ci0tLSBhL01ha2VmaWxlCisrKyBiL01ha2VmaWxlCkBAIC02NjIsNyArNjYy
LDcgQEAgaW5zdGFsbDogYWxsCiAJJChJTlNUQUxMKSAtZCAtbTc1NSAnJChERVNURElSX1NRKSQo
Z2l0ZXhlY2Rpcl9TUSknCiAJJChJTlNUQUxMKSAkKEFMTF9QUk9HUkFNUykgJyQoREVTVERJUl9T
USkkKGdpdGV4ZWNkaXJfU1EpJwogCSQoSU5TVEFMTCkgZ2l0JFggZ2l0ayAnJChERVNURElSX1NR
KSQoYmluZGlyX1NRKScKLQkkKE1BS0UpIC1DIHRlbXBsYXRlcyBpbnN0YWxsCisJJChNQUtFKSAt
QyB0ZW1wbGF0ZXMgaW5zdGFsbCBERVNURElSPSQoREVTVERJUikKIAkkKElOU1RBTEwpIC1kIC1t
NzU1ICckKERFU1RESVJfU1EpJChHSVRfUFlUSE9OX0RJUl9TUSknCiAJJChJTlNUQUxMKSAkKFBZ
TU9EVUxFUykgJyQoREVTVERJUl9TUSkkKEdJVF9QWVRIT05fRElSX1NRKScKIAlpZiB0ZXN0ICd6
JChiaW5kaXJfU1EpJyAhPSAneiQoZ2l0ZXhlY2Rpcl9TUSknOyBcCmRpZmYgLS1naXQgYS90ZW1w
bGF0ZXMvTWFrZWZpbGUgYi90ZW1wbGF0ZXMvTWFrZWZpbGUKaW5kZXggOGY3ZjRmZS4uOWUxYWUx
YSAxMDA2NDQKLS0tIGEvdGVtcGxhdGVzL01ha2VmaWxlCisrKyBiL3RlbXBsYXRlcy9NYWtlZmls
ZQpAQCAtNiwxMSArNiw5IEBAIHByZWZpeCA/PSAkKEhPTUUpCiB0ZW1wbGF0ZV9kaXIgPz0gJChw
cmVmaXgpL3NoYXJlL2dpdC1jb3JlL3RlbXBsYXRlcy8KICMgREVTVERJUj0KIAotIyBTaGVsbCBx
dW90ZTsKLSMgUmVzdWx0IG9mIHRoaXMgbmVlZHMgdG8gYmUgcGxhY2VkIGluc2lkZSAnJwotc2hx
ID0gJChzdWJzdCAnLCdcJycsJCgxKSkKLSMgVGhpcyBoYXMgc3Vycm91bmRpbmcgJycKLXNoZWxs
cXVvdGUgPSAnJChjYWxsIHNocSwkKDEpKScKKyMgU2hlbGwgcXVvdGUgKGRvIG5vdCB1c2UgJChj
YWxsKSB0byBhY2NvbW9kYXRlIGFuY2llbnQgc2V0dXBzKTsKK0RFU1RESVJfU1EgPSAkKHN1YnN0
ICcsJ1wnJywkKERFU1RESVIpKQordGVtcGxhdGVfZGlyX1NRID0gJChzdWJzdCAnLCdcJycsJCh0
ZW1wbGF0ZV9kaXIpKQogCiBhbGw6IGJvaWxlcnBsYXRlcy5tYWRlIGN1c3RvbQogCkBAIC00Myw2
ICs0MSw2IEBAIGNsZWFuOgogCXJtIC1yZiBibHQgYm9pbGVycGxhdGVzLm1hZGUKIAogaW5zdGFs
bDogYWxsCi0JJChJTlNUQUxMKSAtZCAtbTc1NSAkKGNhbGwgc2hlbGxxdW90ZSwkKERFU1RESVIp
JCh0ZW1wbGF0ZV9kaXIpKQorCSQoSU5TVEFMTCkgLWQgLW03NTUgJyQoREVTVERJUl9TUSkkKHRl
bXBsYXRlX2Rpcl9TUSknCiAJKGNkIGJsdCAmJiAkKFRBUikgY2YgLSAuKSB8IFwKLQkoY2QgJChj
YWxsIHNoZWxscXVvdGUsJChERVNURElSKSQodGVtcGxhdGVfZGlyKSkgJiYgJChUQVIpIHhmIC0p
CisJKGNkICckKERFU1RESVJfU1EpJCh0ZW1wbGF0ZV9kaXJfU1EpJyAmJiAkKFRBUikgeGYgLSkK
LS0gCjEuNC4xCgo=

------=_NextPart_000_00AB_01C6B5D7.D3E78780--
