Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DB911F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 23:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbdGYXdM (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 19:33:12 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:38564 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbdGYXdL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 19:33:11 -0400
Received: by mail-pg0-f47.google.com with SMTP id k190so10761220pgk.5
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 16:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ekDdvee6k/XHIOfm/eV2t5gqjd5ooeOo2+4gCnuwn8M=;
        b=qqoY1aBYEXiN8QyDe+XO40bZkDEkwPKEm/DZwZKP6ciPVVvort9lIG+bcJlGHeCFQQ
         0enqpMZvEj07V4ZsTtuGGZSIHiz8CnnEquAv6OLzax3PYlxhqLhZ2rcBOL7+XzM3YEsI
         R5WiM29sTI1E9LnIQ+AjWFJyRqGUiSY3IE5QUNnzRTaYd5Svvl+znJG5zyLhNUbS3vOh
         3fuYG0rCtAaGb/8wDMo0cm6cAn0ule3wymlmaqdYNM90RVYasD98YjqicRw6tjRDQA/P
         YG9Wjy2rUPAFXw1UlVoVp1CjjQDBPCAYF2sfvwaAMbm1mf9JVk6ldo3eyky6qX5LWr6C
         atHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ekDdvee6k/XHIOfm/eV2t5gqjd5ooeOo2+4gCnuwn8M=;
        b=lWnQ2PeOeRUYClUxia2GPGTpCCgb4RXVPZOmmYuhSMLEkN4NXckrHQSy75C6ZYJ7hL
         dIxIwMaw/fHVgl1JK/C6emA1rAE6LXGbtmOhCIoRtTwSrB5pkcjmwHB5Y37R+VrsAcQt
         k2Unxjkuvb0jJwvrkBSKEqsYA27UQdFElKA1j4Ao9REsfBPLKE1SV0uRgpGQsenE4vh8
         gg5V2S6PUv1vPtTQJErCxm3Xk90xv/tHBMikLxVGcmkCb2t5lzHfKQJAV+zYxQ76nMxU
         3nNdyvltS6tjgaXr/nztd0KgqTBwVn3mcykDROaBDGl1cXr0n/BtpEhmSeWlbS3z2Q26
         5HKw==
X-Gm-Message-State: AIVw110Dm40QCaS9oeOk2yzjPENG/9pCD1qETQNdAlRcDuef44f1oUby
        0LPTjKaN1K6fUh8s4LGlAUpvS8dDlolaf04/hQ==
X-Received: by 10.99.44.138 with SMTP id s132mr20683391pgs.318.1501025591283;
 Tue, 25 Jul 2017 16:33:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.44 with HTTP; Tue, 25 Jul 2017 16:33:10 -0700 (PDT)
In-Reply-To: <20170725213928.125998-4-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com> <20170725213928.125998-4-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 25 Jul 2017 16:33:10 -0700
Message-ID: <CAGZ79kZByzPbyLUNJ8ViVa2TDk-L+TfnF+wVWRj2d92_MhXPbg@mail.gmail.com>
Subject: Re: [PATCH 03/15] add, reset: ensure submodules can be added or reset
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 25, 2017 at 2:39 PM, Brandon Williams <bmwill@google.com> wrote:
> Commit aee9c7d65 (Submodules: Add the new "ignore" config option for
> diff and status) ...

introduced in 2010, so quite widely spread.

> ...  introduced the ignore configuration option for
> submodules so that configured submodules could be omitted from the
> status and diff commands.  Because this flag is respected in the diff
> machinery it has the unintended consequence of potentially prohibiting
> users from adding or resetting a submodule, even when a path to the
> submodule is explicitly given.
>
> Ensure that submodules can be added or set, even if they are configured
> to be ignored, by setting the `DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG` diff
> flag.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/add.c   | 1 +
>  builtin/reset.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index e888fb8c5..6f271512f 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -116,6 +116,7 @@ int add_files_to_cache(const char *prefix,
>         rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
>         rev.diffopt.format_callback = update_callback;
>         rev.diffopt.format_callback_data = &data;
> +       rev.diffopt.flags |= DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;


This flag occurs once in the code base, with the comment:
    /*
     * Unless the user did explicitly request a submodule
     * ignore mode by passing a command line option we do
     * not ignore any changed submodule SHA-1s when
     * comparing index and parent, no matter what is
     * configured. Otherwise we won't commit any
     * submodules which were manually staged, which would
     * be really confusing.
     */
    int diff_flags = DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;

in prepare_commit, so commit ignores the .gitmodules file.

This allows git-add to add ignored submodules, currently ignored submodules
would have to be added using the plumbing
    git update-index --add --cacheinfo 160000,$SHA1,<gitlink>

This makes sense, though a test demonstrating the change in behavior
would be nice, but git-add doesn't seem to change as it doesn't even load
the git modules config?

>         rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
>         run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
>         return !!data.add_errors;
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 046403ed6..772d078b8 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -156,6 +156,7 @@ static int read_from_tree(const struct pathspec *pathspec,
>         opt.output_format = DIFF_FORMAT_CALLBACK;
>         opt.format_callback = update_index_from_diff;
>         opt.format_callback_data = &intent_to_add;
> +       opt.flags |= DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;

same here? Also as this is not failing any test, it may be worth adding one
to document the behavior of the "submodule.<name>.ignore" flag in tests?

>
>         if (do_diff_cache(tree_oid, &opt))
>                 return 1;
> --
> 2.14.0.rc0.400.g1c36432dff-goog
>
