Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3383B1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 00:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbeGaCJ0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 22:09:26 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:41991 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732009AbeGaCJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 22:09:26 -0400
Received: by mail-ua0-f202.google.com with SMTP id m10-v6so4576049uao.9
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 17:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=96PL6zR14r9+gZQqR3L2teZnHUpQYjYZez7ODGbY+RM=;
        b=um/Wxy4pbRlqylOP8uDIDP2CT8+re0kLPpLQcbHdcDUiR/0VDFqg2+C7S/iBZtbw5C
         qyuvKNVJBIOJIoXMVSLtrvW3MZFnyIymg6K9CiYHKrwPQqvHDHpS45W/U+eDF8RU3v2x
         ei+UVbw4uNwFOPFDzxzBMUBgfNX5C/FlCrfouHQpR8+xx3ERXQgsvVDxM+tWmaiXy10d
         dj7r5dpa9M43lMqoki6VaZgx7bcTtHAWRI9sQxy+vjdbpFj7lQAy4Qzhmk8k/stDX2pd
         1IL+ddUVwcfS1+KlvO/2wVmCXESmVHX1TbuTOkrUHLM2SI8m1O87Nh9nnIpVhKY9w5fn
         NMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=96PL6zR14r9+gZQqR3L2teZnHUpQYjYZez7ODGbY+RM=;
        b=NAU/gKDU5C6Y2F8eSMY0b7+3DqQGVMN1StjlTkjci0RVZorCLoH2wX9Rq0fPH4PhWE
         s38Jn56mLvLr/ehV+cmvkOowxZpTwD2EWfkzIEW8HLxg1seUgA4xI6W9lH3EB+M3yyna
         d0LJ3jQraJLNRjK3zYmueyYMX1pn2PXUpKlAynTm+9fzeuU8Hkd/z8ucW/oVDoksW7Ih
         KMaNZseMHQZ1z1fGza1NISuuIlB/4n1Mu+AlSL0QxJljkxc7n7Snzn1qtI9MFSHCP5WB
         kvFC9ZGCNQaUBqa7C++lJJKPVkUllmefcmhAxXeS1yvhHLhEwIK4kiC7TzArvsv4nUzE
         prOA==
X-Gm-Message-State: AOUpUlF0GIsV7UHxx8xI8KNkkA92y0d7UhtJ4AFjT7JOq+pU+UMfJtCD
        vY3WSBNV56d6Ew0BvmneB3YIDgPJyPGm
X-Google-Smtp-Source: AAOMgpe0qg1cFAXISualP507qebCbYsfI3CKxkBjju6L1KRBlyrVL4kIuoX9A6gA+PRi/V1SXzL5+Um+XQ2U
MIME-Version: 1.0
X-Received: by 2002:a1f:a44:: with SMTP id 65-v6mr9355581vkk.20.1532997113994;
 Mon, 30 Jul 2018 17:31:53 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:31:36 -0700
In-Reply-To: <20180731003141.105192-1-sbeller@google.com>
Message-Id: <20180731003141.105192-4-sbeller@google.com>
References: <20180728030448.192177-1-sbeller@google.com> <20180731003141.105192-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 3/8] diff.c: simplify caller of emit_line_0
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Due to the previous condition we know "set_sign != NULL" at that point.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 272b0b93834..f7251c89cbb 100644
--- a/diff.c
+++ b/diff.c
@@ -997,8 +997,7 @@ static void emit_line_ws_markup(struct diff_options *o,
 		emit_line_0(o, set, 0, reset, sign, line, len);
 	else if (!ws) {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(o, set_sign ? set_sign : set, !!set_sign, reset,
-			    sign, "", 0);
+		emit_line_0(o, set_sign, !!set_sign, reset, sign, "", 0);
 		emit_line_0(o, set, 0, reset, 0, line, len);
 	} else if (blank_at_eof)
 		/* Blank line at EOF - paint '+' as well */
-- 
2.18.0.132.g195c49a2227

