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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E358C433E6
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 11:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18C9664DAF
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 11:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhBJLkP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 06:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhBJLid (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 06:38:33 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2345C061786
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 03:37:51 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id k13so1062161pfh.13
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 03:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hkVWdNQiQTnGfiwViD6nDYqlHF5k8u66zHfNdY58TMY=;
        b=EPMGHmG3uF8RQSvRCJnlE6zeavy1d6fVUr1BxNEmWE+rGRsdw5uhulx6UVb0vNBjEs
         LlTQhNjSEjr4oPrU8MG52CKSJqF+S6Sy2bvWnjW7P7aaS0c1Vm9BEclOLdrcBxdruxko
         PTmQpV6nQ1XDboW+8lTk8AH0tEU3zO4Q3wLjUx9k2R1bIbOLwGy9sr9s5trjoL+NG4QI
         AFo6KB/G0PxdVZwhZ22wIoxRq1+U3p8k1rVB4uC/PacQ6GZzITxZDgDumctEzYcBQEkV
         ArNhogs9LA1U/V3oAuG601wB5bEIYrGAKOnanHxASupcBHAaSi4mNGNKX/pgByDKeS0j
         Oj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hkVWdNQiQTnGfiwViD6nDYqlHF5k8u66zHfNdY58TMY=;
        b=TsY8+jYhwVN+4+oiptmqaFZPOO2JQ1wIteICBXB+36h8P2qMyp8djpzwtzBHZfvUB7
         +KKlRVaDvGLYjCtN0EpD7pTsXRcqB0gn4U6RDFYRDcywgYV/271aB+EOKUk24acAHaQm
         RwBEYe6wm8LTlk5clBqNJM/kTc+OB3lTMlEpk/3WW3RWNiDE80bYMSZZRbdqL0ptw/3f
         MJSFRYbW7pd5R8RVsXPAYBJYfWFplSLysAGxr5qt8MiMgPsQOUPJjmG1unaeqIo41JJU
         p8LjvL6Y7jD+mF4b+nwrDKfY0bRaqWnEWBWYydCLfWPR3GwrDwFXnac3RVjnDUViqIEP
         UDuw==
X-Gm-Message-State: AOAM5320kY970UgYAum8RidXT1O6D6nTcyLqVPtWHRODwKqe2afM64sF
        qcgSBfhqV5scR3oyJlinIhlPiud2Q2AO3A==
X-Google-Smtp-Source: ABdhPJyHw4/STjyDcskAcUi+V+ZUUxsZfRunGKLBNg9gHQavcg5LXz2ahq+lKoupW9n0R3XHRUCqqw==
X-Received: by 2002:a63:4956:: with SMTP id y22mr2688144pgk.309.1612957071114;
        Wed, 10 Feb 2021 03:37:51 -0800 (PST)
Received: from localhost.localdomain ([171.76.0.223])
        by smtp.googlemail.com with ESMTPSA id y3sm2123731pfr.125.2021.02.10.03.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 03:37:50 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 01/11] sequencer: fixup the datatype of the 'flag' argument
Date:   Wed, 10 Feb 2021 17:06:41 +0530
Message-Id: <20210210113650.19715-2-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As 'flag' is a combination of bits, so change its datatype from
'enum todo_item_flags' to 'unsigned'.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 sequencer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index d09ce446b6..f3928cf45c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1744,8 +1744,7 @@ static const char skip_first_commit_msg_str[] = N_("The 1st commit message will
 static const char skip_nth_commit_msg_fmt[] = N_("The commit message #%d will be skipped:");
 static const char combined_commit_msg_fmt[] = N_("This is a combination of %d commits.");
 
-static int check_fixup_flag(enum todo_command command,
-			    enum todo_item_flags flag)
+static int check_fixup_flag(enum todo_command command, unsigned flag)
 {
 	return command == TODO_FIXUP && ((flag & TODO_REPLACE_FIXUP_MSG) ||
 					 (flag & TODO_EDIT_FIXUP_MSG));
@@ -1850,7 +1849,7 @@ static void update_squash_message_for_fixup(struct strbuf *msg)
 
 static int append_squash_message(struct strbuf *buf, const char *body,
 			 enum todo_command command, struct replay_opts *opts,
-			 enum todo_item_flags flag)
+			 unsigned flag)
 {
 	const char *fixup_msg;
 	size_t commented_len = 0, fixup_off;
@@ -1906,7 +1905,7 @@ static int update_squash_messages(struct repository *r,
 				  enum todo_command command,
 				  struct commit *commit,
 				  struct replay_opts *opts,
-				  enum todo_item_flags flag)
+				  unsigned flag)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int res = 0;
-- 
2.29.0.rc1

