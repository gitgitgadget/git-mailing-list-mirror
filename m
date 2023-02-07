Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02450C64EC4
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 23:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjBGXws (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 18:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBGXwq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 18:52:46 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BC82C67E
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 15:52:42 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 203so11941723pfx.6
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 15:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hPbpiuMbdLh1g1U9z/rq4AzfvOLGPsEnctMgHTxbHNo=;
        b=qJ5qvYpviw1oYTycHmb6wWZ7nb3WoLW+VqvrCWCD5ta4+EfTMI1vP9IytE60n7E+zX
         qWlCFbOeQaonj/yxsJrTFmYD2Lo99SVkZwIkrMRAhK+Sl06hkS8W+uzG9Woi8jXIni4K
         TMOTpwnA03L4caACCS9W7R1ER+oDS/Ax5ZV92QAnTjxC1HFKTa+yWKVBrmJePRWvzDJT
         HnL3cZOurJSvG9bcjVQDgTRlloTdpEloxjwjobPrvyJnWv/xtDDZMP52vt6i/a8j8LBD
         irzgx5n6Cg0k7bP8E+GHYIWvNkzOqDULBSBmvaNN7jetJ/s/ACzWmrq0Uf20vBb1IbU4
         JQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPbpiuMbdLh1g1U9z/rq4AzfvOLGPsEnctMgHTxbHNo=;
        b=mj4Fh25pAnZLrFFygat/k99NnX4CsNW836TkISIrr9y6jzqM25c4VVwmoryQB/GElI
         mKZ/MtGNiyB3hNq7qC/QjsGYLlNWe3DDyqyZYkIUU3Uud7e40fU/IYc2tlvhoeVo9pMI
         kpbptHj5bEK724CvvsUXTFcDm7o9b539qkKHQc+u/0mMMMPcVigJeayry3xBHmq7KjMA
         ystzYsXLZWBw7xH/CDS01+ADfUH9c3C2rTpXibZTgrAH2sewLfGs5XlP2fncd+XW05jz
         Gvu1Zb+JCmcXBWVwD+cM4EGJcZQ7X9znvsK4jM5T7+KDFevh8Q8WyeiOMfTOqQzGp7JO
         b88Q==
X-Gm-Message-State: AO0yUKU7tf95sXiKz1P5oaXkkkS3DH0zYhwl1kigLG6XJ0syasKKZ7lW
        5kFB4LrNxIUbR2KJaX84Jd79QUfdzro=
X-Google-Smtp-Source: AK7set/xwE60rhsbzcQltLEi67iHBwQ7Hdh6u6x50KFsaV5d8gxIhZ0Hxn9MJih6cHBcI8qEtwJ6ag==
X-Received: by 2002:a05:6a00:1993:b0:594:1f1c:3d30 with SMTP id d19-20020a056a00199300b005941f1c3d30mr656906pfl.5.1675813961825;
        Tue, 07 Feb 2023 15:52:41 -0800 (PST)
Received: from kir-rhat.redhat.com (c-76-104-243-248.hsd1.wa.comcast.net. [76.104.243.248])
        by smtp.gmail.com with ESMTPSA id x16-20020a62fb10000000b005813f365afcsm2554863pfm.189.2023.02.07.15.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 15:52:41 -0800 (PST)
From:   Kir Kolyshkin <kolyshkin@gmail.com>
To:     git@vger.kernel.org
Cc:     Kir Kolyshkin <kolyshkin@gmail.com>,
        Roman Dodin <dodin.roman@gmail.com>
Subject: [PATCH] remote: align columns on -v
Date:   Tue,  7 Feb 2023 15:52:38 -0800
Message-Id: <20230207235238.1850757-1-kolyshkin@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, git remote -v produces a misaligned output when a remote name
is more than 8 characters long (i.e. longer than a tab step). Here's how
it looks like:

giuseppe	https://github.com/giuseppe/runc (fetch)
giuseppe	https://github.com/giuseppe/runc (push)
kir	git@github.com:kolyshkin/runc.git (fetch)
kir	git@github.com:kolyshkin/runc.git (push)
lifubang	https://github.com/lifubang/runc (fetch)
lifubang	https://github.com/lifubang/runc (push)
marquiz	https://github.com/marquiz/runc (fetch)
marquiz	https://github.com/marquiz/runc (push)

Let's find the maximum width and use it for alignment.

While at it, let's keep the \t in case some tools depend on it
for parsing (there will still be trailing spaces in the remote name).

With this change, the output is like this now:

giuseppe 	https://github.com/giuseppe/runc (fetch)
giuseppe 	https://github.com/giuseppe/runc (push)
kir      	git@github.com:kolyshkin/runc.git (fetch)
kir      	git@github.com:kolyshkin/runc.git (push)
lifubang 	https://github.com/lifubang/runc (fetch)
lifubang 	https://github.com/lifubang/runc (push)
marquiz  	https://github.com/marquiz/runc (fetch)
marquiz  	https://github.com/marquiz/runc (push)

Reported-by: Roman Dodin <dodin.roman@gmail.com>
Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
---
 builtin/remote.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 729f6f3643..116417574d 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1245,13 +1245,21 @@ static int show_all(void)
 	result = for_each_remote(get_one_entry, &list);
 
 	if (!result) {
-		int i;
+		int i, width = 7;
+
+		if (verbose) {
+			for (i = 0; i < list.nr; i++) {
+				int len = strlen((list.items + i)->string);
+				if (len > width)
+					width = len;
+			}
+		}
 
 		string_list_sort(&list);
 		for (i = 0; i < list.nr; i++) {
 			struct string_list_item *item = list.items + i;
 			if (verbose)
-				printf("%s\t%s\n", item->string,
+				printf("%-*s\t%s\n", width, item->string,
 					item->util ? (const char *)item->util : "");
 			else {
 				if (i && !strcmp((item - 1)->string, item->string))
-- 
2.39.0

