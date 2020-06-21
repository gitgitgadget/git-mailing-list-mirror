Return-Path: <SRS0=gxdb=AC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736A3C433E0
	for <git@archiver.kernel.org>; Sun, 21 Jun 2020 20:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BEE52528B
	for <git@archiver.kernel.org>; Sun, 21 Jun 2020 20:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tmn1hbR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbgFUUwD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Jun 2020 16:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbgFUUwC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jun 2020 16:52:02 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E5DC061794
        for <git@vger.kernel.org>; Sun, 21 Jun 2020 13:52:02 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id j10so2651940qtq.11
        for <git@vger.kernel.org>; Sun, 21 Jun 2020 13:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=d07tyvJhylJ5T9cq/Ncp2MU3dsuZKyudIqLSuUC6Wns=;
        b=tmn1hbR3QDIn9QroqssJeZnENHyRhV01hGP8PqhhJZXEwmK8pOQdbUlRD1YZByw9A1
         wXAFz360z1OE3RVO6I1dSRoKxzpj5c3/umnHmnYdxLIL8hiT4LcmF0Ss/+y8XBzGXdzg
         2v/FBxoqNrWOzTogWxE4+Huq4aB7U6a1M4rgsgiMjFHIi1BXR22L+Ao2OrDAu2OPRGMs
         qnecTbTOQvfZFNATy3E7jnPVzScujfuWjXlSNBQgHLBK1JxWDDxvUPak56co9MdmHTKf
         yRgnPwU/qlZJxuGvXhcmoECJhbdkCgV7nTCyoVrNKBn+T7Cmu/iwomUILqfsrZCuTcFA
         6mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=d07tyvJhylJ5T9cq/Ncp2MU3dsuZKyudIqLSuUC6Wns=;
        b=IvpcqFyu1J8idinym6f2BBH0PIx1QpzWVMPIBnBB5g/5EqYxnRPIkEKBCGKEGSiXBl
         IBxG7s8br/jkOQyNCvOiBV3W0gohy8ugAmWAWB7DeN3HW1/SnmVezUg/sXf53CXzGwM6
         N0pClVj8lx79mn25XsytuCH+Uz3S5B/EXHBbhaoR3QVgIhWuD7D5j5nMiGTdYBB5TXgS
         +gSYX/cAWRR2nemyvN0PauFQBwDJyuSK/qCuTaLf1a9bjP3EeN6YxdMCX1qxxw5Dll7Z
         4UlH4T2FIBk1B0Y3mIyKE2iJXQIwO+5QLelVqPOsXQGbhy9swv8qD1BfUs/l2rSAbpRJ
         e1xQ==
X-Gm-Message-State: AOAM531OQ8y/6/wJuPzdF04tkeFo/tS9fGlA3vdvExviZitzweQiGsuo
        FoOh35BKgX3n6GO8wmdxKRZ+y9FJ
X-Google-Smtp-Source: ABdhPJz7qxsZntXSFSgdQvEexCPIXg0eimL/loO42bVHSyAyLgf72bkSbs0Pan6MIFmufkyy4NIMCw==
X-Received: by 2002:ac8:348f:: with SMTP id w15mr3373391qtb.79.1592772721194;
        Sun, 21 Jun 2020 13:52:01 -0700 (PDT)
Received: from flyingpig (gmlyon2002w-lp140-01-64-228-9-12.dsl.bell.ca. [64.228.9.12])
        by smtp.gmail.com with ESMTPSA id o4sm3972774qtb.17.2020.06.21.13.52.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 13:52:00 -0700 (PDT)
Message-ID: <3fe48de84e2803cbd6c28ba0104230a70ec50087.camel@gmail.com>
Subject: Change `option` in `__git_ps1_show_upstream` to a local variable
From:   Black Lamb <notaflyingpig@gmail.com>
To:     git@vger.kernel.org
Date:   Sun, 21 Jun 2020 16:51:59 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `option` variable in the `__git_ps1_show_upstream` function in
`contrib/completion/git-prompt.sh` [1] is not a local variable. Can it
be changed to a local variable like the other variables in
`__git_ps1_show_upstream`?

[1] 
https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh#L131

