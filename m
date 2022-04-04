Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C303C433EF
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 23:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbiDDXKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 19:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237414AbiDDXJu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 19:09:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666A75714F
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 15:42:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b16-20020a253410000000b00633b9e71eecso8915753yba.14
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 15:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xYKVB55lGdTGEsY3DO9An39jvBteNgMSRK4w9o0pjNg=;
        b=Izjp0wRB3Qg4beeIWVNiPHJQIi+CeyyX5fsnGCOPyQkjlFTYfZACMikaI0XSbv6aQW
         lKQ2JYiM6HH0/2Fn1T/7dj2nw2ak9x4gA8/I9EEgMcUrSBhwiibkLxqyzcLCu1KCkRil
         +w28rti+TTspgUZqH2dF1ENXI+nfdvYhphyu+IMR4AJGftVuCEcgj/Myx8/Dk9Ybfudr
         Z+VUoGzD5vgWumogWrzW+2kuhFR/I/pWpiH8ubvCuOwsKcWU15NN251JKLBuVlLM+dew
         M9R2NaJBu7FaTD3ybhAHJ2csclcXxEARSVIq25r9wyEU2yE8pIco+SGTkctdA2dRpUQW
         KwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xYKVB55lGdTGEsY3DO9An39jvBteNgMSRK4w9o0pjNg=;
        b=mEC1BkmGEF+rsfObBI0vYs3E3nVgcE2EPObQVsQMU75cxUXRrW6WmLsL+pUGGl8n9V
         yMQ6VjPLzHkVv3TBzjc4dNd+Oc23HzEG9TBhpHZT/gMm2N69IfPB0ifF9GAJecPes1BI
         9Sq4yW5CGpGcwyPe+v4tv38U8CHNCev14I+f6GqXFuHs1qSnLpGH4tvFj6JIVKBIzh8l
         Wfz/7NfpB1qU8vZpvbTKkBSvZWiTzL+fKX6C6MtHd5G7ZsrXZbgUP7Q7hk6b/zETKXhl
         3Mh/kCvTF6sJo8Lacr0xBLGlRg9ygc6V+bnrITOQv9Bfn690QJEy3+hIrk02TdTecz+R
         qXcQ==
X-Gm-Message-State: AOAM531HPFvj+AFckWk004g43YQVuXvQf1+jCnKZjUleUsNAhXuEGUib
        hKOlI/2eNhiGA6C7vZojymaj8MLA4sgYLt3sXU8izXNW7yyBfDyfibRphz2+KF4SMKcTW7CvFYE
        psf4CWcdermWMf78PdifgDOabzLq24F8t7/HVYj40rffJk7NHE62PvV8qgdQPOVQ=
X-Google-Smtp-Source: ABdhPJyJhaLnCF41Y8olSAjwMRF3ADKxRMerim1bMJXPvEUpR2ixt7gZLEmGC4D+soqFbapy9OGCQbuF2oOk4w==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:dfc5:ffd9:354:5789])
 (user=steadmon job=sendgmr) by 2002:a81:10c4:0:b0:2eb:88a3:5827 with SMTP id
 187-20020a8110c4000000b002eb88a35827mr347450ywq.338.1649112146579; Mon, 04
 Apr 2022 15:42:26 -0700 (PDT)
Date:   Mon,  4 Apr 2022 15:42:24 -0700
In-Reply-To: <YktP0LltNKq7JZZs@google.com>
Message-Id: <9ce4dadf140204e934f7025bb91385c376118940.1649111831.git.steadmon@google.com>
Mime-Version: 1.0
References: <YktP0LltNKq7JZZs@google.com>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [RFC PATCH] ls-tree: `-l` should not imply recursive listing
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        gitster@pobox.com, dyroneteng@gmail.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 9c4d58ff2c (ls-tree: split up "fast path" callbacks, 2022-03-23), a
refactoring of the various read_tree_at() callbacks caused us to
unconditionally recurse into directories if `-l` (long format) was
passed on the command line, regardless of whether or not we also pass
the `-r` (recursive) flag.

Fix this by making show_tree_long() return the value of `recurse`,
rather than always returning 1. This value is interpreted by
read_tree_at() to be a signal on whether or not to recurse.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
I believe this is the correct fix for the change in `git ls-tree -l`
output. I would also like to add tests in a future fix, but I do not
have time to add them today.

 builtin/ls-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 5dac9ee5b9..e279be8bb6 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -255,7 +255,7 @@ static int show_tree_long(const struct object_id *oid, struct strbuf *base,
 	printf("%06o %s %s %7s\t", data.mode, type_name(data.type),
 	       find_unique_abbrev(data.oid, abbrev), size_text);
 	show_tree_common_default_long(base, pathname, data.base->len);
-	return 1;
+	return recurse;
 }
 
 static int show_tree_name_only(const struct object_id *oid, struct strbuf *base,

base-commit: faa21c10d44184f616d391c158dcbb13b9c72ef3
-- 
2.35.1.1094.g7c7d902a7c-goog

