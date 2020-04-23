Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D21C55186
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 23:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 908F02064A
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 23:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuaIEDNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgDWXnY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgDWXnW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 19:43:22 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CCAC09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 16:43:22 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v4so8655067wme.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 16:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zvSRlclVscbKpj/yBPtVkLeJtsfdL6+Sj4GIpIS88zk=;
        b=FuaIEDNwTVVMshrkXFIxvyT/48q0R59xO8O6b5VAMwP0vFAcUOXkOjXWtEg+ijAJJ4
         kAlzv63K8UmnRyBsUeohZpWOIGUI9PHU6Q9xTqrv+N0vZcr8Q6WAXYeig8/AmD3SEPSB
         YKQC90EWNaKSq/lUVPX3dmBmGQto+L2xyiuSDmtz8aAUa+rrxq8jEIOY+YEVxB1nMTBu
         ChLUI60Y1kitXFMgxWMoBY1uswhC/yEhJgSR2e4ZuNoirh8pSSgKG46NAwln4ClT/v0D
         8LTQwK0aQ/M2Pbeauh1NU/kMyfe12gXF6bUnuaiLE9OOQ4oX0IgugBTZpzmCMFUSxBuO
         eFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zvSRlclVscbKpj/yBPtVkLeJtsfdL6+Sj4GIpIS88zk=;
        b=ABymmrTNuQwZhMN0B9NB9NucmaGzcLixls/jFj3fBHIknaIMkXqRG6o7DdMyKL0oWI
         R3ZJYYSv/wfUxpAnhF6IQ44MhfB8zc+/WCgY9zfD2JufptyiBYuHPSUgR6QSotALbKr7
         Zef0o+A+GB89pTsMCy/iFS20+nuARrv+dkXLYjxCnrcJFSdXgKCTu/sG/2ABZX+YbIfm
         jfRbnytrV+XjJAiV1I6a91FIARPVsd8B/LRswMc7didNMsj2ZG3vt8y4jYWF724nmBer
         Il4/yF+ptFqfYbt+L1sj/+473APAWe0Fi2QeZBWqXtR7Wq8sQfHehASxBpemEPYthAs1
         UMPg==
X-Gm-Message-State: AGi0PuYM7l6vSaRDW1bU/KGWkecDOSmWTJFnWm48wMnDqmdzNaVEf54k
        ZcesLVfVD6533nVOVjWG0nmlLcFb
X-Google-Smtp-Source: APiQypKXuOwPBmzScdGZFTJiCxBhJcnl+efoLpZLBmyiY2g0HGk47BlbAI5RrRMzHFy1OBQiJcCclg==
X-Received: by 2002:a1c:1bcb:: with SMTP id b194mr7015746wmb.4.1587685400949;
        Thu, 23 Apr 2020 16:43:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z10sm5902491wrg.69.2020.04.23.16.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 16:43:20 -0700 (PDT)
Message-Id: <daedaffe960581733c25383a2a1b30056a415594.1587685397.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com>
        <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Apr 2020 23:43:17 +0000
Subject: [PATCH v2 3/3] credential: handle `credential.<partial-URL>.<key>`
 again
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the patches for CVE-2020-11008, the ability to specify credential
settings in the config for partial URLs got lost. For example, it used
to be possible to specify a credential helper for a specific protocol:

	[credential "https://"]
		helper = my-https-helper

Likewise, it used to be possible to configure settings for a specific
host, e.g.:

	[credential "dev.azure.com"]
		useHTTPPath = true

Let's reinstate this behavior.

While at it, increase the test coverage to document and verify the
behavior with a couple other categories of partial URLs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 credential.c           |  8 +++++++-
 t/t0300-credentials.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/credential.c b/credential.c
index 52965a5122c..3505f6356d8 100644
--- a/credential.c
+++ b/credential.c
@@ -53,7 +53,13 @@ static int credential_config_callback(const char *var, const char *value,
 		char *url = xmemdupz(key, dot - key);
 		int matched;
 
-		credential_from_url(&want, url);
+		if (credential_from_url_gently(&want, url, 1, 0) < 0) {
+			warning(_("skipping credential lookup for key: %s"),
+				var);
+			credential_clear(&want);
+			free(url);
+			return 0;
+		}
 		matched = credential_match(&want, c);
 
 		credential_clear(&want);
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index efed3ea2955..6fff76cb932 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -448,4 +448,43 @@ test_expect_success 'credential system refuses to work with missing protocol' '
 	test_i18ncmp expect stderr
 '
 
+test_expect_success 'credential config with partial URLs' '
+	echo "echo password=yep" | write_script git-credential-yep &&
+	test_write_lines url=https://user@example.com/repo.git >input &&
+	for partial in \
+		example.com \
+		user@example.com \
+		https:// \
+		https://example.com \
+		https://example.com/ \
+		https://user@example.com \
+		https://user@example.com/ \
+		https://example.com/repo.git \
+		https://user@example.com/repo.git \
+		/repo.git
+	do
+		git -c credential.$partial.helper=yep \
+			credential fill <input >output &&
+		grep yep output ||
+		return 1
+	done &&
+
+	for partial in \
+		dont.use.this \
+		http:// \
+		/repo
+	do
+		git -c credential.$partial.helper=yep \
+			credential fill <input >output &&
+		! grep yep output ||
+		return 1
+	done &&
+
+	git -c credential.$partial.helper=yep \
+		-c credential.with%0anewline.username=uh-oh \
+		credential fill <input >output 2>error &&
+	test_i18ngrep "skipping credential lookup for key" error
+
+'
+
 test_done
-- 
gitgitgadget
