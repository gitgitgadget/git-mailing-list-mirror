Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F27C433FE
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 14:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbiADOtn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 09:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbiADOtl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 09:49:41 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE815C061784
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 06:49:40 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j18so76671975wrd.2
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 06:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mLaByYi+QfagezeHuWfWDfates2Ax6Y+fPE4+rCFGJE=;
        b=VHji6svvqNkkF2OpJw8/yJrkak9ReyLLiiIwJZm0F/4/Ucmw9Dr5YwdP0Ym+YzpqGx
         jP8MgpqUwFxXuPnYNjnD4vhthpuzl4kdA2diyYY887XzxukB0a/XVBQtMGi37YylaraH
         AulqYapgvqtdAZNt326JWB1yx0DOIvsrtOn84R/ZVn0q5Ce0kyKwoAyHCsJxn57pLoSt
         3ttt6OByWUX31LQAPBLXRLlJjIoqOw4dUq/lVQeyZFCwxdQvImJnDs1bOu/RTngWA04g
         PYCWVqGb1XSU5gSmXcBxxf6Zn2Vmq9abDxJnqg9bXMdxdQ30orQZ1Vvzek3iNeIFfsM6
         i6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mLaByYi+QfagezeHuWfWDfates2Ax6Y+fPE4+rCFGJE=;
        b=kFi5GDga6tX2qZWBkgIp1IGNBj6zO0xOHC6IFmgUQAUiJe7wrLjQRbl7n+0LpWQ0bN
         sdTtxetw54gakji8dRfVpVz5pzCippDVy6qR9Keof1NYQX1yl7sRN7V1pkSy7XaufTaq
         nUfQOHWNEHGsh8dIUdILRzDahKVT37hUG/x7SlI32ZFyntfAsgUOHcKWC8avyCXekJJK
         cvfRDG6y5ebMXQYYIylu08HMP7hsdxQAdEoMbW36TCIqq+MyMoBJK1fX5+RkX/hFjtZP
         DFUb1yCy3wllVZblFBFTh3jSZ1SOPVkckXZRkFQiyHTDbyD8hR/ppmyoTL2mEMf6GpjO
         gIcg==
X-Gm-Message-State: AOAM532RFZRUFAXzx7RbmuCVj5S5H2/idnfyobBgkIDwnm5CSd74P8sr
        LXR/Hp0SaqTKJPhk3Y1WUybp06mBMWQ=
X-Google-Smtp-Source: ABdhPJzL69ZM38kmVzLTUYw0jbRPflcp3jOlkm7D3XKAlRtDsPtKjuQphCdu4BnLx8CplvKBD6vFXQ==
X-Received: by 2002:a5d:6111:: with SMTP id v17mr42863328wrt.324.1641307778905;
        Tue, 04 Jan 2022 06:49:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g12sm42634070wrd.71.2022.01.04.06.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 06:49:38 -0800 (PST)
Message-Id: <18f77ab9dde121ca16cc52c624322bda10e2d2bd.1641307776.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v4.git.git.1641307776.gitgitgadget@gmail.com>
References: <pull.1171.v3.git.git.1641221261.gitgitgadget@gmail.com>
        <pull.1171.v4.git.git.1641307776.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Jan 2022 14:49:36 +0000
Subject: [PATCH v4 2/2] name-rev.c: use strbuf_getline instead of limited size
 buffer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Using a buffer limited to 2048 is unnecessarily limiting. Switch to
using a string buffer to read in stdin for annotation.

Signed-off-by: "John Cai" <johncai86@gmail.com>
---
 builtin/name-rev.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 21370afdaf9..d16b4ca0b66 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -625,12 +625,11 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	if (annotate_stdin) {
 		struct strbuf sb = STRBUF_INIT;
 
-		while (!feof(stdin)) {
-			char *p = fgets(buffer, sizeof(buffer), stdin);
-			if (!p)
-				break;
-			name_rev_line(p, &data);
+		while (strbuf_getline(&sb, stdin) != EOF) {
+			strbuf_addch(&sb, '\n');
+			name_rev_line(sb.buf, &data);
 		}
+		strbuf_release(&sb);
 	} else if (all) {
 		int i, max;
 
-- 
gitgitgadget
