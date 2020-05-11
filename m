Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F104C54E90
	for <git@archiver.kernel.org>; Mon, 11 May 2020 05:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58F31208CA
	for <git@archiver.kernel.org>; Mon, 11 May 2020 05:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4kaj9Yu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgEKFuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 01:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728848AbgEKFuK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 01:50:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ADEC061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 22:50:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h17so365510wrc.8
        for <git@vger.kernel.org>; Sun, 10 May 2020 22:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iq2O1E8C5BCz6qYlzRjx7WHAOgbp9wsAEQDcJ0I16ko=;
        b=O4kaj9YuXt0ajB3lEDCbeN5Sye23abKHr5zghsMw8nCHfSCTmKQKf8ptjh2DxyDCwp
         vpw6tnGTvy52NSC5RSlUcN2kkDoZJyfCLMMP5gf48O+3bwkIOD5Ozd9xHm+fC2eJWiRJ
         dXFwbSEIe/zpFIfd8P8lREum4SetfvY0LH8G4aOruGnf0iisWwc+0ltEHkEJK+XXLXZy
         u8Q2mty+YOz1SSrxY+40TLuXe2+OPKXXC0AtLbud1DoNXecS+125QSyKxDPYtEEzutqY
         JCpdLvcoEbGuOQDsXG1r9S3F/fI78mEKCyby6gSL8WZGl0b3OnWyzgJat/5LNQd5d/3v
         rQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iq2O1E8C5BCz6qYlzRjx7WHAOgbp9wsAEQDcJ0I16ko=;
        b=r3EfJDj05+4PAkbxtxXBFXyhZ0ixIH+Q0nWqhJcgraYbu4DNl3ZzMYAmiiocX6cxDd
         RQ5WdybAkcs9fOpf9ZOxezVgmVSnY2VgtwUcDp8jqHzCvGfipm9xAVBB0N8o+fNDKTEZ
         S+ssbYiEkQ/1FLAVGUbnnWZGiQ94djfiLsO4zX9Ck0X4BHyoUAa3gDquAMEpEgO1zI0w
         oyMFD2t59Ii2I9J4AVcKf6Ma/ErZ2/GxnAJcWFgjleUgI/z2wAbCR2IxH7hEmVFAUPBO
         /RJkJrOC3prj3+hSh2oAdk+wX6LpZZ0Zgi5BMaxW1amKJBKPvGT1BauGiCN5cnRef5yk
         lSQg==
X-Gm-Message-State: AGi0PubR1d/fz6816pK5Ee/ANNwxkljaNlK8D8+3Ir0w7nltSnCLmW4z
        /K1quCR0xWDs3DGpCASWN+1iB7nj
X-Google-Smtp-Source: APiQypLNEEuHd7fE0bbkuWAkzhkBjKUZlf/f1lNiGDmmDweP1Slyey+uP/9wogdX1jZqrkDVuvdxDg==
X-Received: by 2002:adf:94c2:: with SMTP id 60mr2988136wrr.366.1589176208817;
        Sun, 10 May 2020 22:50:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f26sm25050714wmj.11.2020.05.10.22.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 22:50:08 -0700 (PDT)
Message-Id: <19db9cfb68c762a262f3f3b6a0781cdc6bf49bfe.1589176202.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.493.git.1589176201.gitgitgadget@gmail.com>
References: <pull.493.git.1589176201.gitgitgadget@gmail.com>
From:   "Tom Clarkson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 05:50:01 +0000
Subject: [PATCH 7/7] subtree: document new subtree commands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Tom Clarkson <tom@tqclarkson.com>,
        Tom Clarkson <tom@tqclarkson.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tom Clarkson <tom@tqclarkson.com>

Signed-off-by: Tom Clarkson <tom@tqclarkson.com>
---
 contrib/subtree/git-subtree.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 352deda69dc..a5a76e8ce69 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -52,6 +52,12 @@ useful elsewhere, you can extract its entire history and publish
 that as its own git repository, without accidentally
 intermingling the history of your application project.
 
+Although the relationship between subtree and mainline commits is stored
+in regular git history, it is also cached between subtree runs. In most
+cases this is merely a performance improvement, but for projects with
+large and complex histories the cache can be manipulated directly
+with the use, ignore and map commands.
+
 [TIP]
 In order to keep your commit messages clean, we recommend that
 people split their commits between the subtrees and the main
@@ -120,6 +126,21 @@ and friends will work as expected.
 Note that if you use '--squash' when you merge, you should usually not
 just '--rejoin' when you split.
 
+ignore::
+	Mark a commit and all of its history as irrelevant to subtree split.
+	In most cases this would be handled automatically based on metadata
+	from subtree join commits. Intended for improving performance on
+	extremely large repos and excluding complex history that turns out
+	to be otherwise problematic.
+
+use::
+	Mark a commit and all of its history as part of an existing subtree.
+	In normal circumstances this would be handled based on the metadata
+	from the subtree join commit. Similar to the --onto option of split.
+
+map::
+	Manually override the normal output of split for a particular commit.
+	Extreme flexibility for advanced troubleshooting purposes only.
 
 OPTIONS
 -------
@@ -142,6 +163,9 @@ OPTIONS
 	This option is only valid for add, merge and pull (unsure).
 	Specify <message> as the commit message for the merge commit.
 
+--clear-cache::
+	Reset the subtree cache and recalculate all subtree mappings from the
+	commit history
 
 OPTIONS FOR add, merge, push, pull
 ----------------------------------
-- 
gitgitgadget
