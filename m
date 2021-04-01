Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92534C433ED
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6860560FEE
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhDABcr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbhDABcO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:32:14 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8A4C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:32:14 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id f1so706049ilk.11
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jz71OwX2mhnld42oU5AmQMnyPJvmax1ULMMxUqRAWeA=;
        b=IcvjyOAbRllbJ8mIgFabzxr8frv920qHaeDRVZRkjgmEHWHpjexTNvLiFC3gftQd1L
         /94nR7FmrIGwFF0acb2+8b4Pw4gtBcGUptGeNKi4s4Zz8MAmeMdNpAlPi1+qxrd6b5OY
         9uRj3s7a8OHUTdzekbQ7kwPErJmUuV+TQeFLSkbHOJUws9dvEYMaMQmgdwgcToeVjeHZ
         I697Ba4fwkSPE95uX6vF2ivqwV98+wEricE7K6TyefeDNV3VPZVYWkBv3aeeAej7EQ3y
         488wdQ2iFc251eaE/cSVrm9IhTl2gAF/+c9H1Ytd0/XaQDQkb5POrNROgxNoF7au8WzZ
         wauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jz71OwX2mhnld42oU5AmQMnyPJvmax1ULMMxUqRAWeA=;
        b=PY0JYVzmD8lIJV/uHQjuk/TDpxV35A/2/CdH7FKXFsIDbHL59+B8EGne5Q7gjMEuky
         I9L5kV2zvfv64dUY2tYm2WPOHgrPd9Iqm3oAj8wbgwWDXGf7w5pMMqOgoj7UmuzkQt+P
         Yl2N6llK10I8KIZ4So5zxCz3uB6H7CqQsH1AeqH6+qaMy/pDF0qDVuEUPCvJaNpx4Jk1
         pcByGWsemr8IZvq69xVP9IFhN7Jn9HO3ScrKV+3MpvGwwlS24KQkj9fooF8ihXjRKGc3
         6SdISFf6JQ298a7YaLCV+mfYqSY01I6eCk/5sgtPEEeALHqVvVEMgDRGS/OIgzutRU2X
         ExGQ==
X-Gm-Message-State: AOAM530y5S++g0Et/EgarRiIQDBvj80Wj88K04QoaiB1gjzQYs8Isnzn
        pYGZrm+Noqvs8IhcorDcbl82cU52x0QzSw==
X-Google-Smtp-Source: ABdhPJzrYpgsVziuKk9eelgDTkYtaRQPz4COqyWSNNQxKbJwVG7KlGohOiRjSWuXfvFfTy9KsIq4Cw==
X-Received: by 2002:a05:6e02:13c8:: with SMTP id v8mr4548314ilj.290.1617240732542;
        Wed, 31 Mar 2021 18:32:12 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:90ff:e0f0:a41:6c5a])
        by smtp.gmail.com with ESMTPSA id o13sm1938149iob.17.2021.03.31.18.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:32:12 -0700 (PDT)
Date:   Wed, 31 Mar 2021 21:32:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Subject: [PATCH 2/3] t/helper/test-bitmap.c: initial commit
Message-ID: <ec974bb0c85bcde00d45e983d701c538488550a6.1617240723.git.me@ttaylorr.com>
References: <cover.1617240723.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617240723.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new 'bitmap' test-tool which can be used to list the commits that
have received bitmaps.

In theory, a determined tester could run 'git rev-list --test-bitmap
<commit>' to check if '<commit>' received a bitmap or not, since
'--test-bitmap' exits with a non-zero code when it can't find the
requested commit.

But this is a dubious behavior to rely on, since arguably 'git
rev-list' could continue its object walk outside of which commits are
covered by bitmaps.

This will be used to test the behavior of 'pack.preferBitmapTips', which
will be added in the following patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Makefile               |  1 +
 t/helper/test-bitmap.c | 24 ++++++++++++++++++++++++
 t/helper/test-tool.c   |  1 +
 t/helper/test-tool.h   |  1 +
 4 files changed, 27 insertions(+)
 create mode 100644 t/helper/test-bitmap.c

diff --git a/Makefile b/Makefile
index 55c8035fa8..89b30495eb 100644
--- a/Makefile
+++ b/Makefile
@@ -693,6 +693,7 @@ X =
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
 TEST_BUILTINS_OBJS += test-advise.o
+TEST_BUILTINS_OBJS += test-bitmap.o
 TEST_BUILTINS_OBJS += test-bloom.o
 TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
diff --git a/t/helper/test-bitmap.c b/t/helper/test-bitmap.c
new file mode 100644
index 0000000000..134a1e9d76
--- /dev/null
+++ b/t/helper/test-bitmap.c
@@ -0,0 +1,24 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "pack-bitmap.h"
+
+static int bitmap_list_commits(void)
+{
+	return test_bitmap_commits(the_repository);
+}
+
+int cmd__bitmap(int argc, const char **argv)
+{
+	setup_git_directory();
+
+	if (argc != 2)
+		goto usage;
+
+	if (!strcmp(argv[1], "list-commits"))
+		return bitmap_list_commits();
+
+usage:
+	usage("\ttest-tool bitmap list-commits");
+
+	return -1;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index f97cd9f48a..a48bd44116 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -15,6 +15,7 @@ struct test_cmd {
 
 static struct test_cmd cmds[] = {
 	{ "advise", cmd__advise_if_enabled },
+	{ "bitmap", cmd__bitmap },
 	{ "bloom", cmd__bloom },
 	{ "chmtime", cmd__chmtime },
 	{ "config", cmd__config },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 28072c0ad5..563fe1b030 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -5,6 +5,7 @@
 #include "git-compat-util.h"
 
 int cmd__advise_if_enabled(int argc, const char **argv);
+int cmd__bitmap(int argc, const char **argv);
 int cmd__bloom(int argc, const char **argv);
 int cmd__chmtime(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
-- 
2.31.1.163.ga65ce7f831

