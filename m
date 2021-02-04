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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A3AC433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2406A64E3F
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239606AbhBDTGt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 14:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239589AbhBDTGS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 14:06:18 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A170C061786
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 11:05:38 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id t25so2792346pga.2
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 11:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cVwqRHiCPVOdFvi8BGeDd6ox9vceEwe8HnBQfQjgJgU=;
        b=lMmcCy+DoREI0RIUPtepKBf2zlKTqeEY98vFReWJEJ4AvnAgxD70EbbRFLQrefVeSn
         9RkX+Ve84NKzq8TVkR5HUfZn8kb+pNka06jBukE3ZHtq1O240HbJAeTHiuE30aRGfJYH
         perFwP3AavZBWiYJnZe4rh1fjiXseJ24UVXO0h1E6jfEStVPpzmqR+MAhunSubb998AS
         U6qNcOt12U3/T2a72sQ9TujWwDk/mn+VkAKxpC53hNpARuTumsCAyBQ8xi4J7mTIWLwg
         cR9U22vDtLDCw0PQC9CYBqN+QREh4WeIlWunDNnoZAnZBoaszittD0pJp53BZ+D0dDzM
         GcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cVwqRHiCPVOdFvi8BGeDd6ox9vceEwe8HnBQfQjgJgU=;
        b=YJJt0urewa775Z0Gr7ayfiq7iB9uPwKTp+Qvs4Sv5kqtZ+x5T7W/PKsgZZPDSwcCdt
         lJAkz83KrOf6zjCG8PjkRrO24UyExUuoIhZFnTZF8NN8qnrx2sqas512FgLImuHv/waX
         t5zk2J7N6o00PmEollFqQqRPebpgBV+6323hqEDr6n3G1mfiqC8agPWv3O8qt437HK+X
         7uQ23XJ7OPH/5zAyAe8qK3ggFDtDYTLk9vy3aE7j4B59Te59GrdNxuZRRJhAXWkU7g99
         KJxWLy+9F6KelNZ8uM/FMNn/fhMeHgfxKbCtbhsa53EMEfKa9CeVYBhruJPCiYwyEx8o
         g6aA==
X-Gm-Message-State: AOAM533155J/qgnGEFD2MF/94XcBd6M40xIv/4EUjkUAqCffzGy5EIrZ
        io6CidxHvA71lmxSj//dV2iHePFr/AS19A==
X-Google-Smtp-Source: ABdhPJzid7q98EphW2D9r5VmB5qVdyo/iqZEyoSWdnjmtu0sUmWbf5X4crkIl/cKwjpoJgPJmPloMQ==
X-Received: by 2002:a63:1f1e:: with SMTP id f30mr432789pgf.141.1612465537971;
        Thu, 04 Feb 2021 11:05:37 -0800 (PST)
Received: from localhost.localdomain ([2405:204:332c:6caa:c21:291b:12a6:463f])
        by smtp.googlemail.com with ESMTPSA id 9sm6729524pfo.1.2021.02.04.11.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:05:37 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v5 1/8] rebase -i: only write fixup-message when it's needed
Date:   Fri,  5 Feb 2021 00:35:00 +0530
Message-Id: <20210204190507.26487-2-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210204190507.26487-1-charvi077@gmail.com>
References: <20210129182050.26143-1-charvi077@gmail.com>
 <20210204190507.26487-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The file "$GIT_DIR/rebase-merge/fixup-message" is only used for fixup
commands, there's no point in writing it for squash commands as it is
immediately deleted.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Reviewed-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 sequencer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8909a46770..a59e0c84af 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1757,11 +1757,10 @@ static int update_squash_messages(struct repository *r,
 			return error(_("could not read HEAD's commit message"));
 
 		find_commit_subject(head_message, &body);
-		if (write_message(body, strlen(body),
-				  rebase_path_fixup_msg(), 0)) {
+		if (command == TODO_FIXUP && write_message(body, strlen(body),
+							rebase_path_fixup_msg(), 0) < 0) {
 			unuse_commit_buffer(head_commit, head_message);
-			return error(_("cannot write '%s'"),
-				     rebase_path_fixup_msg());
+			return error(_("cannot write '%s'"), rebase_path_fixup_msg());
 		}
 
 		strbuf_addf(&buf, "%c ", comment_line_char);
-- 
2.29.0.rc1

