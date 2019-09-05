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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ABF31F461
	for <e@80x24.org>; Thu,  5 Sep 2019 15:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732792AbfIEPrq (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 11:47:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42018 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731868AbfIEPrq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 11:47:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id y1so1468762plp.9
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 08:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fhEVlpDqPdKjKtPrLrVfFAjkD2iGcu6rZ2BXYwyYmfg=;
        b=Rh+/YbC63nPwqgkTGcarllmqrtn8umQzh6hEqzSG18PZquSrPfMifyOHdv4LwTTAEv
         ro68PLepUvk64sfnKkNUeUl4N4VdZ/2vHrgcx1FDHWQfOBAqXsj7b6q6UpOP9h7ruxIp
         tcC7su8QemRhjFgiDGaix9aEwv6PZ6J4LZIgAjRFgmbkqMJjN9mhjnRWwcnD70ufK082
         HYKnRvcrB7xY7nEhyhIs63hXdgvtKQVSJAW4fpd+lWYTOyVQdRlfeQ0v7bSTVjoHZrMM
         Q9YEKnxgtgLoZW600HsuNe1DJsvfiteT4KtVV20iQKwbYyhwNF1ZNxhyXBGkxxPv+ccM
         amhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fhEVlpDqPdKjKtPrLrVfFAjkD2iGcu6rZ2BXYwyYmfg=;
        b=hAs0UrfS/asdsMfpWO9crhZxwL1/dTqPpCQYH1BdVqSWyyC3usT500/u1xHTirg53d
         34yMwEv+yJ/YosWOfsPOfWlFfd9+BlT6tf6jGEGYXvFg0O1DYeTcb4izf2dp9RS76BUc
         rovRwhT7Sodv3dSvCsDqqOO3gJnptBKQaf+e7uDv2tBltvDZYiZbFio0/3mMoe24YeYY
         h1E9mbDaCXgkYcMIj0scCQgS0PSHnY/vzjD3CXEOM8cifc/R2sxH39zAC77u7fowcPHD
         I7BbkN2IfjDqEB2Wks37e19PSVugRFfhtFDiLMUDzmujNFubxNuVkjUk1VStY94WeIJu
         LtvA==
X-Gm-Message-State: APjAAAUtwaEoKsm0en4gQIrBZ9olNZDvfV3Ut/GSAqbvgAESHzwfhdcd
        vOql+coN7nHfACL0Nm6ydOOxS9GV
X-Google-Smtp-Source: APXvYqz/zbfMDwwniYtfI01d8wpFhCg9EUmI5ITco38bWge6mKjH/hOswSCODM8fXNqmRnEm/OuPoQ==
X-Received: by 2002:a17:902:b202:: with SMTP id t2mr4229327plr.303.1567698464331;
        Thu, 05 Sep 2019 08:47:44 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id x16sm2339867pjn.12.2019.09.05.08.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Sep 2019 08:47:43 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 03/12] dir: fix off-by-one error in match_pathspec_item
Date:   Thu,  5 Sep 2019 08:47:26 -0700
Message-Id: <20190905154735.29784-4-newren@gmail.com>
X-Mailer: git-send-email 2.22.1.11.g45a39ee867
In-Reply-To: <20190905154735.29784-1-newren@gmail.com>
References: <20190825185918.3909-1-szeder.dev@gmail.com>
 <20190905154735.29784-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For a pathspec like 'foo/bar' comparing against a path named "foo/",
namelen will be 4, and match[namelen] will be 'b'.  The correct location
of the directory separator is namelen-1.

The reason the code worked anyway was that the following code immediately
checked whether the first matchlen characters matched (which they do) and
then bailed and return MATCHED_RECURSIVELY anyway since wildmatch doesn't
have the ability to check if "name" can be matched as a directory (or
prefix) against the pathspec.

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
2.22.1.11.g45a39ee867

