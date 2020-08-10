Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41370C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 16:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D46D20855
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 16:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgHJQXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:23:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41143 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgHJQXR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 12:23:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id r2so8752258wrs.8
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 09:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UUvo4QDuBfzXKwEyWHSz4LbK/C87SOIDxK0M8/wwojM=;
        b=FqVaVIsoLP21JT54EOhXM+PLVHaJX4cvFMFxI+uGWDJ5jk8sKZPzJuMzX1e8xjEo2p
         86iNz1aGnOx0Dy34nOgUJgCcn2ApAe7skhwWcZyeOguyqgvcvZ3zBtSr7l17s2LoLJx+
         mIX5MGt9G7Ffp9zpdSHYgNUrd3YWQnLFRSDFHoP4N2mSQJUm5qGXdDIsWtZ638+Q5VQL
         MUuNeRQQmHFZCEtM/WVhueWNoiq0qpvEq6/0erCIkENgkhustdULk46sjKsBEZbR14bC
         TAtynQj/gIkM+iOZ9sfpLiApq4Dyh98Spyjsusv+i6D3VTrcji/z63H7JT3/hDvFS8Rz
         S8NA==
X-Gm-Message-State: AOAM531Op0N7PjQTpfw145x8rfP5tqPiIBa7rGRaRWYY7wnS5+fGnlSd
        6W6Q8IVlFkb/njNqU1fcG2+o/bZn/M2fd5BgbFEOdw5w
X-Google-Smtp-Source: ABdhPJyDhSB/GDaDzzTMGGmEz49gAyRC8fyGyPFtUaSuFa/VPMYQa9vcpzmAWwumUvNeOQZlF2WpJM9ktm1iFTmp/IM=
X-Received: by 2002:adf:ec45:: with SMTP id w5mr25812002wrn.415.1597076595731;
 Mon, 10 Aug 2020 09:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200808075323.36041-1-ray@ameretat.dev> <20200810085343.43717-1-ray@ameretat.dev>
In-Reply-To: <20200810085343.43717-1-ray@ameretat.dev>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 10 Aug 2020 12:23:04 -0400
Message-ID: <CAPig+cSn_wrBuMKzoUZ720Hy-Y9RuPpJtmZ1mr--cnyAP866-Q@mail.gmail.com>
Subject: Re: [PATCH] t4069: test diff behavior with i-t-a paths
To:     "Raymond E. Pasco" <ray@ameretat.dev>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 10, 2020 at 4:54 AM Raymond E. Pasco <ray@ameretat.dev> wrote:
> Add a small test suite to test the behavior of diff with intent-to-add
> paths. Specifically, the diff between an i-t-a entry and a file in the
> worktree should be a "new file" diff, and the diff between an i-t-a
> entry and no file in the worktree should be a "deleted file" diff.
> However, if --ita-visible-in-index is passed, the former should instead
> be a diff from the empty blob.
>
> Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
> ---
> diff --git a/t/t4069-diff-intent-to-add.sh b/t/t4069-diff-intent-to-add.sh
> @@ -0,0 +1,30 @@
> +test_expect_success 'diff between i-t-a and file should be new file' '
> +       cat blueprint >test-file &&
> +       git add -N test-file &&
> +       git diff >output &&
> +       grep "new file mode 100644" output
> +'

If someone comes along and inserts new tests above this one and those
new tests make their own changes to the index or worktree, how can
this test be sure that the "new file mode" line is about 'test-file'
rather than some other entry? It might be better to tighten this test,
perhaps like this:

    git diff -- test-file &&

Same comment applies to the other tests.

> +test_expect_success 'diff between i-t-a and no file should be deletion' '
> +       rm -f test-file &&
> +       git diff >output &&
> +       grep "deleted file mode 100644" output
> +'
> +
> +test_expect_success '--ita-visible-in-index diff should be from empty blob' '
> +       cat blueprint >test-file &&
> +       git diff --ita-visible-in-index >output &&
> +       grep "index e69de29" output
> +'

The hard-coded SHA-1 value in the "index" line is going to cause the
test to fail when the test suite is configured to run with SHA-256.
You could fix it by preparing two hash values -- one for SHA-1 and one
for SHA-256 -- and then looking up the value with test_oid() for use
with grep. On the other hand, if you're not interested in the exact
value, but care only that _some_ hash value is present, then you could
just grep for a hex-string.

But what is this test actually checking? In my experiments, this grep
expression will also successfully match the output from the test
preceding this one, which means that the conditions of this test are
too loose.

To tighten this test, perhaps it makes sense to take a different
approach and check the exact output rather than merely grepping for a
particular string. In other words, something like this might be better
(typed in email, so untested):

    cat >expect <<-\EOF &&
    diff --git a/test-file b/test-file
    index HEX..HEX HEX
    --- a/test-file
    +++ b/test-file
    EOF
    cat blueprint >test-file &&
    git diff --ita-visible-in-index -- test-file >raw &&
    sed "s/[0-9a-f][0-9a-f]*/HEX/g' raw >actual &&
    test_cmp expect actual

In fact, this likely would be a good model to use for all the tests.
