Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93204C77B73
	for <git@archiver.kernel.org>; Sat, 27 May 2023 07:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjE0H6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 May 2023 03:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjE0H6H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2023 03:58:07 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1893BBB
        for <git@vger.kernel.org>; Sat, 27 May 2023 00:58:06 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d1a0d640cso1331645b3a.1
        for <git@vger.kernel.org>; Sat, 27 May 2023 00:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685174285; x=1687766285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nr2o2k4M7iYJ0FlpNlzTlipEOBZWJbJ+J5FjSFWFzY=;
        b=oR2Xzsh9iBV/Y4BfXdXG1VZ9I+AM3/fdRKs4M4qaiXUGM5Vzow2jZkEqC7Svs/3uMI
         o2iW9gE/LfAvH6fJUk6W3nz9Ooa+PvC3IBoUz8IyDZsrfZNTIhuwR18bwDYEhCRFMvXn
         cMa+jrq1ud5yDvxG8WtDWJ2rF6aaBDuxvbFaONVT/0FOc7EACz6PyFDld8SQRlJaLmBY
         HcmcN7OAlvG+lLirx41MD8AToMpuutZ/bLdA/SlKECe4c+oq6Pd9euScYOdiqdZovqlv
         8YXIIc9wTyvaFQLPzWaFuDmk6GIuxy8j0R30dTPFHY0hNjXGzn3piTDrMaS2ykKQ6OMC
         I8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685174285; x=1687766285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nr2o2k4M7iYJ0FlpNlzTlipEOBZWJbJ+J5FjSFWFzY=;
        b=EDuoaC0ZvCF7/gYo7A7jGX4FGJzn2byJnZUul0TjyxlGxvEzbhvdqTBZc1NjSoMhmx
         HYdAIvp8x40Mni4cLzYpSiSof9uX5gJOOPwQKk6IQ28aCdO/46IaL6ydfhOuWklk/7kC
         bpHJGzHAev6WRcVHB7Mhh0JnZ/jwAviJP0NBXW1R5ZETy1EEBdu8QJEjxxfG+qBYLaH0
         5LaGdhsCAkAmsW9Jc6+1BK4edgXbQk1raDrGDPskX/VfkyImltPQt3u9HNhX0Hjg6bp4
         I5abbHEWfL2mLnFi79+ryDyTNN7Zttjfbq41dR/A36mRy2t1StkZ3NAibK1wONrX3432
         uMAw==
X-Gm-Message-State: AC+VfDxROA+EVuYwME3TfaHIP8+cyIXh5CueIp2xVZFLn/yHW6Tv6AOR
        T6qQ2hoMFwCyfuOpSH09Qa4=
X-Google-Smtp-Source: ACHHUZ5Z8HNqoyobOiSg8l78gOhXoYBAJf+NQXzNJ+NOsKQUOLybNdvH6zXnJ8uAt7MEeEJzakf6DQ==
X-Received: by 2002:a17:903:234f:b0:1ae:3e5b:31b1 with SMTP id c15-20020a170903234f00b001ae3e5b31b1mr6508301plh.9.1685174285410;
        Sat, 27 May 2023 00:58:05 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902b20400b001a6b2813c13sm4355239plr.172.2023.05.27.00.58.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 May 2023 00:58:05 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com,
        peff@peff.net, code@khaugsbakk.name
Subject: [PATCH v11 1/7] notes.c: cleanup 'strbuf_grow' call in 'append_edit'
Date:   Sat, 27 May 2023 15:57:48 +0800
Message-ID: <0634434e2a3e40ef4af5013349202491d55fe1d7.1685174012.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.356.g367cb1d4
In-Reply-To: <cover.1685174011.git.dyroneteng@gmail.com>
References: <cover.1685174011.git.dyroneteng@gmail.com>
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
2.40.0.356.g367cb1d4

