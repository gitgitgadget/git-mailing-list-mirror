Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9FAC433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 09:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 455732080C
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 09:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgH0JFk convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 27 Aug 2020 05:05:40 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35053 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgH0JFj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 05:05:39 -0400
Received: by mail-qt1-f196.google.com with SMTP id y65so4019119qtd.2
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 02:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pk0JZTxxholoRN3JQnXy4HwQ9tVs6bpInE3iy+iG8iU=;
        b=Nldkipku/F9WSc7rqxzy0RREOkWibO/LfC1rIEMBZVIPgQV0wSDOCiRVtUvtaa2Hx+
         fbB/knf9gZu3XQp1Zq9XuxFAewwFc1siCTpLP5G8BBiOaULzaWPFvpIvPYc50vmajIoQ
         c+d/nukGBOSiNNIVb4ux1feAyIHRJW0A9W9+xbVUt5Q5WF8OZpiG9uUxRUBg7FJaPQD/
         mtk4wXocn0WCLD/ikRjXxQXPUPs2qbbFLLUotpOV6oaA6tXz6k8vFnpvAMJq4VWSP4Kc
         QQ26X9Vl8A44gYkaq3Q3+M589XHi1P4aj4QbC981h5Qenk+1HC9FDb2oFJBz5UHMbMTp
         SgSQ==
X-Gm-Message-State: AOAM532qWJjBQq96BaZllMa+FrOtQqUH9qxskV7uisvYfQtKz1FV9BZA
        3zENeiNtPKHYZuGw9KG35Fmt1X9G96D3m3dL5ZEFdg4e
X-Google-Smtp-Source: ABdhPJyLujavJMOOKO9lOYPNJOjRocUde5S80NIj5Gm7QTXhZNrwFkoABSKae+Um5qdeLOFnMfSUXuTD6lr4YQ4rxWk=
X-Received: by 2002:ac8:2ab9:: with SMTP id b54mr17609974qta.323.1598519138055;
 Thu, 27 Aug 2020 02:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <2639321.dTF8K4C05n@alien.lan> <b67eb51d-75e8-62c5-d1c4-fc3015e13fc6@web.de>
In-Reply-To: <b67eb51d-75e8-62c5-d1c4-fc3015e13fc6@web.de>
From:   Tilman Vogel <tilman.vogel@web.de>
Date:   Thu, 27 Aug 2020 11:05:26 +0200
Message-ID: <CAAbQbbDM-C3UzQVqm6tdUV+wztKVu-g=gLDKEp_oJQiaXVkbNQ@mail.gmail.com>
Subject: Re: [PATCH] patch-id: ignore newline at end of file in diff_flush_patch_id()
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That's great, thanks René! Looking forward to try that out!

Tilman

Am Mi., 19. Aug. 2020 um 00:09 Uhr schrieb René Scharfe <l.s.r@web.de>:
>
> Whitespace is ignored when calculating patch IDs.  This is done by
> removing all whitespace from diff lines before hashing them, including
> a newline at the end of a file.  If that newline is missing, however,
> diff reports that fact in a separate line containing "\ No newline at
> end of file\n", and this marker is hashed like a context line.
>
> This goes against our goal of making patch IDs independent of
> whitespace.  Use the same heuristic that 2485eab55cc (git-patch-id: do
> not trip over "no newline" markers, 2011-02-17) added to git patch-id
> instead and skip diff lines that start with a backslash and a space
> and are longer than twelve characters.
>
> Reported-by: Tilman Vogel <tilman.vogel@web.de>
> Initial-test-by: Tilman Vogel <tilman.vogel@web.de>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  diff.c            |  2 ++
>  t/t3500-cherry.sh | 23 +++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/diff.c b/diff.c
> index f9709de7b45..f175019eb7a 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6044,6 +6044,8 @@ static void patch_id_consume(void *priv, char *line, unsigned long len)
>         struct patch_id_t *data = priv;
>         int new_len;
>
> +       if (len > 12 && starts_with(line, "\\ "))
> +               return;
>         new_len = remove_space(line, len);
>
>         the_hash_algo->update_fn(data->ctx, line, new_len);
> diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
> index f038f34b7c0..2b8d9cb38ed 100755
> --- a/t/t3500-cherry.sh
> +++ b/t/t3500-cherry.sh
> @@ -55,4 +55,27 @@ test_expect_success \
>       expr "$(echo $(git cherry master my-topic-branch) )" : "+ [^ ]* - .*"
>  '
>
> +test_expect_success 'cherry ignores whitespace' '
> +       git switch --orphan=upstream-with-space &&
> +       test_commit initial file &&
> +       >expect &&
> +       git switch --create=feature-without-space &&
> +
> +       # A spaceless file on the feature branch.  Expect a match upstream.
> +       printf space >file &&
> +       git add file &&
> +       git commit -m"file without space" &&
> +       git log --format="- %H" -1 >>expect &&
> +
> +       # A further change.  Should not match upstream.
> +       test_commit change file &&
> +       git log --format="+ %H" -1 >>expect &&
> +
> +       git switch upstream-with-space &&
> +       # Same as the spaceless file, just with spaces and on upstream.
> +       test_commit "file with space" file "s p a c e" file-with-space &&
> +       git cherry upstream-with-space feature-without-space >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.28.0
