Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274DCC433E2
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 17:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F4220674
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 17:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G38DyZNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgGJRT7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgGJRT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 13:19:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0B8C08C5DC
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 10:19:57 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so6652849wml.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 10:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mj5ZbJ12LR3v8Yt4MmtqwCsvAWZFVJ2iC7ETEQzbIiw=;
        b=G38DyZNpbas4eXgZURNeDYcuNtoN+nOpnIs9Z7DDabl4EGvofE+yXrTdpGPtGMup+i
         RJPx7W3BPyKwcaFge/HC8yfhvbSxppVBLEmmk2Zn89ejwW2jhF7nSyCEIwXiI5hzRrJd
         k8miPsxBERjpCSmglihlwFHTW8XqYn+6xPR88svRQbLIwlq9Jp7VfOFvd4rs82qpcMfo
         pc0MuK1uis/gRpJ/kL3PfoRCTlDoUHGUjLbPNsb4293UEeHq/4VnRlsZMNVqR/2cVR3A
         MQzJcAqYhJd83AWvBYcOX3Y3aS17n5KpKXVID8CI8IzSCknujD01BSFWqEnOzM2cWef8
         t0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Mj5ZbJ12LR3v8Yt4MmtqwCsvAWZFVJ2iC7ETEQzbIiw=;
        b=XK3B00SqLSRDLVAsz4j4yynb1xXLMAuPgVptDoPG3/0w9xCW68VbLvsXb44rjir9Ue
         Dl9CypoI8FzF4hOLaLAdLwP5BQD1nmF+dBJr4uPimz7taiyXvgAxfy4SuSY38FEmNXgc
         UP28iien+dxnC16TI4Lz4jr7mYbX+fUbd/bZsRWgVwqT5/szmAiTLxhWxAbZT2OXQAfs
         jBFZw04MvUsL4vUSEO3qhF2qYGFzHfdRa4Vm+83Csbw2+ZAbkUmleKM9y7kkyDTAKmls
         gzEZ15iu3Uwk9wvJw2/RJ0a6kkYO32hhEtHVGDXiJypSeveUL2BRzvIfpQws/vg4n/Pe
         zOCw==
X-Gm-Message-State: AOAM533vyLy17pnFu19annTA3xQceTl2eVsyVO60tK2jYEG3sNu/48ae
        XsT4Mw0Bxir9DgARGMYHvpyrTD+1
X-Google-Smtp-Source: ABdhPJzTKZGt9kBk7Qsq/qqqjSFguJgZJ6ag2mvOcgHy0mSYHeKfIuQ8Qr4og1N9Wcb4iJOHXpRrkA==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr6268270wmk.34.1594401596048;
        Fri, 10 Jul 2020 10:19:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l14sm11395210wrn.18.2020.07.10.10.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 10:19:55 -0700 (PDT)
Message-Id: <0f244ed6cbddd0673653349b78c3ede31f9bbf71.1594401593.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.669.v2.git.1594401593.gitgitgadget@gmail.com>
References: <pull.669.git.1593518738.gitgitgadget@gmail.com>
        <pull.669.v2.git.1594401593.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Jul 2020 17:19:50 +0000
Subject: [PATCH v2 1/4] lib-t6000.sh: write tag using git-update-ref
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/lib-t6000.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/lib-t6000.sh b/t/lib-t6000.sh
index b0ed4767e3..fba6778ca3 100644
--- a/t/lib-t6000.sh
+++ b/t/lib-t6000.sh
@@ -1,7 +1,5 @@
 : included from 6002 and others
 
-mkdir -p .git/refs/tags
-
 >sed.script
 
 # Answer the sha1 has associated with the tag. The tag must exist under refs/tags
@@ -26,7 +24,8 @@ save_tag () {
 	_tag=$1
 	test -n "$_tag" || error "usage: save_tag tag commit-args ..."
 	shift 1
-	"$@" >".git/refs/tags/$_tag"
+
+	git update-ref "refs/tags/$_tag" $("$@")
 
 	echo "s/$(tag $_tag)/$_tag/g" >sed.script.tmp
 	cat sed.script >>sed.script.tmp
-- 
gitgitgadget

