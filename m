Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09079C433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 07:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6A3E22CAE
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 07:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgLUHIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 02:08:24 -0500
Received: from mail-ej1-f49.google.com ([209.85.218.49]:45204 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgLUHIX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 02:08:23 -0500
Received: by mail-ej1-f49.google.com with SMTP id qw4so11922316ejb.12
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 23:08:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7UypgBAk0+4cOVZkuNKwlbX9rrfI7Py7m/zg8BQhSfg=;
        b=dKxoQohVymJhvyOkBNOiFaideJZyd/MBefoK0r3atzmsgytVQUtHCfYxqkgkDYHAX6
         MZQitzFgMp+AqLdyZGvyPZi+6WBYzXM4xMUV+QZI2RJSFqcvWObNHRtR73cMBFZp7GVB
         f56BzxsaaxyOHzJzzovwfawz7RFtb0nUaIHaJ4qWRzX+WA9KIXz1Bz8iHtu78IFEw2HQ
         eW2eR17BQyJ9AOisJEtbxK0oOPsxREFBIjEEnItFqklJKL2fZv8AnCB6g5Bj9J/X4pG7
         +0cAGZyGXTkvxo6bGgSWN/wWawp8ZJI+4nM5YHxoapLqX1Y8MAMOKe9Gysx5+TXPfGx0
         SGdA==
X-Gm-Message-State: AOAM532VepoxjRdnescM5GzNHwnwdJN1h7eNuHcAh4tiext/vdRhy7Fm
        3NCuI/ok/eb1tQmymPnnJXrztttR+NtOC2Zf/mg=
X-Google-Smtp-Source: ABdhPJyJQjhVkrHBjkXqMCK6IZrWh0ug3f4joBiVwnNQokXcSoPY/sE5Qlrxbui4wkMMeI2wh1wTdgODnuQsVTa+HAg=
X-Received: by 2002:a17:906:c7d9:: with SMTP id dc25mr14583399ejb.138.1608534461867;
 Sun, 20 Dec 2020 23:07:41 -0800 (PST)
MIME-Version: 1.0
References: <pull.820.v2.git.1608415117.gitgitgadget@gmail.com>
 <pull.820.v3.git.1608516320.gitgitgadget@gmail.com> <733c674bd1901c931a8917045eb72f661872f462.1608516320.git.gitgitgadget@gmail.com>
In-Reply-To: <733c674bd1901c931a8917045eb72f661872f462.1608516320.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 21 Dec 2020 02:07:31 -0500
Message-ID: <CAPig+cSaq4vTK7CtvxB2bd0=WTW+d=s0H2RMquyCEf+q0YVn2w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] test-lib-functions: handle --add in test_config
To:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 20, 2020 at 9:05 PM Nipunn Koorapati via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> test_config fails to unset the configuration variable when
> using --add, as it tries to run git config --unset-all --add
>
> Tell test_config to invoke test_unconfig with the arg $2 when
> the arg $1 is --add
>
> Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
> ---
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> @@ -381,6 +381,7 @@ test_unconfig () {
>                 config_dir=$1
>                 shift
>         fi
> +       echo git ${config_dir:+-C "$config_dir"} config --unset-all "$@"

Stray debugging gunk?

> @@ -400,7 +401,13 @@ test_config () {
> -       test_when_finished "test_unconfig ${config_dir:+-C '$config_dir'} '$1'" &&
> +
> +       first_arg=$1
> +       if test "$1" = --add; then
> +               first_arg=$2
> +       fi
> +
> +       test_when_finished "test_unconfig ${config_dir:+-C '$config_dir'} '$first_arg'" &&

Several comments...

Style on this project is to place `then` on its own line (as seen a
few lines above this change):

    if test "$1" = --add
    then
        ...

This logic would be easier to understand if the variable was named
`varname` or `cfgvar` (or something), which better conveys intention,
rather than `first_arg`.

It feels odd to single out `--add` when there are other similar
options, such as `--replace-all`, `--fixed-value`, or even `--type`
which people might try using in the future.

This new option parsing is somewhat brittle. If a caller uses
`test_config --add -C <dir> ...`, it won't work as expected. Perhaps
that's not likely to happen, but it would be easy enough to fix by
unifying and generalizing option parsing a bit. Doing so would also
make it easy for the other options mentioned above to be added later
if ever needed. For instance:

    options=
    while test $# != 0
    do
        case "$1" in
        -C)
            config_dir=$2
            shift
            ;;
        --add)
            options="$options $1"
            ;;
        *)
            break
            ;;
        esac
        shift
    done

Finally, as this is a one-off case, it might be simpler just to drop
this patch altogether and open-code the cleanup in the test itself in
patch [2/3] rather than bothering with test_config() in that
particular case. For example:

    test_when_finished "test_unconfig -C two remote.one.push" &&
    git config -C two --add remote.one.push : &&
    test_must_fail git -C two push one &&
    git config -C two --add remote.one.push ^refs/heads/master &&
    git -C two push one
