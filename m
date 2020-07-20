Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBDFC433DF
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 18:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0413422B4E
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 18:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNUcdM3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbgGTSqG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbgGTSqF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 14:46:05 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B57C061794
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 11:46:05 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q4so21434382lji.2
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 11:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q72ldy3aS585EgXFRgQHJGhyIClWksBE+2ct16n4CGA=;
        b=QNUcdM3eJI4C3mjiEYQxEId1hqTt/+Dn9Bgbdo2shD6SrAkA7WS/zPM5pqvkw53bxA
         po5zkCLb0HBHHXXWPbpr6p8+HsskPFojX2a1eOR+EfoT5doLPOGa0lbiRAs9Qyd4jLLq
         SSB86CTPkJW9GGTuLuNqDJMiPMSBBzyMQU41sVS2vthG19lsqDPMbFkxDc52rQDfJyck
         cEW+VFA/B1c3IdMK1KO/cADgklDD+VApbDOLIefvCDRAHzlxOEjZw9GYJ3BxtrDsgL3F
         /veIDzVt0gw8PH/xPJpxfHj8rksHVPP1IXmV2GoAhSB2fIXFEMwgitFYxYEJUaI4ROs1
         K7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q72ldy3aS585EgXFRgQHJGhyIClWksBE+2ct16n4CGA=;
        b=HYT7hVfjx3LdkzBkxAmogEuxngs2fa9XEo8h2Ad6IG/MkGpWOZzb5NFxStb2VVOu3M
         ajIgBEiwrdMNHb6ZzGt/HB/q15X7hMD5PKFg0jlhP8VVPWrvGgs+/XGdp2JXu7xl/mW2
         c+/h7N4GUjuvSPa3arf2sX1YkwrZLFrxPKJ6Qf0df0sIFZzh91QuD3q/FJcQSt312c8M
         xoFveYj9OCd+6ujJ4xzdpRUxO3fmaJ8epKju+HFuwSZ8mrEBCI+5im0ui1S1bXQ+4dlm
         hhaTzZN4SHkroYIVncrhdy0jYL1OhJRhzv/IqZjs6VL034UoK1T/uwIkQcLm+iZbxDkG
         Lpxg==
X-Gm-Message-State: AOAM533rsp6zT+APaCOrRVakgwFinLQNBiEMdvtgaRMVXR/E1GtMIt4Q
        zCVyPsV2DcEzDtZ3XEbftwE=
X-Google-Smtp-Source: ABdhPJyfmq7q0ANXfZqoFq5cmDcOEU9QqOV/Y5E2plenjxJmUPrCx4OJoeEAv4LNvRNmG8C4Ho/DUQ==
X-Received: by 2002:a2e:a58a:: with SMTP id m10mr138086ljp.76.1595270763735;
        Mon, 20 Jul 2020 11:46:03 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id v11sm3371948ljh.119.2020.07.20.11.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 11:46:03 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Martin Melka <martin.melka@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH] dir: check pathspecs before returning `path_excluded`
Date:   Mon, 20 Jul 2020 20:45:29 +0200
Message-Id: <20200720184529.22449-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.rc1
In-Reply-To: <CABPp-BH6xYb8a5hkV_68vbXhH4kApCxw0WG9oveXOk5zzU==1A@mail.gmail.com>
References: <CABPp-BH6xYb8a5hkV_68vbXhH4kApCxw0WG9oveXOk5zzU==1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 20 Jul 2020 at 17:25, Elijah Newren <newren@gmail.com> wrote:
>
> Awesome, thanks Andreas for the bisected report and Martin for finding
> and fixing the bug.  As for the reason that the old patch injected the
> pathspec check between the path_excluded and the path_untracked cases,
> that appears to me to just be "I'm good at making boneheaded
> mistakes".  Your changes here are the right fix.

Ok, here it is as a proper patch.

> Reviewed-by: Elijah Newren <newren@gmail.com>

Thanks. I've included your reviewed-by below. The log message is
obviously new, but the diff is identical to what I posted earlier.

BTW, this bug first appeared in v2.27.0, so this is not a regression
during the v2.28.0 cycle.

Martin

-- >8 --
In 95c11ecc73 ("Fix error-prone fill_directory() API; make it only
return matches", 2020-04-01), we taught `fill_directory()`, or more
specifically `treat_path()`, to check against any pathspecs so that we
could simplify the callers.

But in doing so, we added a slightly-to-early return for the "excluded"
case. We end up not checking the pathspecs, meaning we return
`path_excluded` when maybe we should return `path_none`. As a result,
`git status --ignored -- pathspec` might show paths that don't actually
match "pathspec".

Move the "excluded" check down to after we've checked any pathspecs.

Reported-by: Andreas Schwab <schwab@linux-m68k.org>
Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 dir.c                      |  4 ++--
 t/t7061-wtstatus-ignore.sh | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 1045cc9c6f..fe64be30ed 100644
--- a/dir.c
+++ b/dir.c
@@ -2209,13 +2209,13 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 				       baselen, excluded, pathspec);
 	case DT_REG:
 	case DT_LNK:
-		if (excluded)
-			return path_excluded;
 		if (pathspec &&
 		    !match_pathspec(istate, pathspec, path->buf, path->len,
 				    0 /* prefix */, NULL /* seen */,
 				    0 /* is_dir */))
 			return path_none;
+		if (excluded)
+			return path_excluded;
 		return path_untracked;
 	}
 }
diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index e4cf5484f9..2f9bea9793 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -30,6 +30,31 @@ test_expect_success 'same with gitignore starting with BOM' '
 	test_cmp expected actual
 '
 
+test_expect_success 'status untracked files --ignored with pathspec (no match)' '
+	git status --porcelain --ignored -- untracked/i >actual &&
+	test_must_be_empty actual &&
+	git status --porcelain --ignored -- untracked/u >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'status untracked files --ignored with pathspec (literal match)' '
+	git status --porcelain --ignored -- untracked/ignored >actual &&
+	echo "!! untracked/ignored" >expected &&
+	test_cmp expected actual &&
+	git status --porcelain --ignored -- untracked/uncommitted >actual &&
+	echo "?? untracked/uncommitted" >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'status untracked files --ignored with pathspec (glob match)' '
+	git status --porcelain --ignored -- untracked/i\* >actual &&
+	echo "!! untracked/ignored" >expected &&
+	test_cmp expected actual &&
+	git status --porcelain --ignored -- untracked/u\* >actual &&
+	echo "?? untracked/uncommitted" >expected &&
+	test_cmp expected actual
+'
+
 cat >expected <<\EOF
 ?? .gitignore
 ?? actual
-- 
2.28.0.rc1

