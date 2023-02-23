Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D02C636D7
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 07:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjBWHaC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 02:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjBWH37 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 02:29:59 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEBF32537
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 23:29:58 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id d10so1860464pgt.12
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 23:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqqANCJ/5EbUxhX1q6md/iiNuYrqr/dW0kGua/uzH0k=;
        b=Qm67N53DEcdAAIQ52qQChaaAnpZg8jsbkjvoUvHpnrztEPxfcxhF9GmcQTHLPHQS4H
         kJ+Q1Vd3D4+jxPAfn2q6B7hq2dRJ7+F234sI4Blk+Eh/hmU5I8TmRNOTrQjzxH20B73S
         Ym/Q9AKTybPPBFW2dhnJ2By5ojztxjnmtwXSvzlfTJr0SOnTISbCNS93NtOm83Xv5K8e
         VFzzpKwtJXSdHrOS9cs2+WOgKLzvjJrANV6+1f4FuslNbnFuwiSCQM7nPPbkUgsYymFO
         MqmJQqpYEuclPa++jfwjA3d7foOqMD0Qt4BNrwSSanxm7k6YopYamrrMnW3f35PyIyLc
         2/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqqANCJ/5EbUxhX1q6md/iiNuYrqr/dW0kGua/uzH0k=;
        b=HYdsoa8xBTLuhJwMLVezU/UCfcCjh71Pi2ZzKICbC1zlhnyvjnm5t58+pGQNPEcXo2
         2KQUUii+HqePgNRx3f/9yvfTpUkUzfJFSCbeF1aUSe54wSpkWlJfVB6R6LLtX3h/Hthp
         4j5aRvCY+hoqDtJVUsWaJwlXb9/hQPfKmQD0M3F9aiGfRP1eboMoywvj68ac5xUHEAde
         drzAJchoKQI/jqe79GuRGVagT+BFJrj5hdxRWPB3kG9IKHrDhvgd1qz8bbFnYDJAxalR
         xWyqgFtYwODXFpL2w6NF/LdcM6TmzlXuP9JVqvyZrJ2uJq36u217sm5CSgYSRp6OpJ0x
         JFjg==
X-Gm-Message-State: AO0yUKU7Tx3Ygq6LASEymniNg35RU0/evho7HSomNlswCr4nxDsLk3G4
        qNnOmM4rWtlgMVDHK3/+bGg=
X-Google-Smtp-Source: AK7set/5IBZwbaNMmNMX4mwcLdhzjGysw0TS6K9XGyTjujjQSFh9EN9aRwe+re1M+6HCBRsbOHg1SQ==
X-Received: by 2002:aa7:96ae:0:b0:5db:bc21:8dfa with SMTP id g14-20020aa796ae000000b005dbbc218dfamr1446114pfk.19.1677137398245;
        Wed, 22 Feb 2023 23:29:58 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.50])
        by smtp.gmail.com with ESMTPSA id u20-20020a62ed14000000b0059085684b54sm5570364pfh.140.2023.02.22.23.29.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2023 23:29:57 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com, gitster@pobox.com
Subject: [PATCH v6 2/3] notes.c: cleanup for "designated init"
Date:   Thu, 23 Feb 2023 15:29:46 +0800
Message-Id: <043db6311b0af9311764d8e763e85867ed3381a6.1677136319.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.39.2.459.gd5a6c747
In-Reply-To: <cover.1677136319.git.dyroneteng@gmail.com>
References: <cover.1677136319.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

The "struct note_data d = { 0, 0, NULL, STRBUF_INIT };" style could be
replaced with designated init format.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/notes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 23cb6f0d..553ae2bd 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -401,7 +401,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	struct object_id object, new_note;
 	const struct object_id *note;
-	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
+	struct note_data d = { .buf = STRBUF_INIT };
 	struct option options[] = {
 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
@@ -567,7 +567,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	const struct object_id *note;
 	char *logmsg;
 	const char * const *usage;
-	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
+	struct note_data d = { .buf = STRBUF_INIT };
 	struct option options[] = {
 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
-- 
2.39.2.459.gd5a6c747

