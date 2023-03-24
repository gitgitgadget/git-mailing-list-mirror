Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AB2C6FD20
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 20:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjCXUyu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 16:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjCXUyn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 16:54:43 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758A849E1
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 13:54:42 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b20so12764654edd.1
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 13:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679691280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vG1kNPwjsqbMj1d58BRaDxcD8X8R5R92P+u/4DJ1KU=;
        b=UaGj8WbEhnq31znZkWJ37VVqNxCoU06iOGHh678ZJ77fBRxyeqSzSHiZFHMGkP9KFg
         2ABk+eEcKR+rdaBvLPQN4Ha0krP4/mZ5n9kl6ywHYZrbow/LUPkHwaxnnSE+88xLMhXe
         rDnDSIUNfSoyE4KMMNisvgkCtiEExU/Jjw17t5g/sTlnoeQ26N/yDMEU23WrJFmeHfHB
         mhKR7AiBobRisjzgkZHc7dW5+X65TzYfGBMAWm6KrqQpKYym5PmkzT95gVR+fkM7hN1L
         GewTaGvmrBG+yX5fnjpVlYksKeJ4u/YwuqNTu5adUMf/y7HqU+jbmYT51Cgshnibiyv/
         atqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679691280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vG1kNPwjsqbMj1d58BRaDxcD8X8R5R92P+u/4DJ1KU=;
        b=iGfzs784x43f7TBkgaIzOcCk3TLKYvBYraWDy41kRN4b+Qti9GQHOChdmkvaR65uav
         HPjhJ6vBmpzNQ1jGC6XEi3JvfXqR9WMWVZz19DnzLvKwa/uqhh8HHIiDDTfr+XGuOFnC
         c33t2zDlVAI6+BVI0kbd0/wP3FdK+iQR0KFzqBrhdyeLLR4mnk0yNOGqJUFIJ7LFo5Zo
         QHgi2e7VWB7Rnl7YPGtMxbNWAq5byZkaryolRZaqN+xxnPX4wrPMD/evi+in4eUUkWdh
         Z4Gdz8x3dtEHttJLGRLLVaOFfFFmkOj2GzUC+FclzKwx0BdGIe7uRv623KOksDsvbcuA
         qGaQ==
X-Gm-Message-State: AAQBX9fpJI+L1cUyK9ciWb8OLWr6YT+7G8Nq7bTV6Znlt4i8+VlZ1Oui
        nlLRwdRJVJs2Qf+6GpYZvyGzS+per+GqKydk
X-Google-Smtp-Source: AKy350ayMvgfPLSb6fpXUxHdiTBMCXPq7NnIwsepQbI8DKlQ+1V28YzLfDEgQWfsgWrtEvbqswxKpg==
X-Received: by 2002:a05:6402:8cf:b0:501:d43e:d1e3 with SMTP id d15-20020a05640208cf00b00501d43ed1e3mr4725357edz.8.1679691280306;
        Fri, 24 Mar 2023 13:54:40 -0700 (PDT)
Received: from titov.fritz.box ([212.102.57.11])
        by smtp.gmail.com with ESMTPSA id e22-20020a50a696000000b005021c7f08absm2007099edc.29.2023.03.24.13.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:54:40 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 4/7] t1302: don't create unused file
Date:   Fri, 24 Mar 2023 21:54:31 +0100
Message-Id: <20230324205434.93754-5-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324205434.93754-1-rybak.a.v@gmail.com>
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
 <20230324205434.93754-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 'gitdir selection on unsupported repo' in t1302-repo-version.sh
writes output of a "git config" invocation to file "actual".  However,
the test doesn't have any assertions for the file.  The file was used by
this test until commit b9605bc4f2 (config: only read .git/config from
configured repos, 2016-09-12), before which "git config" was expected to
print the bogus value of "core.repositoryformatversion" to standard
output.

Don't redirect output of "git config" to file "actual" in test 'gitdir
selection on unsupported repo'.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1302-repo-version.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index 70389fa2eb..179474fa65 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -37,7 +37,7 @@ test_expect_success 'gitdir selection on normal repos' '
 
 test_expect_success 'gitdir selection on unsupported repo' '
 	# Make sure it would stop at test2, not trash
-	test_expect_code 1 git -C test2 config core.repositoryformatversion >actual
+	test_expect_code 1 git -C test2 config core.repositoryformatversion
 '
 
 test_expect_success 'gitdir not required mode' '
-- 
2.40.0

