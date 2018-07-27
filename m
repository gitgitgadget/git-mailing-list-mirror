Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	WEIRD_QUOTING shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 157211F597
	for <e@80x24.org>; Fri, 27 Jul 2018 18:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388925AbeG0Tig (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 15:38:36 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:44858 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730981AbeG0Tif (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 15:38:35 -0400
Received: by mail-yw0-f193.google.com with SMTP id k18-v6so2181230ywm.11
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 11:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u6CffOvseEWB6qAMmKC/1OVfRx9kDbv/Swiuap0zils=;
        b=GBjEHrvOtqyeDw/XKedP5gkG/XaEKot4ZD400fIOWMab1s5PTPMI9Aik9i6+/Lno23
         4m5Q+1OvnELXER8Xn0DekRWYysXV2UAIYduCVTGL3x1ltf0jisKC+OTSKneBlUBWzxQ4
         VO5/patOUAXpV7YiCOGezJpM1UXBR34tf3ZJFqMnZQl82WscKsGgW2V8oYoJDlmZ+N95
         UX3ob9GHrZK/NVoIH3PitKrYMfVpshf3BCgCF3H+d5IlFHg+b2ZyEJlyjhx3KmAhSpKh
         lyiY+7kdQOFf8p52vElhAYdv1DZmkasbZOMRxgsokb9cj2gxyusKASxbL21V2MRKhJi5
         UMxQ==
X-Gm-Message-State: AOUpUlFE45ZVZeZRHul5jIuajiekmXIwnnXzAx0XaE0MUipZz34YwkZl
        Y+xR9VYdB5//nzKRoBpMil8vm5hyq6TkDO38ZEE=
X-Google-Smtp-Source: AAOMgpcU/FxwXQsFu/hT3oLUHNcQNPwVjiRWkXiMOzWEPZU0KKiyvYbAeZK36I6H9lL8ZqnghQlFc3J6fXIzvlF+h+U=
X-Received: by 2002:a81:4153:: with SMTP id f19-v6mr3964579ywk.418.1532715332598;
 Fri, 27 Jul 2018 11:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq36w6rlh7.fsf@gitster-ct.c.googlers.com> <20180727112222.19061-1-chenbin.sh@gmail.com>
In-Reply-To: <20180727112222.19061-1-chenbin.sh@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 27 Jul 2018 14:15:21 -0400
Message-ID: <CAPig+cSOQHV-F9GfB+73VAY-jyFdBSU93kdLa9jiRqLUvPoJ4w@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add the `p4-pre-submit` hook
To:     bin chen <chenbin.sh@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 27, 2018 at 7:22 AM Chen Bin <chenbin.sh@gmail.com> wrote:
> The `p4-pre-submit` hook is executed before git-p4 submits code.
> If the hook exits with non-zero value, submit process not start.
>
> Signed-off-by: Chen Bin <chenbin.sh@gmail.com>
> ---
> diff --git a/git-p4.py b/git-p4.py
> @@ -1494,7 +1494,13 @@ def __init__(self):
> -        self.description = "Submit changes from git to the perforce depot."
> +        self.description = """Submit changes from git to the perforce depot.\n

It seemed odd to have an explicit \n within a """...""" string as
opposed to simply using a blank line, but I see there is existing
precedence in git-p4.py when setting (at least one) self.description.
Okay.

> +    The `p4-pre-submit` hook is executed if it exists and is executable.
> +    The hook takes no parameter and nothing from standard input. Exiting with
> +    non-zero status from this script prevents `git-p4 submit` from launching.
> +
> +    One usage scenario is to run unit tests in the hook."""
