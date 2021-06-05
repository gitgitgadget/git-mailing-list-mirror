Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0335AC47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 09:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE702613E9
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 09:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhFEJQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 05:16:35 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:55045 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhFEJQf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 05:16:35 -0400
Received: by mail-wm1-f51.google.com with SMTP id o127so6700049wmo.4
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 02:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=//N8eRRx8wwJ0uDIx93a5crUlk1vWHkCfWiu6zlge/0=;
        b=VKf8DSIrNTW1GffhCW1HYQE6iNo23ayvX22q5VEyOsBhf2wWGibELIChLgTkJqyGMA
         8wVhp0aopy/JA2kTA3/neY1M5J8yeoRgfn1HBtitcUQdFAQusIuXgAqLCYz9y6RQSh1f
         p3GHlb1JddssC2ugAe0/KX+hrl8dxyscOAZa9hFKJxnTliCDeQRFzdtQgdBuXtTmpNB9
         CNEPwmhgpt2fQ+QPYarwz7fru0RhGEPLdwzn16pdEyL662U6K//Vl5SmK97hTWVOZzP1
         4qW3AwEIBZqJbCu1F93WGFDHyYpMoQzeVCof+WPu7L9Apq6A/ocXtkXs5bFERCDhNEug
         qIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=//N8eRRx8wwJ0uDIx93a5crUlk1vWHkCfWiu6zlge/0=;
        b=ppZOkdn0vIwYtqRdyKOTDNna0DSIepfr1X8CC4XfLEmCWR9oiVtwb5Oe/0gU4u9Qan
         radMwfrlhr4Udovo9YfjM997uBLs3ZUXowoWAa8oiyJ7t4iM2OJX2uFr/bkOK+uGomKV
         RCsnJA9ScMUb0QZ/tNxvcCBP/woYu1l72Ce0Q7ybZzpb0A+1k6+BDDEiis7bnxG8QZb5
         I8kIs0s+yEom9cwPFY58gXTYkcBKNxrgAGKRDc7lmnF7jEXn+H3rZuatt8s8m6jF/oal
         LucHKJBiWZDZIPReE/OEkG6yFbG5m5JnxOyyVaVZ0eMOakiEjLF/kZ01soH7IPind2uA
         XFeA==
X-Gm-Message-State: AOAM530K46dU1vLMrvQIP0Id3T7zv7eb+tFwSkQEMtdnAoCVPBmfa501
        GGeqyzOHCKBpQXNxvG0Uwzk4vcTLSg8=
X-Google-Smtp-Source: ABdhPJx2G61fkKlnsw6E+nef1kvexE+TrUh0lKJsqx0Ru2fwOT4k9BAq6Pp0og8VbduYGhhSJZq2ug==
X-Received: by 2002:a7b:c157:: with SMTP id z23mr7639626wmi.148.1622884416784;
        Sat, 05 Jun 2021 02:13:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w13sm8099973wmi.4.2021.06.05.02.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 02:13:36 -0700 (PDT)
Message-Id: <pull.972.git.1622884415.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Jun 2021 09:13:28 +0000
Subject: [PATCH 0/6] [GSOC][RFC] ref-filter: add %(raw:textconv) and %(raw:filters)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to let git cat-file --batch reuse ref-filter logic, This patch,
%(rest), %(raw:textconv), %(raw:filters) atoms and --rest=<rest> option are
added to ref-filter.

 * %(rest) int the format will be replaced by the <rest> in --rest=<rest>.
 * the <rest> in --rest=<rest> can also be used as the <path> for
   %(raw:textconv) and %(raw:filters).
 * %(raw:textconv) can show the object's contents as transformed by a
   textconv filter.
 * %(raw:filters) can show the content as converted by the filters
   configured in the current working tree for the given <path> (i.e. smudge
   filters, end-of-line conversion, etc).

The current series is based on 0efed9435 ([GSOC] ref-filter: add %(raw)
atom)
https://lore.kernel.org/git/pull.966.v2.git.1622808751.gitgitgadget@gmail.com/
If necessary, "%(rest)" part can be an independent patch later.

ZheNing Hu (6):
  [GSOC] ref-filter: add obj-type check in grab contents
  [GSOC] ref-filter: add %(raw) atom
  [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
  [GSOC] ref-filter: add %(rest) atom and --rest option
  [GSOC] ref-filter: teach grab_sub_body_contents() return value and err
  [GSOC] ref-filter: add %(raw:textconv) and %(raw:filters)

 Documentation/git-branch.txt       |   6 +-
 Documentation/git-for-each-ref.txt |  29 ++-
 Documentation/git-tag.txt          |   4 +
 Documentation/git-verify-tag.txt   |   6 +-
 builtin/branch.c                   |   5 +
 builtin/for-each-ref.c             |  17 +-
 builtin/tag.c                      |   8 +-
 builtin/verify-tag.c               |   1 +
 ref-filter.c                       | 296 ++++++++++++++++++++++-------
 ref-filter.h                       |   9 +-
 t/t3203-branch-output.sh           |  14 ++
 t/t6300-for-each-ref.sh            | 294 ++++++++++++++++++++++++++++
 t/t7004-tag.sh                     |  10 +
 t/t7030-verify-tag.sh              |   8 +
 14 files changed, 633 insertions(+), 74 deletions(-)


base-commit: 1197f1a46360d3ae96bd9c15908a3a6f8e562207
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-972%2Fadlternative%2Fref-filter-texconv-filters-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-972/adlternative/ref-filter-texconv-filters-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/972
-- 
gitgitgadget
