Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67600C64ED8
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 23:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjBXXjf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 18:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBXXje (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 18:39:34 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0BE6F40D
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 15:39:32 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so3384697wmb.5
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 15:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FbWlNZEuq+pZx1n/PRTiTJYEQ/r7ZV1yvpw1t1wQDs=;
        b=KOR8E/y3oE0KiEYDYRIdbZpZaTNGBXscjFmkt7atB0x1EVFIMK1wvtnItKJ+hKNiWQ
         HvZH9ZghzrJWfX2CBYkGv632Xh+HLcDR8jtWN2K3iEyVckn3Nev1mfDzcybUNN1qJdcS
         vy7WMoOBwHgRZKhuZVDzC8WUcTsEgU/taeI+jPO2aolF1seSOAYk4bFB8CSc7pfJs94z
         BH8eS1UwzfEGLy2EKjap4y1qtmArFiEpYZoeep4kSCQdApyjeg2Mq9+dh0VM0byfqps6
         +CAnLXXs0L5n312xic/Zm+fKEm3opj+g8A2cCERDjFkbk42qzUhLtccMiH5q+nzcDchK
         SCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FbWlNZEuq+pZx1n/PRTiTJYEQ/r7ZV1yvpw1t1wQDs=;
        b=5Zut09Jquj4IF2hLSSQzoc1YG/MEkkibMiaDOeuDLlOdQ9yQdWwgt09L1MB5bANQht
         OOQZwwtZYQDamfdikOC1IaCVFSRpc/mgdl5G22UIDPgkPX2EU2AO4H7LFJBGZ/5y0J99
         PXk9Xxlwds5qFgHDTIyiTSRagTJjRkjFspxkxFgZv65BpQHL6QPvXYOjiBBOamLdcCNZ
         y9KOsM3+9ZZTdjeaDfd1L+ATGkiv9+SkYSshadXpD/adijsxmhfvd2SlnoADXjiStMUT
         nmw60VwEvXDp0MZh+Zue0ErgUXvmbuRCaem3/1QHwVW3ntmub9IMRhYCJmoxxFKktbwH
         UWEg==
X-Gm-Message-State: AO0yUKVP3kpT+FZmt12WlGhTZI4d1FbsxJ9VpurPO/fK0P34/hKGgKsN
        ahb9Q6woSXVbCLVsYGPVwNVDEIeLethe7A==
X-Google-Smtp-Source: AK7set8Ukxo3uT5I8S31SelMuW78qr7932X3U5qpnB0YVeRjYqXFgYebjbl7axOiISZ5jQjcAaKh/w==
X-Received: by 2002:a05:600c:3b8b:b0:3ea:ea6b:f9ad with SMTP id n11-20020a05600c3b8b00b003eaea6bf9admr4609673wms.31.1677281970787;
        Fri, 24 Feb 2023 15:39:30 -0800 (PST)
Received: from DESKTOP-FOQ07IR.localdomain ([2a00:a040:191:caeb:8c12:5f48:cdd4:4a9e])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c35c600b003dc4fd6e624sm709441wmq.19.2023.02.24.15.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 15:39:30 -0800 (PST)
From:   Roy Eldar <royeldar0@gmail.com>
To:     git@vger.kernel.org
Cc:     Roy Eldar <royeldar0@gmail.com>
Subject: [RFC PATCH 2/2] status: improve info for detached HEAD after clone
Date:   Sat, 25 Feb 2023 01:28:41 +0200
Message-Id: <20230224232841.21297-3-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230224232841.21297-1-royeldar0@gmail.com>
References: <20230224232841.21297-1-royeldar0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a remote ref or a tag is checked out, HEAD is automatically
detached, and "git status" says 'HEAD detached at ...', instead of
'Not currently on any branch.'; this is done by traversing the reflog
and parsing an entry like 'checkout: moving from ... to ...'.

In certain situations, HEAD can be detached after "git clone": for
example, when "--branch" specifies a non-branch (e.g. a tag). It is
preferable to avoid displaying 'Not currently on any branch.', so
'HEAD detached at $sha1' is shown instead.

Signed-off-by: Roy Eldar <royeldar0@gmail.com>
---
 t/t7508-status.sh | 2 +-
 wt-status.c       | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index d279157d28..0ab5bdc1e0 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -894,7 +894,7 @@ test_expect_success 'status shows detached HEAD properly after cloning a reposit
 
 	git clone -b test_tag upstream downstream &&
 	git -C downstream status >actual &&
-	grep -E "Not currently on any branch." actual
+	grep -E "HEAD detached at [0-9a-f]+" actual
 '
 
 test_expect_success 'setup status submodule summary' '
diff --git a/wt-status.c b/wt-status.c
index 3162241a57..f0a5fb578a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1632,6 +1632,13 @@ static int grab_1st_switch(struct object_id *ooid UNUSED,
 	struct grab_1st_switch_cbdata *cb = cb_data;
 	const char *target = NULL, *end;
 
+	if (skip_prefix(message, "clone: from ", &message)) {
+		oidcpy(&cb->noid, noid);
+		strbuf_reset(&cb->buf);
+		strbuf_add_unique_abbrev(&cb->buf, noid, DEFAULT_ABBREV);
+		return 1;
+	}
+
 	if (!skip_prefix(message, "checkout: moving from ", &message))
 		return 0;
 	target = strstr(message, " to ");
-- 
2.30.2

