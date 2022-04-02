Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29694C433EF
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 10:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353617AbiDBKwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354564AbiDBKwI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 06:52:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B194A14144B
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 03:50:06 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id p15so10674566ejc.7
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 03:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XrXpQIOmFSyzGKtnFgmghoZHdpHRM6E+wH9Ng2v9LzE=;
        b=To/He+Svym7xdTI0/qagNLp02kBxJ/ueiWIkTVgR8xKVWZN/cExkzdEI6sDWaa6Aqb
         VLW/Ubaq1rVOnDLJzwTS2uLL0ecfXCOFhKyocGin2zV0O7pLj0VMgCathGaleai3s16e
         Ci1PPq14QDOWsaMgVmY3ceXigKh+szPXfK2FsoJ3McxW/UPon4A2xN/1pIrPLg5wpcsh
         qa0i/9ZzluKDH989ZSF1ZCaLgfQlL4btP/yvtOaomHMqi/arV1lkLPmX0WVESjZQb1VC
         4Alo6A+klZq4878PYtxbqRZAqGjvEhMiyThpi0SHR/nl7aeP5ZCHYTfQ0hs6xAahFGbl
         QRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XrXpQIOmFSyzGKtnFgmghoZHdpHRM6E+wH9Ng2v9LzE=;
        b=khhP/gvtO2+OVtdLZ/PQURqaPv+8+QJi6CoSq2L9DwovXx6NHqmSv0jsOO9u22afSM
         cIOUL7mc7mw4aBlt2cs80wgFNC6Qv6ek2f5g4ygd3n1CITBhqD+K4k8IFiqzYxlhz8nw
         1PNPByOaPApDn5yYpAMzeJ3fIoak8vKf8LOpj1u3QYi8+ESuBitmbUZ/ISGUSZMulcq8
         AILnfE9OjBHsPOFdOrUXdox7UCRPnYUp/YEees3vBkH3299P+fhfZgstmUy7sJOWALF9
         FJrDTOWXe7+LOTSQRU2LYrOjweXMOrePDEVGqfwFm75zdbvq0e+Kv31qTuXkprEAWH8z
         WQtg==
X-Gm-Message-State: AOAM5338sMvDc5haljGMPbO9P3cvTe8NS2tYgUwKYlBC8a7Eb8iQ7UzJ
        5KG+rTx7AeRedN3XLcS3IQDxOXXcroPx5Q==
X-Google-Smtp-Source: ABdhPJyj+uk6d7O54zqrWonhKqJKY5ql234DfQ69a//nEc+WAzZTQAN8bc8LqQCvF7CH3CTBChy6sw==
X-Received: by 2002:a17:906:1f11:b0:685:d50e:3bf9 with SMTP id w17-20020a1709061f1100b00685d50e3bf9mr3563545ejj.275.1648896604802;
        Sat, 02 Apr 2022 03:50:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm2366137eda.59.2022.04.02.03.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:50:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 20/27] revisions API: have release_revisions() release "grep_filter"
Date:   Sat,  2 Apr 2022 12:49:34 +0200
Message-Id: <patch-v5-20.27-ebdcdc88d79-20220402T102002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1584.g2aeb20a6519
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com> <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the the release_revisions() function so that it frees the
"grep_filter" in the "struct rev_info".This allows us to mark a test
as passing under "TEST_PASSES_SANITIZE_LEAK=true".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c               | 1 +
 t/t9151-svn-mergeinfo.sh | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 2484e14d26b..2c23de60093 100644
--- a/revision.c
+++ b/revision.c
@@ -2952,6 +2952,7 @@ void release_revisions(struct rev_info *revs)
 	release_revisions_cmdline(&revs->cmdline);
 	list_objects_filter_release(&revs->filter);
 	release_revisions_mailmap(revs->mailmap);
+	free_grep_patterns(&revs->grep_filter);
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index 85221d439bd..c93a5beab25 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -5,7 +5,6 @@
 
 test_description='git-svn svn mergeinfo properties'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'load svn dump' "
-- 
2.35.1.1585.gd85f8dcb745

