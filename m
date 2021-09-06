Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60314C433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 18:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39E2060724
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 18:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245094AbhIFS6w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 14:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244964AbhIFS6v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 14:58:51 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6F7C061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 11:57:46 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so9785002otg.11
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 11:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cA8yZ9Cz1KaZwzBurxAuDsxw+w6dQaah+wOPYhuxkAg=;
        b=FiH/YrWVuCQNomImO8hfeaOSioWd6QBascqdWV2qokOsWa+737afM2i0darvExv/cF
         dsijbGJ3dtJ2gTcy6Mg8qyvCs7WaSoPRKy7ruww1D+qfYYisnB4WmMwUOmsnO62nYN44
         TEP7AjzRzf55+1sFY9KEr4XksK/jRBKx5RacMcUTuukygLk1j21+W7X7gn0PKR8XDQb2
         ImxiXhzebcoXFYe55/TvXLiWwn2XT/qwHUyYZAbAnauZswzcQL920A/M0BB3aNkMYoFC
         PO7lRRPTgCZ8kgsYaq2xoGwL/1WzOJAz0ZFgwM2VVaorHCrZQFg/J+dnbJ7BSYd6rMlc
         XG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cA8yZ9Cz1KaZwzBurxAuDsxw+w6dQaah+wOPYhuxkAg=;
        b=DMjj331yl4NapOme5w6friYsCImm1Khs9hiZ5vM17GmlJ/TqyPJY0wnGBedo2RwCds
         J80C15VcAhtLGe3b7F21ondSnVf4FVZZ4WhbVqXGtEHb45Tj/3EPXI04nJbvVWyJ7cqQ
         6kpfXbiDo0cys9ByzFgPmk/TLPu1x+izy6mXQsNYjzBorlQM7CxHYcEVh6VgXsjZaRng
         YIdCPwHde21gs9BuLQ1nqw7g18la878ARb6iIaGJwkj00RZdL5+zm/u170WKDq052INY
         XalCNb1sNXADajZc0Xv+rC0pzNdnRuKcx2Ecrj7GrTAGiuKQWjuvjvdHTSOWvanFhNwo
         BN4A==
X-Gm-Message-State: AOAM530QK7US2SdP+Q7L/GllCKy2PZl/DKzamgT/eXWJJLxemfcoE5un
        +EaEqY2o1EluJbzLxjY0R2mFhAW0johllsgb2LhghvC8VSw=
X-Google-Smtp-Source: ABdhPJzh/WblDnCXt2w9Heqrx8UMTi3rPAv5CZF5TVtuwlizAg9fVKUQuFlrvj6u3bKtox4nz6cV7mdpPr/qdzZPn8M=
X-Received: by 2002:a9d:609e:: with SMTP id m30mr11814846otj.174.1630954665913;
 Mon, 06 Sep 2021 11:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqczr26i9f.fsf@gitster.g> <20210905190657.2906699-1-gitster@pobox.com>
In-Reply-To: <20210905190657.2906699-1-gitster@pobox.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 6 Sep 2021 11:57:34 -0700
Message-ID: <CABPp-BGrg7eBCeq7SLvx3N5p7HyKGwS7qwTe=+En6OfiKhiXPQ@mail.gmail.com>
Subject: Re: [PATCH v2] apply: resolve trivial merge without hitting ll-merge
 with "--3way"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, lilinchao@oschina.cn,
        Jerry Zhang <jerry@skydio.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 5, 2021 at 12:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> The ll_binary_merge() function assumes that the ancestor blob is
