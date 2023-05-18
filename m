Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA406C77B7A
	for <git@archiver.kernel.org>; Thu, 18 May 2023 12:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjERMCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 08:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjERMC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 08:02:28 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5DCF7
        for <git@vger.kernel.org>; Thu, 18 May 2023 05:02:27 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ae5dc9eac4so9603585ad.1
        for <git@vger.kernel.org>; Thu, 18 May 2023 05:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684411347; x=1687003347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5Lim86nXQck3hwdqkWO/kZgVNn5qOIL/Z+/sAjNTLc=;
        b=I5YNob83pZXaxgGfVv3MAb/phwKWBpHIv/Jj7w+OtZBb/udveoYe8XsDRPR13G6/oT
         QUIcOpnCxEx02rAwMkkqBXNBTa8yyBCjfalzuejKTJM8dJjboECLLyAa3YAp3/KMWL0V
         IMGbqrZ+dA3AU2Tm1RuNeoq3QjFIayMJPLMZiQq4IbIU3pmLq0B67TrUPsNJifxvW5b3
         ktlZ6ODEDEgV03yaA019DdXFICrlPFFF9lfbTGSoL9JLmS7iQdpctObhQDrncLgXYV3x
         5SIPjLor+OQc/buu7U/YUHYBiVctJrsAhQ/wNBZ/I8JQIVIDQXZkrVwZlftxUkdOiCAR
         53lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684411347; x=1687003347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5Lim86nXQck3hwdqkWO/kZgVNn5qOIL/Z+/sAjNTLc=;
        b=lC9ENDidAU1qrHdvo0IFgCFWCQSq97a7ZMkon0vqZtSlakTWOiFymyNn34jmSHSXw5
         DqBLpYqW6EHox4kSmX8O6zBrfGLuvV93zAE7L32591nLVv5SMqm0eHK1kfV9UbU1zWA3
         3SHs0a9LZffqq9Qz4EnWr/el/kUaf9/VCWbMerGWUUONrf8+QFH/3/FuNLgoeeJ3oMTz
         TgKk+PU/r68KRn9ER+5MlCgMwNpCubpP3qV311LGOTH7qvEbAJPdMY2wS6wm9y+UfhZU
         xmdYJlBpTVBNxjEi5+4pCjdz5JvdAuPd9+L4vWrrn1xFWXA76Rn+EUjt+VvAt8G34Yx+
         R5yQ==
X-Gm-Message-State: AC+VfDzVvBilzQVDBxxFMejsmEWHp/l3wognx4VUVWCGCDILnFKA6x4q
        kZM200gwv72v/VsJOGHYtyU=
X-Google-Smtp-Source: ACHHUZ6Q/VB2Lqwo1NkYUeNPwQXa0Tc9r4termzr9KIAgLqyAVd4KIrgF5TH8aslad4QQEmZcOApzg==
X-Received: by 2002:a17:902:7205:b0:1a6:4127:857 with SMTP id ba5-20020a170902720500b001a641270857mr1899138plb.5.1684411346566;
        Thu, 18 May 2023 05:02:26 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.51])
        by smtp.gmail.com with ESMTPSA id ji17-20020a170903325100b001960706141fsm1264203plb.149.2023.05.18.05.02.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2023 05:02:25 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v10 1/6] notes.c: cleanup 'strbuf_grow' call in 'append_edit'
Date:   Thu, 18 May 2023 20:02:06 +0800
Message-ID: <0634434e2a3e40ef4af5013349202491d55fe1d7.1684411136.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.356.g67a1c1d0
In-Reply-To: <cover.1684411136.git.dyroneteng@gmail.com>
References: <cover.1684411136.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Let's cleanup the unnecessary 'strbuf_grow' call in 'append_edit'. This
"strbuf_grow(&d.buf, size + 1);" is prepared for insert a blank line if
needed, but actually when inserting, "strbuf_insertstr(&d.buf, 0,
"\n");" will do the "grow" for us.

348f199b (builtin-notes: Refactor handling of -F option to allow
combining -m and -F, 2010-02-13) added these to mimic the code
introduced by 2347fae5 (builtin-notes: Add "append" subcommand for
appending to note objects, 2010-02-13) that reads in previous note
before the message.  And the resulting code with explicit sizing is
carried to this day.

In the context of reading an existing note in, exact sizing may have
made sense, but because the resulting note needs cleansing with
stripspace() when appending with this option, such an exact sizing
does not buy us all that much in practice.

It may help avoiding overallocation due to ALLOC_GROW() slop, but
nobody can feed so many long messages for it to matter from the
command line.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/notes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 4ff44f1e..c501c6ee 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -219,7 +219,6 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 
 	BUG_ON_OPT_NEG(unset);
 
-	strbuf_grow(&d->buf, strlen(arg) + 2);
 	if (d->buf.len)
 		strbuf_addch(&d->buf, '\n');
 	strbuf_addstr(&d->buf, arg);
@@ -623,7 +622,6 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		char *prev_buf = repo_read_object_file(the_repository, note,
 						       &type, &size);
 
-		strbuf_grow(&d.buf, size + 1);
 		if (d.buf.len && prev_buf && size)
 			strbuf_insertstr(&d.buf, 0, "\n");
 		if (prev_buf && size)
-- 
2.40.0.356.g67a1c1d0

