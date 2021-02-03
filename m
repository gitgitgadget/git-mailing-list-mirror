Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C5BC433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 420BA64F58
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbhBCPij (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 10:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbhBCPgR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 10:36:17 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ABDC06178A
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 07:34:55 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id c12so24873424wrc.7
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 07:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lqKy4hVMWrTskZKeFtm7FEKoU1VgE+JBqwUCMTIqmOc=;
        b=Hikr5YIWfEm8+My0Mr97/7LizCoq9h9FYhJFUT1zg9jkLhHKI3n7R8oKI/o3sEjvbK
         zjQPImB/nC5BYdNk40YFPf+DaPHb9yZ3TcR29rw2m7yV5qwo4LTc+CmRBEWSARYKKQig
         XruYR1IeOMhOPg1hA84VPoVg2Kd4FlHh2zrvj9MW+MBih3p7b5IELxKXC58WlysKOqtv
         IFMhK8ttswfYCgv/iX8h1X4xmfDD+Pb6GjqLov5OvH9AheqpHGVm9SmlOkQgK8SUSIzp
         UObSZCprAcIvFoGqe2POcrigZnVzs9gGa5nUPi2qwNpgYX2e2L4wPc2cqHwwgCqHS3a8
         6HWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lqKy4hVMWrTskZKeFtm7FEKoU1VgE+JBqwUCMTIqmOc=;
        b=Fzn18xUs973JVn9TeiLorTdDznN5qq4KEn5ToYFobGFFsJWcaPvfbN6haNT8iQhBja
         +q2pbdDQTInAYScCazCnsp8PfFKpQn7vthHdSnAD0BM6wZX5490gVcNGgynut0z53AYl
         nojHZosbLxVvVFh/Yby43lecpgJm0Ji1pcnjlaxAKrm6/DckU4aCQVckKyFodgiww5W5
         pOOEYK2ARLo7utI8+Q40ut1hTTtlaSxfJZCHu+JW5Y7ao3oj+zC+U2GlM6eF0KwxQU24
         H/LDAK5TcqJS5WtPBZuOnVWdNLaTgDOhc6hnsJVNytVUFKQX2VmAkmEVri+fMMS5F0tq
         k1Vw==
X-Gm-Message-State: AOAM531Bb4Mrhd7XxmUQd8/8N0UpbUt3ieVn+fKFUwFbgcoVMPBRwa6i
        4tsErDxH01APkrAV+N7chTMVjYvp6l4=
X-Google-Smtp-Source: ABdhPJyhbGQLLi7kaxs7HmSEZCCwMkA6SIaS1k+1GnxV2gQ/ZMN3yqWrC+4hxewf0RgI5UnSZB1mSA==
X-Received: by 2002:a5d:6282:: with SMTP id k2mr4307182wru.159.1612366493880;
        Wed, 03 Feb 2021 07:34:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c62sm3162762wmd.43.2021.02.03.07.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:34:53 -0800 (PST)
Message-Id: <e570f7316cce4d3cd6cedbb551124b7b317f11d3.1612366490.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
        <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 15:34:40 +0000
Subject: [PATCH v2 01/11] p7519: do not rely on "xargs -d" in test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Convert the test to use a more portable method to update the mtime on a
large number of files under version control.

The Mac version of xargs does not support the "-d" option.
Likewise, the "-0" and "--null" options are not portable.

Furthermore, use `test-tool chmtime` rather than `touch` to update the
mtime to ensure that it is actually updated (especially on file systems
with only whole second resolution).

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p7519-fsmonitor.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 9b43342806b..6677e0ef7ab 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -164,8 +164,18 @@ test_fsmonitor_suite() {
 		git status -uall
 	'
 
+	# Update the mtimes on upto 100k files to make status think
+	# that they are dirty.  For simplicity, omit any files with
+	# LFs (i.e. anything that ls-files thinks it needs to dquote).
+	# Then fully backslash-quote the paths to capture any
+	# whitespace so that they pass thru xargs properly.
+	#
 	test_perf_w_drop_caches "status (dirty) ($DESC)" '
-		git ls-files | head -100000 | xargs -d "\n" touch -h &&
+		git ls-files | \
+			head -100000 | \
+			grep -v \" | \
+			sed '\''s/\(.\)/\\\1/g'\'' | \
+			xargs test-tool chmtime -300 &&
 		git status
 	'
 
-- 
gitgitgadget

