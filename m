Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54511EE3F06
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 17:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbjILRah (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 13:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbjILRaf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 13:30:35 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB4010E9
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 10:30:31 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-403061cdf2bso33678565e9.2
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 10:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694539830; x=1695144630; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGLZDG45u80sd4JuCS1XmO732v/Nhixwl2/JhbF2oqQ=;
        b=W8iJDjmc1dDhmlBOwupjIJrrdiUaHykuvQWHn2BBOGvg/9wptQMQ96mYz5GCbjmT3O
         D19DXRpGJKwnBNrqDSpN4VWhgG7Yrc4AjCqvWZMNuTKF2C+XJBo5MUOdGG6MdbRyMfdB
         bxuU3klhANj6AoqMBsa/FlDr1mKZHemYG+Wqb9+7hOgpWWRdlfheZzlLP8GY1iI0x6wK
         lLBzIeBFSE+zC1BUb3TI3xL95NeE85uPnDIl/1ZAANfVCNYg8/dXlGcXrDGHGMOjgrX5
         o5mzhkfiXAazsE8/413yTw3M5FkhEdzCpxYY5NRXbX2SkZu7RblySC0V5rfaQx3SXJMg
         hLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694539830; x=1695144630;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGLZDG45u80sd4JuCS1XmO732v/Nhixwl2/JhbF2oqQ=;
        b=GiO55PyT8z/8BO4aWf8+LjjCOJWTyjBCrXujAsQ4q/ReHXANAPQOrr5if4qjWs/qw8
         DlzejhguuAzyngZOTGe9AAw6cM6RX6I9KIYufjb3d26iOkg/bjsdDmJpQJru8anQm0mS
         59poaZZPXAjZxUPrU0aB+wEwtDDNL6YQcyo+pmunTO0Wus8FQd8liku70j8yR93TtDBD
         K5XiMA/R6TnDcTE+j5X0bcTr6Zfu1XW7BIX5QNsX/iONLt03z8xaQg0cETscDsFTQsMw
         T/G61XVtVrRR/V6Y/afgotzh35FYzdjTX1g7F18yL4r4hZGre1HPywTfMS8C+ZcOWW+k
         EUpg==
X-Gm-Message-State: AOJu0Yz3wEhkBPSR7v6dSseC6Uyq0asZvC553kOz+6WfW44QwO7Fnphh
        4dbUpe6cNNG1CpK266VnnR7HPTPDN7w=
X-Google-Smtp-Source: AGHT+IHK0Cy6j5tK5hmtvOTW0jZpBOzz/+1xndrBVO63afvXYj9LRJgXB0Aim17wURJEPRGRbUtsoA==
X-Received: by 2002:a7b:c846:0:b0:3fc:3e1:7105 with SMTP id c6-20020a7bc846000000b003fc03e17105mr100269wml.24.1694539829715;
        Tue, 12 Sep 2023 10:30:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n21-20020a1c7215000000b003fc16ee2864sm13330700wmc.48.2023.09.12.10.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:30:29 -0700 (PDT)
Message-ID: <a31d7a29af91284f6b8720c810a88076edf5cdd1.1694539827.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1583.v2.git.1694539827.gitgitgadget@gmail.com>
References: <pull.1583.git.1694108551683.gitgitgadget@gmail.com>
        <pull.1583.v2.git.1694539827.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Sep 2023 17:30:26 +0000
Subject: [PATCH v2 1/2] completion: commit: complete configured trailer tokens
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Since 2daae3d1d1 (commit: add --trailer option, 2021-03-23), 'git
commit' can add trailers to commit messages. To make that feature more
pleasant to use at the command line, update the Bash completion code to
offer configured trailer tokens.

Add a __git_trailer_tokens function to list the configured trailers
tokens, and use it in _git_commit to suggest the configured tokens,
suffixing the completion words with ':' so that the user only has to add
the trailer value.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 133ec92bfae..b5eb75aadc5 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1677,6 +1677,11 @@ _git_clone ()
 
 __git_untracked_file_modes="all no normal"
 
+__git_trailer_tokens ()
+{
+	git config --name-only --get-regexp trailer.\*.key | awk -F. '{print $2}'
+}
+
 _git_commit ()
 {
 	case "$prev" in
@@ -1701,6 +1706,10 @@ _git_commit ()
 		__gitcomp "$__git_untracked_file_modes" "" "${cur##--untracked-files=}"
 		return
 		;;
+	--trailer=*)
+		__gitcomp_nl "$(__git_trailer_tokens)" "" "${cur##--trailer=}" ":"
+		return
+		;;
 	--*)
 		__gitcomp_builtin commit
 		return
-- 
gitgitgadget

