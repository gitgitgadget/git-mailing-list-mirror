Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB529C433E2
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B72C20760
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8VbKYlQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgGICQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 22:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgGICQy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 22:16:54 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479EBC08C5C1
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 19:16:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f139so262146wmf.5
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 19:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ApQ+V89A/zq8C/Qw2GSH4PzXeMWH/yQZMIZhPI31emo=;
        b=b8VbKYlQ3l6XFEDuiesiOHovnsgTer8MFPIMekll43aJT1SSEXBfZMfW/lf5akbxk/
         A087RQ+sGvJPAv9cVEI2oSmQn4wVyT2ATnvtft4bO2JKfOXlyJM/tjqW8hhOAT90HZ7k
         z1hZPvOMvEM4/oi125i72ZChL/vfbXtPzBIsdlbVrvsooJuEyJdey1wP/0AU272NBwPO
         ThGzp/kcUg7XHtmavUsy5ncvivFL882uttzjaIQHQN6FSY4ClHVarwRhwXcdDWGoznv7
         b7UEGgtXayevPGT/YvTw4vBPynlndJ+NFc2+TJywO+XHJMPkwGPe5FA+QPOLDV+75tIk
         q6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ApQ+V89A/zq8C/Qw2GSH4PzXeMWH/yQZMIZhPI31emo=;
        b=MlRkxyh6Wev8iNPzWzwQJ/1Fes4PZz7DZDbFxK3zsx0CC4LHCcaAX/N8b81Yodcg8l
         KoZQl2I/F6o6DrS4pvBCblx7i6WCL+Mib49D7LuvKwZUfB8KJrVjBmyMYpjAtz608eyy
         pFRGys31eAHUq62f31HHRh6G+gwmC+xFNTJHp0OndRT/GPu4Z2PpFndpw+IswFjmPJP9
         cOchiC9uXtXBcCyLFqQYaaBcm3fBYk39vlhuFZpdTN5daos2Mj9QS3X/f5cWHcJHfIL9
         2CeWOhGt0ajTzjujmjejJWXr023SwqpEU/shiE3ZRQAz84vdHahC4SLNvfQc0UrRlNyq
         ReYA==
X-Gm-Message-State: AOAM533KZ29dza8i/F5999unCeus7zv/A1Y3OY1uV1ohtYaPB830tbl6
        EhHNNCQc/fzDa3IrpzSO1doGCaPc
X-Google-Smtp-Source: ABdhPJx9ZU1y3AuSKd+UwKNo5D6wXBBHtpygK/3q/nqPk4clXw+bzNUE3mHVRr3RM62GRxzS0KE23w==
X-Received: by 2002:a05:600c:218f:: with SMTP id e15mr11658791wme.187.1594261012803;
        Wed, 08 Jul 2020 19:16:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j16sm2968503wrt.7.2020.07.08.19.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 19:16:52 -0700 (PDT)
Message-Id: <cf934ddf33e94871bd8b7fcba1c420c89c88e6d2.1594261008.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.590.v3.git.1594261008.gitgitgadget@gmail.com>
References: <pull.590.v2.git.1593747509.gitgitgadget@gmail.com>
        <pull.590.v3.git.1594261008.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Jul 2020 02:16:46 +0000
Subject: [PATCH v3 4/6] git-rev-list.txt: tweak wording in set operations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Lawrence Siebert <lawrencesiebert@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Tweak a sentence to make it a little more readable.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-rev-list.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index aa95334a79..f2b83df2fa 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -19,12 +19,12 @@ given commit(s), but exclude commits that are reachable from the one(s)
 given with a '{caret}' in front of them.  The output is given in reverse
 chronological order by default.
 
-You can think of this as a set operation.  Commits given on the command
-line form a set of commits that are reachable from any of them, and then
-commits reachable from any of the ones given with '{caret}' in front are
-subtracted from that set.  The remaining commits are what comes out in the
-command's output.  Various other options and paths parameters can be used
-to further limit the result.
+You can think of this as a set operation. Commits reachable from any of
+the commits given on the command line form a set, and then commits reachable
+from any of the ones given with '{caret}' in front are subtracted from that
+set.  The remaining commits are what comes out in the command's output.
+Various other options and paths parameters can be used to further limit the
+result.
 
 Thus, the following command:
 
-- 
gitgitgadget

