Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E947AC433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB359619C8
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhC3NHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbhC3NHv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 09:07:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E377BC061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:07:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso8390363wmi.0
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=w3uiq2g3V/Kvs6wMo0YlqCw5lBjDkgPoCXBVvJzAny4=;
        b=tu22cmib1AtLVy0w+OEVBnysUTapR03Qvj7BSVUE2aJld8btrIwE1uHYS83fM1Fq/N
         1lzvmF+d5zpFA/rR4rIksGCb9M2hL8jf8pydYezc25OzdC0OBiE3j+ICWHipMiAdE6I5
         qlydo9CCjGXEMZwFxbN2A7fsanTCQBSAp4CT5JibDBVxQ5L8QJ9TW0wL85kepOGaSTjb
         f1uDyy4gEDABcao9HfecGtGueKWzdiC21VB1Ds1Z2UjnEPK/1cfTdQ+2mHk4upOGBWOe
         wYib7+qjWAQHzNvtC4GH7v+WZWVdM/9ZqckA2hOh1LwKgozcjjm6UAJZzuGLg6XnOR8C
         4gTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=w3uiq2g3V/Kvs6wMo0YlqCw5lBjDkgPoCXBVvJzAny4=;
        b=WPhzmZftSsMfZXYENw7SfUaEmwVdFzc0mR8b7I3ahOxpYheF29ho2zdOpz0i40gq6G
         z/CdbXV5GkWiohHQVfGSd1bch4TVN7xYCRmYKOk5X+WjRREo7jF/zB5GsmPaSmRp7ymd
         zaKHvPXZpUN2S/bZeIByXZe9PPKYZTV2Vz5Y20B35D7RfT3VEQ5d/MAtDFCpMt/5W1Wu
         LCIvYdw9WFPxoStcBD6DAihe/cqiCPqmCYU5lAZaXTHaPnVN23VoJQFhQqVJ+aQqJBV3
         5HAdRw//2A+D3Rbxw1oeGQkw2VatDjHO752F0eyvet/88dqVAdermmUahvinMpEUIaO1
         CM1A==
X-Gm-Message-State: AOAM530xrct9LuB48ws/9jTn4VstfiNFDsqpoca5yiCR1wsgmFZCzrUW
        kvtI9O8hKVNunCgW/X6sNJ4qNk3aNqA=
X-Google-Smtp-Source: ABdhPJzkoRcB+Zuehtpnm6/RkwGk9Eb/Yec11UvplIWnXgEvpw/Yt9TqUDm2eGEKVT8AhIvpWm8ORQ==
X-Received: by 2002:a1c:3954:: with SMTP id g81mr4050504wma.170.1617109669669;
        Tue, 30 Mar 2021 06:07:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h13sm3206465wmq.29.2021.03.30.06.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:07:48 -0700 (PDT)
Message-Id: <pull.989.git.git.1617109668438.gitgitgadget@gmail.com>
From:   "Dominyk Tiller via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Mar 2021 13:07:48 +0000
Subject: [PATCH] persistent-https: add go.mod to fix compile
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Dominyk Tiller <dominyktiller@gmail.com>,
        Dominyk Tiller <dominyktiller@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Dominyk Tiller <dominyktiller@gmail.com>

GOPATH-based builds and non module-aware builds are being deprecated
by golang upstream, which currently causes this to fail. This adds a
barebones mod file to fix the build.

The `persistent-https` code hasn't been touched for a long time but
I assume this is preferable to simply removing it from the codebase.

Before this change:
```
case $(go version) in \
	"go version go"1.[0-5].*) EQ=" " ;; *) EQ="=" ;; esac && \
	go build -o git-remote-persistent-https \
		-ldflags "-X main._BUILD_EMBED_LABEL${EQ}"
go: cannot find main module, but found .git/config in ../git
	to create a module there, run:
	cd ../.. && go mod init
make: *** [git-remote-persistent-https] Error 1
```

Ref: https://blog.golang.org/go116-module-changes.

Signed-off-by: Dominyk Tiller <dominyktiller@gmail.com>
---
    persistent-https: add go.mod to fix compile
    
    GOPATH-based builds and non module-aware builds are being deprecated by
    golang upstream, which currently causes this to fail. This adds a
    barebones mod file to fix the build.
    
    The persistent-https code hasn't been touched for a long time but I
    assume this is preferable to simply removing it from the codebase.
    Before this change:
    
    case $(go version) in \
        "go version go"1.[0-5].*) EQ=" " ;; *) EQ="=" ;; esac && \
        go build -o git-remote-persistent-https \
            -ldflags "-X main._BUILD_EMBED_LABEL${EQ}"
    go: cannot find main module, but found .git/config in ../git
        to create a module there, run:
        cd ../.. && go mod init
    make: *** [git-remote-persistent-https] Error 1
    
    
    Ref: https://blog.golang.org/go116-module-changes

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-989%2FDomT4%2Fgo_modules-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-989/DomT4/go_modules-v1
Pull-Request: https://github.com/git/git/pull/989

 contrib/persistent-https/go.mod | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 contrib/persistent-https/go.mod

diff --git a/contrib/persistent-https/go.mod b/contrib/persistent-https/go.mod
new file mode 100644
index 000000000000..6028b1fe5e62
--- /dev/null
+++ b/contrib/persistent-https/go.mod
@@ -0,0 +1,3 @@
+module github.com/git/git/contrib/persistent-https
+
+go 1.16

base-commit: 9198c13e34f6d51c983b31a9397d4d62bc2147ac
-- 
gitgitgadget
