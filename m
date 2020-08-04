Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D55CC433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24573206DA
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLFc1e9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgHDA4c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbgHDA4b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 20:56:31 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F69EC06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 17:56:31 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id z6so40558376iow.6
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 17:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+MSyWolaZ9rx9rfOBC20BM8W0Fhzr5CmGl5fgY7iOX0=;
        b=tLFc1e9ZJI0wrnSBxBwy67tjSDqLVG9dRi3c1OBL7rTy9EEWE7oyF8ebO9gtQZWCke
         5rmcT5JSSIGfhcTDK7LfM4ggxhUIXemhM1n9WHz+H+HEgGlvbB3qWCqUelv9fn+G9AGx
         eo+NAcmwncnw3Q88So0lT+t9yNNq799ig5COaP9mgu84MkrfaBMzvHDtb4pD5kHfW1h+
         OKoJLIOIkXZ0xk+LGtmY8bbEQUJXFWkxcEu0g0lhRbqlExrPS+Q1DyMVj1PC5K/sKIur
         Bw5bd50yVjVty69FqPw3+yl4wz2IYX5KJwpW/CsOT37v13Krzh8da5Km0afix92su62w
         42Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+MSyWolaZ9rx9rfOBC20BM8W0Fhzr5CmGl5fgY7iOX0=;
        b=YYrDU5e2qBiYCg1CeftT7U7I2tswSgePDSHyXZc5uqvXtqBuG3gaqcXMULMcj+JJmB
         qyhkQFzoeacbJavKBSXjEjC9YNoyKcxOIyYZNQ6Ltxf6Pqj8d1jz4pfnPGy/NSXF5EbC
         qhrw+I0gzd3LHeyEvyPVYAvznMX39EbDglpAXt4mA93Q+bRnZ4jpxsRr8uni+l2d1FBy
         nWhTHUKkl1R4BinaaiYdMUPQWOzYxjttuayullzzF/qZtYfwp4iqS+yBiOGcFKK7grP+
         p9ru5a9cTYfxrloayf444iuMCX8Bn/wFs4gA5KkYo7rIe5uMy3j8djowDmEKx5yo3XCB
         sdsw==
X-Gm-Message-State: AOAM531CTNc872P3ryq03j2g+JogCQafY5YRWLz74WfT59v+OVZkt8ap
        k93iqTHsUSCNj3QYG1sVUlHThmvLyy0=
X-Google-Smtp-Source: ABdhPJwfnJ0BciB2rrFwMkknldVHvKk4jvWyud9eUFtR7SKISQudcxbcx+WaLmDgkenE3mibONvRBA==
X-Received: by 2002:a05:6638:1611:: with SMTP id x17mr2693810jas.99.1596502589920;
        Mon, 03 Aug 2020 17:56:29 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id e84sm11878453ill.60.2020.08.03.17.56.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Aug 2020 17:56:29 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/5] git-worktree.txt: make start of new sentence more obvious
Date:   Mon,  3 Aug 2020 20:55:34 -0400
Message-Id: <20200804005535.5126-5-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966
In-Reply-To: <20200804005535.5126-1-sunshine@sunshineco.com>
References: <20200803053612.50095-1-sunshine@sunshineco.com>
 <20200804005535.5126-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When reading the rendered description of `add`, it's easy to trip over
and miss the end of one sentence and the start of the next, making it
seem as if they are part of the same statement, separated only by a
dash:

    ... specific files such as HEAD, index, etc. - may also be
    specified as <commit-ish>; it is synonymous with...

This can be particularly confusing since the thoughts expressed by the
two sentences are unrelated. Reduce the likelihood of confusion by
making it obvious that the two sentences are distinct.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index ce2d40ee4c..544464f949 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -48,8 +48,8 @@ add <path> [<commit-ish>]::
 
 Create `<path>` and checkout `<commit-ish>` into it. The new working directory
 is linked to the current repository, sharing everything except working
-directory specific files such as `HEAD`, `index`, etc. `-` may also be
-specified as `<commit-ish>`; it is synonymous with `@{-1}`.
+directory specific files such as `HEAD`, `index`, etc. As a convenience,
+`<commit-ish>` may be a bare "`-`", which is synonymous with `@{-1}`.
 +
 If `<commit-ish>` is a branch name (call it `<branch>`) and is not found,
 and neither `-b` nor `-B` nor `--detach` are used, but there does
-- 
2.28.0.236.gb10cc79966

