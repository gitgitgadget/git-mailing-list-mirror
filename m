Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CC7C19F29
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 04:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbiHCEvt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 00:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHCEvq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 00:51:46 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A722AA444
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 21:51:42 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g12so15473963pfb.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 21:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Giyu19Nl2bViNaKwVJz8wtqPCydX94E30pkaHtiIhc=;
        b=Ivja0BKIfSfBoE01goytG3YOfIy5cjKPteCDr/QeybM0myrHK53ohq988+1MoUgzes
         wtiS/FD3c96szXMMXBNlZBOKWyJnHK1QYPNFJqA4LsroLXnech2eLeIVrG3lvPFqFpMm
         zyXdh/mnPttzpym6pNLBiNgBLsw8aZhIGE0egFcU4/VAPmmac9r9nO9KlBi8OW3JKpWF
         MVHCsxW8/pRMFEnsu7Z08JeZVOjNGqScnqFEeTsT32EyYWAJswMjkG3pLW1/YPUuE/eo
         VfEVEbnAbrB5uCbrSqG8187QKFJvCpEfIWpkU4JAOl5tLbguM5onBPF/Zsptf3oIQD+N
         7BTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Giyu19Nl2bViNaKwVJz8wtqPCydX94E30pkaHtiIhc=;
        b=jSTWBtf2B8aYFXHep+sFG4lAsPjReg+N8pFcgAJPLpcdJgXs5F4cufTdX9ZFNOYhPb
         JDDiVnkunVu9Px6sh0ofa9Dr6c7E8OVlk4CAVQcGLSUkSkHwRAMXem3FFAJqQtuOSAzq
         EQnbmW/17WuHa4uR3OolKQ0Z2UXcttvhIFsNWDVcvpwnwLDJg8F3t1qkMaIi5CWYsdHU
         hsMwHRQHNtMI+rY9CnZ11D25v964sUTwbWyyblb8EF632VwlvyKklE6e46qAPAMRbj/b
         ggW336KFHKUNlW6Hbaxt7I9C6wsrRy44U/93FFspwbnNuk4R40iSgpV6F2fd3pnIanWr
         0xgw==
X-Gm-Message-State: AJIora/DIebsXDhh01aZwLxbtYL2RaMnLFPqPDMCmDJsP+kPpuOTVmq7
        AX+YfP+Os4NYwfbMRqt/6ztqvm2BikOrm8SP
X-Google-Smtp-Source: AGRyM1seXgrVd3+Ej1oPZ34yuXyEjUMheT2w2gC3Bx5twsyI4gZav8Ru1lE8jNSO3BzOcKKFvCfkqA==
X-Received: by 2002:a63:293:0:b0:412:4f02:950f with SMTP id 141-20020a630293000000b004124f02950fmr19548044pgc.187.1659502301929;
        Tue, 02 Aug 2022 21:51:41 -0700 (PDT)
Received: from ffyuanda.localdomain ([113.65.228.71])
        by smtp.gmail.com with ESMTPSA id f131-20020a623889000000b0052e2a1edab8sm470211pfa.24.2022.08.02.21.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 21:51:41 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v1 1/4] t1092: add tests for `git-rm`
Date:   Wed,  3 Aug 2022 12:51:15 +0800
Message-Id: <20220803045118.1243087-2-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
References: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for `git-rm`, make sure it behaves as expected when
<pathspec> is both inside or outside of sparse-checkout definition.

Also add ensure_not_expanded test to make sure `git-rm` does not
accidentally expand the index when <pathspec> is within the
sparse-checkout definition.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 71 ++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 763c6cc684..75649e3265 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1853,4 +1853,75 @@ test_expect_success 'mv directory from out-of-cone to in-cone' '
 	grep -e "H deep/0/1" actual
 '
 
+test_expect_success 'rm pathspec inside sparse definition' '
+	init_repos &&
+
+	test_all_match git rm deep/a &&
+	test_all_match git status --porcelain=v2 &&
+
+	# test wildcard
+	run_on_all git reset --hard &&
+	test_all_match git rm deep/* &&
+	test_all_match git status --porcelain=v2 &&
+
+	# test recursive rm
+	run_on_all git reset --hard &&
+	test_all_match git rm -r deep &&
+	test_all_match git status --porcelain=v2
+'
+
+test_expect_failure 'rm pathspec outside sparse definition' '
+	init_repos &&
+
+	for file in folder1/a folder1/0/1
+	do
+		test_sparse_match test_must_fail git rm $file &&
+		test_sparse_match test_must_fail git rm --cached $file &&
+		test_sparse_match git rm --sparse $file &&
+		test_sparse_match git status --porcelain=v2
+	done &&
+
+	cat >folder1-full <<-EOF &&
+	rm ${SQ}folder1/0/0/0${SQ}
+	rm ${SQ}folder1/0/1${SQ}
+	rm ${SQ}folder1/a${SQ}
+	EOF
+
+	cat >folder1-sparse <<-EOF &&
+	rm ${SQ}folder1/${SQ}
+	EOF
+
+	# test wildcard
+	run_on_sparse git reset --hard &&
+	run_on_sparse git sparse-checkout reapply &&
+	test_sparse_match test_must_fail git rm folder1/* &&
+	run_on_sparse git rm --sparse folder1/* &&
+	test_cmp folder1-full sparse-checkout-out &&
+	test_cmp folder1-sparse sparse-index-out &&
+	test_sparse_match git status --porcelain=v2 &&
+
+	# test recursive rm
+	run_on_sparse git reset --hard &&
+	run_on_sparse git sparse-checkout reapply &&
+	test_sparse_match test_must_fail git rm --sparse folder1 &&
+	run_on_sparse git rm --sparse -r folder1 &&
+	test_cmp folder1-full sparse-checkout-out &&
+	test_cmp folder1-sparse sparse-index-out &&
+	test_sparse_match git status --porcelain=v2
+'
+
+test_expect_failure 'sparse index is not expanded: rm' '
+	init_repos &&
+
+	ensure_not_expanded rm deep/a &&
+
+	# test in-cone wildcard
+	git -C sparse-index reset --hard &&
+	ensure_not_expanded rm deep/* &&
+
+	# test recursive rm
+	git -C sparse-index reset --hard &&
+	ensure_not_expanded rm -r deep
+'
+
 test_done
-- 
2.37.0

