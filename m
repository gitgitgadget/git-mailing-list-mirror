Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3793C2BB85
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 18:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793CE2076E
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 18:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/wTBckT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgDGSL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:11:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36549 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgDGSL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 14:11:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id d202so2847668wmd.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 11:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=svxXleaYVNzmsfdHQPy5VIqpODRCRPfFD7ls94oE3Os=;
        b=Y/wTBckTHJi4rd33eR1ZgP6QiAdvmoFFZKrMwSJmDUhK1zMGV/a4s7oAsudN+zFfIy
         v1Z57DBEhteefE4P9cko2nkEaqm7NfWJaYG+MxcWKGTz2MR+EQkLmBnavHsp9eWXoLBN
         W4vutCGTVVibqhd/Ih3kM6xnf8I0vls49Ea0QeDLQ5Fj/jtOIfJFfnosHNvxvPB+TxtX
         C6kW9C2Y0kG9rxjqCftTLZ+nuk5b4Ai5740V1XzF9DPYf/cAgcIRM8slb4zVezlvf0vv
         VuME5CeKKlfas4eymT2x0FVBOyKez9DYFbB70GuZsIciFjwFJZs63qJeLntGOUB8evgv
         e6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=svxXleaYVNzmsfdHQPy5VIqpODRCRPfFD7ls94oE3Os=;
        b=fvlIDlaU6MoCyPIFVu3rFQfrqNMyFUN4fKnFrQ9S/IQ17Zwwb7cNTLDkkSYmyq+dgH
         4+ZH+XjlkFFMIqoR3kqc/1VV/2Km7UUMh610l3p2Fc7om9NkOaZTgqXuOXKddkj7lcCX
         5+1xz4COhDh7api8MzAvyNG1L76paBmUxMIfRXTfQYntjHMYLHZeZishgWo/dcij4nc4
         ojtd27kv5ndSI4VOfn5FvNo9fhWQ4iUqXz1vGSsS53KBL+ocqlSGC3ZqkGlnmslDQ+O3
         ursHe0jN2BJ1NrmeGSf6FTT1eP7vS8vixfYQHB+Gzhur6/F6U1NI4y/Fi+0r4I7fbTXf
         orIw==
X-Gm-Message-State: AGi0PuZUDfQa/G5c9Lq18cpRXA+V86JMLLgdp4Y7bnYtGr/nnEGH1byt
        qPtJNWR2jtw6hAhqsewWnTQ=
X-Google-Smtp-Source: APiQypI4jlWG5h+FkHzBAC0gO1MW0oxhNIi9W6fejGwuo5NvJ9p12buXwO+4W6szeILfJMaFnIeTZQ==
X-Received: by 2002:a1c:e187:: with SMTP id y129mr520445wmg.133.1586283082044;
        Tue, 07 Apr 2020 11:11:22 -0700 (PDT)
Received: from [192.168.1.201] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.googlemail.com with ESMTPSA id t17sm27571173wrv.53.2020.04.07.11.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 11:11:21 -0700 (PDT)
Subject: Re: [PATCH 4/6] rebase -i: fix --committer-date-is-author-date
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200407141125.30872-5-phillip.wood123@gmail.com>
 <CABPp-BFu0mgNnxcuZZ_kBJ3WWXxCNSZAFdmq9zKT4H9i47sNsA@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <33f0ee87-7b6a-d48a-fd40-9c513a626a22@gmail.com>
