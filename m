Return-Path: <SRS0=wQ61=DL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC25C4363C
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 11:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43D75206A1
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 11:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIjF+9K6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgJDLUE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Oct 2020 07:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgJDLSb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Oct 2020 07:18:31 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDF9C0613CE
        for <git@vger.kernel.org>; Sun,  4 Oct 2020 04:18:31 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g9so3384010pgh.8
        for <git@vger.kernel.org>; Sun, 04 Oct 2020 04:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zpeu5BZO6jjorZ3Idz4lZxC7csLygtiYeBOXSKiYXNY=;
        b=OIjF+9K6ahCem27ShhofDdYnmDmu/sw98aNmcA2JKF9sYpLTo85DZt9iYWQiwK0o8a
         upMC9oecistk8OVWLHOT94w9+AeCOxR85eukn2M98kF6vplN9ve01CwqoPAVNhOFESOp
         KbSoGe2N9nfLq+3/aZR7GUQ4dkYNKWmwjboo/fqX49ZJOkM1C5mrRGvcu1xkGB69Q/lG
         g4POUPIvcmj9KsgjIExVcnQnjCcG/lB+C8GibtaKRBKdbpqTrzE05at9mh9NrIpm2WU/
         GWlo3xghb48gFEbWC+14iKVYoTyzwRwxYJVNByJxBuXfOPKihHF+bBeIhNplDbpwbAQq
         2YtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zpeu5BZO6jjorZ3Idz4lZxC7csLygtiYeBOXSKiYXNY=;
        b=Pj4UCEVW/pyNbi4cgAo6baYCh1C38O6EMj1pMQXPTIhkrEMFUJS4HJNAoN51aE0i7R
         vCivgbOvORSupBi4B86uoJclXEP86QJMs7zDedBP8bdDv3o4E3ly3zsierZXdTM68npc
         kuN36MeEPvlR+e16VaeEWaekUyrc248Wd1W+dNO1/J+KN+YVGLf/5nFVijtHXR5dD7An
         N8qcpizqdU9H2iBM0fIvXFeLWSXGLu8uKdcy/fnRFRGkC1MucwfWD3kg5fg5DlCHfm8P
         MOf43blcEt9XiOyoYVFgljbNlWRg+JWsDCNE9sOdeHcNV4sN/qXGQjREFezRaBJze4va
         tgwg==
X-Gm-Message-State: AOAM530zhMByo5kqkS7gnZwFTooVLG9Gojvec4PGiYVrJj/wg7fAf7oT
        XWvyrUlH4uCZM4lfOJc50c6WMmStxJY=
X-Google-Smtp-Source: ABdhPJx5DgC3keIlDBoIyM5QabkMMU+0pchYClO2XHNT7AKPF6NOddUyYuhzaxUeJfoqWv7nOFiJAw==
X-Received: by 2002:a62:7b94:0:b029:142:2501:35e4 with SMTP id w142-20020a627b940000b0290142250135e4mr11859177pfc.68.1601810310471;
        Sun, 04 Oct 2020 04:18:30 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id 78sm4298162pfz.211.2020.10.04.04.18.29
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 04:18:29 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/2] checkout: learn the checkout.guess config variable
Date:   Sun,  4 Oct 2020 04:18:22 -0700
Message-Id: <cover.1601810233.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.942.g77c4c6094c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a user does not wish to use DWIM behaviour, they must manually
specify git checkout --no-guess each time. Teach checkout and switch to
honour the checkout.guess config variable instead.

Denton Liu (2):
  Documentation/config/checkout: replace sq with backticks
  checkout: learn to respect checkout.guess

 Documentation/config/checkout.txt      | 21 +++++++----
 Documentation/git-checkout.txt         |  3 ++
 Documentation/git-switch.txt           |  3 ++
 builtin/checkout.c                     |  7 +++-
 contrib/completion/git-completion.bash | 15 ++++++--
 t/t2024-checkout-dwim.sh               | 11 ++++++
 t/t2060-switch.sh                      |  5 ++-
 t/t9902-completion.sh                  | 52 ++++++++++++++++++++++++++
 8 files changed, 103 insertions(+), 14 deletions(-)

-- 
2.28.0.942.g77c4c6094c

