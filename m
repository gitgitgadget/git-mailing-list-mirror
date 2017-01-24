Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5CCF1F6DC
	for <e@80x24.org>; Tue, 24 Jan 2017 22:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbdAXWU2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 17:20:28 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:33046 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbdAXWU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 17:20:26 -0500
Received: by mail-io0-f179.google.com with SMTP id v96so164479ioi.0
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 14:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iA3qD8lEB4FUKnsxbheibFCcFK+e7rqhtbGhRSYN4/o=;
        b=KPvW1S8V+OniZPh92g60wsGg2em9dhvq3bQVWScNoggn8sb6xXbhP4prfvufU5dFuL
         /B2Xj7TYDJwhq4RY0VrIUdxuDmE6DIxnxd0GrJ6XniP+4UDvX1DJZW/gqHexFLWB7D95
         qaYtwksZ7nJpWbs9W/ZouWWVtbA41yD8O4sSJP8kAMBIzL/Cb8ojiv1EgOcid83T6jpN
         g6+gFAMzZh2UdjCSV4neozO1dqQHTkdKB6a9n62i5rLy8/+8WdjhTPAhMPqmBgxPonG+
         Gaylwc/7cF43sKd0MP8c+zCU9sZZFnx6KqyIN/XRSR42kZETi/jalBdXhFZLQnldc2Tz
         ggww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iA3qD8lEB4FUKnsxbheibFCcFK+e7rqhtbGhRSYN4/o=;
        b=nsnG30lFUZm88gFcK88BpWWgLc167tiD5IIIrrh74A+KwkrIVRII1Y73Dc/ay9cGsI
         Vy73mcws+f62ryMchCm9oIPdvsjMkWD1O3NYwo/SaDv0OxEhlbrQLI1whDQtieKtodWC
         OZrKJzyXwvRBFXJjgTAKSSlVzgMR4S36cMW723NB2dvKHsQLFNwSdf1bopSqQLiMFney
         uoe3ynjXEcv5i4yuyzat1kwa3XmFm4AoJONowB/XEGDDHxJ53WEWFUkSMwJSEP5CPnr/
         Mz6L+UMe+mvbrDCvUke9ZloUHcwT1nT8YDE+qVMt7nQk279z9qoFQHI+HPmc2Wt+WRbs
         2Yig==
X-Gm-Message-State: AIkVDXKlmJrNloqmpXpuOWd6eJgGz3FTA72oBC9lCnIUF99quEwY6pEYxNkU0nenIeVzU+qulmdWOZCQpE1TXK/J
X-Received: by 10.107.3.160 with SMTP id e32mr31620580ioi.52.1485296033783;
 Tue, 24 Jan 2017 14:13:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Tue, 24 Jan 2017 14:13:53 -0800 (PST)
