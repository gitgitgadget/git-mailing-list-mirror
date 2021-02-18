Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E99C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9007861606
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhBRMcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 07:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhBRLB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 06:01:26 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4512C06178C
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:58:47 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id v62so2560746wmg.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8hQioYq2SUFWVMt390/hFdBWnZ+TltgMRh5ZIojhMRg=;
        b=fjW5mYTxopUFY9lPHbg3MrXuvOWtaTCNhpBZUkNAuVOR3yPowJwpIdp239GdCA7tPr
         PfkQn7HyZZqxZbS7He3UexInBTo+E9uzb5doRLh/JLFMFGCCoZ3CYDAwvDzYF4w3BsID
         k9bLDBE6nofMw8KTmVX5jwvCy05inxj9KZpzBGoxFci0KIuLrNX903ht3hef0axnuG03
         SObiR4DP64dHQgALx02VavjrqIYkN3z+ohahuPffMubjtMfoqEuCbp9uoR+nQc1c6hrf
         sMU3SUrPEiFn5nxbDZvMFNbSN6CtvvlYOxuanCQ3zesbfk0jx6gTte9ZugI8nDnqMGV8
         2acA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8hQioYq2SUFWVMt390/hFdBWnZ+TltgMRh5ZIojhMRg=;
        b=UynJSt3UHZ0+kyrLHjlpEZfFrSu6TD1qFeN7RLhIoRLi65+BFoDPJBgq+pZ3hMIQ0B
         hJoeEEdb1jzFyMt1II9//oP+HkOMxCJUPzr6CWXBxhm3fXf4RXXD1m+oggelJ9OjoG2+
         1URxz/ydBhwLxVXahOlItS5NX+jSfII1xbDxXfrbxZlX/MtI/TQ5+ScoGC2eSzoPOSbs
         FrX7ktLk/5er2zlCb03P+Wea5SMipSILKfeSTFvDOwm4Sx+zqACUcCTM+y0aP8WoxS9K
         H3o1XwiYlMUkZAYdscqp9Ca3YHWe9j7E1oxmu8PERvYyyLz3GgTFsXm+ub93bJXnJsRW
         9k0A==
X-Gm-Message-State: AOAM532fUPlLMALIJNRRMzttv3nlRfcaIqCdIADGPjqPvFpKSLNpxzQV
        xCtQIk3yjxxmA4NRHNWwUPXjI/5ED+BMZw==
X-Google-Smtp-Source: ABdhPJya24pdmi/Igj6YuuEadKc2rAUGSnBjVPJlwmrhR7JzH4C7Yb2cXjRwy5oyG40fpo8HLyVc1w==
X-Received: by 2002:a1c:cc08:: with SMTP id h8mr3081420wmb.188.1613645926269;
        Thu, 18 Feb 2021 02:58:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l7sm8604376wrn.11.2021.02.18.02.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 02:58:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/10] fsck.c: move definition of msg_id into append_msg_id()
Date:   Thu, 18 Feb 2021 11:58:34 +0100
Message-Id: <20210218105840.11989-5-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210217194246.25342-1-avarab@gmail.com>
References: <20210217194246.25342-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor code added in 71ab8fa840f (fsck: report the ID of the
error/warning, 2015-06-22) to resolve the msg_id to a string in the
function that wants it, instead of doing it in report().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index acccad243ec..1070071ffec 100644
--- a/fsck.c
+++ b/fsck.c
@@ -264,8 +264,9 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 	free(to_free);
 }
 
-static void append_msg_id(struct strbuf *sb, const char *msg_id)
+static void append_msg_id(struct strbuf *sb, enum fsck_msg_id id)
 {
+	const char *msg_id = msg_id_info[id].id_string;
 	for (;;) {
 		char c = *(msg_id)++;
 
@@ -308,7 +309,7 @@ static int report(struct fsck_options *options,
 	else if (msg_type == FSCK_INFO)
 		msg_type = FSCK_WARN;
 
-	append_msg_id(&sb, msg_id_info[id].id_string);
+	append_msg_id(&sb, id);
 
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
-- 
2.30.0.284.gd98b1dd5eaa7

