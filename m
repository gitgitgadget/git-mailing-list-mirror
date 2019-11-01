Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
	SPF_NONE shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7EC11F454
	for <e@80x24.org>; Fri,  1 Nov 2019 14:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfKAOBV (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 10:01:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43159 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbfKAOBU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 10:01:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id a18so3266917plm.10
        for <git@vger.kernel.org>; Fri, 01 Nov 2019 07:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yCYwLn9Yq6MBeEciruWWmefKgtYHrRPbZDn+NXiK4/U=;
        b=FnZNDg60PIgubgCTbt49GXUXCsvMry9n/WxCXfVp1d0rRTM4rC5fw1wECoff9q4P4L
         wCxEfFiYkFpSMqzrrTKO8ftNeB94zlbac9lFmeYIkQk8QQqUfVk2TB//w2VbuL2KsSMk
         VMIJHL2GrKFdQbqgvwh94CuiTeycmVps25Dw+99FHia2csb7sz0iMC8LfthAlxNvzG9a
         htpPgYhtkFj6JBVBaPs9gpou5e9rB3Z6BcrAZOYFlB9cCr2h+Q3fkmOwA7gZTIeeEOb8
         G4ILwiLFFotq3diDujhxZkHsEEgSqbaSGmlPScZd/cf5bancYEuxpsjMS9+CAR+KK8TN
         7DMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yCYwLn9Yq6MBeEciruWWmefKgtYHrRPbZDn+NXiK4/U=;
        b=KPgCRQfjbId3IM+Be8TK7iusZU1kLpJTQFXmptK4g0Rpu9ugukkPdOZRYI3J9ngmkX
         0UamF1Sv+2XbLgiU07t1HwgZXAL5G8Pc3wVTezEE8nqFa0qXiSbUtt3G+wajoRGxXTwc
         HSW8NqF1IdVKTnripJR5kz6W/YoMlhTWQj8qRg+GHbiXFxkhYsvS4Lyz9+u/7G2hUdME
         wueHDnkHTvRD8jQbk5gstLk2KCv7nYotA4MhXuiVAwG4U3yMFdu+Q3KEeL9NPRGjr5Ur
         X7u2uRTFkGj8wi1dTUhqM+rIc1hX2S6RoNRjSq+G02FGlFYwtjLhiO6QMJK8o8mULxaf
         B/kA==
X-Gm-Message-State: APjAAAVXLysuagmrX8irEjl3p1Dbj9lRagiPQyywaM1MrwC6upJ4h5eS
        WxqcQm+vF3MXxK46o7pM0UtijCDO7q0=
X-Google-Smtp-Source: APXvYqyQ3FnYulN6qfAKMqZT8sy+Ukad0xCGfsLFsvTxoQFT3/fYMUaAMWbsIahboR4Jd8wmlqCpvQ==
X-Received: by 2002:a17:902:864b:: with SMTP id y11mr12989205plt.148.1572616878490;
        Fri, 01 Nov 2019 07:01:18 -0700 (PDT)
Received: from ar135.mshome.net ([103.37.200.214])
        by smtp.gmail.com with ESMTPSA id z4sm7806816pjt.20.2019.11.01.07.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 07:01:17 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: [PATCH v5 2/6] sequencer: allow callers of read_author_script() to ignore fields
Date:   Fri,  1 Nov 2019 19:29:59 +0530
Message-Id: <20191101140003.13960-3-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191101140003.13960-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20191101140003.13960-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current callers of the read_author_script() function read name,
email and date from the author script.  Allow callers to signal that
they are not interested in some among these three fields by passing
NULL.

Note that fields that are ignored still must exist and be formatted
correctly in the author script.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 sequencer.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 9d5964fd81..6954b9eea9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -823,9 +823,19 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 		error(_("missing 'GIT_AUTHOR_DATE'"));
 	if (date_i < 0 || email_i < 0 || date_i < 0 || err)
 		goto finish;
-	*name = kv.items[name_i].util;
-	*email = kv.items[email_i].util;
-	*date = kv.items[date_i].util;
+
+	if (name)
+		*name = kv.items[name_i].util;
+	else
+		free(kv.items[name_i].util);
+	if (email)
+		*email = kv.items[email_i].util;
+	else
+		free(kv.items[email_i].util);
+	if (date)
+		*date = kv.items[date_i].util;
+	else
+		free(kv.items[date_i].util);
 	retval = 0;
 finish:
 	string_list_clear(&kv, !!retval);
-- 
2.21.0

