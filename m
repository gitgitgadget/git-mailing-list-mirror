Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7B8C433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 17:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55389207ED
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 17:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgFKRiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:38:06 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:44507 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgFKRiG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 13:38:06 -0400
Received: by mail-ej1-f66.google.com with SMTP id gl26so7278955ejb.11
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 10:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0W4KVTk3zIrU+oEUl5kY4hkeZecv5lLNtpu49rBN5C8=;
        b=jqg0oIcOCFQoxJTzQ9eAU3wXKcnITI+n/jzlmLXg1Fvk8yyxBxaQ3qucSYVEdydCwY
         WToP09l/jh6+gR6WvgKW+qdkyMdui+VEs6E5eO5trahMHtEBV2hhb5kDOYEUJb7Z9lnw
         wpD8Mw4OToKM93qJkZMqiYMy01mWP8GJHDGk1AcBQga53YjOOzvOO/pDFeXnul2+pTKe
         SqWE/TgXKpZuG/Bdiz91ueB2CihKl6lZlsEHlsSf5p86YVzsOKlkxetBvy3zHE9fdKza
         TydyLVGFBda8p91Ceo56C9IQVoRM6nPuT5XLkH8ZUzsmqFAC3D0MveueMSTUwGGnXCf1
         PaDg==
X-Gm-Message-State: AOAM5329ROx1vdXLajbOklk8/Q8O64BLyOiKs7+NSTzUGZKT1rN4S9Cl
        AcGggJQWKmiBWMIZMrR9azW4evxiK1nWNy5O87A=
X-Google-Smtp-Source: ABdhPJzZSQtU9mEzt1JwV2EQjPScQm4nPuDF0FbVKlJtgCWzOCH0VxIAvDlcLbsby0iJ4umrvE70fNL156/QAgIb/BE=
X-Received: by 2002:a17:906:4dc2:: with SMTP id f2mr9788315ejw.402.1591897083982;
 Thu, 11 Jun 2020 10:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200611172201.962109-1-a3at.mail@gmail.com>
In-Reply-To: <20200611172201.962109-1-a3at.mail@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Thu, 11 Jun 2020 10:37:51 -0700
Message-ID: <CAPc5daXjJY42Ou-P71G6Tmo-Qgf2CeLT9dCiw63urg2cZ1eiNw@mail.gmail.com>
Subject: Re: [PATCH] pull: passthrough --no-verify to merge
To:     Azat Khuzhin <a3at.mail@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is where you justify why applying this patch is a good idea
for the project and its users. You left it blank.

> Signed-off-by: Azat Khuzhin <a3at.mail@gmail.com>
> ---
>  builtin/pull.c                                   |  6 ++++++
>  t/t7503-pre-commit-and-pre-merge-commit-hooks.sh | 12 ++++++++++++
>  2 files changed, 18 insertions(+)

I can sort of see the convenience value of doing:

  $ git pull --no-verify

when the remote is *known* to always have problematic changes
that you'd rather prefer to skip the check, instead of having to do

  $ git pull
  $ git merge --no-verify FETCH_HEAD

to see if this time their new stuff passes the check and use the
option only when they are unclean.

But I am not sure if it is a good idea to let the convenience
trump the code hygiene in general.

In any case, even if we assume that the convenience value
outweighs the downside of allowing people to become even more
sloppy, we would need an update to the documentation, no?

Would "--no-verify" work well both in the rebase mode and in
the merge mode, by the way? If yes, then that would be great.
If it works only with one backend but not with the other, do we
silently ignore, or do we detect incompatible options and
error out? That needs to be designed, documented, and
tested, too.

Thanks.
