Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C6EC433E6
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 10:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C9DC64EDA
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 10:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhBBKik (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 05:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhBBKid (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 05:38:33 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB29EC061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 02:37:51 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id q2so7571991edi.4
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 02:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZMzXkYzryiVu/B4G2QGY7D3BCF7Nwo+zun05jkCLQK0=;
        b=Q9l8D5YdiLVmBtm6hSlQRcHzyxkzZRYxACwsbmo443YxQ22Jcty8RiU4fNsfEVD8a3
         iOzHeQahHig30Tu4tgzpI0np9e+tVytY6sBWhmb6DQjUI1ew6VEg1XIPifn2tRVEXgQW
         41KiYvxx9cfRCMGiYCZQXcndzFfjBYhb7MEn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZMzXkYzryiVu/B4G2QGY7D3BCF7Nwo+zun05jkCLQK0=;
        b=m14oXmm+q6fWpHFbIFzextb6fnZPEd8r4zEgtA5kZB4NnUbgLyQiPExm2wbWB2XvOs
         56HoA99exq701WyGn5XRvW/qgtYn4KOsqtcSY4gxVw6v7duDbNkdMpj4HPk6EZRVt95z
         S3cAfdW9i0SxlV+N9h6/aJP1/LDAZ3G+EcjtJbAXYgo6QUF4ZuI33RIJi9ac3Ld9SXN3
         RiOHrgI5Y0og+a2jKqyz+jAGtbwxv9R0rgyp2G1I2qCmtMCnIbjF/moOZhlrfViQgKfw
         rvHoM821vVcYHuI5nXc/KzA2H+hkYFsIc1htS6YpIi7T0Wrylq1zBOaDAl37vnZijG0y
         OHng==
X-Gm-Message-State: AOAM530O781pYsQPfnpJ2n87YLXqdpyu3ZPMgqS8xyf2m+CaktSk7HMz
        MCVg3WKy28ODfSlUV0VlF08B9g==
X-Google-Smtp-Source: ABdhPJyQgaTzm271VQ0yhWsl8VzlzR0Ortlcj4cugOWCzau7mfQY/0t+cmZ1Q67okmzTGwYahD8ZNQ==
X-Received: by 2002:aa7:d6d4:: with SMTP id x20mr10531028edr.8.1612262270609;
        Tue, 02 Feb 2021 02:37:50 -0800 (PST)
Received: from localhost.localdomain (e93008.upc-e.chello.nl. [213.93.93.8])
        by smtp.gmail.com with ESMTPSA id p16sm423173eja.109.2021.02.02.02.37.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Feb 2021 02:37:50 -0800 (PST)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     peff@peff.net, avarab@gmail.com, git@vger.kernel.org,
        jeffhost@microsoft.com, jonathantanmy@google.com, gitster@pobox.com
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH 1/1] t5544: clarify 'hook works with partial clone' test
Date:   Tue,  2 Feb 2021 11:37:33 +0100
Message-Id: <20210202103733.42513-1-jacob@gitlab.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <xmqq8s87hvd7.fsf@gitster.c.googlers.com>
References: <xmqq8s87hvd7.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply a few leftover improvements from the review of ad5df6b782
(upload-pack.c: fix filter spec quoting bug).

1. Instead of enumerating objects reachable from HEAD, enumerate all
reachable objects, because HEAD has not special significance in this
test.

2. Instead of relying on the knowledge that "? in rev-list output
means partial clone", explicitly verify that there are no blobs with
cat-file.
---
 t/t5544-pack-objects-hook.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t5544-pack-objects-hook.sh b/t/t5544-pack-objects-hook.sh
index f5ba663d64..dd5f44d986 100755
--- a/t/t5544-pack-objects-hook.sh
+++ b/t/t5544-pack-objects-hook.sh
@@ -64,8 +64,9 @@ test_expect_success 'hook works with partial clone' '
 	test_config_global uploadpack.packObjectsHook ./hook &&
 	test_config_global uploadpack.allowFilter true &&
 	git clone --bare --no-local --filter=blob:none . dst.git &&
-	git -C dst.git rev-list --objects --missing=print HEAD >objects &&
-	grep "^?" objects
+	git -C dst.git rev-list --objects --missing=allow-any --no-object-names --all >objects &&
+	git -C dst.git cat-file --batch-check="%(objecttype)" <objects >types &&
+	! grep blob types
 '
 
 test_done
-- 
2.30.0

