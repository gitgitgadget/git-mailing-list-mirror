Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D30AC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 19:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0784124679
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 19:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfLSTsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:48:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45410 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfLSTsD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 14:48:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id j42so7166187wrj.12
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 11:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y97MAl1EyIaXPw4js0PGJmciburRaPCvsL1q8rL4lU4=;
        b=SMQzioVnWfxNVjqouPuAbO0GcvatIwYEDGj9BUnh2XFRfw5RXOlzN9v/DwQIPAhn3R
         dO3HDBZcKFW3zdjUFJWMVusPw3fgNiLU/Vd6XNesFOhpQYP3CVgrnZy5CS+OryoiXmLo
         1IZ9n2IIUZHNpmjaDmDgQp2utanEsvHZzBJM6KuRj/UkJtuz3sYGbKaO3yGt04vrBOrP
         R1ii2DIezN1B87DpYA5PR/S++huH8bFVnDj3Un+lanv3AJWnz7R2GrUE63npfk5DBl0f
         qOj7ybnKDAqHQw8qyblXcWRp26vfVm1NyV4KJNzG5UmjxnWTplR4oI3kujDMm2HQravc
         QtwQ==
X-Gm-Message-State: APjAAAVbDAyx5gfJjFODvknQnaj2gIn0lLCJz+1SBS9Pdba4wv0C884h
        Lhn0K1Yr3cuPlOdf664HOpXBAUtk+IYC0eT9Eik=
X-Google-Smtp-Source: APXvYqyQMql6ztk5Hq/fs8MzpnwTq+xiD9O0qX2ZuTyNTYyng4u25nzV6sq9DerLN9uK6BCWp/D35A8+5HmBrhsrXdA=
X-Received: by 2002:adf:db84:: with SMTP id u4mr11499907wri.317.1576784880599;
 Thu, 19 Dec 2019 11:48:00 -0800 (PST)
MIME-Version: 1.0
References: <pull.495.git.1576574242.gitgitgadget@gmail.com>
 <pull.495.v2.git.1576746982.gitgitgadget@gmail.com> <ebec2379207681152c6e5196a1418aca03da113a.1576746982.git.gitgitgadget@gmail.com>
 <xmqqfthgb01m.fsf@gitster-ct.c.googlers.com> <xmqqbls4aznl.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqbls4aznl.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 19 Dec 2019 14:47:49 -0500
Message-ID: <CAPig+cQZBXOZeYDJRH+9YLobTOP1_UndV_Snk+S0_LL1=h-aag@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] commit: display advice hints when commit fails
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Heba Waly <heba.waly@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 19, 2019 at 2:22 PM Junio C Hamano <gitster@pobox.com> wrote:
> In any case, here is what I tentatively have in my tree (with heavy
> rewrite to the proposed log message).
>
> +test_expect_success 'commit without staging files fails and displays hints' '
> +       echo "initial" >>file &&

The use of '>>' here rather than '>' feels wrong, especially when
"initial" is used for both the file body and the commit message,
causing a reader of the test to wonder if this test somehow depends
upon earlier tests.

> +       git add file &&
> +       git commit -m initial &&
> +       echo "changes" >>file &&
> +       test_must_fail git commit -m update >actual &&
> +       test_i18ngrep "no changes added to commit (use \"git add\" and/or \"git commit -a\")" actual
> +'
