Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512FCC433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 10:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0202123770
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 10:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbhAHKdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 05:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbhAHKdu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 05:33:50 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA32C0612F4
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 02:33:09 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d26so8455877wrb.12
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 02:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8rhZynsuM29djDmIWfjOmfp0XyX1WlHJN75RWsAMbvY=;
        b=qVH+bOGLOUeRm8rYijyUAswZRp5sEqp3VK7hycedRwWd8LM9d4bfA9URZtd9eDhRGT
         KCZRcmRpVEMl6BUeF6VEfFu93BK8EdBK/FLm/9KjtbaAXpbDq4KzqFkIKZq/uY61qnt+
         vevjk/YaZiSYfae726udhxYjxEa2Jsfv4LXOajgKoNseLUcL3hcpLqmlGzJd/TCz2A2/
         +rPf7YwcUA71pJeh6cAbUDg0FGHz0bGOPX7BEKF05xFBjCetXVafi5JuI46wDijzeZW5
         uP70eZmm43K2DDjB8VHgBK52IYeh7NnaZttOVCexdUSAFLTjNWGB8c6DPcm6LzZdBREG
         mpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8rhZynsuM29djDmIWfjOmfp0XyX1WlHJN75RWsAMbvY=;
        b=fWmgGfZfHlOdpS5AEXWGtGAQtFkGXxXscoANle840HQmLcNWbNUn4bDuMB7AAF5kn6
         03c/oX7De0UyyMUCGgqnd/H/RetA+4y7ewZP2aJc6YZDdmTZFdWMpwdvnDUx5bcXLs8o
         8ED0fDJFDcx+Pa2FYl2aLsuknpXTX2PCDLjHb/fuZA2feLgCis3ssy1q2lNMRAAf//qC
         /y54XPE6ihF5DE8Y6l3uX61IZwDdheYHwtvaT/Ee1h5ylbk8c0FVNigMysEfgj7AET50
         sCGeIxRW5WZurw5cKiObbFCUyt5VHFkSXbjmyZ6ugRR0vq+O+hm1CIxqTDvxQLiGjrtT
         cQbw==
X-Gm-Message-State: AOAM533IIizMLrrRVaZEl28fKyZ6xixONIP4bBTMllNHPNCJ+b+aNZVW
        RiLYWOUXEhQm66CVx3xVS1XStndv1Ik=
X-Google-Smtp-Source: ABdhPJyDC180HT9LZCLo8tmz/Htszu8YK6jdvLglUeK/wHb3MA+maAu7ow5izMCK0A1nAs4TkJ6GpA==
X-Received: by 2002:a5d:4d50:: with SMTP id a16mr2883591wru.43.1610101988544;
        Fri, 08 Jan 2021 02:33:08 -0800 (PST)
Received: from [192.168.1.240] (209.20.198.146.dyn.plus.net. [146.198.20.209])
        by smtp.gmail.com with ESMTPSA id w21sm11045484wmi.45.2021.01.08.02.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 02:33:07 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] worktree: add -z option for list subcommand
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
References: <428d16e8-fdb8-a587-6a0b-39c6c50eba99@gmail.com>
 <20210105110219.99610-1-phillip.wood123@gmail.com>
 <CAPig+cT-9sjmkdWFEcFS=rg9ziV9b6uWNMpQ8BTYP-a258La6Q@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <936f9b7c-6d54-00bc-f136-4cb4c2836eb6@gmail.com>
Date:   Fri, 8 Jan 2021 10:33:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cT-9sjmkdWFEcFS=rg9ziV9b6uWNMpQ8BTYP-a258La6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric & Rafael

On 07/01/2021 03:34, Eric Sunshine wrote:
> On Tue, Jan 5, 2021 at 6:02 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> Add a -z option to be used in conjunction with --porcelain that gives
>> NUL-terminated output. This enables 'worktree list --porcelain' to
>> handle worktree paths that contain newlines.
> 
> Adding a -z mode makes a lot of sense. This, along with a fix to call
> quote_c_style() on paths in normal (not `-z`) porcelain mode, 

I'm concerned that starting to quote paths will break backwards 
compatibility. Even if we restricted the quoting to just those paths 
that contain '\n' there is no way to distinguish between a quoted path 
and one that begins and ends with ". This is the reason I prefer to add 
`-z` instead of taking Rafael's patch to quote the lock reason as that 
patch still leaves the output of `git worktree list --porcelain` 
ambiguous and it cannot be fixed without breaking existing users. A 
counter argument to all this is that there are thousands of users on 
file systems that cannot have newlines in paths and Rafael's patch is 
definitely a net win for them.

> can
> easily be done after Rafael's series lands. Or they could be done
> before his series, though that might make a lot of extra work for him.

I would definitely be easiest to wait for Rafael's series to land if we 
want to add `-z` separately

