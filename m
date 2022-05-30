Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67BAC433EF
	for <git@archiver.kernel.org>; Mon, 30 May 2022 17:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbiE3RpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 May 2022 13:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiE3RpU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 May 2022 13:45:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1D99C2D7
        for <git@vger.kernel.org>; Mon, 30 May 2022 10:45:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e2so15659331wrc.1
        for <git@vger.kernel.org>; Mon, 30 May 2022 10:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=MeFQDd/vMIq3sQTe/EpHZmNwHjtDbeiSDoIWpfAEIb4=;
        b=DPAIWcPWRNlM3n8e+lSgC8ZYIq6YqiE/WvkoDOuqF28TyxsXVbdfrtkwL5aTVb6OSG
         egbC8AjADCWGpb2WQ1FkPcldGh72uc3XKXzyxAdIulnGvTlioZvBO6IOxno3RCLGQ5/n
         EQBqQZIN0bFatPgXa2ANsKZ6sRs3y3VKPWO+hrUaOBdLBa/0kNApPnsfTIpOrowt8nBe
         mpqFYewCueq/KECA2xwTbLS8ywP3hsFowjrek0qNzZ/k5HAiozOCKDEcS5KEt4NCCrI9
         kENBl3k1KQJ+r+J3utgk/Ta84z9meqUxJ0XHSYr6m5FEY0hjxCSnHi8EyX81s4scFwQH
         RkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MeFQDd/vMIq3sQTe/EpHZmNwHjtDbeiSDoIWpfAEIb4=;
        b=uj047csQyBB9ZFwNdtF5SchJwgEOSyH2N6IiUGs2pgFJq19HXQ/ZAj7cX3shm9qFK8
         QyWLmBjroLVpAM4KYNUUvnonyWHFenzfKiLTIFUAG8Sr0xXPHSc3C31u3C+TfZgh6rPL
         qCQyFfeZyrU1kZwCU932amKyiAu021jp80PXNwT7grrGJEZQmXMp4NxughmuKQ/cUq0w
         57r2wwrVQTECIzxFpEO6FSa69RhMbuyzyw4GoshGdsch4kqJ7kqyCFcVOWkWkJSKuP0+
         yKwqHXQkXIKj/PrjALg96v+fJZnqBKW9DRhczJRRD6VUW6LYs9YV7uMWzyjfH25EVDdF
         NJ9g==
X-Gm-Message-State: AOAM5336fYZZ4dib4QKYcao/0Hf47AUeClcU8QJZctbjGSEWB8+EThbF
        zp483A6Gt/XUEHeGQYGqCxQjYnStsrk=
X-Google-Smtp-Source: ABdhPJzcSIUaELtrCgOKnKArisNq3SICoTZhDbmuBfrJI2pNWMlcEf29NgT6KVjct9OB5dOcsMu42Q==
X-Received: by 2002:a05:6000:15c1:b0:20f:c1d3:8a89 with SMTP id y1-20020a05600015c100b0020fc1d38a89mr40930812wry.287.1653932706382;
        Mon, 30 May 2022 10:45:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8-20020a056000128800b002102b16b9a4sm6094840wrx.110.2022.05.30.10.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 10:45:05 -0700 (PDT)
Message-Id: <pull.1272.git.git.1653932705097.gitgitgadget@gmail.com>
From:   "Andy Lindeman via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 May 2022 17:45:04 +0000
Subject: [PATCH] ssh signing: Support ECDSA as literal SSH keys
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>, Andy Lindeman <andy@lindeman.io>,
        Andy Lindeman <andy@lindeman.io>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andy Lindeman <andy@lindeman.io>

Keys generated using `ssh-keygen -t ecdsa` or similar are being rejected
as literal SSH keys because the prefix is `ecdsa-sha2-nistp256`,
`ecdsa-sha2-nistp384` or `ecdsa-sha2-nistp521`.

This was acknowledged as an issue [1] in the past, but hasn't yet been
fixed.

[1]: https://github.com/git/git/pull/1041#issuecomment-971425601

Signed-off-by: Andy Lindeman <andy@lindeman.io>
---
    ssh signing: Support ECDSA as literal SSH keys
    
    Keys generated using ssh-keygen -t ecdsa or similar will currently be
    rejected as literal SSH keys because the prefix is ecdsa-sha2-nistp256,
    ecdsa-sha2-nistp384 or ecdsa-sha2-nistp521.
    
    This was acknowledged as an issue in the past, but hasn't yet been
    fixed.
    
    https://github.com/git/git/pull/1041#issuecomment-971425601

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1272%2Falindeman%2Fecdsa-sha2-keys-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1272/alindeman/ecdsa-sha2-keys-v1
Pull-Request: https://github.com/git/git/pull/1272

 gpg-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 280f1fa1a58..086bd03b51d 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -779,7 +779,7 @@ static int is_literal_ssh_key(const char *string, const char **key)
 {
 	if (skip_prefix(string, "key::", key))
 		return 1;
-	if (starts_with(string, "ssh-")) {
+	if (starts_with(string, "ssh-") || starts_with(string, "ecdsa-sha2-")) {
 		*key = string;
 		return 1;
 	}

base-commit: 8ddf593a250e07d388059f7e3f471078e1d2ed5c
-- 
gitgitgadget
