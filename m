Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB6961F405
	for <e@80x24.org>; Fri, 21 Dec 2018 13:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390557AbeLUNRk (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 08:17:40 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43207 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387590AbeLUNRj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 08:17:39 -0500
Received: by mail-ed1-f68.google.com with SMTP id f9so4623034eds.10
        for <git@vger.kernel.org>; Fri, 21 Dec 2018 05:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c+/BCnXGXJN1boqBzB/q631gRwtpWa74PMbkPMOlK1I=;
        b=Ah3etzwEUdZApWBUfWDYMRF74GPH63Aemntk923YFGGmBMQRgLL97304YCgLDz+XPD
         znBtR/k4zSFWYaTVdqKEf3aHm9+7hoYqESozToD68wkWbCCJy+7Bzm3cCPIn4ZXCy1bQ
         VRGL9GySvma1hEUwXni6Uw6zN3rgqIURy8kpyBswoIuBGNzv7St0sj2qUKIeMw+nOdKC
         SzbVEM09vIHz094c4pZf/fzvFOCExR/AS/kim1jSpE0ScVmpcWELRhU7ROnawAGt22iq
         Ziblf862F7ZxiOk+ADYqa26A4kDVPRJPSN/yOkdFgCqjWaWV/5hzRjeIlCesFO5IJYm+
         XpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c+/BCnXGXJN1boqBzB/q631gRwtpWa74PMbkPMOlK1I=;
        b=hszcNn4yLyRjZDd36P32MAi49m2GFGIRZb9PTjZsE83o2+vHNlYzbo+iorDlN0nCIH
         BB8jLTb6DU8Lku7mm31ngscjsaNjSvGQ/Y6lukS4X2+y4rPKhjNzixSlBjDCEnFNo053
         lHfkchgY27ru20zYeb2pOwnKWK7JnnNJv0g36KWlReY+iQI74ndiWG5/8Q1WXtuR00Uf
         hSWy6zNKhiZqUW37ey5bXdr+gWry5/FxEYRNAtrYgPa1paxLi43mTrCN35zqzR0TagK6
         pCmCWXgnhKGvq3DGEzf/g7eDd1EEUKJw0gv/Y/kHJhnS0dA1G1PzcwwObyULtOJKSb1F
         fbbg==
X-Gm-Message-State: AA+aEWb1tQMFO+Rxl+fldMzdvM5u8NzA6myicVpZdXpo4jKsI+KB6fwm
        iN/A0356Vfdd2gLY/1GnPsiEmITb8SQi8Q==
X-Google-Smtp-Source: AFSGD/WL508o11Ti0+y7MhzmwjEmnd+FsNKQG8lQhjJ15YwbxLy9HGLCr84rZ9VAswrBxqg/HyvIPg==
X-Received: by 2002:a17:906:2496:: with SMTP id e22-v6mr2085419ejb.84.1545398257835;
        Fri, 21 Dec 2018 05:17:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c11-v6sm3548996ejm.67.2018.12.21.05.17.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 05:17:37 -0800 (PST)
Date:   Fri, 21 Dec 2018 05:17:37 -0800 (PST)
X-Google-Original-Date: Fri, 21 Dec 2018 13:17:32 GMT
Message-Id: <4c5f87b9dc245bf27785aa5559d4b35d87c4bcbf.1545398254.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.24.git.gitgitgadget@gmail.com>
References: <pull.24.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/4] rebase: avoid double reflog entry when switching branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When switching a branch *and* updating said branch to a different
revision, let's avoid a double entry by first updating the branch and
then adjusting the symbolic ref HEAD.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e1dfa74ca8..768bea0da8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -438,10 +438,11 @@ static int reset_head(struct object_id *oid, const char *action,
 				 detach_head ? REF_NO_DEREF : 0,
 				 UPDATE_REFS_MSG_ON_ERR);
 	else {
-		ret = create_symref("HEAD", switch_to_branch, msg.buf);
+		ret = update_ref(reflog_orig_head, switch_to_branch, oid,
+				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
 		if (!ret)
-			ret = update_ref(reflog_head, "HEAD", oid, NULL, 0,
-					 UPDATE_REFS_MSG_ON_ERR);
+			ret = create_symref("HEAD", switch_to_branch,
+					    reflog_head);
 	}
 
 leave_reset_head:
-- 
gitgitgadget

