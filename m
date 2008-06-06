From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGIT PATCH 5/5] Add test_patches target to Makefile
Date: Fri, 06 Jun 2008 21:46:11 +0100
Message-ID: <20080606204611.8805.45597.stgit@localhost.localdomain>
References: <20080606204322.8805.32313.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 22:47:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4iqP-0001dA-Ni
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 22:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbYFFUqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 16:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765001AbYFFUqQ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 16:46:16 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:17029 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764833AbYFFUqP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jun 2008 16:46:15 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com with ESMTP
          id <20080606205133.LOWS16629.mtaout03-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Fri, 6 Jun 2008 21:51:33 +0100
Received: from localhost.localdomain ([86.7.22.36])
          by aamtaout03-winn.ispmail.ntl.com with ESMTP
          id <20080606205515.LHJT8797.aamtaout03-winn.ispmail.ntl.com@localhost.localdomain>;
          Fri, 6 Jun 2008 21:55:15 +0100
In-Reply-To: <20080606204322.8805.32313.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.2.168.ge637
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84110>

This target tests individual patches in the series.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 Makefile |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index c890b8e..e5c002a 100644
--- a/Makefile
+++ b/Makefile
@@ -2,6 +2,8 @@ PREFIX	?= $(HOME)
 DESTDIR	?= /
 PYTHON	?= python
 
+TEST_PATCHES ?= ..
+
 all:
 	$(PYTHON) setup.py build
 
@@ -14,6 +16,11 @@ doc:
 test:
 	cd t && $(MAKE) all
 
+test_patches:
+	for patch in $$(stg series --noprefix $(TEST_PATCHES)); do \
+		stg goto $$patch && $(MAKE) test || break; \
+	done
+
 clean:
 	for dir in Documentation t; do \
 		(cd $$dir && $(MAKE) clean); \
@@ -26,4 +33,4 @@ clean:
 tags:
 	ctags -e -R stgit/*
 
-.PHONY: all install doc test clean
+.PHONY: all install doc test test_patches clean
