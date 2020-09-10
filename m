Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691A0C433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF1621D91
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="VFVHOvhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgIJTRv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgIJTRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 15:17:09 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278EBC061756
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:17:09 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id c17so4806227ybe.0
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:from:date:message-id:subject:to;
        bh=h2vDcvlIr4BYmjqxz9k8Jce3rPfht/vpsAmz6smZ7AU=;
        b=VFVHOvhwaHVYQvwA4+BqkTwiwsuXDVjVF5XD8Be5WEj48IO6qoX/NO+Ld7pSirqcgo
         +xkzC48kaNlJblEWDUB7LnDN6pMe2q4VlnbUx9cESTXPkBNXfa9oIFFPNbivSOqdox7T
         U3h1giz3/jgSHkU8CoHSlNTLjHpetVx8uq9MxdlmTcTwTMEqF7jgyrBbLg3o+tubENk1
         K5YWFWbqQrVSqtuesXZPrjsOkCwzKD0w0Vf4C3TANqDByIgWEcU2TVylIhetTfzhhn7q
         5QBJxx2IUCV7sUucfE+DXzbjkV6XiiVSTLq3m5S2zMtRIWLk+8VhKIQKq3WSUeXuPX6a
         Jy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=h2vDcvlIr4BYmjqxz9k8Jce3rPfht/vpsAmz6smZ7AU=;
        b=OL8B+AC/oF0SqGdpdWKlGbjFeNGk8jnYnLzNSgONVuPifh+d1L4HRAbScBlDG7fFXa
         5Xz/qZGURDcpTgpOzQRudAtfEs3sFBbUMThJ35ohtFp8ABWbpK+sPoaRQfVEACG3LWja
         Chsth8XivrkgZLF7dXwX1BKl5YRAmeJgTZBh0L+Ki6613gygHW5pzyzuvvSn4pBgxGho
         gLzfKxTiaxhRFJfF6n8z5sfJ5OwXxTZtGRclrLJiSd+FMXAPhl748sk3KBO6FzgfePoh
         KEsG08zeT5MtndDwD0wCqEZ/HJpu8Hwz1HEiGM16J7b2ZQj0JYCPX2FRo5zZChC/VT0k
         +oJA==
X-Gm-Message-State: AOAM530bWHVyx6kwI80Gsa2pEPc8gtRmz9WmaihK/UkQTjaLVcMOm87n
        EId1JSKSwCVMpPUl/aCD8Ty51Gw3Lwy1d3E7VLalcetsCThIAA==
X-Google-Smtp-Source: ABdhPJxmtdliG60Bf7zsIvZ0Rrj3QbKz9Lp3a4tTYUINkXmTT79gaIPv/v2Gs0yJMzUCWTaWPUZIvGISGaC2h+WAcbY=
X-Received: by 2002:a25:cb57:: with SMTP id b84mr14869945ybg.425.1599765426872;
 Thu, 10 Sep 2020 12:17:06 -0700 (PDT)
MIME-Version: 1.0
From:   Ethan Rahn <erahn@arista.com>
Date:   Thu, 10 Sep 2020 12:16:56 -0700
Message-ID: <CAMk6QYPgC1ch_umvGvYRa8F97iY6ynO-ApYC8zHwGzPY3TauDg@mail.gmail.com>
Subject: Enterprise wide Git commit signing
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git Users,

My name is Ethan Rahn and I lead Product Security at Arista Networks.
I recently completed work on a project which I wanted to highlight for
everyone on this list. This is a means for allowing an enterprise to
centrally manage code signing keys for all engineers, enforce the
signing of all git commits, and audit that the source code repository
was not altered after signing. You can read the full blog post here:
https://eos.arista.com/commit-signing-with-git-at-enterprise-scale/ .
Part of what makes this so exciting to me is that I haven't seen
commit signing done at this level before, especially not with having
the repo be auditable after the fact. By having the repo be auditable
the level of vulnerable infrastructure can be reduced to the code
signing keystore; in other words the code repository can be validated
at any time to ensure it was not tampered with.

I think that the work done here is very interesting because I have not
seen it done elsewhere. Supply chain attacks through source code
repositories are a real problem. The solution in most cases seems to
be setting up a security perimeter around the repository and checking
for unauthorized accesses. If an unauthorized access does occur, or
credentials are stolen, it is hard to know the complete set of
unauthorized changes made, especially if they are mixed with
legitimate work of a number of users over a period of time.

Happy to answer any questions around this or take comments. The work
around key management has been open sourced ( references in the blog
post ) so that the open source community can benefit from this.

Cheers,

Ethan
