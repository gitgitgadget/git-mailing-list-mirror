Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9BAC433FE
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 10:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhLIKdz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 05:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbhLIKds (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 05:33:48 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6788C0617A1
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 02:30:14 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id y196so3782854wmc.3
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 02:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8PooKE+ZmACiLnvvFNaC9GMC6c2B/Iz1nlWdS4LuFUY=;
        b=h8rioBTutx19lpS3B1gDa5AwOpWfnD2vssAB40de+aV5SDdfXHPHikjfwrQVZKyts0
         BEzY9SpCe+nUE2dVtjupf8mVRYADilT7Ai/Mp2M6vPfoBPFK2H2D6p1dciMGL7W11lqN
         /6IO0eLmraG++s9C24aw7mwpPiCo8iSaOUdR57fIMq0ELIDGMmV8tOf6/i4ZUftUXETd
         IPD2f9v8zVFPJ2TQacRskHLWYoFkOGue1j4r8zUYat5U0BUVfR2jdRds3DwH0/DAI1kw
         twgrsyJnX8DHqPTpQvWZ0EuIOvYaX+NhqW5vzNkqt+Gp2bS2bQNe2I4qICkiBoK3feiK
         mXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8PooKE+ZmACiLnvvFNaC9GMC6c2B/Iz1nlWdS4LuFUY=;
        b=BDqU4JLEu6PMCBRCBfX/fg1jrPr7fmsdk7NvNgzeY4o8T7GslrSSUHsXAZUBkpSBI5
         KW+draK/n2kh5IT/JMEkDifdqMlxUYUYuq1EkWI7FWCSuz8mwocUXAIfzmeG6cOnVzxP
         M5/bG1tiWR7RR2y/709SqM95c8WkKLZ4KnJgijbWG2ov385N1wTfygK0PbwwrATHNhdg
         RAfvBXARzM5JdXn1SqH2UKEZUPz1Q5jM6j4yLzZ8p7aTaB+YQyR8SdU4EohXjTypjN5p
         60/kmrcfq38/OLqRM3lF7HFa24wKVwyyAxWK6qLUKH5H+fZLbdSBU0SwG9Oa7CAs8VBL
         M7Yw==
X-Gm-Message-State: AOAM530pcNavaCpiqblkYogD/kvYPgCqSTTplqVsVmOT734wMsf0iJft
        0bygwc0MZkN+HM267sjaVxZUWUOlFgU=
X-Google-Smtp-Source: ABdhPJx79+ar2+MnEQxxGO77epsJd4r4CS69OtthMniisKQA+mptA7hHe9A0CYp0+pIlyaidvayXrw==
X-Received: by 2002:a05:600c:19d1:: with SMTP id u17mr6110709wmq.148.1639045813127;
        Thu, 09 Dec 2021 02:30:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n1sm5557598wmq.6.2021.12.09.02.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 02:30:12 -0800 (PST)
Message-Id: <47c652716e88af7199c44a555780eafb643a1f9e.1639045809.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
References: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
        <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 10:29:56 +0000
Subject: [PATCH v5 02/15] diff --color-moved: clear all flags on blocks that
 are too short
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If a block of potentially moved lines is not long enough then the
DIFF_SYMBOL_MOVED_LINE flag is cleared on the matching lines so they
are not marked as moved. To avoid problems when we start rewinding
after an unsuccessful match in a couple of commits time make sure all
the move related flags are cleared, not just DIFF_SYMBOL_MOVED_LINE.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 52c791574b7..bd8e4ec9757 100644
--- a/diff.c
+++ b/diff.c
@@ -1114,6 +1114,8 @@ static int shrink_potential_moved_blocks(struct moved_block *pmb,
  * NEEDSWORK: This uses the same heuristic as blame_entry_score() in blame.c.
  * Think of a way to unify them.
  */
+#define DIFF_SYMBOL_MOVED_LINE_ZEBRA_MASK \
+  (DIFF_SYMBOL_MOVED_LINE | DIFF_SYMBOL_MOVED_LINE_ALT)
 static int adjust_last_block(struct diff_options *o, int n, int block_length)
 {
 	int i, alnum_count = 0;
@@ -1130,7 +1132,7 @@ static int adjust_last_block(struct diff_options *o, int n, int block_length)
 		}
 	}
 	for (i = 1; i < block_length + 1; i++)
-		o->emitted_symbols->buf[n - i].flags &= ~DIFF_SYMBOL_MOVED_LINE;
+		o->emitted_symbols->buf[n - i].flags &= ~DIFF_SYMBOL_MOVED_LINE_ZEBRA_MASK;
 	return 0;
 }
 
@@ -1237,8 +1239,6 @@ static void mark_color_as_moved(struct diff_options *o,
 	free(pmb);
 }
 
-#define DIFF_SYMBOL_MOVED_LINE_ZEBRA_MASK \
-  (DIFF_SYMBOL_MOVED_LINE | DIFF_SYMBOL_MOVED_LINE_ALT)
 static void dim_moved_lines(struct diff_options *o)
 {
 	int n;
-- 
gitgitgadget

