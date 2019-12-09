Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED57C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE9F20692
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oikF3ZGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfLIQKI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:10:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39617 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIQKI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 11:10:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so16806448wrt.6
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 08:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pfn0Wbyas+epD+7PkfHj1Q6CsjnDLoQMW5oNeHuZuqk=;
        b=oikF3ZGDovZr9wcDhfRevkpxNy3NM8fXrpNGOBT2gF6grz5zTP7Bu7E4sfrqe7arT+
         lDDp5doH8xkynClfeE6IfleOmLHiJuXvoSIARYqwz1E3ih770aZxoo+YJtw0X+tkWM1B
         IzHbVUPZEsZSNNPSJzaJCIApxZ2WlZmH1+QFrxyZluLLytn5kb3PUtBfH8lpWSFShfkB
         vSzpZp0SuUc2KYbdGtyOBWBHntWLldq8VDSNHzIkCkAOMPcyn9ZlCp8ptH2Bmaa6CXrf
         5KdUeSskdsj2o16PRc0Pk0OYcbO1HpNOThrkduUHbIPEYgRJK0IhTt2CiFB5PyjapiS1
         CHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pfn0Wbyas+epD+7PkfHj1Q6CsjnDLoQMW5oNeHuZuqk=;
        b=dJHau7WTk0nCsNDQC8Qj0RksVU40KKzzwRCNLhgA4sveV+bOjzDsGtER9dOFp2FGxY
         r4m4JJ+wL+TMuUGqE2CrvhKUXVKYDsShZlxFg/trPLLYMApU3IDSKYGzO1O/pSgiqEfK
         1CQJbk1NAkJ+jdMa9TXmt9DLNrmlRDzWuPvJggc852zNmlP2TxdlnZf0WpYFjGNGrjLg
         IQ6Eg9r4P9tFw5cjP5pjV+2gaMY+ZK24b9zdqNomjXfDxnWH9GpwG54yJnY8kxWBvNAU
         cnGj0OTSDnvgDr+DMdoLuxg5Z7hvxn9hFgFoCZtthy7Sv/7PuKsHNadYQxAVX0F6QfU5
         f4kg==
X-Gm-Message-State: APjAAAWgV7dMkyg8HSrKkxa/p3sujittIdn8T/Cr2YWdpO9Vn++Gda+a
        nSrcwfgyllO3LN/QuV3i2uPXVMh8
X-Google-Smtp-Source: APXvYqwjp/SbL6x5/H70JAX0d3ysgzp38X2ZhVtQyuDM7oTEl8ASjrrTSCjK9GPQWTiaYvCPys/tBQ==
X-Received: by 2002:adf:f70b:: with SMTP id r11mr3206136wrp.388.1575907806276;
        Mon, 09 Dec 2019 08:10:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x132sm306868wmg.0.2019.12.09.08.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 08:10:05 -0800 (PST)
Message-Id: <79bb4c8e7d74c9c85cd6e6616811fc9a2e7c0afa.1575907804.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
        <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 16:09:57 +0000
Subject: [PATCH v2 1/8] fsmonitor: disable in a bare repo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, ukshah2@illinois.edu,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The fsmonitor feature allows an external tool such as watchman to
monitor the working directory. The direct test
t7619-status-fsmonitor.sh provides some coverage, but it would be
better to run the entire test suite with watchman enabled. This
would provide more confidence that the feature is working as
intended.

If the repository is bare, then there is no working directory to
watch. Disable the core_fsmonitor global in this case.

Before this change, the test t0003-attributes.sh would fail with
GIT_TEST_FSMONITOR pointing to t/t7519/fsmonitor-watchman.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 config.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/config.c b/config.c
index 3900e4947b..f6d4e2fae3 100644
--- a/config.c
+++ b/config.c
@@ -2339,6 +2339,11 @@ int git_config_get_max_percent_split_change(void)
 
 int git_config_get_fsmonitor(void)
 {
+	if (!the_repository->worktree) {
+		core_fsmonitor = 0;
+		return 0;
+	}
+
 	if (git_config_get_pathname("core.fsmonitor", &core_fsmonitor))
 		core_fsmonitor = getenv("GIT_TEST_FSMONITOR");
 
-- 
gitgitgadget

