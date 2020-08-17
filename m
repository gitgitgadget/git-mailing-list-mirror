Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73C6C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 09:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B22A02063A
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 09:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMxPtlSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgHQJJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbgHQJH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 05:07:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A84FC061346
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 02:07:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c15so14147183wrs.11
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 02:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:in-reply-to:references:date:subject:fcc
         :content-transfer-encoding:mime-version:to;
        bh=ihGai2AY9Gy8QwmQXW3nx3AoRw0pY+Kkquo06oTffVE=;
        b=BMxPtlSmWYG1rX+waweGDNsRk90tp2HshxtvSd190BAI/zHGv/rdthUNQPTJLZ1yLK
         hcY+XdygvVjIR+iPdqT+w230Lw4OMXBXfjZaTlGq+AcaFsuvo4ZxbLZyuK+aWeP0b0no
         +YEASPddKVvWXNZxWJI9y+XWGQy8znNSNu8rLMtrXkUC562Zx5+ig611cQw72KPZeiLs
         gMKnBNFXPqChdWwFOlKnC6sJQriPGJDcDRVKQpKoUSxnw9u6D0ySXSJruF9XtoDfo/Rl
         pCKgpae0GFnIymDCb/QL58dovdA6AuUwknXjOVWEHwJmlDamTcmn/TqD70QJotf8YsyL
         xQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:in-reply-to:references:date
         :subject:fcc:content-transfer-encoding:mime-version:to;
        bh=ihGai2AY9Gy8QwmQXW3nx3AoRw0pY+Kkquo06oTffVE=;
        b=OkVwcGWoikdtWiM/XSi/3HZdfA5CL2lhJx8HH310h7jCYrude6XTQgTpiGulhTLQwY
         MUfkZlT2ZOMltpAC0ztSbZIClOMOThUbWaSm6E22yq7K6gijJewU120zN9cw5znGyFFb
         ZVRtEyQtzRkjUzZk9UbV/ort3kIHUBxAgrQUlgRA0J9q6tvJozaWfqoa1i1eayo8nT9q
         e+ZhxIQssh5Apv4N/XFZ92LOMvqTnjDI88WB1VC9YKP1xsPlWrlq8fdh/pZdX+C4IdSb
         iK8qYaJvm6fAsOcJYtg2+1gSnVBDn6JKkdaZNqclXNM6qgSGVpsDzdRKfBxUtnVKfXEU
         Dn8w==
X-Gm-Message-State: AOAM531rthCzcNOlHSvEdhEbBfe+AEqQQ8utjFfsdDmUiIBiFBKL6i8/
        HW3LwjiIMPNIpNdgDG+ke2njDvuKRDM=
X-Google-Smtp-Source: ABdhPJxqcZs0vQ7ec5QdQXB1fyL58O8N9fTcoOqLUPPzRiPp6LnhnSNEJbUDaeV/rrdy+vVcpxVlXw==
X-Received: by 2002:adf:e712:: with SMTP id c18mr14968756wrm.92.1597655277135;
        Mon, 17 Aug 2020 02:07:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r3sm28341657wro.1.2020.08.17.02.07.56
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 02:07:56 -0700 (PDT)
From:   Johannes Schindelin <gitgitgadget@gmail.com>
X-Google-Original-From: Johannes Schindelin <johannes.schindelin@gmx.de>
Message-Id: <1269d7ace84b5d0e9a009044b49251cdf1dfbd23.1597655273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.411.git.1597655273.gitgitgadget@gmail.com>
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 09:07:53 +0000
Subject: [PATCH 3/3] ci: stop linking built-ins to the dashed versions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, all of Git's subcommands were implemented in their own
executable/script, using the naming scheme `git-<command-name>`. When
more and more functionality was turned into built-in commands (i.e. the
`git` executable could run them without spawning a separate process),
for backwards-compatibility, we hard-link the `git` executable to
`git-<built-in>` for every built-in.

This backwards-compatibility was needed to support scripts that called
the dashed form, even if we deprecated that a _long_ time ago.

In preparation for eventually dropping those hard-links, teach the CI
(and PR) builds to skip generating those hard-links.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/run-build-and-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 17e25aade9..b074db5c4b 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -10,7 +10,7 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
 *) ln -s "$cache_dir/.prove" t/.prove;;
 esac
 
-make
+make SKIP_DASHED_BUILT_INS=YesPlease
 case "$jobname" in
 linux-gcc)
 	make test
-- 
gitgitgadget
