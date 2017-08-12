Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1553C208CD
	for <e@80x24.org>; Sat, 12 Aug 2017 13:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750975AbdHLNt7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 09:49:59 -0400
Received: from mail.teddy.ch ([82.197.162.18]:35054 "EHLO mail.teddy.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbdHLNt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2017 09:49:58 -0400
X-Greylist: delayed 337 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Aug 2017 09:49:57 EDT
Received: from [192.168.0.118] (adsl-178-38-69-218.adslplus.ch [178.38.69.218])
        (authenticated bits=0)
        by mail.teddy.ch (8.15.2/8.15.2/Teddy) with ESMTPSA id v7CDiHJd014584
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <git@vger.kernel.org>; Sat, 12 Aug 2017 15:44:17 +0200
To:     git@vger.kernel.org
From:   "Dominik Mahrer (Teddy)" <teddy@teddy.ch>
Subject: NO_MSGFMT
Message-ID: <b6b12040-100f-5965-6dfd-344c84dddf96@teddy.ch>
Date:   Sat, 12 Aug 2017 15:44:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
X-Milter-Limit: Version: 1.0.1; IP-Address: 178.38.69.218; Host: mail
X-Milter-Log: Version: 1.0.2; Logged as: logall-170812154417-0Wlfsz; Host: mail
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.teddy.ch [82.197.162.18]); Sat, 12 Aug 2017 15:44:18 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all

I'm compiling git from source code on a mashine without msgfmt. This 
leads to compile errors. To be able to compile git I created a patch 
that at least works for me:

diff -Naur ../git-2.14.1.orig/Makefile ./Makefile
--- ../git-2.14.1.orig/Makefile	2017-08-09 21:54:31.000000000 +0200
+++ ./Makefile	2017-08-12 15:22:06.000000000 +0200
@@ -2261,7 +2261,11 @@
  endif

  po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
+ifndef NO_MSGFMT
  	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
+else
+	@echo Skipping file $@
+endif

  FIND_SOURCE_FILES = ( \
  	git ls-files \
@@ -2523,7 +2527,9 @@
  endif
  ifndef NO_TCLTK
  	$(MAKE) -C gitk-git install
-	$(MAKE) -C git-gui gitexecdir='$(gitexec_instdir_SQ)' install
+	ifndef NO_MSGFMT
+		$(MAKE) -C git-gui gitexecdir='$(gitexec_instdir_SQ)' install
+	endif
  endif
  ifneq (,$X)
  	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) 
$(BUILT_INS) git$X)), test '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p' -ef 
'$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p$X' || $(RM) 
'$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)



It would be great if it (or something similar) could be included in git.

Regards
Teddy
