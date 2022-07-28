Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87645C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbiG1Qaz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiG1Qak (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:30:40 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4442319C39
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:29 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v5so1283292wmj.0
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=NQe6PkKD628J1ciH6LcRkkH7QD3SC8650VZsGYakTms=;
        b=VEdpKIrEy7rOI8zg0FUdczLbAaU+zuW4uN23c83yXLK+n6wbBJW2vWn5ejeIX7zQjl
         L+sYP477Yw5w5e1+zNrfpnnDfna4cq1OdMQ3gBlmHrRCtnBtA2Pd3Kk4xPmDXDCvwGHh
         2zZ+c52rsm7ufK2F6poWO9zSLSGhHA3mJqlHKMhVpQWeJSEhLbI9wIicE2rd3468BYR3
         bev0OIKsatMzPDOGzWw6evSOzg05KiROSHTrsmcpEpbAWSlYHSR+txUr/U7glO9puZm6
         zVnsnM0fx+OOPXYSlr0H5AcU6MHdvQEYlSORIT5LHGem1b1Y0cs9ByHtgc3oKX5qerrG
         Jzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=NQe6PkKD628J1ciH6LcRkkH7QD3SC8650VZsGYakTms=;
        b=JSfsxb2+QFVDdCX6OmrGCOpmXQRoR237K39brRA5/TdM08pIz9VOakpEnfl6ER5G+3
         vpMoT7Rhfg4wbiB7P4Va/ilPDcQobkb3F8Qemoj5gsbLLhxDYxhNVDH9Nr0mWcJ/guVb
         bknKuUx+hf4tlPbHRfZfr/Jkd+m0vT0/pLWWJtt6aA73KIEB/RDcGReQzmSF98846FZ5
         VZAhLetm36bvFnZNs+GabuLNuArxIof32H9nB3lLCALyiqGVpBERPULGbrZ3OJgS4AJd
         Qi8uipejE7ilP6caDvhW//ATHe+51fwZAOFUjP6QxmJp26cjtA/N0WifiJqHtX1ylhAX
         wstg==
X-Gm-Message-State: AJIora84FR9bryYCKwmsQ/1DRwEcSXos714ZH31JRqOZ9MsteFpjsfvz
        BYA49shmoFM+WWqWTCQkzZiXwex5Eo0Efg==
X-Google-Smtp-Source: AGRyM1sUmu8l0FNYsjAjAGUpvKZfv2bYZ6zefEMnpZD1QFFbdo/aKEPGnagVgtlMVJnaata42FVaHw==
X-Received: by 2002:a05:600c:1e03:b0:3a3:6cd6:1d38 with SMTP id ay3-20020a05600c1e0300b003a36cd61d38mr142172wmb.25.1659025826703;
        Thu, 28 Jul 2022 09:30:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d528d000000b0021ef34124ebsm1492018wrv.11.2022.07.28.09.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:30:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 09/17] submodule--helper: fix a leak with repo_clear()
Date:   Thu, 28 Jul 2022 18:30:03 +0200
Message-Id: <patch-v4-09.17-0798a00c9ef-20220728T162442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1197.g7ed548b7807
In-Reply-To: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
References: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call repo_clear() in ensure_core_worktree() to free the "struct
repository". Fixes a leak that's been here since
74d4731da1f (submodule--helper: replace connect-gitdir-workingtree by
ensure-core-worktree, 2018-08-13).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index becf686e47a..dbeafd9787d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2375,6 +2375,7 @@ static void ensure_core_worktree(const char *path)
 		free(abs_path);
 		strbuf_release(&sb);
 	}
+	repo_clear(&subrepo);
 }
 
 static const char *submodule_update_type_to_label(enum submodule_update_type type)
-- 
2.37.1.1197.g7ed548b7807

