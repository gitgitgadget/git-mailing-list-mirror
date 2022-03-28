Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F44C433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 03:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237869AbiC1DsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Mar 2022 23:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiC1DsL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Mar 2022 23:48:11 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEEFFD36
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 20:46:32 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso9920464otj.0
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 20:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=6Zp8DYO2Q1q2Lj/wn+LRdq6GmUZS97J7uWIhvhinLR8=;
        b=PP+aK/DdnP0vl7lFXcL0SOzVdZ+cEw8zO8KU20c5z7kjsCBLRP6ji7wfdQ4C50fEnf
         EkmbavvqGgJAnUBsFDtMzvSILhZjuixakHm4s33Uqi8fr1SZ645koqc6OZivNqfkMzmD
         hO2bMt5Cz/VGKIImlEoeT5PYnt9G38fpqjW2/2tSGsPzUvFV2yT48bPEz8SEmIHY+1ai
         WqUPPBRdrARVq0TOCdXhbIDll0m/8xSNaFOAexIod7eSU4nggCQycJd6EFXffk4/DDzo
         8f3zAZr/q82UazpjZ/A+JrpbUcUyLBtAHKoFSqNffcVYZKwt0/7+Av3+pIwW0VZXnPER
         +bAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6Zp8DYO2Q1q2Lj/wn+LRdq6GmUZS97J7uWIhvhinLR8=;
        b=N9aZkSmB6Txx+POX6u3ZIbxF/LhOt7wc1W5Ih9nl5GLw9mu9REXxr82hUQB1NEHL1Y
         FVIho6pQ6UAda/YEKOPFIEPGlMixA88o5tPnAxiNxI2dxIUh/oIVKd1KOtUqs7LS0n9Y
         d+JaSp307ePo8ciHeZ0xzqnbhE4HQtnBL/aaagf4yVXVxHF3qKKC2N3vHxFQjMf5O/or
         iYcmy02MpXy2wtvFGj/a8Pd1gK92zTnAa4yIi+kcAIRSvl2mT3Kma2SzStqZgJjMEKOE
         mURpQjHIE7fR7Z6PBY6l4kxZvcVwrE82TcI0qJmjg2JaFJV2gDl/PC3puBC996VFNg7u
         SaGQ==
X-Gm-Message-State: AOAM533mzHmKyqgpvLDh2e5bc/DDXgFyHjed3vBHkJpi3YbW88n0+bKZ
        px7Peieo6Tj7v8GxPBnLEYbn+xQ7yffkIjLS2B2AtRAtQpk=
X-Google-Smtp-Source: ABdhPJwseQiPuCKkLpXlya1p4gDEO15/fgyVSVcQbMt+fbfM6b8uL1Obo5gqed6hEs9MST30fvrBRwAnbWGgfhc+m9A=
X-Received: by 2002:a9d:6b89:0:b0:5c9:7b17:7cfc with SMTP id
 b9-20020a9d6b89000000b005c97b177cfcmr9361904otq.359.1648439191078; Sun, 27
 Mar 2022 20:46:31 -0700 (PDT)
MIME-Version: 1.0
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Mon, 28 Mar 2022 11:46:20 +0800
Message-ID: <CAJyCBORyNQX7u5=ZTdyHWyb63r-Cus4hb_yZingm4B=J4pjhkA@mail.gmail.com>
Subject: Add a "remove" subcommand to "git-sparse-checkout"
To:     Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I'm wondering do we have a plan to add a "remove" subcommand
to the existing "git-sparse-checkout" command set?

Because when I am messing with sparse-checkout, I sometimes want
to remove a directory from cone, and I have to either go into
".git/info/sparse-checkout"
to manually remove it, or "disable" then "init" or "set" the
directories all over again.

I think it will be nice to "remove" a directory, then "reapply" to get
the job done.

-- 
Thanks & Regards,
Shaoxuan
