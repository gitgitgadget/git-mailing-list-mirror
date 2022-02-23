Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA78C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 11:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240095AbiBWLzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 06:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbiBWLzA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 06:55:00 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C4C985A2
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 03:54:32 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id z4so19660065pgh.12
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 03:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z6gbmk5vEwtI3Jj4AJHDHTFoq4sXxxNVUi8JQhacJmo=;
        b=JxLmyAi2gEFgCV6Rsm5DT7y3TOtGxWdP1vhCKISp53yHGwSE6hfzUtaAjEM9pcJkfx
         JCsbifrsfDe/q1BBz8xjegLyxe8UPvgSB+AjtFMLpbOSKd2gYhZ/xzOmCsbq7rFIlF1o
         /AJsGSuinUt6YTLWaDrdrviEseprsga/eC0ADW2lTVfjglhWbHOMqcQotYX/VlLKSMv4
         a/dwXy9g1l3Q49nptgFKBkkL2KsoTY4zPGdrM6Dty9VST5p2StWuzihvuVEGHvjiia+c
         TnCxJuMDiPPpRlzD4XoHBvW7BfvfJqevQC5HL4haoBnTFV6x7F6ywmQk/q8uyTtdJoVl
         DiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z6gbmk5vEwtI3Jj4AJHDHTFoq4sXxxNVUi8JQhacJmo=;
        b=z81L2dMgfrAh9xEJQnKOlGe+dGHDyxAvb5s+5t3qI1msdiAk+TVSE50LS13feodhla
         8h2uU098o0YR3eopxom2DYYxXC1cK4aDHRj47HCtipTRUsNbLsypjOAF5aq1n9ASwlKB
         klcFY74c2d1w9xcc4DAKhTfvB/XaVyhhK3cuxYLc93dBvfCgWRbbE0Dl3dQqnCqnlQOa
         jlLEMXQWuquEoaTATPpDaIvHxqnvdaZotwFfzOtDqI1z6cey1zstTJw1RJepyeiNHcg4
         V/htBgzSyYxRo/QrrEqxrMjGLr/h21CbBmaBbtzuOL9uSBn6A5ZjLgWsPZvHVA3rKna5
         n5VA==
X-Gm-Message-State: AOAM530FOyrqly2cgLRLUUMqI6raDaNqWnftxbRB1XQPUkkCExWf7wsM
        STbq5v7v+SRQXOLjs8Av63Ka0XF8eKqze/1T9QM=
X-Google-Smtp-Source: ABdhPJwzr3HnpFD5eIv3+YSgjs8cVYze4GzCF699wCix9CAqymBsBUIVr6qWgfGs1Be1MdBujXGtog==
X-Received: by 2002:a63:894a:0:b0:365:8dbf:cd0d with SMTP id v71-20020a63894a000000b003658dbfcd0dmr23065197pgd.5.1645617272084;
        Wed, 23 Feb 2022 03:54:32 -0800 (PST)
Received: from DESKTOP-MEF584H.localdomain ([103.108.4.99])
        by smtp.gmail.com with ESMTPSA id rm6sm2728578pjb.52.2022.02.23.03.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 03:54:31 -0800 (PST)
From:   Shubham Mishra <shivam828787@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, derrickstolee@github.com, avarab@gmail.com,
        Shubham Mishra <shivam828787@gmail.com>
Subject: [PATCH v2 2/2] t0003: avoid pipes with Git on LHS
Date:   Wed, 23 Feb 2022 17:23:47 +0530
Message-Id: <20220223115347.3083-3-shivam828787@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223115347.3083-1-shivam828787@gmail.com>
References: <20220222114313.14921-1-shivam828787@gmail.com>
 <20220223115347.3083-1-shivam828787@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pipes ignore error codes of LHS command and thus we should not use them
with Git in tests. As an alternative, use a 'tmp' file to write the Git
output so we can test the exit code.

Signed-off-by: Shubham Mishra <shivam828787@gmail.com>
---
 t/t0003-attributes.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index b9ed612af1..143f100517 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -205,15 +205,18 @@ test_expect_success 'attribute test: read paths from stdin' '
 test_expect_success 'attribute test: --all option' '
 	grep -v unspecified <expect-all | sort >specified-all &&
 	sed -e "s/:.*//" <expect-all | uniq >stdin-all &&
-	git check-attr --stdin --all <stdin-all | sort >actual &&
+	git check-attr --stdin --all <stdin-all >tmp &&
+	sort tmp >actual &&
 	test_cmp specified-all actual
 '
 
 test_expect_success 'attribute test: --cached option' '
-	git check-attr --cached --stdin --all <stdin-all | sort >actual &&
+	git check-attr --cached --stdin --all <stdin-all >tmp &&
+	sort tmp >actual &&
 	test_must_be_empty actual &&
 	git add .gitattributes a/.gitattributes a/b/.gitattributes &&
-	git check-attr --cached --stdin --all <stdin-all | sort >actual &&
+	git check-attr --cached --stdin --all <stdin-all >tmp &&
+	sort tmp >actual &&
 	test_cmp specified-all actual
 '
 
-- 
2.25.1

