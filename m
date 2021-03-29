Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21EFC433E0
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 12:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B2E96195D
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 12:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhC2Ml4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 08:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhC2Mlu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 08:41:50 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6C0C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 05:41:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j18so12722198wra.2
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 05:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zYrVP6IDFHlUPnzgKlGqYKbYIHQcNhsU+1TSWXFUAWQ=;
        b=VkMruh3lDuoFwbBGkfjUxzxwNEvig7fndxqWHrTsVNbgtcEtlMQw3OA6ltjQujGAuW
         IlyUHj5WZjaP8zVA3KCn4/YYKOBP/lcnP5DebOJLyItf7WpVVXYnqzjeduSzLUw7kAMc
         6lCOYFSGeP4da8cpAPgcL+WISpRRHRkSPOUENsXOOZuSPgLPr4C0XL9Pzvic0cJ+8yVq
         a/jtJorustdX7754iOwqOCmUNquan51OPPgSAp3mS2jaZGgZwqo5qqRX9Ju/TbwT8ALp
         TtqbfgFIo6yJmmhDR5cNQe5iKLvtNTOLb0GBQ4Etlu07BMUvefVQ5nwZgLujNarDQlrK
         Jn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zYrVP6IDFHlUPnzgKlGqYKbYIHQcNhsU+1TSWXFUAWQ=;
        b=Qv0plZO6pIpxmhqPII/b7XzYyX/dTQl7N1uIEBLngHA1SkfZTqfE5svzgTE3Qz2AHb
         pt0elQovKjhdipj4m8X82T+1/qZZ1OpsWGJ+D0zEpE7gD5klQbyklGiaatjWNYwzy0Dj
         gRuUN/wtSsqCuIFqJwVfcMnUmOO0w1y8du+thBdCZ/QhyL4FAtF1DpH5I5v9o8G+EV1q
         QNa3nDEVJ0CIKK3DDesjOs0ofJ4nubziH3U2ntFQIXLa/6De+bHlaycTQqx3/rmoGEf6
         CZ7T0wT40ntLP1YstFGIGebt6nEDSqmjZksNgdJvkj5wsQmx1cScgg/nuK7DwINU4xj4
         SeTA==
X-Gm-Message-State: AOAM533JAeHlnJ/yGHKqja8qcqlnHSangGyOESNh9ZJ5eA+NvLFZZNua
        Tb9IvUITY4Cci1v0abkxfL3mPOG/0Bs=
X-Google-Smtp-Source: ABdhPJx+mPGN9Cskvk0zNmUrgNLtjcbR+tdfmHCCa5/72ArxRN07p2T9PDfzkuyQr1Rb6Wr7T9k+hA==
X-Received: by 2002:a5d:6304:: with SMTP id i4mr28234794wru.155.1617021709035;
        Mon, 29 Mar 2021 05:41:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a14sm29886044wrn.5.2021.03.29.05.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 05:41:48 -0700 (PDT)
Message-Id: <69856f278645ebe1a9779aaa0a6894db33e22b3a.1617021705.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.887.v2.git.1617021705.gitgitgadget@gmail.com>
References: <pull.887.git.1616886386.gitgitgadget@gmail.com>
        <pull.887.v2.git.1617021705.gitgitgadget@gmail.com>
From:   "Dennis Ameling via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Mar 2021 12:41:43 +0000
Subject: [PATCH v2 2/4] cmake(install): fix double .exe suffixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Dennis Ameling <dennis@dennisameling.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Dennis Ameling <dennis@dennisameling.com>

By mistake, the `.exe` extension is appended _twice_ when installing the
dashed executables into `libexec/git-core/` on Windows (the extension is
already appended when adding items to the `git_links` list in the
`#Creating hardlinks` section).

Signed-off-by: Dennis Ameling <dennis@dennisameling.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 12c40a72bfff..da2811ae3aad 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -832,12 +832,12 @@ install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git-shell${EXE_EXTENS
 
 foreach(b ${git_links})
 	string(REPLACE "${CMAKE_BINARY_DIR}" "" b ${b})
-	install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git${EXE_EXTENSION} ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b}${EXE_EXTENSION})")
+	install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git${EXE_EXTENSION} ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b})")
 endforeach()
 
 foreach(b ${git_http_links})
 	string(REPLACE "${CMAKE_BINARY_DIR}" "" b ${b})
-	install(CODE "file(CREATE_LINK  ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git-remote-http${EXE_EXTENSION} ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b}${EXE_EXTENSION})")
+	install(CODE "file(CREATE_LINK  ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git-remote-http${EXE_EXTENSION} ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b})")
 endforeach()
 
 install(PROGRAMS ${git_shell_scripts} ${git_perl_scripts} ${CMAKE_BINARY_DIR}/git-p4
-- 
gitgitgadget