In-Reply-To: <20170124215851.GA58021@google.com>
References: <20170124210346.12060-1-sbeller@google.com> <20170124215851.GA58021@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 24 Jan 2017 14:13:53 -0800
Message-ID: <CAGZ79kYKkx441bbU5Oy9Ernb1FmbcTybYbL_M_+yWG_ycfPwrA@mail.gmail.com>
Subject: Re: [PATCH] submodule absorbing: fix worktree/gitdir pointers
 recursively for non-moves
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 24, 2017 at 1:58 PM, Brandon Williams <bmwill@google.com> wrote:
> On 01/24, Stefan Beller wrote:
>> +     if (read_gitfile_gently(old_git_dir, &err_code) ||
>> +         err_code == READ_GITFILE_ERR_NOT_A_REPO) {
>> +             /*
>> +              * If it is an actual gitfile, it doesn't need migration,
>> +              * however in case of a recursively nested submodule, the
>> +              * gitfile content may be stale, as its superproject
>> +              * (which may be a submodule of another superproject)
>> +              * may have been moved. So expect a bogus pointer to be read,
>> +              * which materializes as error READ_GITFILE_ERR_NOT_A_REPO.
>> +              */
>> +             connect_work_tree_and_git_dir(path, real_new_git_dir);
>
> So connect_work_tree_and_git_dir() will update the .gitfile if it is
> stale.
>
>> +             return;
>> +     }
>> +
>> +     if (submodule_uses_worktrees(path))
>> +             die(_("relocate_gitdir for submodule '%s' with "
>> +                   "more than one worktree not supported"), path);
>
> No current support for worktrees (yet!).
>
>> +
>>       if (!prefix)
>>               prefix = get_super_prefix();
>>
>> @@ -1437,22 +1448,14 @@ void absorb_git_dir_into_superproject(const char *prefix,
>>                                     const char *path,
>>                                     unsigned flags)
>>  {
>> -     const char *sub_git_dir, *v;
>> -     char *real_sub_git_dir = NULL, *real_common_git_dir = NULL;
>>       struct strbuf gitdir = STRBUF_INIT;
>> -
>>       strbuf_addf(&gitdir, "%s/.git", path);
>> -     sub_git_dir = resolve_gitdir(gitdir.buf);
>>
>>       /* Not populated? */
>> -     if (!sub_git_dir)
>> +     if (!file_exists(gitdir.buf))
>>               goto out;
>
> There should be a is_submodule_populated() function now, maybe
> we should start using it when performing population checks?

Yes I am aware of that, but the problem is we cannot use it here.
is_submodule_populated[1], just like the code here, uses
resolve_gitdir, which is

    const char *resolve_gitdir(const char *suspect)
    {
        if (is_git_directory(suspect))
           return suspect;
        return read_gitfile(suspect);
    }

And there you see the problem: read_gitfile will die on error.
we'd have to have use read_gitfile_gently(old_git_dir, &err_code),
and then allow READ_GITFILE_ERR_NOT_A_REPO to go through,
just as above.

And that is also the reason why we had to move submodule_uses_worktrees
down, as it also uses no gentle function to look for a git directory
(read: it would die as well). When you have bogus content in your
.git file, there is really nothing you can do to determine if the submodule
is part of a worktree setup, so it is fine to postpone the check until after we
fixed up the link.

So here is the bug you spotted: If it is a worktree already, then
read_gitfile_gently would work fine, no need to "fix" it.

I'll resend with logic as follows:

    char *retvalue = read_gitfile_gently(old_git_dir, &err_code);
    if (retvalue)
        // return early; a worktree is fine here, no need to check
        // because we do nothing

    if (err_code == READ_GITFILE_ERR_NOT_A_REPO)
        // connect; then check for worktree and return early;

    // do the actual relocation.


[1] as found e.g. at
https://public-inbox.org/git/1481915002-162130-2-git-send-email-bmwill@google.com/

>
>>
>> -     /* Is it already absorbed into the superprojects git dir? */
>> -     real_sub_git_dir = real_pathdup(sub_git_dir);
>> -     real_common_git_dir = real_pathdup(get_git_common_dir());
>> -     if (!skip_prefix(real_sub_git_dir, real_common_git_dir, &v))
>> -             relocate_single_git_dir_into_superproject(prefix, path);
>> +     relocate_single_git_dir_into_superproject(prefix, path);
>
> So the check was just pushed into the relocation function.

The check was pushed down, so we can use the
connect_work_tree_and_git_dir instead.

>
>>
>>       if (flags & ABSORB_GITDIR_RECURSE_SUBMODULES) {
>>               struct child_process cp = CHILD_PROCESS_INIT;
>> @@ -1481,6 +1484,4 @@ void absorb_git_dir_into_superproject(const char *prefix,
>>
>>  out:
>>       strbuf_release(&gitdir);
>> -     free(real_sub_git_dir);
>> -     free(real_common_git_dir);
>>  }
>> diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
>> index 1c47780e2b..e2bbb449b6 100755
>> --- a/t/t7412-submodule-absorbgitdirs.sh
>> +++ b/t/t7412-submodule-absorbgitdirs.sh
>> @@ -64,6 +64,33 @@ test_expect_success 'absorb the git dir in a nested submodule' '
>>       test_cmp expect.2 actual.2
>>  '
>>
>> +test_expect_success 're-setup nested submodule' '
>> +     # un-absorb the direct submodule, to test if the nested submodule
>> +     # is still correct (needs a rewrite of the gitfile only)
>> +     rm -rf sub1/.git &&
>> +     mv .git/modules/sub1 sub1/.git &&
>> +     GIT_WORK_TREE=. git -C sub1 config --unset core.worktree &&
>> +     # fixup the nested submodule
>> +     echo "gitdir: ../.git/modules/nested" >sub1/nested/.git &&
>> +     GIT_WORK_TREE=../../../nested git -C sub1/.git/modules/nested config \
>> +             core.worktree "../../../nested" &&
>> +     # make sure this re-setup is correct
>> +     git status --ignore-submodules=none
>> +'
>> +
>> +test_expect_success 'absorb the git dir in a nested submodule' '
>> +     git status >expect.1 &&
>> +     git -C sub1/nested rev-parse HEAD >expect.2 &&
>> +     git submodule absorbgitdirs &&
>> +     test -f sub1/.git &&
>> +     test -f sub1/nested/.git &&
>> +     test -d .git/modules/sub1/modules/nested &&
>> +     git status >actual.1 &&
>> +     git -C sub1/nested rev-parse HEAD >actual.2 &&
>> +     test_cmp expect.1 actual.1 &&
>> +     test_cmp expect.2 actual.2
>> +'
>> +
>>  test_expect_success 'setup a gitlink with missing .gitmodules entry' '
>>       git init sub2 &&
>>       test_commit -C sub2 first &&
>> --
>> 2.11.0.486.g67830dbe1c
>
>
> Aside from my one question the rest of this looks good to me.
>
> --
> Brandon Williams
