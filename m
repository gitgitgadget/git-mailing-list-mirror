Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_24_48,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1FB6207F8
	for <e@80x24.org>; Sat,  6 May 2017 18:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752508AbdEFStm (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 14:49:42 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35379 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751727AbdEFStb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 14:49:31 -0400
Received: by mail-qt0-f193.google.com with SMTP id r58so4880414qtb.2
        for <git@vger.kernel.org>; Sat, 06 May 2017 11:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=EBOM+6eb29YbMlznjWGhEHs9GKKRDmfjtwwJfVGdWBI=;
        b=XqtDLXCTNDeLv3B4iAwT4X51XnFuGL5ikXnWVVY7tqCI6iBdKnPG2i87/oofLbN2yL
         GcQN4H2JcCX6+hUiao1uniJUG1MH4IOKnZYk9gwA95qAxSj8hQFYxxhBlrlIuo0Cdkfv
         L5xzPdf9lywDfK0+SedTF6bWU/MjndXm4L/0zOboY9n+d250gufCoisaWfT5sXPCxnAZ
         tsmYqxpaRu/KKthMpyYh8tAX/5TBbsnoOX1ErU7U9gwAvQxUz+ApvvWsOm4HlPMxHw/C
         hRcs3xYl/AE66+5unD6Ss5QTosulWOrHqlRFogp2THn3TLvqgNnzfiDGUokr6tHBo+Yg
         I5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=EBOM+6eb29YbMlznjWGhEHs9GKKRDmfjtwwJfVGdWBI=;
        b=YsCRQeog8lYSMvgl1hTcSAkg4n5fxIdwkag3Fn7dAKoz05WMBFRxpz7a+HQ+GRno1k
         WHjYMjY3EeT2MillrEY+YsDp8AXxoabQE9Wk+1EX/sMZL47qz/IZKvhKC+tuojx1jqdi
         xYuVDfQf8n3UTKO1UvAKbcPUAmDeUVGHFEBPQuZAGvNWVE+tDmHKsleiJPfJGRkpJPj7
         3lFbnxTl7wTbOG26HTJrotm7wqsRtFWYQAR8GXF72TCH2kiFHyUXwoqOjOb23b/ggwj4
         M+u5yKBa+ltBwXwa7l46JeX4r/SPk9kLUfWf95l+igkklZ7+m/+P5oqbh1FTdKhCVjOU
         fDlA==
X-Gm-Message-State: AN3rC/6kMQY4i6b2iCyTWNxCmWdE3E8PQUdU10SdvtS2e4FQuoq4D19i
        vnJ+7X449HZCOA==
X-Received: by 10.200.42.171 with SMTP id b40mr19813670qta.92.1494096570791;
        Sat, 06 May 2017 11:49:30 -0700 (PDT)
Received: from localhost.localdomain ([129.59.122.17])
        by smtp.gmail.com with ESMTPSA id 83sm6866347qkq.26.2017.05.06.11.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 May 2017 11:49:30 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v2 3/9] dir: recurse into untracked dirs for ignored files
Date:   Fri,  5 May 2017 05:46:05 -0500
Message-Id: <20170505104611.17845-4-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170505104611.17845-1-sxlijin@gmail.com>
References: <20170505104611.17845-1-sxlijin@gmail.com>
In-Reply-To: <20170503032932.16043-1-sxlijin@gmail.com>
References: <20170503032932.16043-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We consider directories containing only untracked and ignored files to
be themselves untracked, which in the usual case means we don't have to
search these directories. This is problematic when we want to collect
ignored files with DIR_SHOW_IGNORED_TOO, though, so we teach
read_directory_recursive() to recurse into untracked directories to find
the ignored files they contain when DIR_SHOW_IGNORED_TOO is set. This
has the side effect of also collecting all untracked files in untracked
directories as well.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 dir.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index f451bfa48..6bd0350e9 100644
--- a/dir.c
+++ b/dir.c
@@ -1784,7 +1784,12 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 			dir_state = state;
 
 		/* recurse into subdir if instructed by treat_path */
-		if (state == path_recurse) {
+		if ((state == path_recurse) ||
+				((get_dtype(cdir.de, path.buf, path.len) == DT_DIR) &&
+				 (state == path_untracked) &&
+				 (dir->flags & DIR_SHOW_IGNORED_TOO))
+				)
+		{
 			struct untracked_cache_dir *ud;
 			ud = lookup_untracked(dir->untracked, untracked,
 					      path.buf + baselen,
-- 
2.12.2

