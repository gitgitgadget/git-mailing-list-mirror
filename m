Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 103811F461
	for <e@80x24.org>; Thu, 16 May 2019 02:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfEPCAp (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 22:00:45 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:51674 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfEPCAo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 22:00:44 -0400
Received: by mail-ot1-f73.google.com with SMTP id 68so950339otu.18
        for <git@vger.kernel.org>; Wed, 15 May 2019 19:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=L+QotSifchmjb/VjKPlpnkPS0I7ApHwzihPEf1NVO8w=;
        b=TN0dNyfRErIQBh04l2z3HLPvDMF7Bhqm+E+mOgxoz1ZU2KqiwqQIz/SbnmMYCAZW61
         CMmFv2l0Em3qAu6sNT9KOmQTwZ5COcucjvVfjechEVln36uB5sIx3JkGFRWr44hKzpuz
         InU9PQpFfYum8smXI2H1JZuoP/ilhqZMxRKNLkp+k4GZeFtBDawuhr1zp928k65EbbyF
         PAfoGp4cRqjHemVqPgY1P0W/I3jsrO9ngrgrWwJAuUhJ1v8wbmlTAE8KALwXChJH/Zrs
         SKlIVEyg1JgvEfwLgC4kFjodTEKf4el6bMJux1sihc3NKrjh5QgahIeHPl7PCZK/HFyF
         e+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=L+QotSifchmjb/VjKPlpnkPS0I7ApHwzihPEf1NVO8w=;
        b=MkcNBjZpoE1cynoWbXDYKlcshD8JdtVzBTzbsULqJpb54GAeli0q1Vw9rTM4iHzdHh
         6G2UKNQe9am7jp7RZeAIzrUXzqIeIoY5DFYqr9srpR3V5mPoaYXus9lNJt/DiwKRj8R6
         MMighm9W06dBzXmxbvObgg+gBP6Dz7BueuM7G58O6m15vxj2fYbYuBMVnOK0nV/E2Lgq
         FF8fX7xb86PWPuM/sFmlYtkUNFl2LGHN1WYo4Rc476LX0bT198mKs5kaRaaS+Ti+Xo8z
         vrtQlwdl0RdZkgdU2B6PVwdLclZuTinuaDFpe/iHvi0lJu+cbiDqZv/cjWd3VUNwE54O
         Ag2w==
X-Gm-Message-State: APjAAAU2kghyUBLbfWMKTfIpu41pNZ+h3hYlSPxWlz5EKl0LEVukOc1v
        Zev3kQoTXYNsXB5WF49418xJleRWyJLh7RqXZt3uFOa5cGfgvZeYhjwhU9zO8yEdgfk+832BQNj
        UEeWuL/EqR9qxTDqmvU4kU6rYNwJpyQb91usLn9OZWTTIsygNGXrqeRCDJ639faX5Iwj2r6cY+A
        ==
X-Google-Smtp-Source: APXvYqxqTU2vjIzavXt3VjLgHBv7rgUCVm4rA/sZO7+3tW1ktOa/hoQQ4VN7BWpHi/ZSzgCJ+SLBrcWV/NsL+V1w51s=
X-Received: by 2002:aca:d40a:: with SMTP id l10mr8649456oig.177.1557972043309;
 Wed, 15 May 2019 19:00:43 -0700 (PDT)
Date:   Wed, 15 May 2019 19:00:23 -0700
Message-Id: <20190516020023.61161-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [RFC PATCH] grep: provide sane default to grep_source struct
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     jrn@google.com, Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

grep_buffer creates a struct grep_source gs and calls grep_source()
with it. However, gs.name is null, which eventually produces a
segmentation fault in
grep_source()->grep_source_1()->show_line() when grep_opt.status_only is
not set.

This seems to be unreachable from existing commands but is reachable in
the event that someone rolls their own revision walk and neglects to set
rev_info->grep_filter->status_only. Conceivably, someone might want to
print all changed lines of all commits which match some regex.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
Hiya,

I ran into this issue while I was working on a tutorial on rolling your
own revision walk. I didn't want to print all the lines associated with
a matching change, but it didn't seem good that a seemingly-sane
grep_filter config was segfaulting.

I don't know if adding a placeholder name is the right answer (hence RFC
patch).

Jonathan Nieder proposed alternatively adding some check to grep_source()
to ensure that if opt->status_only is unset, gs->name must be non-NULL
(and yell about it if not), as well as some extra comments indicating
what assumptions are made about the data coming into functions like
grep_source(). I'm fine with that as well (although I'm not sure it
makes sense semantically to require a name which the user probably can't
easily set, or else ban the user from printing LOC during grep). Mostly
I'm happy with any solution besides a segfault with no error logging :)

Thanks in advance for everyone's thoughts.
Emily


 grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 0d50598acd..fd84454faf 100644
--- a/grep.c
+++ b/grep.c
@@ -2045,7 +2045,7 @@ int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size)
 	struct grep_source gs;
 	int r;
 
-	grep_source_init(&gs, GREP_SOURCE_BUF, NULL, NULL, NULL);
+	grep_source_init(&gs, GREP_SOURCE_BUF, _("(in memory)"), NULL, NULL);
 	gs.buf = buf;
 	gs.size = size;
 
-- 
2.21.0.1020.gf2820cf01a-goog

