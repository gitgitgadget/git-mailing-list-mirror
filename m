Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B7CC4338F
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 14:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1593B60E92
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 14:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhGXNl3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jul 2021 09:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhGXNl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jul 2021 09:41:28 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B7FC061575
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 07:21:59 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id r6so5969943ioj.8
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 07:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=hC1gjAPxGip7Eeg8jpAu7AzOKXHuwDXtd1ZOI7nJi1c=;
        b=cMccgjsFLKq110gA9nEDqR7c2OUF6wjNHA86Z+h7bQUpcQGuOWrmCommVmsGFaei0/
         K1EDT6PaefA+I8SwvTCC8mLZHXfrqcEJIk0ALnG82kqZIzFob58/jZZrjb0es699XayS
         fLSwtt0uRGwLVFSgj0+CxwisjWLP6Y4UYkD9qDGO9rVUOMCagcva90QyMv4KfD+0GEB9
         v5OrLTEhSduta2s9K4Whp6OE44eA6eXwd4Xy+Gxxs2LfqBJBgSrz8E9NsQOtHRqxisWd
         gFrD2izrY8v7V/C1QQYVkUgr6696Ct/zjJLDZJLwAu2Zk+kmHwhkIKYOg+lBrUVvG9lB
         XMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hC1gjAPxGip7Eeg8jpAu7AzOKXHuwDXtd1ZOI7nJi1c=;
        b=EhxlfVJTPM1yMJLBZTsXq5V+DV39Bobg56OTQ6v5jcrH8YAab94wFXwN6ALEmBVJTF
         hODloClVHHmOFK8IwiS9Yhl7lSfY7dExOfbmt+VbKi982FjLM50rWZEBFt+6xd1SrxAX
         nXFf/e+yGqZfyP1R+vh6xJ2z24T4+Yamirrzj5ZLIBryJp8ntpBAs69t2h9LExwq/Nnm
         gYDqU0RthM5E8uL0e4Kbk91mMjNjdemOWwxL3WteXA4JPMFzpsNU2cxj8zmQLS8rco8r
         YJ5eiPA0b0ZZ86g6+mcqUPKxy6aDhz+b+6MMrWdhHFdpkgJbqeQPCiT+xY6PtoMne0K5
         bgEQ==
X-Gm-Message-State: AOAM530OGEYnKHNiCsMsTUYfhkl3ATtlIuStjin8JfJMDVYrO5s7Xt++
        NN3YpXhph8a4+xvQUbgkcxmAvCoeixfOPyWI2jKaVU8yTLaMFWzy
X-Google-Smtp-Source: ABdhPJxlh94fS4G+y0KMLZuuFbDdRQPPnSyhj+JvQlO6b6dRqr5iwytW50y4vDBdu+ITL++w4tomtC1xr9ilmWZSyD0=
X-Received: by 2002:a02:9f89:: with SMTP id a9mr8675664jam.51.1627136518913;
 Sat, 24 Jul 2021 07:21:58 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 24 Jul 2021 22:22:26 +0800
Message-ID: <CAOLTT8RR3nvtXotqhSO8xPCzGQpGUA8dnNgraAjREZ6uLf4n4w@mail.gmail.com>
Subject: [GSOC] How to improve the performance of git cat-file --batch
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After reusing ref-filter logic for cat-file --batch, the function of
cat-file --batch has been enhanced,
but the performance of cat-file is severely degraded. So we need a
better solution to solve it.
its last version is here:
https://lore.kernel.org/git/pull.993.v2.git.1626363626.gitgitgadget@gmail.com/

Use google doc to show some of my recent ideas:
https://docs.google.com/document/d/1hyM-ecMd8C_TJ3OsOn46nMr8ZxCUxeK7HKj-bRkq3sk/edit?usp=sharing

Anyone is welcome to comment and suggest better solutions!

Thanks!
--
ZheNing Hu
