Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBA5C433E6
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD86461964
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhC2QU5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 12:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhC2QU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 12:20:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663DDC061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:20:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j9so11740251wrx.12
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m5xiZCX2soJcpFcNXwik9gsOi/coEJEkKX582Hbb6d4=;
        b=ogsHTo5OLjYe2nolheuM1puLXUqDXNrhXHO3l5TE97UuPIfItfLjOPMxN1d2PHmUJ3
         C/KlNGxku6lBHuYXjsXU3UONriybbTcguCJN+8KSqtcWfYmY4KWe4sFEG5VDLjfeaHn+
         t1WQCA/EGrqUaQMf4lSdzIyNZnh+K3I+R58+fAS+67/JNuKw8cg/KQzO3PnL8brKIllm
         WmXQdv4KGdndtZ5eP9d3PVz4QcGeJnWI7SeFHFViXZurvyjzGpnwryLS1yQg4BVxinEr
         qZMSSLJNlwS6L3V0l/R4lGjFZHi+wblFaXIySIX0dOWWYA9S01EVqvEvNTemb8aQ4oaa
         UhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m5xiZCX2soJcpFcNXwik9gsOi/coEJEkKX582Hbb6d4=;
        b=MgyyvX9/BFtv2uwk5norm/UExnvgWfv256kkNfHsugjbvuCs3NohXq5VrVZYIQhOFF
         cKAC3C/MfczSqX8yLnEAT2tY1Pu+xMlOCROjUlvCgonOQpLoiz/xpi8R6coHd8NzQQwe
         hfeDxGNg5MhVdV/fRX9VQt1IorhSdg+qo+pz4mU7p8omQDm/CxMcGHubLtoWWdL8Km/h
         vwUuK9ayg4Mzs3O2ZqFnL6kV1dQdYVDq2st5JQZ+UcLztoP6WjE/0fwjBXLL/3y1W8YY
         B/JoLRgMnEmzTAmoaBadT9PZWoakEp8stzYAp3912fUSLVR1uUOYBHD0ihv+XlabCPPr
         l2yQ==
X-Gm-Message-State: AOAM530a6ElMYrz9Yq7VnF0lUSzv8Ba3jH9UxJHCpdhE5XrD5qj16yxC
        icJY1UEZ0UFCFeOBQgVQ0yDM6jYyUjEu9g==
X-Google-Smtp-Source: ABdhPJxyALOhJjX4cujuKXKMejIDw1Repbu3WeLRTIQ+MrDtnzyN6xvNGCYavS0Zwr/TINTaiX+B8Q==
X-Received: by 2002:adf:c64a:: with SMTP id u10mr29372605wrg.412.1617034827957;
        Mon, 29 Mar 2021 09:20:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v18sm31835353wrf.41.2021.03.29.09.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:20:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/5] Makefile: don't needlessly "rm $@ $@+" before "mv $@+ $@"
Date:   Mon, 29 Mar 2021 18:20:10 +0200
Message-Id: <patch-3.6-96e2338ed8e-20210329T161723Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.461.gd47399f6574
In-Reply-To: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
References: <20210307132001.7485-1-avarab@gmail.com> <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that preceding commits have moved the generation of objects and
scripts in the Makefile to use the "[...] -o $@+ && mv $@+ $@" pattern
we can stop removing "$@" and "$@+" before the rule is run.

I suppose that we could leave this at removing "$@" before we start
out, per the "age old convention" comment in[1]. I.e. instead of:

    rm -f thing thing+
    prepare contents for thing >thing+
    mv thing+ thing

Do:

    rm -f thing
    prepare contents for thing >thing+
    mv thing+ thing

Since the removal of "thing+" is redundant as we're about to clobber
it anyway, but we might be so paranoid as to be guarding against mv(1)
leaving behind a corrupt "thing".

But I think guarding against "mv" failing is a step too far in
paranoia, let's just rely on the "[...] -o $@+ && mv $@+ $@" pattern
working instead.

Especially as we'll see in a follow-up commit, we're just about to use
the GNU make ".DELETE_ON_ERROR" feature, which will reliably do this
for us.

1. http://lore.kernel.org/git/xmqqpn097e9o.fsf@gitster.c.googlers.com

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index ef2d4a9973b..f08635067b3 100644
--- a/Makefile
+++ b/Makefile
@@ -2210,7 +2210,6 @@ SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV):\
 	$(perllibdir_SQ)
 define cmd_munge_script
-$(RM) $@ $@+ && \
 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
     -e 's|@@DIFF@@|$(DIFF_SQ)|' \
@@ -2278,8 +2277,7 @@ endif
 PERL_DEFINES += $(gitexecdir) $(perllibdir) $(localedir)
 
 $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
-	$(QUIET_GEN)$(RM) $@ $@+ && \
-	sed -e '1{' \
+	$(QUIET_GEN)sed -e '1{' \
 	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
 	    -e '	r GIT-PERL-HEADER' \
 	    -e '	G' \
@@ -2299,8 +2297,7 @@ GIT-PERL-DEFINES: FORCE
 	    fi
 
 GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
-	$(QUIET_GEN)$(RM) $@ && \
-	INSTLIBDIR='$(perllibdir_SQ)' && \
+	$(QUIET_GEN)INSTLIBDIR='$(perllibdir_SQ)' && \
 	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
 	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
 	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
@@ -2325,8 +2322,7 @@ git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
 	mv $@+ $@
 else # NO_PERL
 $(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
-	$(QUIET_GEN)$(RM) $@ $@+ && \
-	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \
 	    unimplemented.sh >$@+ && \
 	chmod +x $@+ && \
@@ -2339,15 +2335,13 @@ $(SCRIPT_PYTHON_GEN): GIT-BUILD-OPTIONS
 ifndef NO_PYTHON
 $(SCRIPT_PYTHON_GEN): GIT-CFLAGS GIT-PREFIX GIT-PYTHON-VARS
 $(SCRIPT_PYTHON_GEN): % : %.py
-	$(QUIET_GEN)$(RM) $@ $@+ && \
-	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
+	$(QUIET_GEN)sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
 	    $< >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 else # NO_PYTHON
 $(SCRIPT_PYTHON_GEN): % : unimplemented.sh
-	$(QUIET_GEN)$(RM) $@ $@+ && \
-	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's|@@REASON@@|NO_PYTHON=$(NO_PYTHON)|g' \
 	    unimplemented.sh >$@+ && \
 	chmod +x $@+ && \
-- 
2.31.1.461.gd47399f6574

