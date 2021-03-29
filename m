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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BC9C433E8
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F8A9619A7
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhC2QUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 12:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhC2QUa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 12:20:30 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37741C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:20:30 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id k128so6902039wmk.4
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5G3mTCDjnzB4lUwb20mhFbw/FfeCyhwsiq4w0gaedGo=;
        b=L/MZ5a+7AZS0dKylEEEPe9nf42diJMuXxrFRNMEKDsQQY4URNKJcyVi6RdKtK2/rK3
         x0hW/6enVvBJidmIWpRdKKvgv+g06PAVeC1CPLXJB8CkaHKp2b7xvNU1pXjNUtiO0mXL
         Nm8hN8ioxKpIOXxMi28tYmaYEB/LHSZdaKpCtCdklVZdD22NEc+t2PQ321c/AsjCdk+h
         uIWIIn2cNgT/z96MdeyvpuA72d7JjmYPuLNMSQz8yy8VtEPvCCZPKzLMGJLu6JejsS20
         AWNOjmGNdnnRqdPIvM28lOdOGwa9GhSfdiPZCLT3085iYEWv3rHn9VfTQCM3fPy9nHp6
         lXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5G3mTCDjnzB4lUwb20mhFbw/FfeCyhwsiq4w0gaedGo=;
        b=Ri0bHYgR0MTWMN444xbQ2EZ7sQdUV/rJfGJ4Kjm3LfLMdDYlB9qW5asG3QMSsXRplu
         dUxy3h9IpMWMpNzUEKYbF20Oovqqd0GZfdqNd87uGQKDP2lkJZc+ZM9X0IwhsiP73Gmc
         x1PmEp/WGTL/Wf+Q8zn8DPqK616U/ZScopdzxhvZViSciO4EHyvcalYIKtjs41mE5QsM
         Ib3Ti59up2+bj9JA5j/ZKPdrjXun/NigNzzD6HD7+/VfyfJzw21xdpKj/vOsKgGHq9jP
         id+7mw2v4Mdc/6kVz/eP7tMmjhXt7kpocsuUCXFqbel0UyKRADTnm4FGR8BSHGCbt/jl
         /hIw==
X-Gm-Message-State: AOAM533sQzRsp0+swdLIhzkWJPlw/kWz0iZsztXYyI7QTRSMeKocRQTn
        zBIX4q9fX7BIzok1mGIJg8Lf8DPls4gvPw==
X-Google-Smtp-Source: ABdhPJylLVYvBt/GcqguTF/JZkuOQMV9JKh8dTGPim6l+AEMhJx9WTyBMlDxtcB0JWW2V0Aot8V2QA==
X-Received: by 2002:a05:600c:47d7:: with SMTP id l23mr26206244wmo.155.1617034828717;
        Mon, 29 Mar 2021 09:20:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v18sm31835353wrf.41.2021.03.29.09.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:20:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/5] Makefile: add the ".DELETE_ON_ERROR" flag
Date:   Mon, 29 Mar 2021 18:20:11 +0200
Message-Id: <patch-4.6-2ff6359c273-20210329T161723Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.461.gd47399f6574
In-Reply-To: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
References: <20210307132001.7485-1-avarab@gmail.com> <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the GNU make ".DELETE_ON_ERROR" flag. As discussed in preceding
commits we're now less paranoid about "mv" failing, let's bring that
paranoia back in a way that makes more sense, and applies to all rules
in the Makefile.

Now if a command to make X fails X will be removed, the default
behavior of GNU make is to only do so if "make" itself is interrupted
with a signal.

E.g. if we now intentionally break one of the rules with:

    -       mv $@+ $@
    +       mv $@+ $@ && \
    +       false

We'll get output like:

    $ make git
        CC git.o
        LINK git
    make: *** [Makefile:2179: git] Error 1
    make: *** Deleting file 'git'
    $ file git
    git: cannot open `git' (No such file or directory)

Before this change we'd leave the file in place in under this
scenario.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index f08635067b3..573bce20357 100644
--- a/Makefile
+++ b/Makefile
@@ -2126,6 +2126,16 @@ shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
 strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $^
 
+### Flags affecting all rules
+
+# A GNU make extension since gmake 3.72 (released in late 1994) to
+# remove the target of rules if commands in those rules fail. The
+# default is to only do that if make itself receives a signal. Affects
+# all targets, see:
+#
+#    info make --index-search=.DELETE_ON_ERROR
+.DELETE_ON_ERROR:
+
 ### Target-specific flags and dependencies
 
 # The generic compilation pattern rule and automatically
-- 
2.31.1.461.gd47399f6574

