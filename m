Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E52CC433E9
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 23:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AC4164F64
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 23:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbhCOXmA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 19:42:00 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:33055 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhCOXlp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 19:41:45 -0400
Received: by mail-ej1-f50.google.com with SMTP id jt13so69241082ejb.0
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 16:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P1NwJUh/NluiQGiW8ixS3HBY3F47mcVQcmCruBbKFfY=;
        b=flkYv2Y9piqaO+xR7yGXw6H7rwADcAUfDkqA3VKP6RftP8BU1mRfv37E4M3uCLGJNr
         vREdtNtznpCCamV3bydzsqG3/uz21fAmlmk3afhx5SZHPyE6ECgCxmG53SMq7iQ6Ly0I
         Bsy1u7WcRi8dfQ+JWArRJ582N3fgZvq039okcOzCshwRus2H0mSFkkRiNxcmfF43tsoO
         1Ut4fQSHinlknciK3qUTaOxqgHB1rrBwUTOOq63hc6vLFAPtWZ/vttqOTjrveLIb2dVE
         f9qZc1ysf6KG5qChrLDH13PDFCApE454s4QHVQwO89hb6ZeEZDnbNz0Yk3LDTEVtGJ27
         tA1Q==
X-Gm-Message-State: AOAM530+NJHL+PXs87b9R7/OZmUKlIE+GVBurRMfaD8taIc/Tes0vgHB
        bdec0oKCbFklxD69bO9IIqrPsaELsA9A/bvy3+Y33c0F
X-Google-Smtp-Source: ABdhPJwgdDbmDEdgw29KHPoernaGAic+yPPtXmKKhZw5phJNh4PyhCCg6ILZx6+kYnzEru6g9lTcQX078q38bt+1MCo=
X-Received: by 2002:a17:906:d8c6:: with SMTP id re6mr25631677ejb.311.1615851704389;
 Mon, 15 Mar 2021 16:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.v3.git.1614859926974.gitgitgadget@gmail.com> <pull.885.v4.git.1614928211635.gitgitgadget@gmail.com>
In-Reply-To: <pull.885.v4.git.1614928211635.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 15 Mar 2021 19:41:33 -0400
Message-ID: <CAPig+cSd-e76bOQY8yoZnRDbuQbZ_FNHJ5TV6BC+dAofPmk7DQ@mail.gmail.com>
Subject: Re: [PATCH v4] format-patch: allow a non-integral version numbers
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 5, 2021 at 2:10 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Usually we can only use `format-patch -v<n>` to generate integral
> version numbers patches, but sometimes a same fixup should be
> labeled as a non-integral version like `v1.1`, so teach `format-patch`
> to allow a non-integral version which may be helpful to send those
> patches.
>
> `<n>` can be any string, such as `-v1.1`.  In the case where it
> is a non-integral value, the "Range-diff" and "Interdiff"
> headers will not include the previous version.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> @@ -221,6 +221,7 @@ populated with placeholder text.
>         `--reroll-count=4` may produce `v4-0001-add-makefile.patch`
>         file that has "Subject: [PATCH v4 1/20] Add makefile" in it.
> +       now can support non-integrated version number like `-v1.1`.

Let's drop "now" from the beginning of the sentence since it is only
meaningful for people who have read this documentation previously, but
not for people newly learning about the option. Perhaps just say:

    `<n>` may be a fractional number.

> diff --git a/builtin/log.c b/builtin/log.c
> @@ -1862,11 +1863,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> -       if (0 < reroll_count) {
> +       if (reroll_count_string) {
>                 struct strbuf sprefix = STRBUF_INIT;
> +
> +               strtol_i(reroll_count_string, 10, &reroll_count);
> +               strbuf_addf(&sprefix, "%s v%s",
> +                           rev.subject_prefix, reroll_count_string);
> +               rev.reroll_count = reroll_count_string;

This code can be confusing to readers since it appears to ignore the
result of strtol_i(), and it's difficult for the reader to understand
the difference between `reroll_count` and `reroll_count_string` and
why you need both variables. I was going to suggest that you write an
/* in-code comment */ here explaining why you don't care if the reroll
count parsed correctly as a number. However, now that I'm examining
the code again, I think it would be clearer if you move the strtol_i()
call into the diff_title() function since -- following your changes --
that function is the only code which cares whether `reroll_count` can
be parsed as a number (the rest of the code, after your change, just
uses it as a string).
