Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B38C61DA4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 01:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjBOBLX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 20:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbjBOBLW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 20:11:22 -0500
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DC82ED5F
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 17:11:01 -0800 (PST)
Received: by mail-pg1-f180.google.com with SMTP id a23so11432968pga.13
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 17:11:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHwCiSOA0Kgx49EF+tnQwshYQfCcc8TlCDhyjm36Bak=;
        b=vyWZAH1sObp1+rkBsy77oCM4pJuM3qQ80hvonDxpe+D/RwY9VbDOtWdWQxUc3yVRq+
         WZRFowKbtHhe9sHX9SnfDoTC2twNbqdGJwydPPRdzOscgeiRw8HcGijCGjpybLoe0+DE
         sm+yyOGAXfgBeG+vWlRMVamO8iSqkKluBCeCIY+Uf5gpB/Vm11LF3f7G2I42zRHoJBNc
         3s0iIMqI6leMRifXln/EUjDFvNf4ixNyAJUtmmmKttPAbSRje0L9cVi9djBVTz5xFjKB
         PrqsaDwRIZZK/w4yh2dm9Z23zrSrUszYxveVOONqLO6sozyEYPAbSBvmd4/NGCGKui4u
         l2nw==
X-Gm-Message-State: AO0yUKXhMDmtC9MSn739CpYhR8lC7vDdxIAeeIIgLQMgVHkyFCfKiizW
        KJNYKVS31IQJfvamjN7sv8kgz6XDY+9elB40hiQ=
X-Google-Smtp-Source: AK7set+5cvnysWvH7XOz9fHJgUZ9gobNgJcP5fyXu3zF3tjTSRIRxCDsSsfbzaWOaEeIx+1ZFRgF4v4tQVdcZ4rplbI=
X-Received: by 2002:a63:5c1a:0:b0:4fb:a109:3272 with SMTP id
 q26-20020a635c1a000000b004fba1093272mr213749pgb.4.1676423356706; Tue, 14 Feb
 2023 17:09:16 -0800 (PST)
MIME-Version: 1.0
References: <20230206211823.8651-1-cheskaqiqi@gmail.com> <20230209154417.10763-1-cheskaqiqi@gmail.com>
 <20230209154417.10763-4-cheskaqiqi@gmail.com>
In-Reply-To: <20230209154417.10763-4-cheskaqiqi@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 Feb 2023 20:09:04 -0500
Message-ID: <CAPig+cTKCMwCQ2TxXyc1KquZmB0QWQAuuag52a1qmeYh6XPXYQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] t4113: put executable lines to test_expect_success
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 9, 2023 at 11:00 AM Shuqi Liang <cheskaqiqi@gmail.com> wrote:
> As t/README says, put all code inside test_expect_success and
> other assertions. This script is written in old style,where there are
> some executable lines outside test_expect_success. Put the executable
> lines inside the test_expect_success.

Although it's true that t/README explains why code should be placed
inside tests, you can help readers out by simply explaining the reason
here in the commit message. For instance, you might replace the above
paragraph with:

    Some old test scripts have setup code outside of tests. This
    is problematic since any failures of the setup code will go
    unnoticed. Therefore, move setup code into the tests themselves
    so that failures are properly flagged.

As for the rest of the commit message...

> As t/README says,use "<<-" instead of "<<"
> to strip leading TABs used for indentation. Change the "<<" to "<<-"
>
> for example:
> -cat >test-patch <<\EOF
> -diff a/file b/file
>
>  test_expect_success 'apply at the beginning' '
> +       cat >test-patch <<-\EOF
> +       diff a/file b/file
> +       --- a/file

Certain changes are considered obvious by reviewers, so you don't need
to mention them explicitly in the commit message. This is one such
change. Any reviewer who sees that you indented the here-doc body to
match the indentation of the rest of the test body will understand why
you changed `<<` to `<<-` without the commit message having to explain
it.

> As t/README says,chain test assertions.Chain this test assertions
> with &&.
>
> For example:
>
> -cat >test-patch <<\EOF
> -diff --git a/file b/file
>
> + cat >test-patch <<-\EOF &&
> + diff --git a/file b/file

Same thing. Reviewers understand that all code inside a test body must
have an intact &&-chain, so you needn't mention this in the commit
message.

> This script is written in old style,where there are something like
>
>         echo x >file &&
>         echo y >>file &&
>         echo z >>file
>
>   Change it to this stlye :
>         {
>         echo x &&
>         echo y &&
>         echo z
>         } >file

This is similar. This is such a simple style change, and the code
fragment itself is so tiny, that a reviewer can understand this change
without the commit message spelling it out.

> In order to escape for executable lines inside the test_expect_success.
> Change ' in executable lines to '\'' in order to escape.

Likewise.

Reviewers appreciate well-explained commit messages, but they also
appreciate succinctness. Although it may not always be obvious how
much to write in a commit message, you can assume that reviewers will
understand obvious changes simply by reading the patch itself, thus
you don't need to mention every little detail in the commit message.
The important thing to mention in the commit message is the
explanation of _why_ the change is being made, plus any changes which
might not be obvious. In this case, all the changes are obvious, so,
really, you can collapse this entire commit message to just the first
paragraph.

> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
> ---
> diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
> @@ -8,46 +8,45 @@ test_description='git apply trying to add an ending line.
> -# setup
> -

Good to see that you got rid of the now-unnecessary comment.

> -cat >test-patch <<\EOF
> -diff --git a/file b/file
> ---- a/file
> -+++ b/file
> -@@ -1,2 +1,3 @@
> - a
> - b
> -+c
> -EOF
> -
> -echo 'a' >file
> -echo 'b' >>file
> -echo 'c' >>file
> -
>  test_expect_success setup '
> +       cat >test-patch <<-\EOF &&
> +       diff --git a/file b/file
> +       --- a/file
> +       +++ b/file
> +       @@ -1,2 +1,3 @@
> +        a
> +        b
> +       +c
> +       EOF

Okay.

> +       {
> +       echo '\''a'\'' &&
> +       echo '\''b'\'' &&
> +       echo '\''c'\''
> +       } >file &&

A few comments:

This is unnecessarily confusing. Although this does work, it would be
sufficient just to change the single-quotes to double-quotes, like
this:

    {
    echo "a" &&
    echo "b" &&
    echo "c"
    } >file &&

Even simpler, you could drop the quotes altogether for such a simple case:

    {
    echo a &&
    echo b &&
    echo c
    } >file &&

However, as mentioned elsewhere in this thread, a really succinct way
to do this, taking advantage of modern style would be to use
test_write_lines(), so the five lines collapse to a single line:

    test_write_lines a b c >file &&

> -cat >test-patch <<\EOF
> -diff a/file b/file
> ---- a/file
> -+++ b/file
> -@@ -1,2 +1,3 @@
> -+a
> - b
> - c
> -EOF
> -
> -echo >file 'a
> -b
> -c'
> -git update-index file
>
>  test_expect_success 'apply at the beginning' '
> +       cat >test-patch <<-\EOF &&
> +       diff a/file b/file
> +       --- a/file
> +       +++ b/file
> +       @@ -1,2 +1,3 @@
> +       +a
> +        b
> +        c
> +       EOF
> +
> +       echo >file '\''a
> +       b
> +       c'\'' &&

Same comment about simply using double-quotes instead of
single-quotes, however, this is also another really good place to use
test_write_lines:

    test_write_lines a b c >file &&
