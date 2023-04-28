Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FEAC77B60
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 09:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjD1JXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 05:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjD1JXt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 05:23:49 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7199930E8
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 02:23:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b8b19901fso11503894b3a.3
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 02:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682673828; x=1685265828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVYihN8aR3j/eJQhwBiADSvdvPg7dbbTDJpfSpUb5Uo=;
        b=CB2Haa+H+nNoZAFo2JRbBdPgFGeKrm/Jr5e2CToK/2V+uGEhtuIr8y+Jqut4puR7PJ
         CpFPNydmCgU6PS6tJ5Iys7SVJX9SYp3RPyrcbuEbfGg9uqmBeh2TdVro0ypBbfA0FyCb
         kdfD7SS3EoVX5GWL4SPhTBPOSVwYhtXBxIxr3SlQQBfB5AlxREyZk89FmvfWzpxwWNlo
         P0BX5CokSdjfRzcv468kSH4bgRmcF/al/OH16Jr1DgZ6czBOoU5pnSJOZ98ur4WPmtdJ
         hSGEDRYLc+ROa5525HTEqZ++htQ3jLleedux+I4yAj1/sRVEdj07aipI8cAk/ekaLSRN
         F73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682673828; x=1685265828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVYihN8aR3j/eJQhwBiADSvdvPg7dbbTDJpfSpUb5Uo=;
        b=MWmSz/NPVmTlnqQQlVtuZoR5Zet0wx8SPnJKAwu+BrmVCBl7TByM3zeabov5vM/wZu
         h+gxzDn7W+SrMuLLs2KOfQWat2rP+krmSpHjIEn4NAqA1X0RUuyYT90vfZHFMxvU/zdd
         Wy5KwUA5M31P17Taozk8L6Bmv5MlZfwZ4izcylb/fswCkKffYAHVa4mnBSwBUwjEHZQb
         pwqlE9EKw+FzXivcHSzUGIXzFlyQ47FudH8CoL2GTKjbdr2JL/sX/c+eVNwiUj6oSe2g
         bBB9UVMUzedV/ZfGIYZZHRz+In/NpbiDz7VAQEwl7/E9mQ8ttitWAeG1FUOcj4jvKBOc
         fZ9w==
X-Gm-Message-State: AC+VfDw12Uk6QPXBmgbBqH5OTjNQSqzK1G7esYYo9LcPLou8XtiqB586
        nYfaWAS8/LbQDUu8HRBWu94=
X-Google-Smtp-Source: ACHHUZ4GkmgzuchFVw8D3wr5J4Ij0RsI8t0h3ALmsCsuSxDlbHmXHrxEClNIf5Ddw9C1dJ/WLbI9hQ==
X-Received: by 2002:a05:6a00:1950:b0:628:1b3:d499 with SMTP id s16-20020a056a00195000b0062801b3d499mr7014130pfk.21.1682673827840;
        Fri, 28 Apr 2023 02:23:47 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.51])
        by smtp.gmail.com with ESMTPSA id i21-20020a056a00225500b0063b8f33cb81sm15107078pfu.93.2023.04.28.02.23.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Apr 2023 02:23:47 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v9 1/6] notes.c: cleanup 'strbuf_grow' call in 'append_edit'
Date:   Fri, 28 Apr 2023 17:23:29 +0800
Message-ID: <0634434e2a3e40ef4af5013349202491d55fe1d7.1682671758.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.358.g2947072e.dirty
In-Reply-To: <cover.1682671758.git.dyroneteng@gmail.com>
References: <cover.1682671758.git.dyroneteng@gmail.com>
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
2.40.0.358.g2947072e.dirty

