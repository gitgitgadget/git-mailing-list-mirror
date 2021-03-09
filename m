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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7700C433E9
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 17:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F9466523D
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 17:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhCIRUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 12:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhCIRTb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 12:19:31 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAE5C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 09:19:31 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id x23so3231347oop.1
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 09:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dVaeidsGxst5Gul55dqqgOZj7jZQO9C+5FhhFrEMT/4=;
        b=prUCAe33KAgGwXLcQrVWZg0j5E8/FZbLwdPvHz3mmI2Ssl7zaguATde0CWEqtfj5u0
         jz6lMoHFI3T5Bje9isetCpvQnzKpdQSE+ycABOMzSzonbonx2yj4IKgvqOOpTDT5uRgg
         SXwjQHjpuxNds4RrEw6m/g8F/7ebiPQP1krvKpVjUHNGym98ZwZgUoPk+MzaLVPavwL+
         Mf9ob/Kqd/1etZF3gqhgxFnjC5JmXjlvH0ak+cGKggBMgNPcyfjvTy7GzVOartOjOntf
         brpdLkJdRn3pHg11Tu5+87Lm+ZzrBAID2JV0owEYb0brXQ4gqfke9kflKqFPhx03lWdZ
         qhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dVaeidsGxst5Gul55dqqgOZj7jZQO9C+5FhhFrEMT/4=;
        b=TnoocZTJ9I4S6FEdWGO4fIDFI0sWkRz8thFybI2ojsNKSvmenCpZkUZ6KZ3njQoRdH
         It2fk2Nssyj3u6p4knZ+YN34Yhx4C+QBUrVNWCAqmHgk/XSgXSm2ORvo4t/x6NOwrmXa
         zVUuaYVGQkFsFjB3aECkOo4XcfFldHt1hAGpXTHOrJkllpslJqqWVMKcL9I8KGNC6dlO
         MtQ5QZfNQ97ARWdH4LNJ8uslHDnAlK1kVhRsNCKoKGE51GSW7Zpcm0KXRrXJs9HNH9Fq
         7hBTsVl7X4e0vMuzr3m4w3P4xQyuGSZgIJxLZjD1gjf7WZe0g7AIEN2W9Pu/1pgXtHCe
         goOw==
X-Gm-Message-State: AOAM530KNGo1GZhc5d4ORdkP9Ze3Wbm1feh+sffxb8lOXLG20ZnC3wIa
        rcqKK2evE9KR69e9p9b96bWmic6W7Z+OJFIamae8aJqdFYw=
X-Google-Smtp-Source: ABdhPJyCAoTCS2ggNB3dbmO+YR+ByobQUYR/BxoSnLJC0BlOMRxVRCPFpPeFUMOusZxrIylTYb21/jBWXA83yRl8Q/o=
X-Received: by 2002:a4a:94a7:: with SMTP id k36mr22849556ooi.45.1615310370440;
 Tue, 09 Mar 2021 09:19:30 -0800 (PST)
MIME-Version: 1.0
References: <20210308022138.28166-1-avarab@gmail.com> <20210308150650.18626-16-avarab@gmail.com>
In-Reply-To: <20210308150650.18626-16-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Mar 2021 09:19:19 -0800
Message-ID: <CABPp-BHfH4v4xEc4MPv24tRoW1pPrXSCFfqCpSSyGOGT_-1kCA@mail.gmail.com>
Subject: Re: [PATCH 15/30] merge-tree tests: test for the mode comparison in same_entry()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 8, 2021 at 7:07 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Add a test to stress the "a->mode =3D=3D b->mode" comparison in
> merge-tree.c's same_entry().

I can't remember now; did you remove the preliminary canon_mode()?  If
so, does this check actually need to be generalized?

For example, if someone has a git repository where a mode on a file in
one part of history is 100666, and on the other is 100644, then the
equality comparison no longer is satisfied because the modes haven't
been canonicalized.  Yet it's clear how the merge-tree should resolve
it -- both are regular, non-executable files, so the merged mode
should be 100644.

> That code was initially added by Linus in 33deb63a36f (Add
> "merge-tree" helper program. Maybe it's retarded, maybe it's helpful.,
> 2005-04-14), and then again in its current form in
> 492e0759bfe (Handling large files with GIT, 2006-02-14).
>
> However, nothing was testing that we handled this case
> correctly. Simply removing the mode comparison left all tests passing,
> but as seen here it's important that we don't think a path with the
> same content but different modes is the same_entry().
>
> The rest of this series will touch code that's relevant to this, but
> won't change its behavior. This test is just something I came up with
> in testing whether the mode test in same_entry() was needed at all.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  t/t4300-merge-tree.sh | 44 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
> index e59601e5fe9..f783d784d02 100755
> --- a/t/t4300-merge-tree.sh
> +++ b/t/t4300-merge-tree.sh
> @@ -40,6 +40,25 @@ test_expect_success 'file add A, B (same)' '
>         test_must_be_empty actual
>  '
>
> +test_expect_success 'file add A, B (different mode)' '
> +       git reset --hard initial &&
> +       test_commit "add-a-b-same-diff-mode-A" "ONE" "AAA" &&
> +       git reset --hard initial &&
> +       echo AAA >ONE &&
> +       test_chmod +x ONE &&
> +       test_tick &&
> +       git commit -m"add-a-b-same-diff-mode-B" &&
> +       git tag "add-a-b-same-diff-mode-B" HEAD &&
> +       git merge-tree initial add-a-b-same-diff-mode-A add-a-b-same-diff=
-mode-B >actual &&
> +       cat >expected <<EXPECTED &&
> +added in both
> +  our    100644 $(git rev-parse add-a-b-same-diff-mode-A:ONE) ONE
> +  their  100755 $(git rev-parse add-a-b-same-diff-mode-B:ONE) ONE
> +EXPECTED
> +
> +       test_cmp expected actual
> +'
> +
>  test_expect_success 'file add A, B (different)' '
>         git reset --hard initial &&
>         test_commit "add-a-b-diff-A" "ONE" "AAA" &&
> @@ -61,6 +80,31 @@ EXPECTED
>         test_cmp expected actual
>  '
>
> +test_expect_success 'file add A, B (different and different mode)' '
> +       git reset --hard initial &&
> +       test_commit "add-a-b-diff-diff-mode-A" "ONE" "AAA" &&
> +       git reset --hard initial &&
> +       echo BBB >ONE &&
> +       test_chmod +x ONE &&
> +       test_tick &&
> +       git commit -m"add-a-b-diff-diff-mode-B" &&
> +       git tag "add-a-b-diff-diff-mode-B" &&
> +       git merge-tree initial add-a-b-diff-diff-mode-A add-a-b-diff-diff=
-mode-B >actual &&
> +       cat >expected <<EXPECTED &&
> +added in both
> +  our    100644 $(git rev-parse add-a-b-diff-diff-mode-A:ONE) ONE
> +  their  100755 $(git rev-parse add-a-b-diff-diff-mode-B:ONE) ONE
> +@@ -1 +1,5 @@
> ++<<<<<<< .our
> + AAA
> ++=3D=3D=3D=3D=3D=3D=3D
> ++BBB
> ++>>>>>>> .their
> +EXPECTED
> +
> +       test_cmp expected actual
> +'
> +
>  test_expect_success 'file change A, !B' '
>         git reset --hard initial &&
>         test_commit "change-a-not-b" "initial-file" "BBB" &&
> --
> 2.31.0.rc0.126.g04f22c5b82
