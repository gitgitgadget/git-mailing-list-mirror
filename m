Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9598C388F9
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F50A208B6
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VF6rft7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbgKATee (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 14:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgKATe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 14:34:28 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A846C061A48
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 11:34:28 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id f9so14663565lfq.2
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 11:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F7skkKHM5R05UGdkMu1617woWQOZ5h6BpD7foIYbeG8=;
        b=VF6rft7Rqx3d/gW0lclzJnuUtwUl5ezFcyiN5ryVo5vPBt3hvkE4s3ShVUglBnTMcb
         R4jg0UVGXlW6JT+5mPgVwjWCP6KUHU4vC24aF30pSJYDdUPnVn+j4jxFpcfOAKiaozov
         0dWub0eLfiWkYGG9bWWKGzFgBGiNFx5/Qk81bVChllZsyVy/73CIDaMSd9MC3S+NorkE
         VT/qYKa/Tg4sLkfAuiYEkamrUEgQxVUM14J7ArdjkYBG/XaiKGiEXOa8A28NeDhxPSKV
         00+tlOubgBhAvcIl01ylNkdLX+Jzo4KAREb7lXlgowtijf/p6A3R67BFS/cZf5B9vu5O
         HoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F7skkKHM5R05UGdkMu1617woWQOZ5h6BpD7foIYbeG8=;
        b=IOLxWx/t26vLRT9vuw3Inc94fNTmfMLIlKLcpZhpIzJOVvhgAxbJXAh6YRR5Ci9kvr
         TSXqjv9OQcU9es0TEqxIUXHb4aoj2fBT1C50gCyMjBzNG71313jLLhMSzRn9E5uPxgER
         6zrd959rEJ9DaO/Bsv14nOx3qEAcRnXRo6f+jO/b0HciTuFGJQ+6gngxXhxTySQs1ruB
         KShxHvhvJHe+dVISv3SCw4VcIYgoGuuMWS8uV+P7Yt4rN1h8iE2miMLJQ5HcouVkBTCR
         1PK1cgMVvxuSifAYxCPclDQ8XUdtZ6UPR+hyTNtmb/wQUd4HRueRjp/5yUFWqhQsaAfX
         QRyA==
X-Gm-Message-State: AOAM533EB+oNfaMjFSC5iVlDZ987vO0T/jshOdHxT9MiOl25fbnhNgc9
        KrOW77tx0OzRvt9tYRHJqVE=
X-Google-Smtp-Source: ABdhPJyW5Qv9WMVMJn0grQK2TfreBaVkUlHD5naV530qzuUcGWZIx6B+qDCXcOA+0z/AnLozjoYfIg==
X-Received: by 2002:a19:8988:: with SMTP id l130mr4305882lfd.126.1604259266923;
        Sun, 01 Nov 2020 11:34:26 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m12sm1766526ljc.88.2020.11.01.11.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 11:34:26 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 25/26] doc/diff-generate-patch: mention new --diff-merges option
Date:   Sun,  1 Nov 2020 22:33:29 +0300
Message-Id: <20201101193330.24775-26-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mention --diff-merges instead of -m in a note to merge formats to aid
discoverability, as -m is now described among --diff-merges options
anyway.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-generate-patch.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index b10ff4caa6c5..2db8eacc3ec7 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -81,9 +81,9 @@ Combined diff format
 Any diff-generating command can take the `-c` or `--cc` option to
 produce a 'combined diff' when showing a merge. This is the default
 format when showing merges with linkgit:git-diff[1] or
-linkgit:git-show[1]. Note also that you can give the `-m` option to any
-of these commands to force generation of diffs with individual parents
-of a merge.
+linkgit:git-show[1]. Note also that you can give suitable
+`--diff-merges` option to any of these commands to force generation of
+diffs in specific format.
 
 A "combined diff" format looks like this:
 
-- 
2.25.1

