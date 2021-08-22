Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B2FC4338F
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 19:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E68E461266
	for <git@archiver.kernel.org>; Sun, 22 Aug 2021 19:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhHVTaL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Aug 2021 15:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhHVTaL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Aug 2021 15:30:11 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF62CC061575
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 12:29:29 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id f15so1576882ybg.3
        for <git@vger.kernel.org>; Sun, 22 Aug 2021 12:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=lbpwQIK+jhAAuSWxkE+Utclsdy4FH+5f4bJ5+5rrvsc=;
        b=oa8EjsRVBRo0OVW6UbF8tLeeEv+Xt/+dcjq5eiQU7TVLeNJguGcmNt9nfrM1GKrM5+
         g203Z1DxCmDD9gI4RfTjb6JMpcG7U8vEmKxs72xXTe8BiXk+g5nLUvpyJ8rXozhhM+6s
         V+ZN8GiG8e6QpYqziVMNahtRqz0CDoODO5KAluZ20e0+zM1iLBKd28M9BiQKxS/SZ3xK
         3tYW/nOZbkiQ8oLZzbKkVEQouKLCuUPeb1NQGNZHk4cXMmJdmdi+DNeARjwEEr1JdeZB
         wTzdQDlnAGiqX2AjcfnUkkixzSWpW5JUlvVhpdO7iC+X/nzbiqdyv/andrkXy76dpH8a
         2Hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=lbpwQIK+jhAAuSWxkE+Utclsdy4FH+5f4bJ5+5rrvsc=;
        b=rZgtow+am3Qqwcku0U0zNU7DWEnAmfPKnWWlFFensgvddxdEnEfYxXWoH+DqTedjeD
         2EBlp5ixRlvoEWrxgJx/Mzu84u4zVBUX9iujd+pCrczfAf9T8TWDUP8cKRNtVEahoY4g
         xZ4y7yo/gMs1ai+okVaonpzyRgjpHk/D1KZOolY/MLrx7piq9g9du8lskScAemFGOFc6
         9xngwkQ0ncGj00niLEtEVApiEvw80ul70Eeo+Cur6L35lhr8s/ebCYbUGJYAJQqtznCh
         XZCAoQbXobRov3Tsyn1O3lD6HT9OxzveSWxi1xOytv+4QdPJHbDKovjFX6mR+T73ew+o
         ho5A==
X-Gm-Message-State: AOAM5338807amPeJyq5PLemlyFl32Qe5lKPMxhDiIM0QqrxreCg92hf1
        NkAWn/IZmdkZVgXljBEBkLYVHMI9N36EIzkFISsiD9I6hntkFQ==
X-Google-Smtp-Source: ABdhPJx/dLADT29iADDPwROfyhgZq37bA/c4V9dCqv4pfIqISMD5OGyz0SbW7dGHP7Pzzrtohs7vN7XoKv0gkxCYav8=
X-Received: by 2002:a25:16c6:: with SMTP id 189mr4037307ybw.27.1629660568835;
 Sun, 22 Aug 2021 12:29:28 -0700 (PDT)
MIME-Version: 1.0
From:   Pavel Rogovoy <p.rogovoy@gmail.com>
Date:   Sun, 22 Aug 2021 22:28:53 +0300
Message-ID: <CA+NVOTBjgQ60hUZyRcK=igEP5=PSJqUFKf4Z-wYr=7+ESp3Ziw@mail.gmail.com>
Subject: Feature Idea: Expanding git to support automatic Semver stamping
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

My name is Pavel Rogovoy and I am a git enthusiast. I have developed a
git-based generic version stamping system that is compliant with the
Semver standard and I believe it can be integrated into git as a
sub-command such as git stamp in the form of an external plugin or a
complete rewrite into git=E2=80=99s source code.

I welcome you to take a look at the stamping utility:
https://github.com/final-israel/vmn

I will be happy to discuss the main benefits of such a move with you.
Here are just some:

- Effortless version management and state recovery for single or
multiple  repositories.
- Can be used as a convenient git submodule alternative.
- Way for storing metadata about a version such as: release notes and
build metadata.

Please let me know if such a feature is of interest to be integrated
into git. I personally am willing to contribute and maintain this
feature in case you will find it useful for expanding git=E2=80=99s
capabilities.

Best,
Pavel Rogovoy
