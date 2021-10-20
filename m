Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CF4C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60069610D0
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhJTSml (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 14:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhJTSm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 14:42:29 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28951C06176C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:40:13 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id g39so16472399wmp.3
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nd8Xd2ivaTKtzZWuGBA7aJ+VshyewN7yC9C84sKUUxQ=;
        b=DIcaRRo2mC1LbgXOHVcizHrQ706Ne/LL/9qHthM0vafaf//i+Ma0mZoxvy1kd65OSx
         IN7jp3b+GDzas6LJ1DF+DlrStgnYywkWlZFWCNUw5Xu/TDT4zWpZSb+1nP40Dfye7gHd
         kS8xhBey1c69DSQFf0nFpoNh41qM+D7945YBej3ZPAXcGFg36FqP2AXLbSZBut1kLBU4
         sD4roI1Ag5tQKnT4CsAPlWq1ptJhOH8aNliD4ueiQgu4WVP1dximTVpR7pdXcuJVNs2f
         2RXHJgFVi5jSwg9FUkHpo6QdFb+2smNhX3xbX4BD5cY8ak7co6xHuV1vyRy/LiOLO1+R
         6PLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nd8Xd2ivaTKtzZWuGBA7aJ+VshyewN7yC9C84sKUUxQ=;
        b=NmD2uB4csOrFlGvxJXGzuOs+MBQgEnQ2SUNtdjO2IfjZefAgivS5YZoDk+j873vQl9
         PRA7+VgRjkx7hpTS5bJ2Q4YMaOurubwxYV2xDwXgLxiOkA9/euRnSFwP/ZjbIX0nX6/q
         csTZyRnIb4OMHCGdLrS30Px/9HlZ98bZf2HEy1CvtVRpRwJHRPtoEsyHAnT6Zywhq/KT
         Y/CrMsTezpBMH9dHvrGemXhicmh71I6dHqFknXfljQ9iJRwV1BTP/aoDDnmP1l6gARHJ
         0Kh3/qB/gyCKNfbBPyO1fJf4uzsKEDa142CeFhBqFSo6R7soUrRsG5skIH2GAVtcE9ND
         RRWA==
X-Gm-Message-State: AOAM530NF2DWh0vOto0G763iWBerxUGoBQG1BAfA4aXV8IPrW462a93m
        WieWGd5hUWv38qTpXoicSy70uam2GPEC1Q==
X-Google-Smtp-Source: ABdhPJyMKEMYC8FO7iAzMzQRFgbrXnY8nFys7p5YcP1kfAArB1GDp7TPwSRz5M+VZDD9ZI4XPvYkVA==
X-Received: by 2002:a05:600c:215:: with SMTP id 21mr6685008wmi.119.1634755211142;
        Wed, 20 Oct 2021 11:40:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d8sm2813835wrv.80.2021.10.20.11.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 11:40:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 8/8] Makefile: assert correct generate-cmdlist.sh output
Date:   Wed, 20 Oct 2021 20:39:59 +0200
Message-Id: <patch-8.8-23d4cc77b6c-20211020T183533Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net> <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Because generate-cmdlist.sh invokes "sed" to extract the "NAME" blurb
from the Documentation/git-*.txt files, we can end up with bad content
if those files aren't what we expected. E.g. we'll emit multiple lines
from that "sed" one-liner if the "NAME" section were to move further
down than what our "head -n 10" covers.

Let's assert that this can't happen by checking that the number of
lines we make is what we'd expect to get. This means we can remove an
assertion added in cfb22a02ab5 (help: use command-list.h for common
command list, 2018-05-10). We'll catch this during compilation
instead.

There are still other cases where it's possible to generate a bad
command-list.h, but the rest should be caught by a C compilation
error.

It would be possible to change our generated "command-list.h" to
simply include this new ".build/command-list.h.gen" instead of cat-ing
it in the Makefile, but let's leave the generated file as it is.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile            | 7 ++++++-
 generate-cmdlist.sh | 2 +-
 help.c              | 3 ---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index ce4cce57eb8..711f0c064e6 100644
--- a/Makefile
+++ b/Makefile
@@ -2278,13 +2278,18 @@ $(COMMAND_LIST_GEN): .build/command-list.h.d/%.gen: Documentation/%.txt
 	$(QUIET)grep "^$(patsubst .build/command-list.h.d/%.gen,%,$@) " command-list.txt >$@.txt && \
 	./generate-cmdlist.sh --entry-only $@.txt >$@
 
+.build/command-list.h.gen: $(COMMAND_LIST_GEN)
+	$(QUIET)LC_ALL=C sort $(COMMAND_LIST_GEN) >$@ && \
+	test $$(wc -l <$@) -eq $(words $(COMMAND_LIST_GEN))
+
 command-list.h: $(COMMAND_LIST_GEN)
 command-list.h: generate-cmdlist.sh
 command-list.h: command-list.txt
+command-list.h: .build/command-list.h.gen
 	$(QUIET_GEN){ \
 		$(SHELL_PATH) ./generate-cmdlist.sh --header-only command-list.txt && \
 		echo "static struct cmdname_help command_list[] = {" && \
-		LC_ALL=C sort $(COMMAND_LIST_GEN) && \
+		cat $< && \
 		echo "};"; \
 	} >$@
 
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 2bc528e8cae..bdefa151ae1 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -23,7 +23,7 @@ category_list () {
 }
 
 get_synopsis () {
-	head -n 10 "Documentation/$1.txt" |
+	head -n 6 "Documentation/$1.txt" |
 	sed -n '
 		/^NAME/,/'"$1"'/H
 		${
diff --git a/help.c b/help.c
index 973e47cdc30..cd6dd4c2440 100644
--- a/help.c
+++ b/help.c
@@ -57,9 +57,6 @@ static void extract_cmds(struct cmdname_help **p_cmds, uint32_t mask)
 	int i, nr = 0;
 	struct cmdname_help *cmds;
 
-	if (ARRAY_SIZE(command_list) == 0)
-		BUG("empty command_list[] is a sign of broken generate-cmdlist.sh");
-
 	ALLOC_ARRAY(cmds, ARRAY_SIZE(command_list) + 1);
 
 	for (i = 0; i < ARRAY_SIZE(command_list); i++) {
-- 
2.33.1.1338.g20da966911a

