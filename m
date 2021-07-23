Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B3CC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 18:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C70160E94
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 18:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbhGWRZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 13:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhGWRZn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 13:25:43 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02040C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 11:06:16 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 68-20020a9d0f4a0000b02904b1f1d7c5f4so1877681ott.9
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 11:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=3iRUIJc9/EkN8q70DHKdEo7AQw82oriZ0g8Hf7cGNq8=;
        b=aWeLbrzBZog9cb5UovGPXGBCeSsmSsOe8psghcDVwGwhlinU4or1FQQn4zAt8gR5iA
         1gEa5Gsea6NV1Ybd6548hfncyD9ETwc+k+jV2wUD+We3Jhpd6mGGYkn1E+fy0nfz1yax
         6yi80IZ56i9P9LlhGLwnRz8NPvw9l+ylKE2WJBTR5Xl+Sz3Rb+FvREgURyjLRRw+xFtd
         vQs0C+FFrNRkseuutQ3eb7H8h1cpZyqc/yHdre4WQRfeQs06hgh23QjCTNk3Ktwxqk/w
         dkzCiSwKMtVtcWcclz3M8b4cO6h2K6UPj2WVqeSQdJWxD9qD2KUzGXffN7wqJNAWwOQL
         qrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=3iRUIJc9/EkN8q70DHKdEo7AQw82oriZ0g8Hf7cGNq8=;
        b=obN8porwVPG34hRe2RGpdFY3Kym0oIt9wiRaDmPstFkO1YPJeRlkgnNYnFKJBmakUm
         YYtkp2d/P40nbB9LwwRZlzMMDh8nCzIYjjjoF+o4wjMfdL22u3jFf9hP4roqEDez/3QU
         gOHB2R2l/uVEbacQYIoPWioA2e2PINwE24J5sjcwBPNZIwLJIJxog1ksuA1BKcNENqZg
         6+j0DrpQ2S5/UG3MIejRtkPzpy+psG8Hi8lGIcahAKfIjjCqpoIuTPjjEa9gnXpW/svb
         Jk8Lbi637xIOogtE3kbXoGGv3mWGZ7kZSpoLywYxq4zDTE4Y+K0mdsXRokMG8eYk/UUS
         quHA==
X-Gm-Message-State: AOAM533mcni631WZepfiPT4R402TSG3JJmb116XP91bmGw/Rjna0Q7Dl
        hVd4QUcUhMNXK2b3p571zCNrlMrBAuNrPw==
X-Google-Smtp-Source: ABdhPJyKKLMBGoio/fb1Ass7Y2J0lKkkikB/ZowfJ4uFErFK1I+QaqZZYwwDRTz0htBtUT9qjIfvsA==
X-Received: by 2002:a9d:62ce:: with SMTP id z14mr3777312otk.159.1627063575422;
        Fri, 23 Jul 2021 11:06:15 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id u6sm3857376oiw.36.2021.07.23.11.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 11:06:15 -0700 (PDT)
Date:   Fri, 23 Jul 2021 13:06:13 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Daniel Santos <hello@brighterdan.com>, git@vger.kernel.org
Message-ID: <60fb0515a3cea_defb20817@natae.notmuch>
In-Reply-To: <924b70af-1e55-0944-0f45-ab28cff1e98d@brighterdan.com>
References: <924b70af-1e55-0944-0f45-ab28cff1e98d@brighterdan.com>
Subject: RE: Git show only showing ASCII chars problem
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Santos wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.=

> =

> What did you do before the bug happened? (Steps to reproduce your issue=
)
> git show
> =

> What did you expect to happen? (Expected behaviour)
> Show non-ASCII characters
> =

> What happened instead? (Actual behaviour)
> `show` does not show non-ASCII characters such as =C3=A7 , =C3=A3 , =C3=
=B5 ...
> =

> What's different between what you expected and what actually happened?
> I expect for `git show` to show all of my machine locale characters, =

> such as =C3=A7 , without any problem

What is the content of your LANG environment variable?

Also, can you attach the commit that caused the issue? You can save it
with this command:

  git cat-file -p @ > commit.txt

-- =

Felipe Contreras=
