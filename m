Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EB8C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 17:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbhLFRVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 12:21:13 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:33313 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbhLFRVM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 12:21:12 -0500
Received: by mail-pf1-f173.google.com with SMTP id x5so10827855pfr.0
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 09:17:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KoSJHaJq2lBXfDZu0qpj7X9nri2xLIWncpPbp7f0Shg=;
        b=W5UkzFnmIPQiBhdguxJKL2sDDvtnwKLdBA1vZJR0pFc6CHQa8lnCdjFOfSzsq2agXf
         fXErDEoFgfj5bv22+jPBni2wWgYJYhnx01DsVHk4NC3pimSjCB8rOy8bnIrB2M92q70C
         fhEwtFWQmSpnm6KY0GLb3TOAER1MuY6OsE2t+hl1U/+EVNMWZk817ZGRSsBjOHjuI/8m
         vSZgDYmmwqWURYEGVxVmBIA8riYdM4f8/HSNC0vFLCDq1aZ4qSgwBSmZwqoTTbT/IETw
         JKBJ0Tors+sHo+HK0FpvvulUj/NggpzRrrnuHV37k4kpp8fhZpnrYvfcvBr1RPbzQ//q
         dWoQ==
X-Gm-Message-State: AOAM530dXuy5xC5M+/aQpHMYEce/xeRCt3T+ilslysyDeGr6BKnQafwj
        sw8TCynpPlOcq7SImb7omnMmWxTOl2j/1Lm27ZI=
X-Google-Smtp-Source: ABdhPJyq97kDlp3jqwZo923EKw8hrM6Dn0tmmo9J0NmmdFQcu3HcoDRABjrznAijL4rXxHzA1xt5ucI6flF2KvN4nwI=
X-Received: by 2002:a05:6a00:230b:b0:4ae:d8b2:dc0c with SMTP id
 h11-20020a056a00230b00b004aed8b2dc0cmr5682654pfh.67.1638811063083; Mon, 06
 Dec 2021 09:17:43 -0800 (PST)
MIME-Version: 1.0
References: <CAO6o7kKXZg37ydC145yf5uZt+tsKdYADnVfinO0sHAN=cHo-FA@mail.gmail.com>
In-Reply-To: <CAO6o7kKXZg37ydC145yf5uZt+tsKdYADnVfinO0sHAN=cHo-FA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 6 Dec 2021 12:17:32 -0500
Message-ID: <CAPig+cQr27ra4DTjC1gyZO7YdV81Jq5J3s-LcAf+wePP=+n59g@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Checkout_previous_branch_command_not_working_on_?=
        =?UTF-8?Q?=E2=80=8B2=2E34=2E1=2E400?=
To:     Will Beason <willbeason@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 6, 2021 at 12:04 PM Will Beason <willbeason@google.com> wrote:
> I typed "git checkout -"
> error: pathspec '-' did not match any file(s) known to git
>
> I expected the previously-working behavior of switching to previous branch to
> work, but it didn't.

If I recall correctly, for `-` to work it consults the reflog, but if
the reflog has been cleared or expired, it won't be able to determine
the previous branch. For instance, try this:

    % git init foo
    % cd foo
    % echo data >data
    % git add data
    % git commit -m data
    % git checkout -b other
    % git checkout -
    % git reflog expire --expire=now --all
    % git checkout -
    error: pathspec '-' did not match any file(s) known to git

So, this is probably expected behavior, though the error message isn't
very helpful and perhaps could be improved.
