Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BACC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1797461507
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354590AbhJAOmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 10:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354591AbhJAOmH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 10:42:07 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA3BC06177C
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 07:40:23 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ba1so35645643edb.4
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 07:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Z2u4btpjqDtYAbXD7XeFJ3s1CY8T0BbXQi6j1HH/2TY=;
        b=jr5u/vqjivczEiXtS+XxYXRk8e/drXggbmqQzkmieWPs6HK/aUNiAyC+HXQDofOeTh
         7aCi99vFc2Opmg9Gf2qr0gzHhh8ncNp7cE/DQ5ITfQpXGr2NPUKKmPk1g+kEnd6unF88
         j2ilV2pm0ExSIeniH3FIbikoqnlUmukUo1RRcm/2sJDCtlgYhCxGFTQAAfsruaFTZ5XQ
         YfzF8BgvXsIdsVBrb/1hdezPFm3AZT/eC4h1U5ylodi0k+SoqfY//DxOTM3Ocyd1nX42
         45Z0BgxPQaaKQLFcvVQs12md6BMOEI7UtHsPWCi04C8N+HI7lDlHgv0QFjWUiRrMyU1o
         187w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Z2u4btpjqDtYAbXD7XeFJ3s1CY8T0BbXQi6j1HH/2TY=;
        b=MKn4eCAz1zBMSXAEkLKf1GYRAXMzyV6XUBKQVd0Lac3q4eEDxPNeGLmF0LicYJ9qws
         /ZcJcXNLUMlWKuhoWhwKeuh63xB6HlE54B8U/xE/lJ70fcOuumuha71dhE984LuNWpML
         sDYnCqyrU1wpGWW7qKYlN9I67rzAMn2ux+G3uatyrPDwy1HDVJTICwzBn04QtBRVf9hT
         8D2fEkQNEsVUENQFeVQL6WMMeS1nvZ1+sU5UJyBpPxU5cXDp1aGXBFiJqOoTEi9Vn5rr
         EiwwBUwyHfObygvxGeHPqxYjqGvNrM0GnNQYzHhtLulK6Ce2J2Ch+6jRIsCOFqeRFi2f
         0LKA==
X-Gm-Message-State: AOAM533iLoMWgth5OilBjJHdVltTQVdo1dhQrFzg7KDrlwKAvledDl0N
        1U2Bag9Dpw5LuyUbwbbDSiSqkroHifeWUQ==
X-Google-Smtp-Source: ABdhPJxd26sQjf8ZVXHznWpG1DmCVDKqONqfLXPJpGIo7KvvohpO7tlBoN2AXgGgHJAq3SqTnBC42g==
X-Received: by 2002:a17:906:cc4a:: with SMTP id mm10mr6646331ejb.384.1633099220326;
        Fri, 01 Oct 2021 07:40:20 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id au26sm2182889ejc.125.2021.10.01.07.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:40:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/sanitize-leak-ci & more leak fixes soon-or-not
Date:   Fri, 01 Oct 2021 16:35:17 +0200
References: <xmqqh7e18soj.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqh7e18soj.fsf@gitster.g>
Message-ID: <87ilygrep8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 30 2021, Junio C Hamano wrote:

> * ab/sanitize-leak-ci (2021-09-23) 2 commits
>  - tests: add a test mode for SANITIZE=leak, run it in CI
>  - Makefile: add SANITIZE=leak flag to GIT-BUILD-OPTIONS
>
>  CI learns to run the leak sanitizer builds.
>
>  Will merge to 'next'.

Yay! I've got some post-cleanup work, leak fixes etc. that were waiting
on this.

I've been careful to only change things that don't textually or
semantically conflict with "seen" (and don't cause any CI smoke there),
so e.g. marking up tests as passing, fixing leaks etc. should go pretty
smoothly as far as those topics graduating.

But it's not in any way urgent, we've had most of those leaks for ages,
but I figured since we're in week 6/12 of 2.34 it might be a good time
to get them in sooner than later.

But you've been frustrated by some past cleanup topics of mine, so I
wanted to ask. Would you prefer to wait until it's in "master" until
those trickle in, or hold them off entirely for a while etc?