> different from either side of the new versions, and always fails
> the merge in conflict, unless -Xours or -Xtheirs is in effect.
>
> The normal "merge" machineries all resolve the trivial cases
> (e.g. if our side changed while their side did not, the result
> is ours) without triggering the file-level merge drivers, so the
> assumption is warranted.
>
> The code path in "git apply --3way", however, does not check for
> the trivial three-way merge situation and always calls the
> file-level merge drivers.  This used to be perfectly OK back
> when we always first attempted a straight patch application and
> used the three-way code path only as a fallback.  Any binary
> patch that can be applied as a trivial three-way merge (e.g. the
> patch is based exactly on the version we happen to have) would
> always cleanly apply, so the ll_binary_merge() that is not
> prepared to see the trivial case would not have to handle such a
> case.
>
> This no longer is true after we made "--3way" to mean "first try
> three-way and then fall back to straight application", and made
> "git apply -3" on a binary patch that is based on the current
> version no longer apply.
>
> Teach "git apply -3" to first check for the trivial merge cases
> and resolve them without hitting the file-level merge drivers.
>
> Signed-off-by: Jerry Zhang <jerry@skydio.com>
> [jc: stolen tests from Jerry's patch]
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  apply.c                   | 21 ++++++++++++++++++
>  t/t4108-apply-threeway.sh | 45 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
>
> diff --git a/apply.c b/apply.c
> index 44bc31d6eb..c9f9503e90 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3467,6 +3467,21 @@ static int load_preimage(struct apply_state *state,
>         return 0;
>  }
>
> +static int resolve_to(struct image *image, const struct object_id *result_id)
> +{
> +       unsigned long size;
> +       enum object_type type;
> +
> +       clear_image(image);
> +
> +       image->buf = read_object_file(result_id, &type, &size);
> +       if (!image->buf || type != OBJ_BLOB)
> +               die("unable to read blob object %s", oid_to_hex(result_id));
> +       image->len = size;
> +
> +       return 0;
> +}
> +
>  static int three_way_merge(struct apply_state *state,
>                            struct image *image,
>                            char *path,
> @@ -3478,6 +3493,12 @@ static int three_way_merge(struct apply_state *state,
>         mmbuffer_t result = { NULL };
>         int status;
>
> +       /* resolve trivial cases first */
> +       if (oideq(base, ours))
> +               return resolve_to(image, theirs);
> +       else if (oideq(base, theirs) || oideq(ours, theirs))
> +               return resolve_to(image, ours);
> +
>         read_mmblob(&base_file, base);
>         read_mmblob(&our_file, ours);
>         read_mmblob(&their_file, theirs);
> diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
> index 65147efdea..cc3aa3314a 100755
> --- a/t/t4108-apply-threeway.sh
> +++ b/t/t4108-apply-threeway.sh
> @@ -230,4 +230,49 @@ test_expect_success 'apply with --3way --cached and conflicts' '
>         test_cmp expect.diff actual.diff
>  '
>
> +test_expect_success 'apply binary file patch' '
> +       git reset --hard main &&
> +       cp "$TEST_DIRECTORY/test-binary-1.png" bin.png &&
> +       git add bin.png &&
> +       git commit -m "add binary file" &&
> +
> +       cp "$TEST_DIRECTORY/test-binary-2.png" bin.png &&
> +
> +       git diff --binary >bin.diff &&
> +       git reset --hard &&
> +
> +       # Apply must succeed.
> +       git apply bin.diff
> +'
> +
> +test_expect_success 'apply binary file patch with 3way' '
> +       git reset --hard main &&
> +       cp "$TEST_DIRECTORY/test-binary-1.png" bin.png &&
> +       git add bin.png &&
> +       git commit -m "add binary file" &&
> +
> +       cp "$TEST_DIRECTORY/test-binary-2.png" bin.png &&
> +
> +       git diff --binary >bin.diff &&
> +       git reset --hard &&
> +
> +       # Apply must succeed.
> +       git apply --3way --index bin.diff
> +'
> +
> +test_expect_success 'apply full-index patch with 3way' '
> +       git reset --hard main &&
> +       cp "$TEST_DIRECTORY/test-binary-1.png" bin.png &&
> +       git add bin.png &&
> +       git commit -m "add binary file" &&
> +
> +       cp "$TEST_DIRECTORY/test-binary-2.png" bin.png &&
> +
> +       git diff --full-index >bin.diff &&
> +       git reset --hard &&
> +
> +       # Apply must succeed.
> +       git apply --3way --index bin.diff
> +'
> +
>  test_done
> --
> 2.33.0-408-g8e1aa136b3

Reviewed-by: Elijah Newren <newren@gmail.com>
