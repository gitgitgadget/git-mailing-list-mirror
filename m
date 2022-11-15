Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC69DC433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 17:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbiKOR1T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 12:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbiKOR0r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 12:26:47 -0500
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5FE2EF63
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 09:26:45 -0800 (PST)
Received: by mail-il1-f178.google.com with SMTP id l6so7760745ilq.3
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 09:26:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JIlgvhu1kWeBIFSBHlp0NvgnDIEakP0gmvBf8QpwGs0=;
        b=jWdCBxekaSougDdbTZUMRBTlFMAKLqTuOiZ2bQJfjrTA8E9Ba3rCHEQ28sDAVQFGCj
         wJ9jz7ulAap34kzozhfQrjLRTrhsz6zd3jfhVoXIDZIZL5q/gs41o/kOPFuG0DsjpV7A
         XsagkOlSv84SFRorkf+EBneTPkhfcTP2OH5lxG0tXwyLVzRZwSkRRYhuh1Y1gxNi4XKm
         ZCnnMfuxsaiBP7Q0pAsSZ3Gy+Vwr6v6mUdUn40O5mY4awDm12nOO6fqtVyEg8D0m31T7
         jRgfOzY81wH2cIVd429Z0XkUBYbgCz3gEVY7j3i42GvupkFrDxdJNOpCF/Dbq9zz6fqx
         79ew==
X-Gm-Message-State: ANoB5plafSVHKab2M2ABGUdQ++hkl1KP2eLhXaSoUFzaBrLOJbZilsWF
        VqPs7kG0PThiP1WAmk9p6fuFTtfWt8oo9hXFhN4=
X-Google-Smtp-Source: AA0mqf4spbH9vZ6UQ3A0VRbkG+MrJ256QAcIRVn2pdZf/ermqPEtoyFO7l6ajIZXZEWArKKdcpfYsQAvawmw+qH5INQ=
X-Received: by 2002:a92:d6ca:0:b0:300:de98:5e30 with SMTP id
 z10-20020a92d6ca000000b00300de985e30mr8381310ilp.252.1668533204434; Tue, 15
 Nov 2022 09:26:44 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v4.git.1668055574050.gitgitgadget@gmail.com> <pull.1384.v5.git.1668110679098.gitgitgadget@gmail.com>
In-Reply-To: <pull.1384.v5.git.1668110679098.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 15 Nov 2022 12:26:33 -0500
Message-ID: <CAPig+cTO3NPg_Kx3dZhFMEtbMe9hRvaumZYxMnSJRyXqUA=p0g@mail.gmail.com>
Subject: Re: [PATCH v5] status: long status advice adapted to recent capabilities
To:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Rudy Rigot <rudy.rigot@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 3:04 PM Rudy Rigot via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Improve the advice displayed when `git status` is slow because
> of excessive numbers of untracked files.  Update the `git status`
> man page to explain the various configuration options.
>
> `git status` can be slow when there are a large number of untracked
> files and directories, because Git must search the entire worktree
> to enumerate them.  Previously, Git would print an advice message
> with the elapsed search time and a suggestion to disable the search
> using the `-uno` option.  This suggestion also carried a warning
> that might scare off some users.
>
> Git can reduce the size and time of the untracked file search when
> the `core.untrackedCache` and `core.fsmonitor` features are enabled
> by caching results from previous `git status` invocations.
>
> Update the advice to explain the various combinations of additional
> configuration options and refer to (new) documentation in the man
> page that explains it in more detail than what can be printed in an
> advice message.
>
> Finally, add new tests to verify the new functionality.
>
> Signed-off-by: Rudy Rigot <rudy.rigot@gmail.com>

Mostly just some minor style-related comments below, but also a couple
grammos in the new documentation, and a question or two...

> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> @@ -457,6 +457,65 @@ during the write may conflict with other simultaneous processes, causing
> +* `core.untrackedCache=true` (see linkgit:git-update-index[1]) :
> +       enable the untracked cache feature and only search directories
> +       that have been modified since the previous `git status` command.
> +       Git remembers the set of untracked files within each directory
> +       and assumes that if a directory has not been modified, then
> +       the set of untracked file within has not changed.  This is much

s/file/files/

> +       faster than enumerating the contents of every directory, but still
> +       not without cost, because Git still has to search for the set of
> +       modified directories. The untracked cache is stored in the
> +       .git/index file. The reduced cost searching for untracked

Might want backticks around the literal filename: `.git/index`

Also: s/cost searching/cost of searching/

