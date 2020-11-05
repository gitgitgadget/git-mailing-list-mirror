Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A707C388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98BBA20728
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="YbEUjY66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbgKEVIn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 16:08:43 -0500
Received: from avasout03.plus.net ([84.93.230.244]:34225 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEVIn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 16:08:43 -0500
Received: from [10.0.2.15] ([195.213.6.50])
        by smtp with ESMTPA
        id amUqkLtMT99nqamUrkhVkB; Thu, 05 Nov 2020 21:08:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1604610522; bh=2LJeG7qTZ2YjWCVZAzXCMsM3m4Os1+pFTmUUO+zrb9M=;
        h=To:Cc:From:Subject:Date;
        b=YbEUjY66zVDQ0LwDp6levnQ54/9zgJMXMJj3ED2tYJXcQQD2c16chbLpdRoV4iE05
         FstrQxNLj0T2Mt6GTK7oe1rBPau2P5MTXLm1xR4ej/k5nJfOuUVVrkSZbDAm0drmk9
         PB3KK58HqKMrDDmIxQJ/rA9uxqc4SGIYflTgEAWl136PqEWw4WYVPvuo20ChPCKaFk
         OTWuKw1VQvPD8Mn/0TgOwrdCEVlycuzWxkD7k0+YGh/0t3v0ceyO2BZQLpRtfr8iow
         LfN/IFiNHDNw/n40PGVlipupFt72lGX10gSD23cJ0c4gJrfy+sbKtG2o6XHPGusD4m
         4rYHlubfH1VpA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Uoz4y94B c=1 sm=1 tr=0
 a=n8v6pzUV7wpcOOJT0hzGjw==:117 a=n8v6pzUV7wpcOOJT0hzGjw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=12cImHxmkD7F_EgP1BAA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     GIT Mailing-list <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 6/8] Makefile: don't use a versioned temp distribution
 directory
Message-ID: <5add11fe-6d94-f2e0-f91c-360a7844c720@ramsayjones.plus.com>
Date:   Thu, 5 Nov 2020 21:08:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBOmjz7Y3PvEPpY9ENNebuPF5dMCD7Nde3uVSaQQW2wt94BsSV8QJmP3Dpa/tTInyVbMplfj7ZLZrdCzQ6G07ufmBAdddLDuBR63s7e9DJZ7pqHg9Wng
 KFf1HdN+a+BqbEtjOFz9hwZ/ox8wh0Vt5eBiN6yw7036DjJ3EQ4o8CybaWO11UmKx/gbIvZzYEwPVQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


The 'dist' target uses a versioned temp directory, $(GIT_TARNAME), into
which it copies various files added to the distibution tarball. A future
patch requires the 'clean' target not to depend on the $(GIT_VERSION)
variable. However, the $(GIT_TARNAME) variable contains $(GIT_VERSION) in
its definition.

Create an '.dist-tmp-dir' directory and copy the various files into this
now un-versioned directory while creating the distribution tarball. Change
the 'clean' target to remove the '.dist-tmp-dir' directory, instead of the
version dependent $(GIT_TARNAME) directory.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Makefile | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 09d6f23b88..90e91a2185 100644
--- a/Makefile
+++ b/Makefile
@@ -3060,9 +3060,9 @@ GIT_TARNAME = git-$(GIT_VERSION)
 GIT_ARCHIVE_EXTRA_FILES = \
 	--prefix=$(GIT_TARNAME)/ \
 	--add-file=configure \
-	--add-file=$(GIT_TARNAME)/version \
+	--add-file=.dist-tmp-dir/version \
 	--prefix=$(GIT_TARNAME)/git-gui/ \
-	--add-file=$(GIT_TARNAME)/git-gui/version
+	--add-file=.dist-tmp-dir/git-gui/version
 ifdef DC_SHA1_SUBMODULE
 GIT_ARCHIVE_EXTRA_FILES += \
 	--prefix=$(GIT_TARNAME)/sha1collisiondetection/ \
@@ -3074,13 +3074,14 @@ GIT_ARCHIVE_EXTRA_FILES += \
 	--add-file=sha1collisiondetection/lib/ubc_check.h
 endif
 dist: git-archive$(X) configure
-	@mkdir -p $(GIT_TARNAME)
-	@echo $(GIT_VERSION) > $(GIT_TARNAME)/version
-	@$(MAKE) -C git-gui TARDIR=../$(GIT_TARNAME)/git-gui dist-version
+	@$(RM) -r .dist-tmp-dir
+	@mkdir .dist-tmp-dir
+	@echo $(GIT_VERSION) > .dist-tmp-dir/version
+	@$(MAKE) -C git-gui TARDIR=../.dist-tmp-dir/git-gui dist-version
 	./git-archive --format=tar \
 		$(GIT_ARCHIVE_EXTRA_FILES) \
 		--prefix=$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
-	@$(RM) -r $(GIT_TARNAME)
+	@$(RM) -r .dist-tmp-dir
 	gzip -f -9 $(GIT_TARNAME).tar
 
 rpm::
@@ -3149,7 +3150,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
 	$(RM) -r po/build/
 	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope*
-	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
+	$(RM) -r .dist-tmp-dir .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
-- 
2.29.0
