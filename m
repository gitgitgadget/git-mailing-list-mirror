Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3216C433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 22:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiCKW32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiCKW3T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 17:29:19 -0500
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4F627AE87
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:18:53 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id qt6so21877005ejb.11
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EsZjPISOsxY8eLD0WyooDenwtD/HwaAWi5+s5m7e8aY=;
        b=MGZ/vYZyIAP0Xgiq4fPaKn1g75kQAmBpe1YVVDrw75Epw+wpA+xs+CmN9+9tnNP4yW
         p2BnmdD+3ynFlGh2TkAcfTWmzvnRcBNa8ZcyFRpv2ajAM/XmjuPTY9/gSbpSxArjSSLG
         dOrPgKKbHtkk6+4BR4G5D27o7gZ/vyNeulIcIvIKFD6dFCudjgxlO3BBMJUEHtL9qksm
         roCLXNnqOIWCSdahgnjN6i9aEXdI+/4QKLX+CAkt/Qt8O9pT8IXoKI5YwuCMP944hJgm
         PT6DqN85qYK8QTVW1XcCOfJUKaJDaGNCuMkD9jmrE2bXkrxBJolbOPaqWkHwWSuVgOF3
         pqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EsZjPISOsxY8eLD0WyooDenwtD/HwaAWi5+s5m7e8aY=;
        b=5ql1AbYWDg/Gnlqn+jbRd1O0WCv6BNCdi32gAS24CcNem60K1VaBkaJTP5GUMJaaPb
         fMC7lcebrrpFEFkzgHz2JVQn9PHfoLkR9GtX3kkewoNNeSPDGQKWX29G8FBKjiHbhhL5
         KaplpcQdGow3JVw457pGEUawoM7V8YLbDdFUngkmMKqN16gmr79GUBtiLY+crXGMzbDg
         8IlkycaXCJ5JA8n+USlHXGpcjlm0XdlHbPbLbDM/Fa7pSXjQzSvg+4hmp4tmp9PDIglK
         iudj8h1uQnwzor9UUe2Ddygd3Xz8uCZ/HM/veqrlBcGKc+fulU680U5dhajJf1nAHCB6
         8ouA==
X-Gm-Message-State: AOAM533M15C9VbpThGgv+rgOmvNhWbauLcVkDnFABDjfdZVLbZmxtnlB
        3mXeODwb6wjb1GBjy5+JIG5TDbWdTKA=
X-Google-Smtp-Source: ABdhPJxXQ6/Gf+8ACLh9NlbC+/UitqRr/CX5LeD80lO6ETJndfTfCqHpzYSttlLKa5cdFNwM0PHT6Q==
X-Received: by 2002:a5d:4609:0:b0:1f1:de8a:af07 with SMTP id t9-20020a5d4609000000b001f1de8aaf07mr8628634wrq.549.1647033305091;
        Fri, 11 Mar 2022 13:15:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1-20020a5d56c1000000b001f0626c9360sm7382556wrw.44.2022.03.11.13.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 13:15:04 -0800 (PST)
Message-Id: <6750cc17bc439c14e752606fbb7271086a802eaf.1647033303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Mar 2022 21:14:48 +0000
Subject: [PATCH 01/16] t/test-lib: avoid using git on LHS of pipe
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

fixup! help: include fsmonitor--daemon feature flag in version info

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/test-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 46cd596e7f5..5d819c1bc11 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1803,5 +1803,6 @@ GIT_TEST_MAINT_SCHEDULER="none:exit 1"
 # Does this platform support `git fsmonitor--daemon`
 #
 test_lazy_prereq FSMONITOR_DAEMON '
-	git version --build-options | grep "feature:" | grep "fsmonitor--daemon"
+	git version --build-options >output &&
+	grep "feature: fsmonitor--daemon" output
 '
-- 
gitgitgadget

