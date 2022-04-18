Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0754CC433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347165AbiDRR2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347081AbiDRR1J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:09 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B7334654
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i20so19270735wrb.13
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ecz6sD4d2eDAhUAiYpFj9M1fcQXuEiVi1TWhK5nDMJk=;
        b=iOAELEufDlEPP41RJgKaC9j7oz+yYm62Os9zkKclyFCR4Tk9JjgNhiFp2wngzHwclr
         7k+RCfu92fTXmFmc+OGvBNFI5oQub9NZY6yTwK3jTgpdMG4Oh4O3L7pzfat0JUxynQ5/
         XfB/BfFwezw0uKo7AuvyrgrDswAB1Y9O5pme40CDuOFMbFB28rTC0v00fKo2NQLqVnDG
         I0fUhXYOYUVop3bBjCu3K2SWRZ+bOO9Lu+kL51QpkkgNCUL8pIqAxJgnIIpMfS5uAlhH
         RzXWR/uC2qzjlSBVLMIgCj9kZV52SFfzUUVStXePL9ICF22nyJ8vCvQQRfJGfpnL+aLB
         xXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ecz6sD4d2eDAhUAiYpFj9M1fcQXuEiVi1TWhK5nDMJk=;
        b=KumGUanNx8BRVK4/Q3k/66SWFbXfLNcHr6tgyIYLZ82JF2n2LMRpNqQhjm/+zXYtiN
         MQvBfQ0p2CMzW/2hGj2IRFlrydMaBztinP63mX21igaxZqeZXWNtQs+N63C66dbO8FNS
         tnQYceKW4UShuRYv/+KwvbC2+YldOfv1L0Iadkbzh2Xe6azafZmtFPvK5Ri3oRbfwnyh
         TQTAhx3D23TXQDvQBIgUUhFbAJ7HHnSy4jkW/fWqTy3O50NUu+c0YUaBjTch3yco/8Xw
         gSMUz0VG0Uwvt99/ksETMhPKCvjTJLRmQwYlkheX5NE4S7HHLMaNqrj4bI8TB/TSEnkD
         JRzQ==
X-Gm-Message-State: AOAM533hVvHMpMeKo11v3uc3J2b5zfcldqi2fH9GwEW233LHcBPEASC/
        8EqBalTdkO6BQeyRkO4cgSWxrfUDaxSGYw==
X-Google-Smtp-Source: ABdhPJymA6jP/c3AXnqZFgi4igovtNIZR6+YF3+BdeT3TodTkIHZl1NcTbFLIMyl3nPus4UbSDJNhA==
X-Received: by 2002:a5d:47c3:0:b0:20a:94c2:e2cf with SMTP id o3-20020a5d47c3000000b0020a94c2e2cfmr4724882wrc.166.1650302665102;
        Mon, 18 Apr 2022 10:24:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH v2 24/36] clone: --bundle-uri cannot be combined with --depth
Date:   Mon, 18 Apr 2022 19:23:41 +0200
Message-Id: <RFC-patch-v2-24.36-d79901dddb0-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change added the '--bundle-uri' option, but did not check
if the --depth parameter was included. Since bundles are not compatible
with shallow clones, provide an error message to the user who is
attempting this combination.

I am leaving this as its own change, separate from the one that
implements '--bundle-uri', because this is more of an advisory for the
user. There is nothing wrong with bootstrapping with bundles and then
fetching a shallow clone. However, that is likely going to involve too
much work for the client _and_ the server. The client will download all
of this bundle information containing the full history of the
repository only to ignore most of it. The server will get a shallow
fetch request, but with a list of haves that might cause a more painful
computation of that shallow pack-file.

RFC-TODO: add a test case for this error message.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/clone.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 51141c979fa..af64bd273b7 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -926,6 +926,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
+	if (bundle_uri) {
+		if (deepen)
+			die(_("--bundle-uri is incompatible with --depth, --shallow-since, and --shallow-exclude"));
+	}
+
 	repo_name = argv[0];
 
 	path = get_repo_path(repo_name, &is_bundle);
-- 
2.36.0.rc2.902.g60576bbc845