>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>> I found an old patch that added NUL termination. I've rebased it
>> but the new test fails as there seems to be another worktree thats
>> been added since I wrote this, anyway I thought it might be a useful
>> start for adding a `-z` option.
> 
> The test failure is fallout from a "bug" in a test added by Rafael's
> earlier series[1] which was not caught by the reviewer[2]. In fact,
> his current series has a drive-by fix[3] for this bug in patch [6/7].
> Applying that fix (or the refinement[4] I suggested in my review)
> makes your test work.

Thanks ever so much for taking the time to track down the cause of the 
test failure.

Best Wishes

Phillip

> [1]: https://lore.kernel.org/git/20201011101152.5291-2-rafaeloliveira.cs@gmail.com/
> [2]: https://lore.kernel.org/git/CAPig+cS8hvX4GCsnfLBnQ4Q_AkUad=bw7rjVcaOqSEqcLZvx8w@mail.gmail.com/
> [3]: https://lore.kernel.org/git/20210104162128.95281-7-rafaeloliveira.cs@gmail.com/
> [4]: https://lore.kernel.org/git/CAPig+cRysXpK0e1xXOuVd+EtkeyTk8FR6MUrL=Bg3W4ve8jdNA@mail.gmail.com/
> 
>> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
>> @@ -217,7 +217,13 @@ This can also be set up as the default behaviour by using the
>> +-z::
>> +       When `--porcelain` is specified with `list` terminate each line with a
>> +       NUL rather than a newline. This makes it possible to parse the output
>> +       when a worktree path contains a newline character.
> 
> If we fix normal-mode porcelain to call quote_c_style(), then we can
> drop the last sentence or refine it to say something along the lines
> of it being easier to deal with paths with embedded newlines than in
> normal porcelain mode.
> 
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> @@ -640,19 +640,25 @@ static int add(int ac, const char **av, const char *prefix)
>> +static void show_worktree_porcelain(struct worktree *wt, int line_terminator)
>>   {
>> +       printf("worktree %s", wt->path);
>> +       fputc(line_terminator, stdout);
>> +       if (wt->is_bare) {
>> +               printf("bare");
>> +               fputc(line_terminator, stdout);
>> +       } else {
>> +               printf("HEAD %s", oid_to_hex(&wt->head_oid));
>> +               fputc(line_terminator, stdout);
>> +               if (wt->is_detached) {
>> +                       printf("detached");
>> +                       fputc(line_terminator, stdout);
>> +               } else if (wt->head_ref) {
>> +                       printf("branch %s", wt->head_ref);
>> +                       fputc(line_terminator, stdout);
>> +               }
> 
> Perhaps this could all be done a bit more concisely with printf()
> alone rather than combining it with fputc(). For instance:
> 
>      printf("worktree %s%c", wt->path, line_terminator);
> 
> and so on.
> 
>> -       printf("\n");
>> +       fputc(line_terminator, stdout);
> 
> This use of fputc() makes sense.
> 
>> @@ -720,15 +726,20 @@ static void pathsort(struct worktree **wt)
>>   static int list(int ac, const char **av, const char *prefix)
>>   {
>> +               OPT_SET_INT('z', NULL, &line_terminator,
>> +                           N_("fields are separated with NUL character"), '\0'),
> 
> "fields" sounds a little odd. "lines" might make more sense. "records"
> might be even better and matches the wording of some other Git
> commands accepting `-z`.
> 
>> +       else if (!line_terminator && !porcelain)
>> +               die(_("'-z' requires '--porcelain'"));
> 
> Other error messages in this file don't quote command-line options, so:
> 
>      die(_("-z requires --porcelain"));
> 
> would be more consistent.
> 
>> diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
>> @@ -71,6 +71,28 @@ test_expect_success '"list" all worktrees with locked annotation' '
>> +test_expect_success '"list" all worktrees --porcelain -z' '
>> +       test_when_finished "rm -rf here _actual actual expect &&
>> +                               git worktree prune" &&
>> +       printf "worktree %sQHEAD %sQbranch %sQQ" \
>> +               "$(git rev-parse --show-toplevel)" \
>> +               "$(git rev-parse HEAD)" \
>> +               "$(git symbolic-ref HEAD)" >expect &&
>> +       git worktree add --detach here master &&
>> +       printf "worktree %sQHEAD %sQdetachedQQ" \
>> +               "$(git -C here rev-parse --show-toplevel)" \
>> +               "$(git rev-parse HEAD)" >>expect &&
>> +       git worktree list --porcelain -z >_actual &&
>> +       cat _actual | tr "\0" Q >actual &&
> 
> Or just use nul_to_q():
> 
>      nul_to_q <_actual >actual &&
> 
> (And there's no need to `cat` the file.)
> 
>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success '"list" -z fails without --porcelain' '
>> +       test_when_finished "rm -rf here && git worktree prune" &&
>> +       git worktree add --detach here master &&
>> +       test_must_fail git worktree list -z
>> +'
> 
> I don't think there's any need for this test to create (and cleanup) a
> worktree. So, the entire test could collapse to:
> 
>      test_expect_success '"list" -z fails without --porcelain' '
>          test_must_fail git worktree list -z
>      '
> 
