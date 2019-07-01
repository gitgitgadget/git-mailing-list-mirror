Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69BCE1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 20:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfGAUUq (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 16:20:46 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:45341 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfGAUUp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 16:20:45 -0400
Received: by mail-yb1-f202.google.com with SMTP id y3so963926ybg.12
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 13:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JdDhJ4Uf2SlYgtWqySb3cKF6BNzumNx1IauuV4GcFIY=;
        b=dEvP6cQuupXLAg1DNnU/cO0OO0hteU6TAU0RhG0u4St6K4XQxateTH3VuGGq7Stmmv
         wA2vqIgSTeBWyavvkru5RduhLsFegURSdIBA/Aw2FiHtu8CCMpNtio8quFg3zYibGNRS
         ir/dBpeyzOjebVc5AtJFoumKc+u1jubj6aejIfjxwYre2KkgSvs4zZ9ydYOFC5izNWXm
         ltmmlKumylw/eSMc5Yh8bm4WdlkTvRvcWKnp58gwdz83X49jWfGTqz0650AOhTpZwaOe
         soTNLWr8fItfroVwlcI9w0/lgPB5jAgyeqzhIWuq+TRr8inUgfK7L0U4RiROrVFN1RW9
         VCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JdDhJ4Uf2SlYgtWqySb3cKF6BNzumNx1IauuV4GcFIY=;
        b=KqHlWRdaPND1PJDXUMl+iHiiAVNmjdPW5FLpzquuvz6skX/ZHCm33v8igkRp1JpZ8w
         TqPLX7zJYCW5zavk9xzfvSMHOWdCuZDXgWQSVIHc7htyVdOPO83R0JIHTakQKuXPeWCw
         jY/Ai+iS6MU5LhuobhRrO3VslACW2bx1JQfmp4kXHVuSfSzvh2d+vuBUZdfT1qLWPVCB
         eUkxEmLFXVgxFmR+EtME5dCh4QDrpCs5M2gW2PhHg4+CYk8yiiIbsOo5Ndihh5GPvRe2
         e8htjX12e4kNeNX8D5nEmI8NXqWWbCSPmKCc7iXsMT6fo8+uPjXEcucLUsn1rvoIGql0
         S/ow==
X-Gm-Message-State: APjAAAUj+W0blYThHqCA2crpH1U/aPtwQv9geuDgRH86O0taYgRBoC8A
        h7tkfg4NZRn3o42wdCe6SYLyOfRPLEAfcb/BhNBJFzcrRiZrUkQa7UC/kQUlJMT8q2RBRkp9UFV
        oVnmzJ1Ot11cw5lKlYPHRcpaUMTOddDItkVFN2gQjiUoXStbmOlKoWq0V+6X0omQFUiWNjon0KQ
        ==
X-Google-Smtp-Source: APXvYqyWWRw65u90WMB/NYYZXtTzTFxhrB3FNW27ubAAJLoumS653JzXj0znYTC8Bkfid0rS7+mtZEsgckblLe/QZKA=
X-Received: by 2002:a0d:d74f:: with SMTP id z76mr15433670ywd.40.1562012444665;
 Mon, 01 Jul 2019 13:20:44 -0700 (PDT)
Date:   Mon,  1 Jul 2019 13:20:10 -0700
In-Reply-To: <20190701202014.34480-1-emilyshaffer@google.com>
Message-Id: <20190701202014.34480-10-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190701201934.30321-1-emilyshaffer@google.com> <20190701202014.34480-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v3 09/13] walken: demonstrate reversing a revision walk list
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The final installment in the tutorial about sorting revision walk
outputs. This commit reverses the commit list, so that we see newer
commits last (handy since we aren't using a pager).

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/walken.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/walken.c b/builtin/walken.c
index b334f61e69..03a50158fb 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -61,6 +61,9 @@ static void final_rev_info_setup(int argc, const char **argv, const char *prefix
 	/* Let's force oneline format. */
 	get_commit_format("oneline", rev);
 	rev->verbose_header = 1;
+
+	/* Reverse the order */
+	rev->reverse = 1;
 	
 	/* Let's play with the sort order. */
 	rev->topo_order = 1;
-- 
2.22.0.410.gd8fdbe21b5-goog

