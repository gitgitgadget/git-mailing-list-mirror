Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0DAB1F463
	for <e@80x24.org>; Tue, 17 Sep 2019 16:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbfIQQfQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 12:35:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42087 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730435AbfIQQfP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 12:35:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id z12so2295055pgp.9
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 09:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WgJngzixExLNz8YPYSy7meaBxrNydj3p9oYE3ikC6uY=;
        b=tZrl/323dYj15DwQ/Q/eYxMLA4dy86VtS0aBpb3a6Er7wFF6oNGcze2tfGrF7lE3Rg
         u/9NPclL3WynZ4N0jQHVTV8cdygQBRp6yKa0GqtR2IYBXzK1UCDtpxlQL6RpFLD7l/EU
         thCvgXz39ZqjrmmJd1vXbTj0AbFZqtyAioFygz6/WrVYgMHvflAogjxGCatmdEm9MRAl
         Cv6w2v5rKO90GBM5PCLP843fWjoekrcnsE3QhaQTJSzJx+wqpgudTaJ5YOOiL6ghClUM
         ldA+dFda944gomRLXI31X0ymelBCweksIllgSfz2OkhR1TUJuRQkt4AUQIIgHU3TgTpO
         i1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WgJngzixExLNz8YPYSy7meaBxrNydj3p9oYE3ikC6uY=;
        b=oHdEqBWeiwdLg10iICpCkO/a0e/IwDVgt94C46RJ6H1T/c5Mms72rBvvnrVVOVofS5
         d0Oj9Ndu0JSjV+6CMFQHF6+uV148qfpRPyWX5fpx2qYv6hV5tVjj6/SmFKyw8uRBlq2p
         uwbgfkqVpTxWihZteBDSrMns9/8JbPMJoj62dsH5D/VohOKRa+59cK7A9J7pXTYooI5n
         2BdQ+r4MW73sT+Qo01cSmyT/2AgjwTL2PceiBIBX/Gfd6FCgCyUDAQcQJ1PZjo25wY9f
         aXoz2EGtxEUSlHRR59OQF9tYx2nZrLJ5i1XOLNUjab/E04awnGbOm3Cjd+4IuZvtE3WN
         GMaw==
X-Gm-Message-State: APjAAAUSBKSnBI/pouiH2oFMmU6FifLCCeejUJ79ygkqvN6ind7ilw1i
        8Sh9VtkXzC5Zqk5bMXm8vwI+LnSAUl4=
X-Google-Smtp-Source: APXvYqwt+O/b2/dHI33BlgXoLk0OS8vBuiN5QOTnUw/lwIi4Aw2JIVDL5iQhnjppeU1KLLYEC44rGQ==
X-Received: by 2002:a63:185c:: with SMTP id 28mr4187356pgy.0.1568738114334;
        Tue, 17 Sep 2019 09:35:14 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id s5sm3202452pfe.52.2019.09.17.09.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Sep 2019 09:35:13 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 03/12] dir: fix off-by-one error in match_pathspec_item
Date:   Tue, 17 Sep 2019 09:34:55 -0700
Message-Id: <20190917163504.14566-4-newren@gmail.com>
X-Mailer: git-send-email 2.22.1.17.g6e632477f7
In-Reply-To: <20190917163504.14566-1-newren@gmail.com>
References: <20190912221240.18057-1-newren@gmail.com>
 <20190917163504.14566-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For a pathspec like 'foo/bar' comparing against a path named "foo/",
namelen will be 4, and match[namelen] will be 'b'.  The correct location
of the directory separator is namelen-1.

However, other callers of match_pathspec_item() such as builtin/grep.c's
submodule_path_match() will compare against a path named "foo" instead of
"foo/".  It might be better to change all the callers to be consistent,
as discussed at
   https://public-inbox.org/git/xmqq7e6cdnkr.fsf@gitster-ct.c.googlers.com/
and
   https://public-inbox.org/git/CABPp-BERWUPCPq-9fVW1LNocqkrfsoF4BPj3gJd9+En43vEkTQ@mail.gmail.com/
but there are many cases to audit, so for now just make sure we handle
both cases with and without a trailing slash.

The reason the code worked despite this sometimes-off-by-one error was
that the subsequent code immediately checked whether the first matchlen
characters matched (which they do) and then bailed and return
MATCHED_RECURSIVELY anyway since wildmatch doesn't have the ability to
check if "name" can be matched as a directory (or prefix) against the
pathspec.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index a9168bed96..bf1a74799e 100644
--- a/dir.c
+++ b/dir.c
@@ -356,8 +356,9 @@ static int match_pathspec_item(const struct index_state *istate,
 	/* Perform checks to see if "name" is a super set of the pathspec */
 	if (flags & DO_MATCH_SUBMODULE) {
 		/* name is a literal prefix of the pathspec */
+		int offset = name[namelen-1] == '/' ? 1 : 0;
 		if ((namelen < matchlen) &&
-		    (match[namelen] == '/') &&
+		    (match[namelen-offset] == '/') &&
 		    !ps_strncmp(item, match, name, namelen))
 			return MATCHED_RECURSIVELY;
 
-- 
2.22.1.17.g6e632477f7.dirty

