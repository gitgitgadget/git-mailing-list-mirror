Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A9ECCA479
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 20:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiFAUzz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 16:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiFAUzf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 16:55:35 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DBD47AE6
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 13:55:22 -0700 (PDT)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 61D183F178
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 20:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1654116921;
        bh=CXidlkjps7TlkyRppobpTyqRLkMpU7szkTmff5Ghx10=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
        b=nxRAVcoO0+A3AwAndsfdM9pgEABInjAYboaiJaIuZHt18oexs9Rks7f9nT4b1ujGg
         naqjQu8Br2U13UOYYXIZac8ZZeouEBnr3gqxE15Hl3XOVJHs0yaWqM2xNSazW++36P
         38woB+bA2pPoa1tnJ5b2yoAz5K3rJKFvAX305n2N0ke+R6+0Q1XdAW5klXK/5LKi01
         d5qoQEt82nWLz2J1iT2Pa1WhSyQyERiN18pXXYSLlpjMXCNuG/J7zsskG3kFvzleAV
         iXT+8tUSU4Q/7CT653BqVn18U7iYn6JQhZ441yKFM0SWXg2SzacCYKY9X8odUE8o+W
         mwpGuVs3ZoeuA==
Received: by mail-ot1-f69.google.com with SMTP id a5-20020a9d4705000000b0060b9c5da2e0so727705otf.2
        for <git@vger.kernel.org>; Wed, 01 Jun 2022 13:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CXidlkjps7TlkyRppobpTyqRLkMpU7szkTmff5Ghx10=;
        b=S6b/MHB0Z/78nZmf583JV8cqGUVqPks+QkxQpIbClIn5W+5b8I9ByhhRtxJhn9BByA
         2yn+KE+7EY92zp5/w6NzavAQ7bpBkSXuxsWve2yJrj2+H5s61FCS5PVMTI8+kdt1t2aA
         guQwCkn1TGuU5X4RSSUpP9mNsrinJQj2vyKGZhbL5aGM3NLucsiJX6egyotlcqCnNDSl
         lY61PXrUi8ZSdnz3wxhzOMUPgD8zkSi2Jf08TSrAAvn6tMtLUpMNAbEFCnpzM7qwhN0I
         edEE0in5l0E3HuVfJ11eTPVXBXfZx9Ul6y63hP6U+c+fpRtxw+vM6MTaOACsAiUC6+NH
         q+Zw==
X-Gm-Message-State: AOAM5312Np/AmI9WEqpavxJbL+U4d8gk5j57aRcN5IAo/nQnOBGSR9oq
        6ZPWzVRd1RXr8b9pBotKExhQoVJN5o+wNIckgDLPdLmFb7ZQ9Q9QEGzRXOj7CFhORmxwGU+0Y5v
        xO+6eOrHBXXAtaEsmontelQzd4XeG0gK07MocMuDeGTQdwQ==
X-Received: by 2002:a05:6870:1686:b0:f4:2cf8:77b3 with SMTP id j6-20020a056870168600b000f42cf877b3mr878450oae.210.1654116920262;
        Wed, 01 Jun 2022 13:55:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsz7I3yA9QDlKzHLbBQ53TTJRUUAhOOt4YL/srvlnMKWbC9DyTE+m0QBgr2vGtEOC5NAEJGAUo82ptzv7PoDM=
X-Received: by 2002:a05:6870:1686:b0:f4:2cf8:77b3 with SMTP id
 j6-20020a056870168600b000f42cf877b3mr878443oae.210.1654116920084; Wed, 01 Jun
 2022 13:55:20 -0700 (PDT)
MIME-Version: 1.0
From:   Mark Esler <mark.esler@canonical.com>
Date:   Wed, 1 Jun 2022 15:55:09 -0500
Message-ID: <CAJ=HsVKX-NXePKU1G0UKRcFT5He8AjS_TQEirb3hN3chGFz9TA@mail.gmail.com>
Subject: CVE-2022-24975
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Could the git developers state their position on CVE-2022-24975? Is it
disputed or will it be addressed by upstream?

As I read the documentation, --mirror is working as stated and MITRE
should remove the CVE.

Thank you,
Mark Esler
