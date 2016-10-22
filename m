Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42D5920986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756235AbcJVXcj (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:32:39 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:34310 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756207AbcJVXcg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:32:36 -0400
Received: by mail-it0-f42.google.com with SMTP id f129so12182641itc.1
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NLkEd61U6RiMldXKaxsKTuiG2DUYvUY+MOstJajRO4M=;
        b=UrufHs3MJ5TaG51MX/7gbGFMeJm3C5nnyZii7zHO78DN6SUm2GnyXjKmIgWVkW5Ltu
         Ag80qwNDZww39gnnH4mNDyWLv4+etmVwP/0FnIYgrWuMP8Kdil57wXGRbFLFEy2Amciv
         mGewMUIubaFBNsBTvwAggMwua4gsZQZtZPFVtxTEriklg/LXGiO5U2QGZXR5Jqe9WBlt
         uZScM5gNUCKZw4XYi42IXQvKZ3o6yjxCMMNlpOu/InG7kMjycbS88OF4CT9MP36egL4i
         KIq+Qc4Ru+Kop+AX8ZB/6gzTQBxw9mfKjSVBsAHDc4a804BEQ+uoVl35bKgTRrChTqJM
         w9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NLkEd61U6RiMldXKaxsKTuiG2DUYvUY+MOstJajRO4M=;
        b=LJNF20C1vaZF7vGeaX+Rye5YSQJ5Kre3aGn+51MzdtVJRtdjfPU9khgU9Bcr7TxvEv
         8vjbb0IsQ++dtJdvpFxFcw+LGf7RkSEdicUyBaBqzf4CMmivIGMBUUEXL/lfrCsQu8z1
         6pR0zp341T4TBg2TZ/iCCSH5Nc2faZroj5kmo0R13dMntIo7tyc/jqHzTnddd0Udke6F
         1VSSZ+0C4tiWUhmBKLUUoepqYvp24YqJXyivD1qP1WfcvrCw7642n25XJdv+AOJjKgqX
         1kGdmKQfqIcn3eOsZb5ec2QogOgKi8FlNnyyoiuJtv+0+q5Y7kA385tSWgEerqZfN9aQ
         xccA==
X-Gm-Message-State: ABUngvcY/jP8BuVkWY9avPlpGx32jXWyq0MJYVbvCUoA0la0vcWcw8P0mXPfhKNCoSZKeO+h
X-Received: by 10.107.202.69 with SMTP id a66mr8472257iog.170.1477179155522;
        Sat, 22 Oct 2016 16:32:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id m71sm1112850itg.1.2016.10.22.16.32.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:32:35 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 02/36] attr.c: use strchrnul() to scan for one line
Date:   Sat, 22 Oct 2016 16:31:51 -0700
Message-Id: <20161022233225.8883-3-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index eec5d7d..45aec1b 100644
--- a/attr.c
+++ b/attr.c
@@ -402,8 +402,8 @@ static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
 	for (sp = buf; *sp; ) {
 		char *ep;
 		int more;
-		for (ep = sp; *ep && *ep != '\n'; ep++)
-			;
+
+		ep = strchrnul(sp, '\n');
 		more = (*ep == '\n');
 		*ep = '\0';
 		handle_attr_line(res, sp, path, ++lineno, macro_ok);
-- 
2.10.1.508.g6572022

