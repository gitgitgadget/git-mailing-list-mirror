Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 082311F5FB
	for <e@80x24.org>; Sun, 26 Feb 2017 10:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbdBZKC4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Feb 2017 05:02:56 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36506 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751983AbdBZKCc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2017 05:02:32 -0500
Received: by mail-oi0-f66.google.com with SMTP id f192so861119oic.3
        for <git@vger.kernel.org>; Sun, 26 Feb 2017 02:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Egkpuf8TG8dOwf7xZBKaZ1koU2Cm1M1ICrxmoiVWSws=;
        b=vDqlfw4gNHcpm09O1gjr2D1AKxL/e+esb0ATEwiykhZrmmqQB02ZIIdwmFnJsDHO+Y
         So2A1DJLeNHDvbl0bHFce4/u0ijqMft5ZdOpBwHhe/SU9x9ZzZKg6ErZU1hJROcpLE+M
         28Zf3mSlRHEzFc4k87oBQKfPfNT/JnyAyS5sa3ksd9Tp1VUPGAiyoy5irT18d4naEPFk
         tOJzMMiVviJD9U4kAd+1bV9OiJfbugDri1bMnJdI8U6CL7NvGwxSwrumaCeW19ySBZi8
         XM4vADzHZZA25axmoXfRF1zSlLtbeB4P1ox7g0il2tF/lMM7q9A/41bo9RySrlRavntY
         q9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Egkpuf8TG8dOwf7xZBKaZ1koU2Cm1M1ICrxmoiVWSws=;
        b=OOvHl7uq56pqTQYUg5zkaxKz79HPFDv6Pff154amXz8ULmP2wtvK7DagF4pRMr9bxC
         cOKxU7KfMarXRz5OQtTwcpz883IV26wA9GprZtUYCL3H0Oq1dlwRD20vrtVR2XFdUapH
         XogeuH6YfImcXcB1CWGcSOZAbKObQN46ByiQT7Q33aun9vZtYD/53m1f5i1t0ms4i5xs
         uUhJQjc3Gogc2Y1IQeOzg05jI3uoJff6aqZgBV1qc5jkH226xw7oK981PG3UXjCyVARn
         quoTkFQNYdC2Eblxpw9wjuhlk/yOhZDK7A7xnCf1m/Nxc/3MlFQX+iTgqcMM6goKlmul
         Ko2g==
X-Gm-Message-State: AMke39n7vCFK0JqUrLuO0yUvpjzmYbrWprNOeJPUHceQKhSm98sDZt4UE8fRiqsPK3YxEwuqQuJcBnkT2RjC9A==
X-Received: by 10.202.80.212 with SMTP id e203mr6128069oib.146.1488102865685;
 Sun, 26 Feb 2017 01:54:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Sun, 26 Feb 2017 01:53:55 -0800 (PST)
In-Reply-To: <20170224235100.52627-2-bmwill@google.com>
References: <20170224235100.52627-1-bmwill@google.com> <20170224235100.52627-2-bmwill@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 26 Feb 2017 16:53:55 +0700
Message-ID: <CACsJy8Df6hhTzx5BNx385T4cuCg5w3nvOioXB=q+NCoW9kA6_w@mail.gmail.com>
Subject: Re: [PATCH 1/5] grep: illustrate bug when recursing with relative pathspec
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 25, 2017 at 6:50 AM, Brandon Williams <bmwill@google.com> wrote:
> When using the --recurse-submodules flag with a relative pathspec which
> includes "..", an error is produced inside the child process spawned for
> a submodule.  When creating the pathspec struct in the child, the ".."
> is interpreted to mean "go up a directory" which causes an error stating
> that the path ".." is outside of the repository.
>
> While it is true that ".." is outside the scope of the submodule, it is
> confusing to a user who originally invoked the command where ".." was
> indeed still inside the scope of the superproject.  Since the child
> process luanched for the submodule has some context that it is operating

s/luanched/launched/

I would prefer 1/5 t to be merged with 3/5 though. The problem
description is very light there, and the test demonstration in the
diff is simply switching from failure to success, which forces the
reader to come back here. It's easier to find here now, but it'll be a
bit harder when it enters master and we have to read it from git-log,
I think.

I'm still munching through the super-prefix patches. From how you
changed match_pathspec call in 0281e487fd (grep: optionally recurse
into submodules - 2016-12-16), I guess pathspecs should be handled
with super-prefix instead of the submodule's prefix (which is empty
anyway, I guess). The right solution wrt. handling relative paths may
be teach pathspec about super-prefix (and even original super's cwd)
then let it processes path in supermodule's context.

Does it handle relative paths with wildcards correctly btw? Ones that
cross submodules? I have a feeling it doesn't, but I haven't seen how
exactly super-prefix works yet.

There's another problem with passing pathspec from one process to
another. The issue with preserving the prefix, see 233c3e6c59
(parse_pathspec: preserve prefix length via PATHSPEC_PREFIX_ORIGIN -
2013-07-14). :(icase) needs this because given a path
"<prefix>/foobar", only the "foobar" part is considered case
insensitive, the prefix part is always case-sensitive. For example, if
you have 4 paths "abc/def", "abc/DEF", "ABC/def" and "ABC/DEF" and are
standing at "abc", you would want ":(icase)def" to match the first two
only, not all of them.

> underneath a superproject, this error could be avoided.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  t/t7814-grep-recurse-submodules.sh | 42 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
> index 67247a01d..418ba68fe 100755
> --- a/t/t7814-grep-recurse-submodules.sh
> +++ b/t/t7814-grep-recurse-submodules.sh
> @@ -227,6 +227,48 @@ test_expect_success 'grep history with moved submoules' '
>         test_cmp expect actual
>  '
>
> +test_expect_failure 'grep using relative path' '
> +       test_when_finished "rm -rf parent sub" &&
> +       git init sub &&
> +       echo "foobar" >sub/file &&
> +       git -C sub add file &&
> +       git -C sub commit -m "add file" &&
> +
> +       git init parent &&
> +       echo "foobar" >parent/file &&
> +       git -C parent add file &&
> +       mkdir parent/src &&
> +       echo "foobar" >parent/src/file2 &&
> +       git -C parent add src/file2 &&
> +       git -C parent submodule add ../sub &&
> +       git -C parent commit -m "add files and submodule" &&
> +
> +       # From top works
> +       cat >expect <<-\EOF &&
> +       file:foobar
> +       src/file2:foobar
> +       sub/file:foobar
> +       EOF
> +       git -C parent grep --recurse-submodules -e "foobar" >actual &&
> +       test_cmp expect actual &&
> +
> +       # Relative path to top errors out

After 3/5, it's not "errors out" any more, is it?

> +       cat >expect <<-\EOF &&
> +       ../file:foobar
> +       file2:foobar
> +       ../sub/file:foobar
> +       EOF
> +       git -C parent/src grep --recurse-submodules -e "foobar" -- .. >actual &&
> +       test_cmp expect actual &&
> +
> +       # Relative path to submodule errors out

ditto

> +       cat >expect <<-\EOF &&
> +       ../sub/file:foobar
> +       EOF
> +       git -C parent/src grep --recurse-submodules -e "foobar" -- ../sub >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_incompatible_with_recurse_submodules ()
>  {
>         test_expect_success "--recurse-submodules and $1 are incompatible" "
> --
> 2.11.0.483.g087da7b7c-goog
>



-- 
Duy
