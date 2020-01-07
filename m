Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C29C33CA4
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54A12075A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcNprWz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgAGExl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:53:41 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32924 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbgAGExj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 23:53:39 -0500
Received: by mail-qt1-f196.google.com with SMTP id d5so44405294qto.0
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 20:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=28oBMed1uIAPxpGMIjzfQY1Nzi7Ju1o58BuNUHYtsOE=;
        b=JcNprWz9UOKkyCWAoGt+ogmak+OtkvhkydIo3HI8axrqtXl4Y61e7MpV3QaXjsUPrT
         Q1BzpbWIlJxrjs3oxBNwaQP4A6YT8EzFTu4QRPAwTE9tQm7mvof6Eak0RiVFcUQg4BRN
         EJye9Is2U9PDDd5HdDo5/Pl9K15kfg2dl4ZuRLrSLOo/J/q/PAAwf1fBhbiztUAg5KUa
         iZPFB2uj4Bgklp1c5wzayFVudXO5G0qpVJKO5+gh+xXWKMpGRn8AH2ou2lH0lpeYfzqM
         fHB+dbQN88kCIx/uq9hCUMpmdiP4AECz8rCpPPf6APK/GfzTDarDWRl9g9ImQ1A96e/+
         ZAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=28oBMed1uIAPxpGMIjzfQY1Nzi7Ju1o58BuNUHYtsOE=;
        b=ums0Yv7XSdGSMPuUknYlLiHcqQXqRQPrLAh+r1pACnbi2xXjo7TU2ykjyCf+9++oqq
         rD0wGPW23SMV8O5jXBZvJJmAb+pJyyBJZtCptLrPJdKYqOLO8yZ9zPwPb+ADI0dsom9Q
         NCX3zdbhpve//Z271SuqjkFbSQlZeBYqIMysugj3NY5wH8V6HIe8qO6vm1ciDSgZVfX1
         4uMWm8YloA5/CUsczEgJJHkLmp8IesF1Rr+BIVThEWEa0JIHSZT1jq+Ef/bfpd2FfhVg
         kubcd87kZyV3fYQa/qyJC9xjXatasR9RVxnpmMXaq9jRu1oCt8wucGOqIyR2iRN01vv9
         FLHg==
X-Gm-Message-State: APjAAAW4MBME4qBOUAm3UTDNPk6LK8EWyokGxsK4YVGEIW4V0Me3u4XF
        6E2CxDytusVUrlXvNGLn5SNVC/vd
X-Google-Smtp-Source: APXvYqxy+MMKzTqZ2onn39zgkAszmVEqypddSJv5MSZmQYJePwWFtY7jpFKUzfETFgJYSWlQK8FAaw==
X-Received: by 2002:ac8:534b:: with SMTP id d11mr78017217qto.170.1578372818876;
        Mon, 06 Jan 2020 20:53:38 -0800 (PST)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id t2sm21663893qkc.31.2020.01.06.20.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 20:53:38 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 13/16] t3504: do check for conflict marker after failed cherry-pick
Date:   Mon,  6 Jan 2020 23:53:10 -0500
Message-Id: <88134bb6d1cb32fca621f5b8acdb3e8b0c4e1c69.1578372682.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.180.g49a268d3eb
In-Reply-To: <cover.1578372682.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com> <cover.1578372682.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Sixt <j6t@kdbg.org>

The test with disabled rerere should make sure that the cherry-picked
result does not have the conflict replaced with a recorded resolution.

It attempts to do so by ensuring that the file content is _not_ equal
to some other file. That by itself is a very dubious check because just
about every random result of an incomplete cherry-pick would satisfy
the condition.

In this case, the intent was to check that the conflicting file does
_not_ contain the resolved content. But the check actually uses the
wrong reference file, but not the resolved content. Needless to say
that the non-equality is satisfied. And, on top of it, it uses a commit
that does not even touch the file that is checked.

Do check for the expected result, which is content from both sides of
the merge and merge conflicts. (The latter we check for just the
middle separator for brevity.)

As a side-effect, this also removes an incorrect use of test_must_fail.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3504-cherry-pick-rerere.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
index a267b2d144..80a0d08706 100755
--- a/t/t3504-cherry-pick-rerere.sh
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -94,8 +94,10 @@ test_expect_success 'cherry-pick --rerere-autoupdate more than once' '
 
 test_expect_success 'cherry-pick conflict without rerere' '
 	test_config rerere.enabled false &&
-	test_must_fail git cherry-pick master &&
-	test_must_fail test_cmp expect foo
+	test_must_fail git cherry-pick foo-master &&
+	grep ===== foo &&
+	grep foo-dev foo &&
+	grep foo-master foo
 '
 
 test_done
-- 
2.25.0.rc1.180.g49a268d3eb

