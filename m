Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9BBC433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6BF320656
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJZWgNhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgHUREY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgHUQ7o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 12:59:44 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C028C0613ED
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 09:59:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f18so1608663wmc.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 09:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DIFo+BrNurMfcn1iRpz15LZRf7JCJXN6gFBT83ytqOM=;
        b=BJZWgNhzg7wxi9qrxAk3lxs52D7xzpjzTh1KAafplA1Ax7hCmI4wBJDwYOajHyd+F/
         p72dUm+jB+m/WElvcy6Pk72fB+Aiw6TR6xdHZVrghj98hbuLqmMZmf0age5UHlnoaaCR
         Km258SnXIG15oWK3rMyEiIfvYj0a/8oVDr6v2xl10NuoHjLQAdZwhsf3J9u9pEoNPWTz
         Q+aRPI/LbWYkQgIQSTLJDK0iva7+722+hoNbnqdfbK5dz3yvwMWmoxNtEJz8A2uH1iPp
         HKW4bCwBvtl+7sinNs9qMC9GcAN0nC5eivlfTZkITVJMkLLiXXyxisnHO3gebr+yS7mI
         kROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DIFo+BrNurMfcn1iRpz15LZRf7JCJXN6gFBT83ytqOM=;
        b=C3Ck8q5pG7oDOlWpQXWWy754mdLW0xLexxyuWRAp1dXQRxMRWmd/z+u2GW7/A3sMNK
         MqwtTI2PTWxmd1FuYrpzCxv39/Kly4Aw3AIsFshmkcOxGtctnndn9BCSklU9BdmVRaoy
         01i8+hy+/oBzdF5nXju+0YaRd4/uR0nyiHaPzG8Ph6Ym3VLN8UHCWGMNoHzqavW3bE3j
         0aWv4/wJvU/ZZ0nv0woOPOR6kSb+4qU3HZbyH7oi5ZmXf9wPACIloeYsy8ZGzNwT7L0B
         gaMZXzV5Jh9A46Orb8H/vJd9v2LyfSsKxuk06iYZOAjqGCjRLs+pQ4CJTCZ8VAtFZLUL
         VQJQ==
X-Gm-Message-State: AOAM5322B2gtYNTJVsIrfb2WVNx8Qbh35I5g+SdN4IhzG7/BFalBRxr8
        /a2iYRBoM7dKgCr0tz3POQjgHvwSaIk=
X-Google-Smtp-Source: ABdhPJzgKOjxskhx2rLVlRvwgJudRFzZcxoZE1+yziZJ8Np61h/w92o01ASqR3WtEEJvM+mYKRi2NQ==
X-Received: by 2002:a7b:c1d0:: with SMTP id a16mr4883034wmj.111.1598029181494;
        Fri, 21 Aug 2020 09:59:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m126sm6598270wmf.3.2020.08.21.09.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 09:59:40 -0700 (PDT)
Message-Id: <8aacde69c8c4689b6b68f11a310a308595ed49ad.1598029177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.706.v3.git.1598029177.gitgitgadget@gmail.com>
References: <pull.706.v2.git.1597850128.gitgitgadget@gmail.com>
        <pull.706.v3.git.1598029177.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 16:59:36 +0000
Subject: [PATCH v3 3/4] builtin/commit: suggest update-ref for pseudoref
 removal
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

When pseudorefs move to a different ref storage mechanism, pseudorefs no longer
can be removed with 'rm'. Instead, suggest a "update-ref -d" command, which will
work regardless of ref storage backend.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 builtin/commit.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 69ac78d5e5..671721c385 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -847,21 +847,19 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
 				!merge_contains_scissors)
 				wt_status_add_cut_line(s->fp);
-			status_printf_ln(s, GIT_COLOR_NORMAL,
-			    whence == FROM_MERGE
-				? _("\n"
-					"It looks like you may be committing a merge.\n"
-					"If this is not correct, please remove the file\n"
-					"	%s\n"
-					"and try again.\n")
-				: _("\n"
-					"It looks like you may be committing a cherry-pick.\n"
-					"If this is not correct, please remove the file\n"
-					"	%s\n"
-					"and try again.\n"),
+			status_printf_ln(
+				s, GIT_COLOR_NORMAL,
 				whence == FROM_MERGE ?
-					git_path_merge_head(the_repository) :
-					git_path_cherry_pick_head(the_repository));
+					      _("\n"
+					  "It looks like you may be committing a merge.\n"
+					  "If this is not correct, please run\n"
+					  "	git update-ref -d MERGE_HEAD\n"
+					  "and try again.\n") :
+					      _("\n"
+					  "It looks like you may be committing a cherry-pick.\n"
+					  "If this is not correct, please run\n"
+					  "	git update-ref -d CHERRY_PICK_HEAD\n"
+					  "and try again.\n"));
 		}
 
 		fprintf(s->fp, "\n");
-- 
gitgitgadget

