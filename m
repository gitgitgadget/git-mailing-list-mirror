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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC3EC433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 680CC6101E
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238071AbhDSKxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 06:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237670AbhDSKxj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 06:53:39 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E67C061763
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:07 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id t14-20020a05600c198eb029012eeb3edfaeso7940005wmq.2
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hCsQOIxYRiZGmvP6afW8BZps1OSvbdwKuZbdnuIFjdk=;
        b=aGeiw8g40Ipdr91utGOYGVaqz86ikUgW4OnafeAqvnrxwUeKmmrfJnt4npVMsOnKlP
         WVjj6BPfhfVMsQxlLGHAqrjla2GeqYcLsUFVz+x9EuU8M8wiJjq1CibNP99ZwRwiEMBk
         Y/nBvxtTmD+lwdZ6ZPmlRoID1+JR8TVLs4YWS+nPaNCam7on199y+m1LdHTkJP5HztVA
         lza87uf8nhqdbNOuf7PC+R1Bfptj32XsXWco8irw6lYSmsk17+ES29XYPUFGYXGsosYx
         an31TUyaOiZ6uaSTnUjZR99e2beQ4Ve1aFySd+xJZAY2aXFfbfHrqZWc2brXoM1/P3KD
         9mVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hCsQOIxYRiZGmvP6afW8BZps1OSvbdwKuZbdnuIFjdk=;
        b=hsFejDqg3IQlIX/8+tNlhldgiHuYlA827A/LRFrxZRxNl2ZJutQW7k9Nf21mhH+BUU
         iBDgffcJ3pl9ZPy2+lvkMCGCHc3+31qaVD2yPWRuwHEpTogb0hqshJKczK39gSu4d6H+
         iQ2386VUiyQkiU4HIV0hlGC7Jcd2Lq0QqL1DI0DhtmblZ13+pmyYtWtF5fvy6/S02Lem
         8qQUVlcR4BAood6IKBWOUyiDCXTyRGHF5XZfyAwglD3HhvsnxNzBa+jcKhccCxkSOIT4
         PdT8bZa/LCHzIpNwXmmftW1ej7ssvBmqptMrnojPa8RTTQKvu432J6TOfHpBMeHlbmcl
         sG3g==
X-Gm-Message-State: AOAM533ro5eXuUT4Ud22yDPl5q90D7lq5DUTfdqAoKSbA+24PpNxEK8O
        3TK8qV1YBA3MaSrEprmAr8JIG3RA9F8=
X-Google-Smtp-Source: ABdhPJywt+CKTFtqfTGxpzjxrEdb5ELi/FRGgRkGGNkTyAQ0oDxuRwJBqGeBXoHhncrGTdXcs/wJKQ==
X-Received: by 2002:a7b:c10e:: with SMTP id w14mr20558230wmi.8.1618829586307;
        Mon, 19 Apr 2021 03:53:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k22sm21811158wrh.5.2021.04.19.03.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 03:53:06 -0700 (PDT)
Message-Id: <47b5ec56a38379adf3eb48acd5a093bbdfdeb511.1618829583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 10:52:48 +0000
Subject: [PATCH 03/18] t5601: read HEAD using rev-parse
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t5601-clone.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 329ae599fd3c..7223372c7660 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -305,7 +305,8 @@ test_expect_success 'clone from original with relative alternate' '
 test_expect_success 'clone checking out a tag' '
 	git clone --branch=some-tag src dst.tag &&
 	GIT_DIR=src/.git git rev-parse some-tag >expected &&
-	test_cmp expected dst.tag/.git/HEAD &&
+	GIT_DIR=dst.tag/.git git rev-parse HEAD >actual &&
+	test_cmp expected actual &&
 	GIT_DIR=dst.tag/.git git config remote.origin.fetch >fetch.actual &&
 	echo "+refs/heads/*:refs/remotes/origin/*" >fetch.expected &&
 	test_cmp fetch.expected fetch.actual
-- 
gitgitgadget

