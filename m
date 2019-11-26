Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1942FC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50632068F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCBWdgVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfKZBSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:18:21 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34669 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKZBSU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:18:20 -0500
Received: by mail-pg1-f194.google.com with SMTP id z188so8115207pgb.1
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IOdCZHq+8yw7YBBrvExEJd34tyBAih6z43dUJHDP6bw=;
        b=gCBWdgVcJ8VHvyB+zDjatBGmKw4hUa8K8ll6nnLm3MEuDqyhpiqjx1mhnZapuAm5mD
         9U12R79sEsGOW8umw7CqIlSdDeXGHfRTtYKRWODFiI1JTL6p2TKl/BU7plsiCZlbFNTk
         WbTbjzQyw4Il/0xHPGGxPot3rK8hvlccRb4om1DFUdht9A8qrROn5TPSoWOCmiJMq6vq
         Lz1BMak7b/Auuqbmm2sb3x6vzjQmI0Br48pCKepC5UolxxH/ZecboRgkxKqEgxvgOg/s
         gegAObcrYFJ5cBrmL2Hdht0bdaj4QA0qPJBvo6h2ZqW4soIFmD8/hWvoNJSptB2Yh0zQ
         KqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IOdCZHq+8yw7YBBrvExEJd34tyBAih6z43dUJHDP6bw=;
        b=QLz2rvIlLyzq7T9wOs0sYGfzqH0IiJ2lhpsW7zwqZ0O4YAU+q0wtX/ZaLnG6bdb60f
         t7GtjFdd/l2XOoR4jSOaXib4gJKN/MEBVS+8dBi4S9s0VRXC5B5lk/G+hLjCkozT6Ffi
         J7be6Tg+S5PEejvV+9Mjfs4iBEwCTQw7ZMQ1LjdAr+oBuMLzwSFiwuXT9hGpcCk8Tn6k
         +LenEC9Eokox4ndlAv7ntBPXe0lSdnr6YWSEWYdbpbUrhmRTFPzo3LH1bMoTg3Qm8oRs
         Iejk0fdc5NkR75aBu0AJnWE1wAvDIxaaaRezY4lf02yuhYHZnQUxd527LKKx2lxLrbcg
         hB4A==
X-Gm-Message-State: APjAAAXDRt/jvmduGebIGSPKgkhzUkJt1NLQzTAr2ERX943Ds+PjI7fe
        07r6wOt2oc51e88qjZKxb8y+ShU1
X-Google-Smtp-Source: APXvYqz6/6w82imTrhx6TIxkRYNxKIx+5uIiYSeYCI2mOFSlQtOLGonh8EHkb/WEoHWhtZv0KjWcEQ==
X-Received: by 2002:a63:774a:: with SMTP id s71mr10697909pgc.57.1574731098419;
        Mon, 25 Nov 2019 17:18:18 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id f10sm9683880pfd.28.2019.11.25.17.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:18:17 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:18:15 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 13/27] t5317: use ! grep to check for no matching lines
Message-ID: <fa238be28b5f4e1281d310eab0a6f90c15196d88.1574731022.git.liu.denton@gmail.com>
References: <cover.1574449072.git.liu.denton@gmail.com>
 <cover.1574731022.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574731022.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several times in t5317, we would use `wc -l` to ensure that a grep
result is empty. However, grep already has a way to do that... Its
return code! Use `! grep` in the cases where we are ensuring that there
are no matching lines.

While at it, drop unnecessary invocations of `awk` and `sort` in each
affected test since those commands do not influence the outcome. It's
not clear why that extra work was being done in the first place, and the
code's history doesn't shed any light on the matter since these tests
were simply born this way[1], likely due to copy-paste programming. The
unnecessary work wasn't noticed even when the code was later touched for
various cleanups[2][3].

[1]: 9535ce7337 (pack-objects: add list-objects filtering, 2017-11-21)
[2]: bdbc17e86a (tests: standardize pipe placement, 2018-10-05)
[3]: 61de0ff695 (tests: don't swallow Git errors upstream of pipes, 2018-10-05)

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5317-pack-objects-filter-objects.sh | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index a8bbad74e2..dc0446574b 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -45,12 +45,7 @@ test_expect_success 'verify blob:none packfile has no blobs' '
 	git -C r1 index-pack ../filter.pack &&
 
 	git -C r1 verify-pack -v ../filter.pack >verify_result &&
-	grep blob verify_result |
-	awk -f print_1.awk |
-	sort >observed &&
-
-	nr=$(wc -l <observed) &&
-	test 0 -eq $nr
+	! grep blob verify_result
 '
 
 test_expect_success 'verify normal and blob:none packfiles have same commits/trees' '
@@ -149,12 +144,7 @@ test_expect_success 'verify blob:limit=500 omits all blobs' '
 	git -C r2 index-pack ../filter.pack &&
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
-	grep blob verify_result |
-	awk -f print_1.awk |
-	sort >observed &&
-
-	nr=$(wc -l <observed) &&
-	test 0 -eq $nr
+	! grep blob verify_result
 '
 
 test_expect_success 'verify blob:limit=1000' '
@@ -164,12 +154,7 @@ test_expect_success 'verify blob:limit=1000' '
 	git -C r2 index-pack ../filter.pack &&
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
-	grep blob verify_result |
-	awk -f print_1.awk |
-	sort >observed &&
-
-	nr=$(wc -l <observed) &&
-	test 0 -eq $nr
+	! grep blob verify_result
 '
 
 test_expect_success 'verify blob:limit=1001' '
-- 
2.24.0.504.g3cd56eb17d

