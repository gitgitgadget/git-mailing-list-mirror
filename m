Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B3FC433E9
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07A6164F6D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbhCPAyj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 20:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbhCPAyf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 20:54:35 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941D8C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 17:54:35 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so2774681pjb.0
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 17:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jv4NT1GMSWNRSVSILiXI6o7+Nq0aGTx3fZssmufEfAM=;
        b=Suw2o8Ejavq0Srmxz6iQ46dOnpllqWKhOetq8TzoeaNs6j5SFej8GyH2KxYNomvELc
         fxHcdQwiBUK25FURCxoEYFh7hS+MnQC78UD4VQwfEFu+HDamLXpW9iUo4hFE8oek6Esd
         68sUbDQOIATPG5nWMTi+Chpv9RqvqqFMdioLvzRCQHi56dp55USmpNmvU/dRKmhVWjAC
         RdtwuZTA5paFK6G0qZvqMf8/4/jA+mEwsiffZgk5nwqXnOlNubLFfpZJNO7MvuKmBFx9
         pSScNoE7XKxO3puc99WyGWKcMNBxMuJBuqYX2wwY4avHVQGnmbEBXHeQYefsXOTluWnN
         xL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jv4NT1GMSWNRSVSILiXI6o7+Nq0aGTx3fZssmufEfAM=;
        b=pXHF9j9l+qIozp0sssGZ7ah6iRahLCHTttJtHagEx/o1zpw/7ElfnGC1MJBqriqzgi
         YviL7qQkBpZqC9ttDcPT4hiuAMYOOG7L6ecdpV2L/IHaB+QWsphGqxd3XhrtjkabwDEj
         Ebc19VaDSazOX6ooPKxf2ArLeg0OWqq/D13MBFLP1oYP6utVfq4J2xilHnXqlbIvQOnK
         2IpY9zPZgMs2HImAV703HVL4f3GABCuxXb+9DyOuxQ5sQgU9EzAkwKvQdi7eoFRHGy26
         YsA8RP4gyf7nhx2KW/FeeNTfo5QHo4x+MxVDLRCcTFt/nbe5scTEWF2WX1J3F75bi79E
         SMhw==
X-Gm-Message-State: AOAM5320nG9+laSQ9cIUcNCHH2XeBRMEssBAOqJSx6Vk+J7S2EBIMxpV
        haDiHlgu6tHg/ECyGiTklYcrUBShQkM=
X-Google-Smtp-Source: ABdhPJxxoRyF0TFVliRM8GBOJ8pfHe0k8L/WZo8ocqAiPf8UT3L7o5OgeqCJqJn3V6Hjpa1JuhY56A==
X-Received: by 2002:a17:902:8507:b029:e5:ea3a:3d61 with SMTP id bj7-20020a1709028507b02900e5ea3a3d61mr7211218plb.71.1615856073192;
        Mon, 15 Mar 2021 17:54:33 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id y24sm14449791pfn.213.2021.03.15.17.54.31
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 17:54:32 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/3] git-completion.bash: improvements to _git_stash()
Date:   Mon, 15 Mar 2021 17:54:17 -0700
Message-Id: <cover.1615855962.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series modernises the _git_stash() completion handler by letting it
take advantage of __gitcomp_builtin(). Also, it fixes a bug with how it
offers completions when arguments are provided to the main git command.

Denton Liu (3):
  git-completion.bash: extract from else in _git_stash()
  git-completion.bash: fix `git <args>... stash branch` bug
  git-completion.bash: use __gitcomp_builtin() in _git_stash()

 contrib/completion/git-completion.bash | 103 +++++++++++++------------
 1 file changed, 52 insertions(+), 51 deletions(-)

-- 
2.31.0.rc2.261.g7f71774620