> +       files is offset slightly by the increased size of the index and
> +       the cost of keeping it up-to-date. That reduced search time is
> +       usually worth the additional size.
> diff --git a/t/t7065-wtstatus-slow.sh b/t/t7065-wtstatus-slow.sh
> @@ -0,0 +1,68 @@
> +test_expect_success setup '
> +       git checkout -b test &&
> +       echo "actual" >> .gitignore &&
> +       echo "expected" >> .gitignore &&
> +       echo "out" >> .gitignore &&

Style: drop space after redirection operator:

    echo "actual" >>.gitignore &&
    echo "expected" >>.gitignore &&
    echo "out" >>.gitignore &&

By the way, this is an excellent opportunity to use a here-doc as
you're now doing elsewhere in the script:

    cat >.gitignore <<-\EOF &&
    actual
    expected
    out
    EOF

Do we want to anchor these .gitignore patterns to make it clear to
future readers the precise expectations of these tests?

    cat >.gitignore <<-\EOF &&
    /actual
    /expected
    /out
    EOF

> +       git add .gitignore &&
> +       git commit -m "Add .gitignore"
> +'
> +
> +test_expect_success 'when core.untrackedCache and fsmonitor are unset' '
> +       test_might_fail git config --unset-all core.untrackedCache &&
> +       test_might_fail git config --unset-all core.fsmonitor &&
> +       git status >out &&
> +       sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
> +       cat >expected <<-\EOF &&
> +               On branch test
> +
> +               It took X seconds to enumerate untracked files.
> +               See '"'"'git help status'"'"' for information on how to improve this.
> +
> +               nothing to commit, working tree clean
> +       EOF

Style: We normally make the here-doc body indentation match the
indentation of the command itself:

    cat >expected <<-\EOF &&
    On branch test
    ...
    EOF

> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'when core.untrackedCache true, but not fsmonitor' '
> +       git config core.untrackedCache true &&

It's perhaps not super important in this case since each subsequent
test is setting up its configuration exactly as it wants it, but it is
common elsewhere in the test scripts to use test_config() which
automatically unsets the configuration when the test finishes:

    test_config core.untrackedCache true &&

I'm on the fence as to whether or not to use test_config() in this
case, but it shouldn't hurt to do so.

> +       test_might_fail git config --unset-all core.fsmonitor &&
> +       git status >out &&
> +       sed "s/[0-9]\.[0-9][0-9]/X/g" out >actual &&
> +       cat >expected <<-\EOF &&
> +               On branch test
> +
> +               It took X seconds to enumerate untracked files.
> +               See '"'"'git help status'"'"' for information on how to improve this.
> +
> +               nothing to commit, working tree clean
> +       EOF
> +       test_cmp expected actual
> diff --git a/wt-status.c b/wt-status.c
> @@ -1205,6 +1207,15 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
> +static inline int uf_was_slow(uint32_t untracked_in_ms)

Does this need to be "inline"?

> +{
> +       if (getenv("GIT_TEST_UF_DELAY_WARNING")) {
> +               untracked_in_ms += UF_DELAY_WARNING_IN_MS + 1;
> +       }
> +
> +       return UF_DELAY_WARNING_IN_MS < untracked_in_ms;
> +}

Style:

    if (getenv("GIT_TEST_UF_DELAY_WARNING"))
        untracked_in_ms += UF_DELAY_WARNING_IN_MS + 1;
    return UF_DELAY_WARNING_IN_MS < untracked_in_ms;

> @@ -1870,13 +1882,21 @@ static void wt_longstatus_print(struct wt_status *s)
> -               if (advice_enabled(ADVICE_STATUS_U_OPTION) && 2000 < s->untracked_in_ms) {
> +               if (uf_was_slow(s->untracked_in_ms) && advice_enabled(ADVICE_STATUS_U_OPTION)) {

Was there a specific reason you switched around the condition so it
checks advice_enabled() _after_ checking for slowness? If so, the
reason may not be obvious to future readers and might deserve mention
in the commit message. If it was just a whim, then future readers
might end up wondering if there was some reason which they are unable
to figure out, in which case it would be better to retain the original
ordering of conditions.

>                         status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
> +                       if (fsm_mode > FSMONITOR_MODE_DISABLED) {
> +                               status_printf_ln(s, GIT_COLOR_NORMAL,
> +                                               _("It took %.2f seconds to enumerate untracked files,\n"
> +                                               "but this is currently being cached."),
> +                                               s->untracked_in_ms / 1000.0);

To what does "this" refer? Is it this repository? Or something else?

> +                       } else {
> +                               status_printf_ln(s, GIT_COLOR_NORMAL,
> +                                               _("It took %.2f seconds to enumerate untracked files."),
> +                                               s->untracked_in_ms / 1000.0);
> +                       }
>                         status_printf_ln(s, GIT_COLOR_NORMAL,
> +                                       _("See 'git help status' for information on how to improve this."));

Okay.

> +                       status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
