Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5623FC433DB
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 22:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2085464E7C
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 22:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhCNWRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 18:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhCNWRl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 18:17:41 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321EFC061762
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 15:17:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f12so7729727wrx.8
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 15:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QXXZ6PRSQKxTNeQUBO+QCyPzTHcNrIuHhP1pl77Aebg=;
        b=PCKK2V+XYUkj1mw6LvFgZAL08wtM12BQePqTzxTngbIYVjgPrWJcXFYs5ZpNTsO94c
         wtDXwdwe2KkDH/CUQxDkBb7Zfj5CMQQX1yorIFuWOdqFxUbnrJoiA33zrVaV6qOE0kKX
         jmpTgaLMweYn5vziijX9MmNurHRMi6IZyG8AnbjEREjP6LcY6IzcPsazQL8FZpQ0fJur
         0K/KnhlEaDVsZ+mCieLwxb3PJPYkGFyxtcAvjmMqN3Jt3gbUK/U2Ntm6sb3480NQ4eiN
         rd0mlwpotM3v4DyaVbkyVXNN9xbiMjDK28GFkHND9K3CnyoR2Lg4TCSSKJl0orLTLv/w
         qggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QXXZ6PRSQKxTNeQUBO+QCyPzTHcNrIuHhP1pl77Aebg=;
        b=CWPwqGnICW8p0e7JbgaHe3WmMc6nUwPQYJla1qMFCxrUsZFSlWQe4NpPN8R3g8FmV6
         w/XslOR5kJFLA0fqJPWWBfP+HTnTX3FW91yo5V6KJI7sThvHwWWniMm0NJGTFfskk6Kd
         RW0KopGgc3/1D62u7xbKrIuB9SRa2aP4cIncrm77saWp87x0ra12VY4JWswpKEf3RmXN
         8jKgFFSBewax9+ufB8TmlmGjl1gi6oSztpZWgMTdj8Ulz+77RcWiz5+vRx/I19kfaAci
         N2VwJOGBp4niZC5S/O1RWbky5Sx39qXHmTiahYpCuJa8AuzWHEcdCXaSLNeIUssKDDOu
         1ciw==
X-Gm-Message-State: AOAM531hcuF8KIdDX0M3rlXmGM1EBVKPYkJtWTJBL/NpuKWAtd3HQ9gL
        DrYAwFBy7Q51ffUOkcGxS5NWgqDJk6E=
X-Google-Smtp-Source: ABdhPJxo+o0PhgOGvaOf/ZjjLdjAKSsvexE4/yAswYUL/Oi2CNVYrmLd1i63j9yEoZzplPiHZI98gg==
X-Received: by 2002:a5d:4904:: with SMTP id x4mr24169011wrq.69.1615760259962;
        Sun, 14 Mar 2021 15:17:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l22sm16729714wrb.4.2021.03.14.15.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 15:17:39 -0700 (PDT)
Message-Id: <75a3c46c405549d1f5127097729c556a7e297587.1615760258.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.903.git.1615760258.gitgitgadget@gmail.com>
References: <pull.903.git.1615760258.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Mar 2021 22:17:35 +0000
Subject: [PATCH 1/3] fsmonitor: skip lstat deletion check during git
 diff-index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

Teach git to honor fsmonitor rather than issuing an lstat
when checking for dirty local deletes. Eliminates O(files)
lstats during `git diff HEAD`

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 diff-lib.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/diff-lib.c b/diff-lib.c
index b73cc1859a49..3fb538ad18e9 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -30,7 +30,7 @@
  */
 static int check_removed(const struct cache_entry *ce, struct stat *st)
 {
-	if (lstat(ce->name, st) < 0) {
+	if (!(ce->ce_flags & CE_FSMONITOR_VALID) && lstat(ce->name, st) < 0) {
 		if (!is_missing_file_error(errno))
 			return -1;
 		return 1;
@@ -574,6 +574,7 @@ int run_diff_index(struct rev_info *revs, unsigned int option)
 	struct object_id oid;
 	const char *name;
 	char merge_base_hex[GIT_MAX_HEXSZ + 1];
+	struct index_state *istate = revs->diffopt.repo->index;
 
 	if (revs->pending.nr != 1)
 		BUG("run_diff_index must be passed exactly one tree");
@@ -581,6 +582,8 @@ int run_diff_index(struct rev_info *revs, unsigned int option)
 	trace_performance_enter();
 	ent = revs->pending.objects;
 
+	refresh_fsmonitor(istate);
+
 	if (merge_base) {
 		diff_get_merge_base(revs, &oid);
 		name = oid_to_hex_r(merge_base_hex, &oid);
-- 
gitgitgadget

