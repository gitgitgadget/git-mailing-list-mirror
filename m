Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE2EC432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 23:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF55620869
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 23:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivHqH1Zq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfK1XCT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 18:02:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34991 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfK1XCT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 18:02:19 -0500
Received: by mail-wm1-f67.google.com with SMTP id n5so13125007wmc.0
        for <git@vger.kernel.org>; Thu, 28 Nov 2019 15:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XqXG/NBN0z58IjMNHmH3kEgPE/g3Ulvdn7ZDW7LLISM=;
        b=ivHqH1ZqH0U5dFtIk+lcV0roDdejFkbczfws4z0ckJ01MsHpNJHeJxaW+jvssWcYon
         F8wf9NRR8iN8bdIwaoOHDEU9ixZYg3ejZTbf/WdJ0DtKKJ+sDVmxE3ZccC+N1kvd4L2N
         pJsVxyJ1f7iVtcOhMpBmUDnXAPHU/9XMIaAB6Uwfv+Wjomz+iAmebk45wYx5WDGv10UU
         jl+mlYMF8iulQbOgysUhGaL6W3siKBv1w0R7mV1tdiYwdkPgzLsA5GV2lDMbasGr33AM
         pbINjLnbBDQFRXdoATwASGRIFUDwG/ZKo1m9Mn/8NeTH5I6sickwilxINYf0ZPWCAXIx
         VC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XqXG/NBN0z58IjMNHmH3kEgPE/g3Ulvdn7ZDW7LLISM=;
        b=KiwqgcU8xqSYXzS50rosBGayMVBemQ+K/y2gFITef2+159NCUneSepzoGfrZgW+jP0
         z8PsVW7WXCNXZRTgpat2o/0TDkTO9qzsKB5koZ/jmDTEb1k5qRhXnZCySkfOrB8ff+3E
         RZcY2Q1Wb0Y/m1gyiOkjal+1R7AGJiE8n6Vd3ALKxM8Ac5E+YuIvuctsIjyp1Pyn/7vp
         5NyRsu8kVNy2M5roWwCduSWYK9yP9obEyUfmgFDtlpAd2x2ywNE09wziTyssMrsNHCVm
         WSWLohMsMHY71F//Aqwol1rmmCriBCJ8a1S1+cUTRZYlNA2CKn9ZrK+Ed5Bn4SK39ff3
         7XAA==
X-Gm-Message-State: APjAAAWUrkL1su94kU4tSffQTpZGrN+q5Oprj08xcbXah0BzymMFOoNf
        +m9Lg5PB4nPXZY+Pg6Spx8se52tL
X-Google-Smtp-Source: APXvYqyFplRHYlm+dy7jaIQEzkuqmV7wq6/Gfkma1pOiYZvkB/GzS5LuAnge2uBfW0ocNV710fHFwg==
X-Received: by 2002:a05:600c:2318:: with SMTP id 24mr11424520wmo.21.1574982136885;
        Thu, 28 Nov 2019 15:02:16 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-25-142.w86-222.abo.wanadoo.fr. [86.222.24.142])
        by smtp.googlemail.com with ESMTPSA id f1sm6665537wrp.93.2019.11.28.15.02.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 15:02:16 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v1 1/1] sequencer: fix a memory leak in sequencer_continue()
Date:   Fri, 29 Nov 2019 00:02:03 +0100
Message-Id: <20191128230203.26058-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When continuing an interactive rebase after a merge conflict was solved,
if the resolution could not be committed, sequencer_continue() would
return early without releasing its todo list, resulting in a memory
leak.  This plugs this leak by jumping to the end of the function, where
the todo list is deallocated.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
I found this while adding support of rebase.missingCommitCheck to `git
rebase --continue'.

 sequencer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8952cfa89b..64227a71e5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4208,8 +4208,10 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 	if (is_rebase_i(opts)) {
 		if ((res = read_populate_todo(r, &todo_list, opts)))
 			goto release_todo_list;
-		if (commit_staged_changes(r, opts, &todo_list))
-			return -1;
+		if (commit_staged_changes(r, opts, &todo_list)) {
+			res = -1;
+			goto release_todo_list;
+		}
 	} else if (!file_exists(get_todo_path(opts)))
 		return continue_single_pick(r);
 	else if ((res = read_populate_todo(r, &todo_list, opts)))
-- 
2.24.0

