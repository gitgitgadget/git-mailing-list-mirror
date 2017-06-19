Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2703E1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 22:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbdFSWCB (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 18:02:01 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36653 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbdFSWCA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 18:02:00 -0400
Received: by mail-wm0-f66.google.com with SMTP id d17so19371299wme.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 15:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EWEAIM7PZYVjsQZpasI2xRn72d/yvg3+oHOraEneBV0=;
        b=DDGBXeT6jrkacfonW6xK46pXxqdBz91xrvpDMsQ/bm1ZVe2FHphjlyd91/bDj6X4ov
         frPWcVMjYSMnijr60uCFCm4Mt0LrRgWk65+XMoC/85Y/W8oL7d9ovR3qlSuVKj+WCmEs
         rTPP05dFFXxAnqdH8f729XxRjvIN49QK0l6P7s2VV5JE9arAQ8Ig3Bcggx3MWyWUYwI4
         i4bisXwnN/2iQ3Un6vTto5dCiMoqH2sVKpWxRMtfWXm5GitzKpOzoFqDgoww/O1wwfxH
         5Xsv9CHLYbDHSvcs8vHvMvgigqDWGGCVGgLHpQ0A4aRmkzch7Szpt/VeyS25b1ifvQzx
         tPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EWEAIM7PZYVjsQZpasI2xRn72d/yvg3+oHOraEneBV0=;
        b=mGvDpDmN2PFdSZoXn6b9OP8WvXsxBJxDxBBqTACBcGEFeCXdUmqLunRQEYfHkX9/Ag
         WoUNZhG22NR5f/fMOKG80S07TEEIW7+bqjedyTehXrRCyle6f7isktnl6JggzvdBdYr/
         Q545FUQYX12AyHnd2vF8fr4KIi++Tv9BYSBI7+kfhm2weSBk0oT2usKSaOIYmL5laWr5
         1pOqEBLR60rFT1uDdMPjwF5P2VM+9UYISLFYUuQtWaCBsK9wfyJtyES3v4xchKhIWfvG
         wdPozc/Pqf0+++HcTbcPmArNCpKxEJTbNuNlUg2bFzI2d8bePjKmTV+gsYA6HQchdLVE
         CRDg==
X-Gm-Message-State: AKS2vOytB2rpmwsZDIo/JT2BOhZDFhzphgmKV+GU3ZIAMe7hvTN2OAzW
        sRvAj6JJj97YAP9gDT0=
X-Received: by 10.80.166.216 with SMTP id f24mr18481216edc.29.1497909718573;
        Mon, 19 Jun 2017 15:01:58 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b27sm5462805ede.62.2017.06.19.15.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jun 2017 15:01:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] grep: fix erroneously copy/pasted variable in check/assert pattern
Date:   Mon, 19 Jun 2017 22:01:48 +0000
Message-Id: <20170619220148.11199-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix an erroneously copy/pasted check for the pcre2_jit_stack variable
to check pcre2_match_context instead. The former was already checked
in the preceding "if" statement.

This is a trivial and obvious error introduced in my commit
94da9193a6 ("grep: add support for PCRE v2", 2017-06-01).

In practice if pcre2_match_context_create() returned NULL we were
likely in a situation where malloc() was returning NULL, and were thus
screwed anyway, but if only the pcre2_match_context_create() call
returned NULL (through some transitory bug) PCRE v2 would just
allocate and supply its own context object when matching, and we'd run
normally at the trivial expense of not getting a slight speedup by
sharing the context object between successive matches.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index d7ef21358e..06c4c24926 100644
--- a/grep.c
+++ b/grep.c
@@ -508,7 +508,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		if (!p->pcre2_jit_stack)
 			die("Couldn't allocate PCRE2 JIT stack");
 		p->pcre2_match_context = pcre2_match_context_create(NULL);
-		if (!p->pcre2_jit_stack)
+		if (!p->pcre2_match_context)
 			die("Couldn't allocate PCRE2 match context");
 		pcre2_jit_stack_assign(p->pcre2_match_context, NULL, p->pcre2_jit_stack);
 	} else if (p->pcre2_jit_on != 0) {
-- 
2.13.1.518.g3df882009

