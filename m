Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B23C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 10:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhLIKd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 05:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbhLIKdw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 05:33:52 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B68C0617A1
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 02:30:18 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i5so8868772wrb.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 02:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QMoWx+vto78ZYKdHTzHFdPgdOaprERVbNGfNe2DRDPg=;
        b=qKEZjmRp66CBiIC7f135+4JrHAc43c3p2OtllsnUXWMZvgSBugDlEkcuhqw4ARjaRH
         WOTRa4grOkttxyJ7Z+lFUWsBHCYT//sn0NRXTyviagz1E4r3CwBUqXef7QnxFlo2aZkJ
         xnKIDIZWmkxMg818XbesKpzNarQLRMF3bn7XtCJRamPZ61e9wvyLvwBASwZ33ZiSHeiB
         q7+mUgswSvebsrFpYVmi2FluUwRtkLehOpHZcVcgNS/wsJk5PgoqiGC7CduA/6UqBSnG
         r6Zt3eYVgGtpdESHR67RlASwC9/X1omow/zxYscIA6+zKOlxPX4uRepTdclGtbzSU/SB
         fpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QMoWx+vto78ZYKdHTzHFdPgdOaprERVbNGfNe2DRDPg=;
        b=KDgtY5SaN1zvuFzZR2USczcxCsWiJkSaEa7yhDQdKrb23gYb9roq8jsK0rAUEFXjqu
         /86rfURINKpu04t7yBiy2V7Wrw3efO2v8hP7Iz9oLrEblOL3PU2eG0GBsX8OwnyVcjjs
         LVR8NcWiKAPBZj9uI99fl/X1D+oqWrmd2TDql2a9FETEEjBiKAeuMiouFFpu0WARBoRP
         5+Mka3MEsl0l6zDoqwjpCu2G2fHn2RM1PbwpljyqKPj0SJaPlm4uJBsS8uc+TDBlUKpG
         tGAIWfC0SqmuCQYZ59o3d4tcS6KsYkKDA5zsKPj6iAfu3uSWUL4C6+qICoL8l4r+rFL4
         u9YA==
X-Gm-Message-State: AOAM53305ZwiKXnh/yf1WiY3g5qiCyNcaI7F9ZUAiBoc0DNRIEm90fft
        nqW16IdK3bk+4ytrLKUc3EYN9dI7040=
X-Google-Smtp-Source: ABdhPJx30WOP6JgBvi9NGIZyrv+3G2n182WFXQalLC21bCouaK1mogGFLj3Mzi/x4zLT8TcIGh830w==
X-Received: by 2002:a5d:404d:: with SMTP id w13mr5135858wrp.293.1639045817394;
        Thu, 09 Dec 2021 02:30:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q8sm5424795wrx.71.2021.12.09.02.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 02:30:17 -0800 (PST)
Message-Id: <b8db6a1af7da5ff7cee0a86f08a5a163965d965b.1639045809.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
References: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
        <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 10:30:01 +0000
Subject: [PATCH v5 07/15] diff: simplify allow-indentation-change delta
 calculation
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

Now that we reliably end a block when the sign changes we don't need
the whitespace delta calculation to rely on the sign.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index efba2789354..9aff167be27 100644
--- a/diff.c
+++ b/diff.c
@@ -864,23 +864,17 @@ static int compute_ws_delta(const struct emitted_diff_symbol *a,
 	    a_width = a->indent_width,
 	    b_off = b->indent_off,
 	    b_width = b->indent_width;
-	int delta;
 
 	if (a_width == INDENT_BLANKLINE && b_width == INDENT_BLANKLINE) {
 		*out = INDENT_BLANKLINE;
 		return 1;
 	}
 
-	if (a->s == DIFF_SYMBOL_PLUS)
-		delta = a_width - b_width;
-	else
-		delta = b_width - a_width;
-
 	if (a_len - a_off != b_len - b_off ||
 	    memcmp(a->line + a_off, b->line + b_off, a_len - a_off))
 		return 0;
 
-	*out = delta;
+	*out = a_width - b_width;
 
 	return 1;
 }
@@ -924,10 +918,7 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 	 * match those of the current block and that the text of 'l' and 'cur'
 	 * after the indentation match.
 	 */
-	if (cur->es->s == DIFF_SYMBOL_PLUS)
-		delta = a_width - c_width;
-	else
-		delta = c_width - a_width;
+	delta = c_width - a_width;
 
 	/*
 	 * If the previous lines of this block were all blank then set its
-- 
gitgitgadget