Date:   Tue, 7 Apr 2020 19:11:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFu0mgNnxcuZZ_kBJ3WWXxCNSZAFdmq9zKT4H9i47sNsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 07/04/2020 16:05, Elijah Newren wrote:
> On Tue, Apr 7, 2020 at 7:11 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Johanathan Nieder reported that `rebase --committer-date-is-author-date`
>> failed with the error "invalid date format: @@2592000 +0000" when the
>> backend was switched to use the sequencer [1]. This is because when we
>> read the date from the author script file is already prefixed by '@' so
>> we do not need to add one. This did not show up in our tests
>> because once match_object_header_date() fails to match because of the
>> extra '@' parse_date_basic() strips the prefix and a date with more than
>> 8 digits is parsed as a number of seconds by match_digit().
>>
>> While fixing this I also noticed that we were not setting
>> GIT_COMMITTER_DATE in the environment when forking `git merge`. This was
>> untested. The tests we did have used commits where the author date was
>> the same as the current value $GIT_COMMITTER_DATE in the environment so
>> they did not test that we were actually using the author date when
>> creating the commit.
>>
>> As we have already read GIT_AUTHOR_DATE into cmd.env_array we now use
>> that rather than re-reading the author-script file. I've moved the code
>> that handles opts->ignore date so that all the code setting the child
>> environment is together and changed it so we no longer set
>> GIT_COMMITTER_DATE twice when --ignore-date is combined with
>> --committer-date-is-author-date.
>>
>> [1] https://lore.kernel.org/git/<20200110231436.GA24315@google.com>
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>  sequencer.c                             | 68 ++++++++++---------------
>>  t/t3433-rebase-options-compatibility.sh | 29 +++++++++--
>>  2 files changed, 52 insertions(+), 45 deletions(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index 763ccbbc45..56f6e49289 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -880,17 +880,6 @@ static char *get_author(const char *message)
>>         return NULL;
>>  }
>>
>> -/* Returns a "date" string that needs to be free()'d by the caller */
>> -static char *read_author_date_or_null(void)
>> -{
>> -       char *date;
>> -
>> -       if (read_author_script(rebase_path_author_script(),
>> -                              NULL, NULL, &date, 0))
>> -               return NULL;
>> -       return date;
>> -}
>> -
>>  /* Construct a free()able author string with current time as the author date */
>>  static char *ignore_author_date(const char *author)
>>  {
>> @@ -909,16 +898,20 @@ static char *ignore_author_date(const char *author)
>>         return strbuf_detach(&new_author, NULL);
>>  }
>>
>> -static void push_dates(struct child_process *child, int change_committer_date)
>> +static const char *author_date_from_env_array(const struct argv_array *env)
>>  {
>> -       time_t now = time(NULL);
>> -       struct strbuf date = STRBUF_INIT;
>> +       int i;
>> +       const char *date;
>>
>> -       strbuf_addf(&date, "@%"PRIuMAX, (uintmax_t)now);
>> -       argv_array_pushf(&child->env_array, "GIT_AUTHOR_DATE=%s", date.buf);
>> -       if (change_committer_date)
>> -               argv_array_pushf(&child->env_array, "GIT_COMMITTER_DATE=%s", date.buf);
>> -       strbuf_release(&date);
>> +       for (i = 0; i < env->argc; i++)
>> +               if (skip_prefix(env->argv[i],
>> +                               "GIT_AUTHOR_DATE=", &date))
>> +                       return date;
> 
> Is there any risk that GIT_AUTHOR_DATE=<somedate> will appear twice in
> @child->env_array ?  If there is, should we read through the whole
> list to make sure we take the last one?

read_author_script() errors out if GIT_AUTHOR_DATE is missing or given
more than once

Best Wishes

Phillip

> 
>> +       /*
>> +        * If GIT_AUTHOR_DATE is missing we should have already errored out when
>> +        * reading the script
>> +        */
>> +       BUG("GIT_AUTHOR_DATE missing from author script");
>>  }
>>
>>  static const char staged_changes_advice[] =
>> @@ -980,31 +973,19 @@ static int run_git_commit(struct repository *r,
>>
>>         cmd.git_cmd = 1;
>>
>> -       if (opts->committer_date_is_author_date) {
>> -               int res = -1;
>> -               struct strbuf datebuf = STRBUF_INIT;
>> -               char *date = read_author_date_or_null();
>> -
>> -               if (!date)
>> -                       return -1;
>> -
>> -               strbuf_addf(&datebuf, "@%s", date);
>> -               res = setenv("GIT_COMMITTER_DATE",
>> -                            opts->ignore_date ? "" : datebuf.buf, 1);
>> -
>> -               strbuf_release(&datebuf);
>> -               free(date);
>> -
>> -               if (res)
>> -                       return -1;
>> -       }
>> -
>>         if (is_rebase_i(opts) && read_env_script(&cmd.env_array)) {
>>                 const char *gpg_opt = gpg_sign_opt_quoted(opts);
>>
>>                 return error(_(staged_changes_advice),
>>                              gpg_opt, gpg_opt);
>>         }
>> +       if (opts->committer_date_is_author_date)
>> +               argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
>> +                                opts->ignore_date ?
>> +                                "" :
>> +                                author_date_from_env_array(&cmd.env_array));
>> +       if (opts->ignore_date)
>> +               argv_array_push(&cmd.env_array, "GIT_AUTHOR_DATE=");
>>
>>         argv_array_push(&cmd.args, "commit");
>>
>> @@ -1014,8 +995,6 @@ static int run_git_commit(struct repository *r,
>>                 argv_array_push(&cmd.args, "--amend");
>>         if (opts->gpg_sign)
>>                 argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
>> -       if (opts->ignore_date)
>> -               push_dates(&cmd, opts->committer_date_is_author_date);
>>         if (defmsg)
>>                 argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
>>         else if (!(flags & EDIT_MSG))
>> @@ -3615,6 +3594,13 @@ static int do_merge(struct repository *r,
>>                         ret = error(_(staged_changes_advice), gpg_opt, gpg_opt);
>>                         goto leave_merge;
>>                 }
>> +               if (opts->committer_date_is_author_date)
>> +                       argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
>> +                                        opts->ignore_date ?
>> +                                        "" :
>> +                                        author_date_from_env_array(&cmd.env_array));
>> +               if (opts->ignore_date)
>> +                       argv_array_push(&cmd.env_array, "GIT_AUTHOR_DATE=");
>>
>>                 cmd.git_cmd = 1;
>>                 argv_array_push(&cmd.args, "merge");
>> @@ -3635,8 +3621,6 @@ static int do_merge(struct repository *r,
>>                 argv_array_push(&cmd.args, git_path_merge_msg(r));
>>                 if (opts->gpg_sign)
>>                         argv_array_push(&cmd.args, opts->gpg_sign);
>> -               if (opts->ignore_date)
>> -                       push_dates(&cmd, opts->committer_date_is_author_date);
>>
>>                 /* Add the tips to be merged */
>>                 for (j = to_merge; j; j = j->next)
>> diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
>> index 132f577fc9..8247d01442 100755
>> --- a/t/t3433-rebase-options-compatibility.sh
>> +++ b/t/t3433-rebase-options-compatibility.sh
>> @@ -71,15 +71,15 @@ test_expect_success '--ignore-whitespace works with interactive backend' '
>>  '
>>
>>  test_expect_success '--committer-date-is-author-date works with am backend' '
>> -       git commit --amend &&
>> +       GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
>>         git rebase --committer-date-is-author-date HEAD^ &&
>>         git log -1 --pretty="format:%ai" >authortime &&
>>         git log -1 --pretty="format:%ci" >committertime &&
>>         test_cmp authortime committertime
>>  '
>>
>>  test_expect_success '--committer-date-is-author-date works with interactive backend' '
>> -       git commit --amend &&
>> +       GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
>>         git rebase -i --committer-date-is-author-date HEAD^ &&
>>         git log -1 --pretty="format:%ai" >authortime &&
>>         git log -1 --pretty="format:%ci" >committertime &&
>> @@ -88,13 +88,36 @@ test_expect_success '--committer-date-is-author-date works with interactive back
>>
>>  test_expect_success '--committer-date-is-author-date works with rebase -r' '
>>         git checkout side &&
>> -       git merge --no-ff commit3 &&
>> +       GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
>>         git rebase -r --root --committer-date-is-author-date &&
>>         git log --pretty="format:%ai" >authortime &&
>>         git log --pretty="format:%ci" >committertime &&
>>         test_cmp authortime committertime
>>  '
>>
>> +test_expect_success '--committer-date-is-author-date works when forking merge' '
>> +       git checkout side &&
>> +       GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
>> +       git rebase -r --root --strategy=resolve --committer-date-is-author-date &&
>> +       git log --pretty="format:%ai" >authortime &&
>> +       git log --pretty="format:%ci" >committertime &&
>> +       test_cmp authortime committertime
>> +
>> +'
>> +
>> +test_expect_success '--committer-date-is-author-date works when committing conflict resolution' '
>> +       git checkout commit2 &&
>> +       GIT_AUTHOR_DATE="@1980 +0000" git commit --amend --only --reset-author &&
>> +       git log -1 --format=%at HEAD >expect &&
>> +       test_must_fail git rebase -i --committer-date-is-author-date \
>> +               --onto HEAD^^ HEAD^ &&
>> +       echo resolved > foo &&
>> +       git add foo &&
>> +       git rebase --continue &&
>> +       git log -1 --format=%ct HEAD >actual &&
>> +       test_cmp expect actual
>> +'
>> +
>>  # Checking for +0000 in author time is enough since default
>>  # timezone is UTC, but the timezone used while committing
>>  # sets to +0530.
>> --
>> 2.26.0
>>

