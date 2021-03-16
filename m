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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC45C433E0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 05:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDC6B6515D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 05:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbhCPFUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 01:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbhCPFUA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 01:20:00 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700C0C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 22:20:00 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id j8so8073576otc.0
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 22:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6e49od3mer6zexTko2ARZJVzywgy7uZX1sYgooYuh08=;
        b=JmwERuN0SE4yvfyciCK3vMtijnI3xmDCwaqZQ66pD+PkSWstQd1oK2DF0AWfCJWhWn
         RWG2EOHa6VqA+2w0eXzVrJTUo+uhlMfn6y9c9U126+Q5409ag7dzuYFRMO2Kfp2Go5ip
         thfIL9eUahAzwlVJvb1Qusgw+UgVjJxZrgbjREejgyBqtcv7Z3opuik6gj4KYt3MYzq7
         mWRkWULll2cvyGoz7SsoJbhHh/vcQNmVzXukwUjCYRtjKXGwL89yWmXZsMeBSqOppiu0
         6ZMGhKGVox4mxVF1bmjI0M5iN43zmkfRmx1WFTIL/bKRco79/5nPNQgD8ojOwj0dWd1Z
         nZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6e49od3mer6zexTko2ARZJVzywgy7uZX1sYgooYuh08=;
        b=mbcwjSlCZ/BVh+kQ54kLNKZ7ElzqyB6E9PWqPttdqKNZWXEU2LG2SsrFSakyTeqFjb
         4znrXTdRKM94Ja8DXLU7QwKfhVfohAZ66yGvZLUl/Dx48SA/hYXhFYzW1f08iCArTHZo
         zPOYUEX0lsVdeO+e3I9GghvMNYVZa4vNe7h55lId1vq6W2q7EFyz8b9bIuqhL1cTCc2Q
         riRkQJ2h766XXk7Vw03I0Gr2zQLIc83RKxRGsRWN6CbXxNf45wItLDKpQjj8+EAqXZY8
         QnenKJUuhjyYwV0yj2DkDi0JER38fZ0IBAIrHb+rm5CAMWJBP6RcSjuREPZ6jLDDrECm
         hmkQ==
X-Gm-Message-State: AOAM532l5+Hb4+07Q3XAKaGCIgPtZ1Se+4hnWBLp7hfZXuI6KN3KDOF+
        QLCq/pTDFgQktBIdYu+oOPvvYoWuFSjpRS+QEeQ=
X-Google-Smtp-Source: ABdhPJxgudQLSsQg6D1C6qhzmhkMboJ0XZUUwgNHHN7XJWmz0pPiaBAw5WLNL+g/GgB9ee39miforAHYQ842Ketx9j0=
X-Received: by 2002:a9d:4d0e:: with SMTP id n14mr2090879otf.316.1615871999817;
 Mon, 15 Mar 2021 22:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210308022138.28166-1-avarab@gmail.com> <20210315234344.28427-9-avarab@gmail.com>
In-Reply-To: <20210315234344.28427-9-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 Mar 2021 22:19:48 -0700
Message-ID: <CABPp-BFXoCs-WXfPjPrQ8YLL2YXG5-Dd85LLnvE_yOKQ5NVD7Q@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] show tests: add test for "git show <tree>"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 4:44 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Add missing tests for showing a tree with "git show". Let's test for
> showing a tree, two trees, and that doing so doesn't recurse.
>
> The only tests for this code added in 5d7eeee2ac6 (git-show: grok
> blobs, trees and tags, too, 2006-12-14) were the tests in
> t7701-repack-unpack-unreachable.sh added in ccc1297226b (repack:
> modify behavior of -A option to leave unreferenced objects unpacked,
> 2008-05-09).
>
> Let's add this common mode of operation to the "show" tests
> themselves. It's more obvious, and the tests in
> t7701-repack-unpack-unreachable.sh happily parse if we start buggily
> emitting trees recursively.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  t/t7007-show.sh | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/t/t7007-show.sh b/t/t7007-show.sh
> index 42d3db62468..37ce718b231 100755
> --- a/t/t7007-show.sh
> +++ b/t/t7007-show.sh
> @@ -38,6 +38,45 @@ test_expect_success 'showing two commits' '
>         test_cmp expect actual.filtered
>  '
>
> +test_expect_success 'showing a tree' '
> +       cat >expected <<-EOF &&
> +       tree main1:
> +
> +       main1.t
> +       EOF
> +       git show main1: >actual &&

I had used COMMIT:PATH syntax before, but I was unaware PATH could be
empty to refer to the toplevel tree.

Still, it seems main1^{tree} might be a bit clearer?

> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'showing two trees' '
> +       cat >expected <<-EOF &&
> +       tree main1:
> +
> +       main1.t
> +
> +       tree main2:
> +
> +       main1.t
> +       main2.t
> +       EOF
> +       git show main1: main2: >actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'showing a trees is not recursive' '
> +       git worktree add not-recursive main1 &&
> +       mkdir not-recursive/a &&
> +       test_commit -C not-recursive a/file &&
> +       cat >expected <<-EOF &&
> +       tree a/file:
> +
> +       a/
> +       main1.t
> +       EOF
> +       git -C not-recursive show a/file: >actual &&

a/file: was really confusing to me.  Perhaps I should have
known/remembered that a/file was both a filename and a tagname (I
dislike that part of test_commit), and you are just using that tag but
I had to fetch your changes and run them and play around to figure out
what was going on here.

Can we just use "HEAD^{tree}" instead of "a/file:" ?

> +       test_cmp expected actual
> +'
> +
>  test_expect_success 'showing a range walks (linear)' '
>         cat >expect <<-EOF &&
>         commit $(git rev-parse main3)
> --
> 2.31.0.rc2.211.g1d0b8788b3
