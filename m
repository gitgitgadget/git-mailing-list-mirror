Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ABEC433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 11:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBAA122CA1
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 11:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jynia08M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732577AbgGaLgS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 07:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732104AbgGaLgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 07:36:16 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E31C061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 04:36:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id f7so27727217wrw.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 04:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=holfVr/mEepbhvHOBRRai8BPIaef+Q7jjjabp3Rt6Os=;
        b=Jynia08MEFOtQn8fRiYupYBujGxpP3QoGYjuZQEZboSML0zHOC+SiHTI8+guP/aLkz
         fCdyQHEY8pxU6kpVjXk37uszdhFD23xoqP5JehhGpRVOKGbHEfoJl2ubIvPZZ5tvhqyJ
         iQsCjzU21c1GgDGE0OhT92+jAHYOix0+wHAMh+0hF+Uh1pTV3OZJER1qvoNtr5PpS5mX
         DabMvgtNZHtO8ap3AsRZLNHm0dBzJzXk8u0VwPiKaiG0sNnCkkj1G0w8OBc30XJERReN
         672eJcOkQS+jq84hvR4b5RjzfRF5NhaPf8DY0f3u8fDSKtsTlJsqzDxmeTj0odvhtj09
         oFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=holfVr/mEepbhvHOBRRai8BPIaef+Q7jjjabp3Rt6Os=;
        b=AOct8S/9Lmp/eXmRZWWDNalDes/SKf7dWyBjr/Mf5LVWEjDn67CpInUgWevzq0tvpg
         J+DXtyYr75mkIK3DPWBpxcZTVcdIsZTcsHmc/fGB5pKLUCiONJAhSBFoRrugHww88IVk
         EPUQHQ6wosP+EStfsumSonq0cTp9i0ZChp3a7uoATKRqOsvfDgTGsXZo0sCIf6oxZJ+y
         HCeDd4DY8cik3YNfbTUqFI0jn6cLs3iPHXaAA+YfpyLFO7/YYElbR2JKBA8sXEHhm/XI
         jSE7SbOO/iY2L3ElInXdcGMAB84zr7RgvA/peR/QRnGAC6h4Ma+qyHWGO56sr3ErWvO1
         ZEcA==
X-Gm-Message-State: AOAM530S/62rOO+I00o1jLRqUkpHrjs8ykMFsah6StWV9QrcwQlvtH+s
        B1b+aLxBfUy9nQYFnq8JcAn1y1Fb
X-Google-Smtp-Source: ABdhPJy68iXf08PBBuWUR3lhMMz8ucto0X6RXVRsjahOqnYv3+LGGZIrD9sXQhUvzQEyAbS/hEIWTA==
X-Received: by 2002:adf:fe0a:: with SMTP id n10mr3045300wrr.125.1596195374228;
        Fri, 31 Jul 2020 04:36:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 68sm13941510wra.39.2020.07.31.04.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 04:36:12 -0700 (PDT)
Message-Id: <pull.688.git.1596195370757.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jul 2020 11:36:10 +0000
Subject: [PATCH] refs: add \t to reflog in the files backend
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

commit 523fa69c3 (Jul 10, 2020) "reflog: cleanse messages in the
refs.c layer" centralized reflog normalizaton.  However, the
normalizaton added a leading "\t" to the message. This is an artifact
of the reflog storage format in the files backend, so it should be
added there.

Routines that parse back the reflog (such as grab_nth_branch_switch)
expect the "\t" to not be in the message, so without this fix, git
with reftable cannot process the "@{-1}" syntax.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    refs: add \t to reflog in the files backend
    
    commit 523fa69c3 (Jul 10, 2020) "reflog: cleanse messages in the refs.c
    layer" centralized reflog normalizaton. However, the normalizaton added
    a leading "\t" to the message. This is an artifact of the reflog storage
    format in the files backend, so it should be added there.
    
    Routines that parse back the reflog (such as grab_nth_branch_switch)
    expect the "\t" to not be in the message, so without this fix, git with
    reftable cannot process the "@{-1}" syntax.
    
    Signed-off-by: Han-Wen Nienhuys hanwen@google.com [hanwen@google.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-688%2Fhanwen%2Ftab-reflog-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-688/hanwen/tab-reflog-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/688

 refs.c               | 1 -
 refs/files-backend.c | 4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 89814c7be4..2dd851fe81 100644
--- a/refs.c
+++ b/refs.c
@@ -907,7 +907,6 @@ static void copy_reflog_msg(struct strbuf *sb, const char *msg)
 	char c;
 	int wasspace = 1;
 
-	strbuf_addch(sb, '\t');
 	while ((c = *msg++)) {
 		if (wasspace && isspace(c))
 			continue;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index e0aba23eb2..985631f33e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1628,8 +1628,10 @@ static int log_ref_write_fd(int fd, const struct object_id *old_oid,
 	int ret = 0;
 
 	strbuf_addf(&sb, "%s %s %s", oid_to_hex(old_oid), oid_to_hex(new_oid), committer);
-	if (msg && *msg)
+	if (msg && *msg) {
+		strbuf_addch(&sb, '\t');
 		strbuf_addstr(&sb, msg);
+	}
 	strbuf_addch(&sb, '\n');
 	if (write_in_full(fd, sb.buf, sb.len) < 0)
 		ret = -1;

base-commit: e8ab941b671da6890181aea5b5755d1d9eea24ec
-- 
gitgitgadget
