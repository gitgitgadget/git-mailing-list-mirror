Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75410C4332E
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43D6223122
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437059AbhALVhY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436876AbhALUTi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:19:38 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EA0C061786
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:36 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d13so3813045wrc.13
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w5dPSi2cBbzusmhOSLzAnu1a620aUwocVNxqpBXnIjc=;
        b=RuNQ/82LSk9vR4wDifIeGIy+rrs2dz+CihDdiyNhMSgKkmBnet5E8MfIOI9pTZOano
         OiHNMiEJnx01Ee2d/MmJk+aZ6cl2V+tTVfw6me+tvPR1wmi3dbvxDX36Jpeifnewk/0P
         x3qzWj+qSz+WrrsgeeUaWFH3GGCShN7B7b3WgfS+1qIvvfWN8tf7f5Cu0bsmZEDylNm6
         EYUwRdhHyDeGLInIFYrSfkmHQpeFCa9VQEBpVNyjuVSqTdTD2XEYWyGtwjszVGnjo5ne
         6n7dTL0z/+x8CuxRFmm3KUcu5PJGCgrVbDUxoa6chd8XgLLYUEqkNYsYGUZkNl2/uFmN
         klDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w5dPSi2cBbzusmhOSLzAnu1a620aUwocVNxqpBXnIjc=;
        b=ChbUwZIy4jRC3JYfna975LwIwgllwFcV4u91d/vfulhY+75l+6kBLY12QTYAaChsSs
         wrc6MyQk5dyesA9T+YKPXz4I1ypLhPTZRM206NUl1nMCd9fZmnqW9vTNHCQnEiGK7s59
         tqalBVbJAMvcefJd4MjHbHuzNDbAJ3FqIeTpQpcoKnAcoVqp/poNVe6d/xOYcd9gexUy
         50OJmd2WXfL9tscd1A3ADR6TY19cxESIkoKou3992BB8ZnYQnfR6uuPEgDxAa3KrMhrz
         TMvsv6CeZiwIUZGOllTIp9QAgg0cQ6/5qmG/LpgI+UobxrbKbW0yfHqsy4Ch+Wk8yl+r
         palA==
X-Gm-Message-State: AOAM531Wwg4jmZ5cBp38qHtwuwImtXeaYoBuE9oUlB5mh2NsVJWAr5sT
        PsI08dRTUXF/W6ZeBwkdj7eiHv0QUX+yBA==
X-Google-Smtp-Source: ABdhPJzeyjFbvLnqEM1hHDD9AqrTt5ByLaluGZhC5fd41+FBBvwVqVfbqZvnSzIdsiCTZie3rYei3Q==
X-Received: by 2002:a5d:4a06:: with SMTP id m6mr539291wrq.189.1610482714940;
        Tue, 12 Jan 2021 12:18:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm7095374wrb.92.2021.01.12.12.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:18:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/22] test-lib functions: expand "test_commit" comment template
Date:   Tue, 12 Jan 2021 21:17:56 +0100
Message-Id: <20210112201806.13284-13-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
References: <20210105130359.21139-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Expand the comment template for "test_commit" to match that of
"test_commit_bulk" added in b1c36cb849 (test-lib: introduce
test_commit_bulk, 2019-07-02). It has several undocumented options,
which won't all fit on one line. Follow-up commit(s) will document
them.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 999982fe4a..396e039d2a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -178,16 +178,14 @@ debug () {
 	GIT_DEBUGGER="${GIT_DEBUGGER}" "$@" <&6 >&5 2>&7
 }
 
-# Call test_commit with the arguments
-# [-C <directory>] <message> [<file> [<contents> [<tag>]]]"
+# Usage: test_commit [options] <message> [<file> [<contents> [<tag>]]]
+#   -C <dir>:
+#	Run all git commands in directory <dir>
 #
 # This will commit a file with the given contents and the given commit
 # message, and tag the resulting commit with the given tag name.
 #
 # <file>, <contents>, and <tag> all default to <message>.
-#
-# If the first argument is "-C", the second argument is used as a path for
-# the git invocations.
 
 test_commit () {
 	notick= &&
-- 
2.29.2.222.g5d2a92d10f8

