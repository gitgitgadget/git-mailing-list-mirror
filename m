Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B80AC83028
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 17:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AF766108E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 17:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346560AbhIBR2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 13:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346499AbhIBR2x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 13:28:53 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8C1C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 10:27:54 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id me10so6123358ejb.11
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lZEzLe9ltn+mSnfcBE7MnHwt8JhqcLSCqiNaaFS8bAs=;
        b=c5nZs0wZ9NT4cCgaB/wNxOPzDS1jMWihJn6rlgqd2HrSQteM74VYxr73PZP26j9A4C
         cZuBoIo6axP37tdvlBVSjSw3pRvZUhOInLf4sZdoTmlGQdWPl48dwjjvzKMW01kkB8PZ
         zoC4xP27jBvo8jZqDXi/iJnjRUoZMf0aPYsORE0NT91nGbpxN6wIVESe40Fz4VmASjSo
         B9CM9tg/fijaKukumpZ9fDB1Bs4Xvn3uXy0VHdsChFkMhvLOY/Zkj7rEyV9h3rvaXfEf
         InuwV7zLZ+y4NhSTl/GOvLZwRC+Dfg9nsyOXDKZYrpoWEW03hqXbn1BWtTDtP7PPCovt
         J5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lZEzLe9ltn+mSnfcBE7MnHwt8JhqcLSCqiNaaFS8bAs=;
        b=m+s3R8aS3QAXYuTuW1IXOIDsZexqFqNcl3vl0T9LpYONrGIX1bBg4RahPvVcxwrWWs
         0CODABksFQFBWkUo8SKmq5RuuJ7GyvLUY8ElNG58e/I7xCO49A7/rSYlymsriIPkw+Qh
         Jr6Hf3OWJ3blCoef6pJVPlZ1HfuG3+LzNkSlV5Ikr5BRhlcgXeGIgwf4zuQXIA6wGdYo
         793/GRG/arthSgHD95j8lIUH4VWvK09slLo8DSDVKOpQyijWnJt4E5HC//e1f0mBqO1a
         RF7MjuUWtoc9WcKF7f2lLzXUtRzVjc6WEDDGYLdsIRo9BBA3MMEkxIyf1JCaXdYxxsJa
         3L0A==
X-Gm-Message-State: AOAM530v09umCdL+dKuuQtVmQReGCKJ6vH94gklbFCiiOMSAtIcABOVQ
        ByQp6Wl7Wqm9oY/7BnXvaZ2JIaiQYt4FXdpLSTG8Qh1tEOYI9w==
X-Google-Smtp-Source: ABdhPJw8oD3lRhxwA126+vEEt9t01+KSeAY8K25FsssFrTchgtPEhvz93IUIjgJYfwvNN2ZWVbFM/XDIJS7CcyUxk0E=
X-Received: by 2002:a17:906:264b:: with SMTP id i11mr4945823ejc.485.1630603673059;
 Thu, 02 Sep 2021 10:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAO=eiXzPaRpEV_nsudvvCUbNab+oMxR8b9rsehjdyc4WMHe3OA@mail.gmail.com>
 <patch-1.1-27f00a664e6-20210831T143536Z-avarab@gmail.com>
In-Reply-To: <patch-1.1-27f00a664e6-20210831T143536Z-avarab@gmail.com>
From:   Jan Judas <snugar.i@gmail.com>
Date:   Thu, 2 Sep 2021 19:27:41 +0200
Message-ID: <CAO=eiXzE5ZjKEBiCnbUW9-JojgPfG1yQuyG+2Pn1O9x08HATgg@mail.gmail.com>
Subject: Re: [PATCH] gc: remove trailing dot from "gc.log" line
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wow, that was quick!
It's awesome to see a project that is alive and welcoming to new
people (unlike some others I tried to contribute to).
Thanks again and keep up the great work!

Jan

=C3=BAt 31. 8. 2021 v 16:37 odes=C3=ADlatel =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason
<avarab@gmail.com> napsal:
>
> Remove the trailing dot from the warning we emit about gc.log. It's
> common for various terminal UX's to allow the user to select "words",
> and by including the trailing dot a user wanting to select the path to
> gc.log will need to manually remove the trailing dot.
>
> Such a user would also probably need to adjust the path if it e.g. had
> spaces in it, but this should address this very common case.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Suggested-by: Jan Judas <snugar.i@gmail.com>
> ---
>
> On Tue, Aug 31 2021, Jan Judas wrote:
>
> > Hello,
> >
> > first time posting here, I hope I'm doing it right.
> > I'd like to suggest a very minor UX improvement regarding the message:
>
> This is the right place for this request. Thanks!
>
> > error: The last gc run reported the following. Please correct the root =
cause
> > and remove /path/to/repo/.git/gc.log.
> >
> > Currently, there is a dot after the file path, so it's impossible to
> > select just the path using double-click. If the dot was removed, or
> > separated from the path by a space, it would be slightly more
> > convenient :-)
> >
> > Thank you
> >
> > Jan Judas
>
> Yes that's annoying, here's a proposed patch to fix this.
>
> As an aside I've also noticed that if you have multiple worktrees
> we'll trigger "git gc --auto" in each one, and then litter various
> per-worktree gc.log, even though the issues being noted are usually
> repository-global, e.g. too many loose objects.
>
> That's per-se unrelated to the issue you're noting, but is usually why
> I end up having to manually remove gc.log files...
>
>  builtin/gc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 6ce5ca45126..69c058533ea 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -502,7 +502,7 @@ static int report_last_gc_error(void)
>                  */
>                 warning(_("The last gc run reported the following. "
>                                "Please correct the root cause\n"
> -                              "and remove %s.\n"
> +                              "and remove %s\n"
>                                "Automatic cleanup will not be performed "
>                                "until the file is removed.\n\n"
>                                "%s"),
> --
> 2.33.0.805.g739b16c2189
>
