Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83D9C432BE
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 23:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BB406101B
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 23:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbhG1Xt3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 19:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbhG1Xt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 19:49:28 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3D4C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 16:49:25 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 21so5955221oin.8
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 16:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h4GDzowlwpm3HA2tUXKAH79HL5f6HBKqKKlJnVC8TSc=;
        b=ImvVy92w1Px0pDaxwDXWIETW7M1kN0+cx1+29m1P19n6fmLoknxGHxnLz02SU9IkiB
         93hUnBEmNVsGfp9OxQhTHgX3GyvxmYaRBQOvY5mhFV5svRjTGVIXBR/JMIADjQ1FlALB
         iQKQV7xgXzNRGW0rAihJGeQ4p1HHFNJ8cb3Sv1OYrS9oeDQSuiR2qrA+MQOPsThswchy
         GgzYEHyXzogKYG1M/XMocK89aKP5K9wXc+tcRobfB9Wu2fBShYkHrOJoMA0Q3bas3aVG
         PRJ51ZLIQvThK/BIaek6pzDL9XWb76E8lvM0PGtqQm3jG24vPQNIa6zAtd1ixMh9EbCD
         jUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4GDzowlwpm3HA2tUXKAH79HL5f6HBKqKKlJnVC8TSc=;
        b=Pwhl5EqxbVmw81iT/GAk4XmPbU0qeEi11JSQu+Of8+hh7i7h93bDJpBjEilrdKwQux
         55rBL9PZMxLfQy038OcP7Qxx+I4ySP8347z1OlbxrBjOhfAmyUOE7bh9RJ2WsbVOAR/V
         4sLzEskzb66z6+1ANNZy6xdoyrl9fZbAid22iafYV6Yx7t2O9q2ZZRQce9d2QfRwH1XA
         FP2HY4Sz7zgZekvtxe9niY8psHTpy8hPCcGcYFch6t72ax29/VioXJDVyNP2JFFC7Pg+
         u/r1rcxyu80GNjwj2lgcyF0OJyBeZmbVfZGkltSel9+XoIH9HQUdE8J46pYXPH500VCd
         Llag==
X-Gm-Message-State: AOAM53267+XYZBl6L/UOJbprdcBnrsgfWk1Lhm/7kwE85xBcnjvVX7mn
        8P8UIenC883dQ64hSB5xjGBTjL/1+VeZBEYqQCc=
X-Google-Smtp-Source: ABdhPJyIgMrP+XQP5QRW4lawRTRgvmDK77gxdEQnjWMz4hx8xvuIGGsQKb6HOMNt9/1LqMLGHCIe3V2E+9NayBUkKR0=
X-Received: by 2002:aca:acc5:: with SMTP id v188mr8087004oie.167.1627516164907;
 Wed, 28 Jul 2021 16:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210728024434.20230-1-jerry@skydio.com> <xmqqh7gfawlt.fsf@gitster.g>
 <xmqqeebi9vd0.fsf_-_@gitster.g>
