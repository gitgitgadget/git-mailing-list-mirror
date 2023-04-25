Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DF6C77B71
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 13:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjDYNf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 09:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjDYNfT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 09:35:19 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C6814447
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 06:34:52 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b35789313so4226876b3a.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 06:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682429691; x=1685021691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2FfaixqwZkNpN8TSQqCuVf4SThXxNw3eQpCanz54ak=;
        b=pPFBDXPTBW+d8VsVqS36bQU2prBc5J62i08Od0LooqVwH/24BJ8V6K9M1rM+tB9UT+
         pB9JK9y9AfvpR3Ha8/GL85RLTZ4hWjP12Z6M8+cxPEkG7T32TZSX1Sf5ADGQhMExT8oc
         R7h6cQdhdL+P5AU4VRRG7Hpwm56RA5tqbpoGqUCLJTh7wDsZgH+R/oZiNIfedH0V+HIN
         6S7O2d3umSyGCFMGdWlHA+69tXcKE+f5bKkc5ZbT6/wvvysc67A9CgNZwm5YdlSwCHPM
         6Z5dEAXFIpdpzWugQ3UlWehhzF+QPkFWzv0V9jpbVAgnshMzTrmWak200l5KAANUQQdq
         rECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682429691; x=1685021691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2FfaixqwZkNpN8TSQqCuVf4SThXxNw3eQpCanz54ak=;
        b=HM93DZwbEe4jxHz5ihYjh2esKewwOOmwIdB+MrzxlhUtDGyYQcO73Ebhb5mJg5JAn4
         yPP0eZMsJ/4owuCgu2VUbyUXZS9IN134lPuPZp8xo60+IJ5Eqb++DDfUUYEZQv7sEzrM
         U9KB13/EjRpXA87UpIhy5B2w1A+CF+6qdTPbgv3jIyBv3O/KQ2a+C2yZl+mTWlKZwXpg
         RkbZI4G3ltpbC/hEa/wINhftlQt0XfAmfvWiJU1pvc93ouZIaxYMDVo5oQ1XbwvUn+oS
         dxCum/XfGiCs/13CurqkW5JsLMftSMnN6BywH/PtXysMmTmkZA2xo7ZwVsWtT33Uted3
         cSpg==
X-Gm-Message-State: AAQBX9eaKuCDrZlTEBHbK1SGr2I23C1Rb4CVVw1U+JqbZ8qDrgH/+y4L
        4VoAxmSdei0qocM4y9QxDtE=
X-Google-Smtp-Source: AKy350YjZHGzgcoQrmFHdJl4eWa7/TC/ztWtA636NYOE3aFvqntBDEd2394rS9s91hS3FV2XbUvdHw==
X-Received: by 2002:a05:6a20:9151:b0:f3:2885:d3b7 with SMTP id x17-20020a056a20915100b000f32885d3b7mr12818071pzc.60.1682429691298;
        Tue, 25 Apr 2023 06:34:51 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id c192-20020a621cc9000000b0063d44634d8csm9243469pfc.71.2023.04.25.06.34.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2023 06:34:50 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v8 1/6] notes.c: cleanup 'strbuf_grow' call in 'append_edit'
Date:   Tue, 25 Apr 2023 21:34:36 +0800
Message-ID: <0634434e2a3e40ef4af5013349202491d55fe1d7.1682429602.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.358.g931d6dc6
In-Reply-To: <cover.1682429602.git.dyroneteng@gmail.com>
References: <cover.1682429602.git.dyroneteng@gmail.com>
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
2.40.0.358.g931d6dc6

