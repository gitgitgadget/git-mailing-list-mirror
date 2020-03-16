Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89206C18E5B
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 21:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6746F206E2
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 21:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732683AbgCPVkE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 17:40:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36276 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732648AbgCPVkE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 17:40:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id s5so23199242wrg.3
        for <git@vger.kernel.org>; Mon, 16 Mar 2020 14:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADNSQsKWSm6e/44VBy7nMnJvsNki8iAWwvbwURjwWpc=;
        b=lxkl4i1TDxkeTPCFKlvJ1YBhO8QrIqQCxnD2YSPRZ32cbCeukxWhLfpMEu1abZAPyl
         fH5BvQhlHoUCPAzkAMvZXX+M39mJAhHNjRN0sbBdBrCjNe4OXYuiUVp8TSFTe4OMff7f
         fLwdmsHfskhxdqYbSAMlyZudkRHUkztxwoC5Acw3Yj47gR8PVLhRbO7WbUq0AkyHLexu
         JIfJwPG6oMApJBeQuEf0uqIwBJiCMFPkS74JrGQdg3KHLHyGWGDj45c9u7aiuX2hdkqh
         wMF3wjFBgyuHhfHk88NoKIikwC7J/A8X3/nsuQaOB6OUDnIuxmP3G8KB3klJDYTLjCYd
         Axng==
X-Gm-Message-State: ANhLgQ2KgHyvEcz7WOyjoEwtqJN0d2+TCCLZwRuboyRrOgUFQBt6xtkc
        QfNdRycpklQKPFiIuZoME/mT8gTCh0BI0o0NROQ=
X-Google-Smtp-Source: ADFU+vsJkyRj4ad8JrcQWZz5YEA4ovWlbOBlRWu6aI1ZdLHgkU5YK/0svXxgmV8xBRxIKKJdkOqOySuRsdVh7pjGBlY=
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr1459736wro.386.1584394802012;
 Mon, 16 Mar 2020 14:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200316212857.259093-1-gitster@pobox.com> <20200316212857.259093-4-gitster@pobox.com>
In-Reply-To: <20200316212857.259093-4-gitster@pobox.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 16 Mar 2020 17:39:50 -0400
Message-ID: <CAPig+cRj5c-AEOySWkfM=PX-CUFO-R-cN8pgyTm0kD32xyhihA@mail.gmail.com>
Subject: Re: [PATCH 3/3] log: give --[no-]use-mailmap a more sensible synonym --[no-]mailmap
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 16, 2020 at 5:29 PM Junio C Hamano <gitster@pobox.com> wrote:
> The option name "--use-mailmap" looks OK, but it becomes awkward
> when you have to negate it, i.e. "--no-use-mailmap".  I, perhaps
> with many other users, always try "--no-mailmap" and become unhappy
> to see it fail.
>
> Add an alias "--[no-]mailmap" to remedy this.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> @@ -49,6 +49,7 @@ OPTIONS
> +--[no-]mailmap::
>  --[no-]use-mailmap::
>         Use mailmap file to map author and committer names and email
>         addresses to canonical real names and email addresses. See

Here, the documentation seems to promote --mailmap over --use-mailmap.

> diff --git a/builtin/log.c b/builtin/log.c
> @@ -173,6 +173,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>                 OPT_BOOL(0, "use-mailmap", &mailmap, N_("Use mail map file")),
> +               OPT_ALIAS(0, "mailmap", "use-mailmap"),

So, along the lines of patch 2/3, I wonder if this should instead make
--mailmap the "real" option and --use-mailmap the alias; namely, use
OPT_ALIAS for --use-mailmap and place it after --mailmap. (Genuine but
very minor question; should not hold up acceptance of patch.)
