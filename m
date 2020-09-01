Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F04FC433E6
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 22:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 028552071B
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 22:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgIAW2L convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 1 Sep 2020 18:28:11 -0400
Received: from elephants.elehost.com ([216.66.27.132]:56187 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgIAW2K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 18:28:10 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 081MS8Wr074677
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Tue, 1 Sep 2020 18:28:08 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'git'" <git@vger.kernel.org>
Subject: [Suggestion] Documentation: quick-install-man not propagating DESTDIR
Date:   Tue, 1 Sep 2020 18:28:02 -0400
Message-ID: <077a01d680af$2ad65510$8082ff30$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdaAros2Jy65ab9CQhOKpiAftHgG4g==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The make quick-install-man rule is not propagating DESTDIR when GNU Make
4.2.1 is used.

It seems like a bit of a nit to report this, but I discovered that the
installation is not putting the manuals in the same place as git. It’s a
pretty simple fix. I can put a patch together if desired.

diff --git a/Makefile b/Makefile
index 372139f1f2..dae2d99a7f 100644
--- a/Makefile
+++ b/Makefile
@@ -2992,10 +2992,10 @@ install-gitweb:
        $(MAKE) -C gitweb install

install-doc: install-man-perl
-       $(MAKE) -C Documentation install
+       $(MAKE) -C Documentation install DESTDIR=$(DESTDIR)

install-man: install-man-perl
-       $(MAKE) -C Documentation install-man
+       $(MAKE) -C Documentation install-man DESTDIR=$(DESTDIR)

install-man-perl: man-perl
        $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mandir_SQ)/man3'
@@ -3006,19 +3006,19 @@ install-html:
        $(MAKE) -C Documentation install-html

install-info:
-       $(MAKE) -C Documentation install-info
+       $(MAKE) -C Documentation install-info DESTDIR=$(DESTDIR)

install-pdf:
-       $(MAKE) -C Documentation install-pdf
+       $(MAKE) -C Documentation install-pdf DESTDIR=$(DESTDIR)

quick-install-doc:
-       $(MAKE) -C Documentation quick-install
+       $(MAKE) -C Documentation quick-install DESTDIR=$(DESTDIR)

quick-install-man:
-       $(MAKE) -C Documentation quick-install-man
+       $(MAKE) -C Documentation quick-install-man DESTDIR=$(DESTDIR)

quick-install-html:
-       $(MAKE) -C Documentation quick-install-html
+       $(MAKE) -C Documentation quick-install-html DESTDIR=$(DESTDIR)

-- Brief whoami:
NonStop developer since approximately 211288444200000000
UNIX developer since approximately 421664400
-- In my real life, I talk too much.


