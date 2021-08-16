Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92658C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 09:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7587461B5D
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 09:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbhHPJLA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 05:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbhHPJK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 05:10:59 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE297C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 02:10:27 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id n1-20020a9d1e810000b0290514da4485e4so17340398otn.4
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 02:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cGX12FXpmf/M6z0dVo0lxgRmsfcgb4Wt8eVFA3KuKd8=;
        b=MTTpIvqHVAhUJPhrg2g6GFjUE29s32K54n4kkDgX7IEXS3Vx/x4d702bObFsHcb6Il
         mQ+s6P5pzIkcCfa3woMcxoPWLq+zexwjgTyN/OcIIb7in1INoLYC78ZOc9Ik1qvEK/b6
         LWyLU1a0zcOiW8jQhPww/QEuZ6iVYrbltC+IG/4FIvaJZPNgNJxjRIA9GmNY4FLIK/Qb
         b2abQ6IWvXbi30poVckhPh2mgeowe4Q5PWURVfUTKyvNeRC9Iz09abojtc0ZtUg4USSn
         x6XmMX6lzqxdUhWQXRT+kJYJagfFMeHPUkkA/6XPS07t69W3IqWhH1CP418bIt73bvIH
         rVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cGX12FXpmf/M6z0dVo0lxgRmsfcgb4Wt8eVFA3KuKd8=;
        b=FEh7E7G54+a1FsLPN9pSi2ulqVfVPv8Syo8v6oFriY44pMeJU70jWzixJ+i3gmz1vd
         z41U9tbPU8tOZocGenqLayfTdJP88iK730CIwGxcp3goZX8DGl0a/tgLvAaB6vU5sSjG
         5Y3nCx4h+qhTPKKd+1m6m2luYC85VtxYTLSUjjGFaotiM+kglY26i2ce41GcmjlMTSHW
         2MA+sXSn4tZFr6YByW3/myAOXxUGgg4/KYSsuG/4btoOD2jGtdOwUqVb6xXSZGjUaNkh
         grWZt6YsQa7GlXg3qLX4MG8Mxt9S7e3NB3euR6/erUPmUp7r2X9nfSruxNeHZxzZZJx2
         Uywg==
X-Gm-Message-State: AOAM530BM0gO1EUc0CagUZ05Z/UZFQKKSHa+lr2P25UO7sSq24XkndvH
        pZZ3nK3ZPfDV5J2sO6rVFxjKbrcjH+M=
X-Google-Smtp-Source: ABdhPJyIYkF/aKWt9lUG11bjjc/m9Duc56N4BPPk+sU/PuhRNekt+HANYEnwKBO73oIMELW6FOVNdA==
X-Received: by 2002:a9d:6103:: with SMTP id i3mr12175315otj.277.1629105027049;
        Mon, 16 Aug 2021 02:10:27 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id j14sm128867oor.33.2021.08.16.02.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 02:10:26 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 try4 0/4] completion: bash: a bunch of fixes
Date:   Mon, 16 Aug 2021 04:10:21 -0500
Message-Id: <20210816091025.548095-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.48.g096519100f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These should be pretty obvious and straightforward.

This is exactly the same as v3, which has been sent 4 times, and already
included the minor adjustment to the commit message of one patch as
suggested by SZEDER Gábor, which was done nine minutes after in June 8,
but for some reason they had trouble getting into 'seen'. So I'm sending
it yet again.

Felipe Contreras (4):
  completion: bash: fix prefix detection in branch.*
  completion: bash: fix for suboptions with value
  completion: bash: fix for multiple dash commands
  completion: bash: add correct suffix in variables

 contrib/completion/git-completion.bash | 14 +++++++-------
 t/t9902-completion.sh                  | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 7 deletions(-)

Range-diff:
1:  4b73b26338 = 1:  e699c8be36 completion: bash: fix prefix detection in branch.*
2:  cb2fc1a7f2 = 2:  7e800faaf1 completion: bash: fix for suboptions with value
3:  ece06463a2 = 3:  523906fe1a completion: bash: fix for multiple dash commands
4:  f9db132cbd = 4:  1cb7457af9 completion: bash: add correct suffix in variables
-- 
2.32.0.48.g096519100f

