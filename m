Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B54141F454
	for <e@80x24.org>; Wed,  6 Nov 2019 09:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbfKFJUz (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 04:20:55 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38095 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730144AbfKFJUz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 04:20:55 -0500
Received: by mail-pg1-f194.google.com with SMTP id 15so3541222pgh.5
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 01:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yo77/4Q8JUxXLzHMAnwKLnWIaV4FjNXvsX03Kuqwvsc=;
        b=MzsfCXrZJgSgYwL0yNtc0iSc7sUF6b6ZOYTTxA7uefJvHnbGe+H0brAyRixbA1Qog/
         d4wuDwkNjg3hW+L0YBAtaqNWb8W0AabWq7JLMAg4+taR7rlXXYIUofxBJ1tRtjfl2vdo
         H9kIc1N0yhsJuIjjYC1Roc12VP2BCHJOnni7Ot6p8/ikJ78rbPnlnXUnKcl7RGECDmie
         /LT/NudMfcuVtUr7DbNRPja8T3QqqaV9BygcD7TsNbaYUUpxlrZple6rvBcnAtNZSXuS
         iH7gkCX3nIshchuVh2RK56WN6K5ut1kOB0okoPHGiZFoWRqVho3sHKGQpmPgYCKM9j88
         tP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yo77/4Q8JUxXLzHMAnwKLnWIaV4FjNXvsX03Kuqwvsc=;
        b=ZA47+AYI2mQRx3KcoSrkSqwbC9aE4CimeZNkGQoEJT3l8DXsKi+z1+cXW/ADCpdQrm
         DaPxd4AspWNxQgprKeBdCepGyV7dVu+6rGdfYNEgoZpC4zL9RxXoK/8+MYgE0/aS4vby
         vHZwO+dt6yfGnlbQlbA1MCWmZZlE6ySYd9khhwQCM7h/Yb46jrh5TWTe64An4dnwaD5l
         GHegwA9OqxOHE63xUK8gZbtJUSDOziNEDzwH6z3WJ+aqRZpb449snDwFA58acXHmm6Lr
         A3hXvaJY0d2nRjP1YLAqVPhblcIldwaKIRCdVfwo2eC9SVmAJpOVKjYnkNfabqn0ynIP
         bsQA==
X-Gm-Message-State: APjAAAUm2c+73tTztceuErOgyPXEIOFU8UdEJeBgk54Snqn2mPG93Qo8
        to9jUucnXt4gx9dpT0WWwcr7/lNK
X-Google-Smtp-Source: APXvYqyuVGwFqaAtS9um2lEnfrFbpDg+qZny6G075TlYQziHsLgZ8vgsNEsu9Zyc2innDjdrdFU+PA==
X-Received: by 2002:a63:555b:: with SMTP id f27mr1722512pgm.66.1573032054700;
        Wed, 06 Nov 2019 01:20:54 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:4ba:cb41:a2ec:2198:454b])
        by smtp.gmail.com with ESMTPSA id c1sm4696984pjc.23.2019.11.06.01.20.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 01:20:54 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v3 8/8] sequencer: reencode commit message for am/rebase --show-current-patch
Date:   Wed,  6 Nov 2019 16:20:06 +0700
Message-Id: <69ec40bb1dbdf7eda21d8fa918164a191ba41875.1573031848.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.4.g6a51fdd29c
In-Reply-To: <cover.1573031848.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573031848.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The message file will be used as commit message for the
git-{am,rebase} --continue.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index d735d09f98..4c1ffad0f1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2972,7 +2972,8 @@ static int make_patch(struct repository *r,
 
 	strbuf_addf(&buf, "%s/message", get_dir(opts));
 	if (!file_exists(buf.buf)) {
-		const char *commit_buffer = get_commit_buffer(commit, NULL);
+		const char *encoding = get_commit_output_encoding()
+		const char *commit_buffer = logmsg_reencode(commit, NULL, encoding);
 		find_commit_subject(commit_buffer, &subject);
 		res |= write_message(subject, strlen(subject), buf.buf, 1);
 		unuse_commit_buffer(commit, commit_buffer);
-- 
2.24.0.4.g6a51fdd29c

