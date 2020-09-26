Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E94C4741F
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 739A521531
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqdTe0i1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgIZVE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 17:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgIZVE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 17:04:26 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04B8C0613D3
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:04:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c18so7581853wrm.9
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a99TZs8RDfEzZQgrvCmmxLFT3tTlt4p0jVhkvTLfJno=;
        b=IqdTe0i1S7/M1ipYRQmMvp3Z9fUkCWa/tymI23OqhE7G9lVIszF1zce7cr9MCG12Qk
         OBUSbQd1P6DXPcx7opKRA37kxjc3R4ER35YIB1FX/jHFnvKAnN8CuJq76DtNJ1JjnyRk
         LGfUxy3Xyzj7rfhDP46i+XV3+vO6ZcAzthzSrfhYIIIKvt2UZjBGHQoDyRhtYXsQ8q6E
         uCJxAmy1OSVbcgBNIf25j5bjIBJ4XpdYqsdMzFmO+jizl3uAv1Wq1NGdPaHR51LCN3uS
         2evd2qKEzUZbUdNPDx6C1V8b03IrQ7A5IJTMU3Wng6o+cmTgVGJIl0TjKZ/49EXZesI9
         fzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a99TZs8RDfEzZQgrvCmmxLFT3tTlt4p0jVhkvTLfJno=;
        b=qQUxwM/wL9HH/bBIBg5c+gsklElbkQQgFRkn/+2x3Y/jgAYqmslTunwgDciVLan75l
         8wLeNyRyF4TcssTQK6UeHh9472dsfJqSNV0ebfOzgoIwBd5jkygdygQfZfEHvaMwWKMs
         ZRia7vc35Lqs2JipnajbgQd4JbTI5QWSaGVhGnnOuFr4eLwIAuqBvg5RmGEyOaF9fdj7
         g2mjV1TQ5mZ/toFVS8wj2hrGKP298eQWRxWeLQcYW6pfoN/LG50FKdILyk2+oW0kDICE
         85wGW/awg7CJbXYLkkSeR927EA0LuVX2FZQWAGppIp0koRK/btNeS6NZ6E95L4oacfk3
         CagQ==
X-Gm-Message-State: AOAM5308iFJVqJSWMJlGROReNB5bGVu8ZhtuzXkUh04QvW6p2UurRLSk
        xeV+YcI4lDepp+KWMqSdBXl8UXVEuH0=
X-Google-Smtp-Source: ABdhPJxf4pB9aZ4vBq1aPf8Ja3yO+8em5HuW+j5REDpaoYI6ciNPPtZPlUY+WXdeWcoSCpGuB5815A==
X-Received: by 2002:adf:c3cc:: with SMTP id d12mr11143905wrg.399.1601154264298;
        Sat, 26 Sep 2020 14:04:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m12sm3522486wml.38.2020.09.26.14.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 14:04:23 -0700 (PDT)
Message-Id: <587ddca42ae36be3d5b333cefe1f9af768bacc9a.1601154262.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.734.v3.git.1601154262.gitgitgadget@gmail.com>
References: <pull.734.v2.git.1600725687.gitgitgadget@gmail.com>
        <pull.734.v3.git.1601154262.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 26 Sep 2020 21:04:18 +0000
Subject: [PATCH v3 1/5] fast-export: avoid using unnecessary language in a
 code comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In an ongoing effort to avoid non-inclusive language, let's avoid using
the branch name "master" in a code comment.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fast-export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 1b8fca3ee0..5527135ba8 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1026,7 +1026,7 @@ static void handle_tags_and_duplicates(struct string_list *extras)
 				/*
 				 * Getting here means we have a commit which
 				 * was excluded by a negative refspec (e.g.
-				 * fast-export ^master master).  If we are
+				 * fast-export ^HEAD HEAD).  If we are
 				 * referencing excluded commits, set the ref
 				 * to the exact commit.  Otherwise, the user
 				 * wants the branch exported but every commit
-- 
gitgitgadget

