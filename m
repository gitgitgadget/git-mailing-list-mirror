Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6947DC433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 14:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CEA820702
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 14:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0z/kEJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbgGAO4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgGAO4p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 10:56:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3C2C08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 07:56:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o8so22756545wmh.4
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 07:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OF84HttbAEguDTlT4rNbdXkNU7elZJKvwF+GchJcqfc=;
        b=Y0z/kEJO3REexp1I1CTDzkRGoncc0uEEZXkRL9EGPtGxqWWswZKWB2y+Ovz90n2Ea1
         C9bE09LE8DI6xs09SZks2COVv9RjPDxbCacVwTvNX0QXhnLhmYWXCQBgLkxuiV21pzvY
         t01bNaUEsxyYedm0HaE2Pr/PouhYPbWeY5hctJBzFNo+esT8wZao+YCmQKWvuFGpO5t9
         KWOShxrqA82WxlXVOCMy0wgHKfCUeTWbIGuhmkYh//7H6laSaLprWh3ex/YhpjV9mWgJ
         Ge36hKdKn9gNrpnnn2zQtNfzgwWHDpkdBd6e/aEnGHe2742Q12g2bMKy183nEswIhLXu
         mxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OF84HttbAEguDTlT4rNbdXkNU7elZJKvwF+GchJcqfc=;
        b=YmDzjs/WVDemIbagv0mH0wr0x51wcMoZ3gLk36IRDCoRQ4NFXEDkP14fGNkd3C3G16
         VKTOnm8GDNylyCIooh2wUD033WJE/GZwiIVr43KHuYzu1ET2/KCgHa+36r4OGe/8CtUx
         I8FlKsJynGq9pq25sGIZHEgHwh5tM3ScrTDUKs139emkzSQhBtuH8EikpDz+t5TQJ2iU
         EekcOKZA6tIV2F6HEoLZdcdoEf9wT07ulAQTv9MyVikkrAUvp/Jn+TrKyZhLOR+24aMI
         zc9Jmf4n1O6kXAlY2ZdFZrH9P1dqezwTtvPuI0mYBgWZ7szaPf1nG+htXSr+koBTV8qn
         9cWA==
X-Gm-Message-State: AOAM532E5wOFsey5WE2lC1vN+gw7PyTHgYYUtSAueOT6zbK4LdBmYEgc
        KUQ8H45xv4c4/oKUS8IycTEl03qgBOr809lhK7E=
X-Google-Smtp-Source: ABdhPJwyN+KyDTVGDS3+SJqPqBVLZ3rsf34XSzsQzrY7+DnFOe46W+ia6ZEBYS7Fx+MUHIFHsRBAbVxoNqZAFnrp760=
X-Received: by 2002:a7b:c746:: with SMTP id w6mr28640790wmk.171.1593615403274;
 Wed, 01 Jul 2020 07:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200701133504.18360-1-mirucam@gmail.com> <20200701133504.18360-4-mirucam@gmail.com>
In-Reply-To: <20200701133504.18360-4-mirucam@gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Wed, 1 Jul 2020 07:56:32 -0700
Message-ID: <CAPx1GvfFCKqTN2zodrO767CQQ2t2m-s9SRwR+s3cs0oAWyJ8Fg@mail.gmail.com>
Subject: Re: [PATCH v4 03/13] bisect--helper: introduce new `write_in_file()` function
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 1, 2020 at 6:37 AM Miriam Rubio <mirucam@gmail.com> wrote:
> Let's refactor code adding a new `write_in_file()` function
> that opens a file for writing a message and closes it and a
> wrapper for writting mode.

Nit: typo, s/writting/writing/

[snippage]

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 0466b07a43..b421056546 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -74,6 +74,38 @@ static int one_of(const char *term, ...)
>         return res;
>  }
>
> +static int write_in_file(const char *path, const char *mode, const char *format, va_list args)
> +{
> +       FILE *fp = NULL;
> +       int res = 0;
> +
> +       if (!strcmp(mode, "a") && !strcmp(mode, "w"))
> +               return error(_("wrong writing mode '%s'"), mode);

Should this maybe just be BUG()?

> +       fp = fopen(path, mode);
> +       if (!fp)
> +               return error_errno(_("cannot open file '%s' in mode '%s'"), path, mode);
> +       res = vfprintf(fp, format, args);
> +
> +       if (!res) {

This isn't quite right - vfprintf() returns a negative value on
error, or the number of characters printed on success.  Zero is
technically OK (if the format and arguments ended up empty).

[rest snipped]

Chris