In-Reply-To: <xmqqeebi9vd0.fsf_-_@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 28 Jul 2021 17:49:13 -0600
Message-ID: <CABPp-BFh3uV9-X8iaKHA771TUneBDYmOKU5+5y9XsE-11UL7tQ@mail.gmail.com>
Subject: Re: [PATCH] ll-merge: teach ll_binary_merge() a trivial three-way merge
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jerry Zhang <jerry@skydio.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 28, 2021 at 11:55 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> The low-level binary merge code assumed that the caller will not
> feed trivial merges that would have been resolved at the tree level;
> because of this, ll_binary_merge() assumes the ancestor is different
> from either side, always failing the merge in conflict unless -Xours
> or -Xtheirs is in effect.
>
> But "git apply --3way" codepath could ask us to perform three-way
> merge between two binaries A and B using A as the ancestor version.
> The current code always fails such an application, but when given a
> binary patch that turns A into B and asked to apply it to A, there
> is no reason to fail such a request---we can trivially tell that the
> result must be B.
>
> Arguably, this fix may belong to one level higher at ll_merge()
> function, which dispatches to lower-level merge drivers, possibly
> even before it renormalizes the three input buffers.  But let's
> first see how this goes.
>
> Signed-off-by: Jerry Zhang <jerry@skydio.com>
> [jc: stolen new tests from Jerry's patch]
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * This time as a proper patch form.  I am asking Elijah's input as
>    I suspect this belongs to ll_merge() layer and it may impact not
>    just "apply --3way" codepath (which is the primary intended user
>    of this "feature") but the merge strategies.  On the other hand,
>    properly written merge strategies would not pass trivial merges
>    down to the low-level backends, so it may not matter much to,
>    say, "merge -sort" and friends.

The patch looks correct if we choose to modify the ll_binary_merge level.

I agree that properly written merge strategies (at least both
merge-recursive and merge-ort) would not pass trivial merges down to
the low-level backends...but I think this change still matters to them
from a performance perspective.  Additional up-front full content
comparisons feel like an unnecessary performance penalty, so if we do
something like this, keeping it at the ll_binary_merge() level to
limit it to binary files would limit the penalty.  However...

It appears that try_threeway() in apply.c is already computing the
OIDs of the blobs involved, so it looks like the full content
comparison is unnecessary even in the apply --3way case.  If we moved
the trivial-merge check to that function, it could just compare the
OIDs rather than comparing the full content.

>  ll-merge.c                | 56 +++++++++++++++++++++++++++------------
>  t/t4108-apply-threeway.sh | 45 +++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+), 17 deletions(-)
>
> diff --git a/ll-merge.c b/ll-merge.c
> index 261657578c..301e244971 100644
> --- a/ll-merge.c
> +++ b/ll-merge.c
> @@ -46,6 +46,13 @@ void reset_merge_attributes(void)
>         merge_attributes = NULL;
>  }
>
> +static int same_mmfile(mmfile_t *a, mmfile_t *b)
> +{
> +       if (a->size != b->size)
> +               return 0;
> +       return !memcmp(a->ptr, b->ptr, a->size);
> +}
> +
>  /*
>   * Built-in low-levels
>   */
> @@ -58,9 +65,18 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
>                            const struct ll_merge_options *opts,
>                            int marker_size)
>  {
> +       int status;
>         mmfile_t *stolen;
>         assert(opts);
>
> +       /*
> +        * With -Xtheirs or -Xours, we have cleanly merged;
> +        * otherwise we got a conflict, unless 3way trivially
> +        * resolves.
> +        */
> +       status = (opts->variant == XDL_MERGE_FAVOR_OURS ||
> +                 opts->variant == XDL_MERGE_FAVOR_THEIRS) ? 0 : 1;
> +
>         /*
>          * The tentative merge result is the common ancestor for an
>          * internal merge.  For the final merge, it is "ours" by
> @@ -68,18 +84,30 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
>          */
>         if (opts->virtual_ancestor) {
>                 stolen = orig;
> +               status = 0;
>         } else {
> -               switch (opts->variant) {
> -               default:
> -                       warning("Cannot merge binary files: %s (%s vs. %s)",
> -                               path, name1, name2);
> -                       /* fallthru */
> -               case XDL_MERGE_FAVOR_OURS:
> -                       stolen = src1;
> -                       break;
> -               case XDL_MERGE_FAVOR_THEIRS:
> +               if (same_mmfile(orig, src1)) {
>                         stolen = src2;
> -                       break;
> +                       status = 0;
> +               } else if (same_mmfile(orig, src2)) {
> +                       stolen = src1;
> +                       status = 0;
> +               } else if (same_mmfile(src1, src2)) {
> +                       stolen = src1;
> +                       status = 0;
> +               } else {
> +                       switch (opts->variant) {
> +                       default:
> +                               warning("Cannot merge binary files: %s (%s vs. %s)",
> +                                       path, name1, name2);
> +                               /* fallthru */
> +                       case XDL_MERGE_FAVOR_OURS:
> +                               stolen = src1;
> +                               break;
> +                       case XDL_MERGE_FAVOR_THEIRS:
> +                               stolen = src2;
> +                               break;
> +                       }
>                 }
>         }
>
> @@ -87,13 +115,7 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
>         result->size = stolen->size;
>         stolen->ptr = NULL;
>
> -       /*
> -        * With -Xtheirs or -Xours, we have cleanly merged;
> -        * otherwise we got a conflict.
> -        */
> -       return opts->variant == XDL_MERGE_FAVOR_OURS ||
> -              opts->variant == XDL_MERGE_FAVOR_THEIRS ?
> -              0 : 1;
> +       return status;
>  }
>
>  static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
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
> 2.32.0-561-g6177dfa0d2
