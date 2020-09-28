Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5132C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 15:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 988DF21548
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 15:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wsp3fsca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgI1PuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 11:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgI1PuV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 11:50:21 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E3AC061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 08:50:21 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w2so1647142wmi.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 08:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WUwQmzqlCtrhqQdmNZH1Yw3BTgVnQ/zChDc3yyYLR2w=;
        b=Wsp3fscaoOF7ALQIhG9Bk7AQNAQKWFe2yx2yQNUYi6qvmJa3N4wFlBgeZ71JolDc08
         32GPAC4zgbG6Yx94oMiSM0yWM4r7+D6xoI5z1uJNjuvLRKsirzJ7QU+whSekuOL+QFmb
         PPB19CdJW3XFUo0Q7ZiSOIbLn1A2G9Q3/0y0JPF0AObNAjXXnyVdgYsntlqS40PTWNRp
         oizZiJTkt71uxirwX0+/LWd7n0Z8Q8kQZs0RWTGVWjpbq47dEDOqiVwlcL9Tg0SBJ5iP
         EC45uKug5KRGY/Grh0QfgbxiXNmGkDEDVe3K0NHpjjC81OiTzb6p36P5fc4u4PdM36YM
         FgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WUwQmzqlCtrhqQdmNZH1Yw3BTgVnQ/zChDc3yyYLR2w=;
        b=SBf3bFiqv4V77Oe0U12I3FEk9dnex1VaTzYxi+UuTCrCVR/mBcxY9SQY4aCvpywssS
         dDb39696kreRFKhaM+2p4o7q6qzeVA75HOtygmmKGrR0KYCjMtzJLEN4AMVrOi/ulKPX
         aUmsLx45mt9GryQq1Mj+HDTGLCkNmWmNrtUHqWkVubBRJYb+KD8B9ac3EsNXxqMBfF8Q
         4RWM5GVIEYK932myML/Tj4vgsFapdaKnDOT4WZjnLEvgVuD9WdjgaemNBeA/VZQvvG2R
         NsoTSZiTXXxyITD3oL7RTLBCzzpmd4PB2Nb1S2KmQuLbuaUd425fZT2EWDWchK2YKrjh
         0miw==
X-Gm-Message-State: AOAM533jDVLq+RWCrXViShcSAyUPobm5okJ/MmIOdLmdZk+zHFYvHILL
        deZEcV1o0NPldLPt4GkA65p6D2oBeRM=
X-Google-Smtp-Source: ABdhPJyOcHYCSmZtmtdqQLRF/rZCX/OlX1k6dL8Y8UtTCEBIw6vyy19Ga8Em9gqyCEWRdVWGuDIjSA==
X-Received: by 2002:a1c:5458:: with SMTP id p24mr589874wmi.160.1601308219449;
        Mon, 28 Sep 2020 08:50:19 -0700 (PDT)
Received: from contrib-buster.auto1.local ([79.140.115.160])
        by smtp.gmail.com with ESMTPSA id o15sm1717067wmh.29.2020.09.28.08.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 08:50:18 -0700 (PDT)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [RFC PATCH 1/2] worktree: teach `list` to mark locked worktree
Date:   Mon, 28 Sep 2020 15:49:52 +0000
Message-Id: <20200928154953.30396-2-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.28.0.856.g4762557030
In-Reply-To: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com>
References: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The output of `worktree list` command is extended to mark a locked
worktree with `(locked)` text. This is used to communicate to the
user that a linked worktree is locked instead of learning only when
attempting to remove it.

This is the output of the worktree list with locked marker:

  $ git worktree list
  /repo/to/main                abc123 [master]
  /path/to/unlocked-worktree1  456def [brancha]
  /path/to/locked-worktree     123abc (detached HEAD) (locked)

Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 Documentation/git-worktree.txt | 5 +++--
 builtin/worktree.c             | 6 +++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 32e8440cde..a3781dd664 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -96,8 +96,9 @@ list::
 
 List details of each working tree.  The main working tree is listed first,
 followed by each of the linked working trees.  The output details include
-whether the working tree is bare, the revision currently checked out, and the
-branch currently checked out (or "detached HEAD" if none).
+whether the working tree is bare, the revision currently checked out, the
+branch currently checked out (or "detached HEAD" if none), and whether
+the worktree is locked.
 
 lock::
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 99abaeec6c..8ad2cdd2f9 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -676,8 +676,12 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 		} else
 			strbuf_addstr(&sb, "(error)");
 	}
-	printf("%s\n", sb.buf);
 
+	if (!is_main_worktree(wt) &&
+	    worktree_lock_reason(wt))
+		strbuf_addstr(&sb, " (locked)");
+
+	printf("%s\n", sb.buf);
 	strbuf_release(&sb);
 }
 
-- 
2.28.0.763.ge7086f1eef

