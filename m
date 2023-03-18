Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2960C76195
	for <git@archiver.kernel.org>; Sat, 18 Mar 2023 15:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCRPrJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Mar 2023 11:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjCRPrC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2023 11:47:02 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C3F1EFE6
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 08:46:57 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x3so31257581edb.10
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 08:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679154416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vG1kNPwjsqbMj1d58BRaDxcD8X8R5R92P+u/4DJ1KU=;
        b=e8dBXfwt4dGteW7QrUsgRAlsTKJT7S2NJS3hSxK7alKABDFYfmOwZjQBnyHbT3a3Qr
         jOFlDfAxICkJ4KaCYfq5UpMDNleXT+EwiRy0xIs5EJ9VZFRxgLaOd41HJrwwxyKJQTiW
         aQONfs+QqnPy8pVPZLbRM1rHXCOXIbClwlwhJvj0cP4jG0pB4woZzM/4/6mSNgZBeJRu
         R6GHOAZCO5tRndmDNYGnpsxgtVrHG+ay9d9myQCjtvY1NMIsMPfHAdYDTGEcRDDLfSQ4
         CP+K+TRScXwu2JIwQW5zGDu3xydvL2UL5f7VA/dCRAi/qugJLPnViJnV2vfyuh47BXUU
         EMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679154416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vG1kNPwjsqbMj1d58BRaDxcD8X8R5R92P+u/4DJ1KU=;
        b=K98Hx/RqwnGKxM6DyJdggZ/vYHlXjpiOEBYorJYOoqvbRY4jrpNeYR72ff/5K845AP
         8yr8h119iOPov4Aaa7NZSRjbKCyIA+1Er/nxxDIMeKipte8ziOmr7T9Tdou6Goatbm5e
         6xg4UeQgOUH1Sk0SUWy23opoatzyXTSZX2RarLNjOtUEpiBrJpa29z/7Knx1rnvVMeTd
         SUxXg5OAR7Hiv2xmrVZOXRdoyF88V+B1+N3wRWDLmAom/cRRUUxyCjwLQahAPnCJiKFj
         Nym0nvB6QDql1rQqDPqczc8vwtcgWRCR5LtKCbfcwUm62mM5Dm6ccWdOrRXdH/KlF5O9
         UftQ==
X-Gm-Message-State: AO0yUKXgH+YfE3mZGAG5Hr/3VOtIZVUUz+i3B66VwTA5PU9M+OpmbJPQ
        ZXHaZ1+74Ui2IPqlFd+c2uerkW33ycvjJQD3Uhg=
X-Google-Smtp-Source: AK7set8Xl0GuZLcpDX2F1Dlw+Pv87QSJnw400gfm2y4M4qzEMBhdm8ivW+shx0mH0PC9qYjMG31eJg==
X-Received: by 2002:a17:907:104a:b0:92b:6f92:7705 with SMTP id oy10-20020a170907104a00b0092b6f927705mr3098042ejb.40.1679154415938;
        Sat, 18 Mar 2023 08:46:55 -0700 (PDT)
Received: from titov.fritz.box ([216.24.216.227])
        by smtp.gmail.com with ESMTPSA id ha18-20020a170906a89200b0092be4b381b7sm2271200ejb.81.2023.03.18.08.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 08:46:55 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 4/7] t1302: don't create unused file
Date:   Sat, 18 Mar 2023 16:46:43 +0100
Message-Id: <20230318154646.131344-5-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230312201520.370234-1-rybak.a.v@gmail.com>
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
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

