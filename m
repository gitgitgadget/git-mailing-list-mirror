Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890E1C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42E1864F45
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhCQS1T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhCQS1M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:27:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E01EC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:27:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h13so3486401eds.5
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=PPvNUb4VqpRkkRodjjpHvbQx9vGxHbl6zjtBMaIbir8=;
        b=WXqQBsDF9Lpt5a8ce45758rQj/67U2SLhdTFb3jbGm/y/HyJi6LOZPxUzPnFxz1qLI
         vanoRJn2yEPyo6B9BfCaoN7J6Of86Gtza9nZ0aZN38dY7+7k5Wyyeew6rt+AspQUd7ux
         l+cR3vun0sQ1YPGm2eDbfkIhq/gioO2wrY+57fXm3gdijeYpocN5kpKfd/00Q7Zzu8JI
         no0DM8em4SMFM/ADbRJKajR+1Dsj8UUo0MLFFQnNsdeJx0e0JVq9kxpYOk8L9R2kESqP
         OBUCsqVzcj4MBIodJG9oLqvUS1+wiLM4anej8sRr6s+kZ6rMN9BPHkgiETixTVhzFSd7
         VjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=PPvNUb4VqpRkkRodjjpHvbQx9vGxHbl6zjtBMaIbir8=;
        b=ai2ZhkLuW4qkOSSpLgLcb9ICs3XzyNvDIW0tGOjJ5WCzPJ2+8xgITY9AJdiH8uAv1/
         Z1vRqL8tqmM6sRJI1yvdAnX1B0M/4FTIwvcw9gMM5bEGXg2gFoXjLmoD3yG14sTQdhDe
         i2DhGEALSdOEsEP5NpQh2oPYMOipGtNQJZlApGVPUlb1kql0Kw5x6fKRgY9lHIcOunUt
         S7DPGbR56xeRvgmgltgU0I8h3t5jNtRBZlh0xsAO9IVP/hNymuY75Hty61N+N9HTbEip
         7+RuozpAYpX7IXhY1zGI+R/IC4X/tak2ruZCqenSyKgwVH9+3AUPghmizCu7ljsJFEjs
         O3uQ==
X-Gm-Message-State: AOAM531EKCfyFsNx7AIYaG1cZD2cVdnkIU2/LRq8OXVAJUj6X54dZAi0
        fB2LAQOWJvlbp5OrcL2PbUZ0bGwtpZuN5w==
X-Google-Smtp-Source: ABdhPJxJxk3/mi7idkS6bjB0yOqIHaGFp+kgNgtAE+upihLf8a5DLyP9se+sXDTlLjNQu3G01idbLA==
X-Received: by 2002:a05:6402:42c9:: with SMTP id i9mr17276378edc.35.1616005630466;
        Wed, 17 Mar 2021 11:27:10 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id gn3sm11642382ejc.2.2021.03.17.11.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:27:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [RFC/PATCH 3/5] ls-files: add and use a new --sparse option
References: <dffe8821fde290a1e19b2968098b007b9ac213e6.1615912983.git.gitgitgadget@gmail.com>
 <20210317132814.30175-4-avarab@gmail.com>
 <CABPp-BEvKTw6tXmFe-BnOsA6g2vsk7vwE1mkpxXmkO__5tFchg@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CABPp-BEvKTw6tXmFe-BnOsA6g2vsk7vwE1mkpxXmkO__5tFchg@mail.gmail.com>
Date:   Wed, 17 Mar 2021 19:27:09 +0100
Message-ID: <87lfalzldu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 17 2021, Elijah Newren wrote:

> On Wed, Mar 17, 2021 at 6:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  Documentation/git-ls-files.txt           |  4 ++
>>  builtin/ls-files.c                       | 10 ++++-
>>  t/t1091-sparse-checkout-builtin.sh       |  9 ++--
>>  t/t1092-sparse-checkout-compatibility.sh | 57 ++++++++++++++++--------
>>  4 files changed, 56 insertions(+), 24 deletions(-)
>>
>> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files=
.txt
>> index 6d11ab506b..1145e960a4 100644
>> --- a/Documentation/git-ls-files.txt
>> +++ b/Documentation/git-ls-files.txt
>> @@ -71,6 +71,10 @@ OPTIONS
>>  --unmerged::
>>         Show unmerged files in the output (forces --stage)
>>
>> +--sparse::
>> +       Show sparse directories in the output instead of expanding
>> +       them (forces --stage)
>> +
>>  -k::
>>  --killed::
>>         Show files on the filesystem that need to be removed due
>> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
>> index 4db75351f2..1ebbb63c10 100644
>> --- a/builtin/ls-files.c
>> +++ b/builtin/ls-files.c
>> @@ -26,6 +26,7 @@ static int show_deleted;
>>  static int show_cached;
>>  static int show_others;
>>  static int show_stage;
>> +static int show_sparse;
>>  static int show_unmerged;
>>  static int show_resolve_undo;
>>  static int show_modified;
>> @@ -639,6 +640,8 @@ int cmd_ls_files(int argc, const char **argv, const =
char *cmd_prefix)
>>                         DIR_SHOW_IGNORED),
>>                 OPT_BOOL('s', "stage", &show_stage,
>>                         N_("show staged contents' object name in the out=
put")),
>> +               OPT_BOOL(0, "sparse", &show_sparse,
>> +                       N_("show unexpanded sparse directories in the ou=
tput")),
>>                 OPT_BOOL('k', "killed", &show_killed,
>>                         N_("show files on the filesystem that need to be=
 removed")),
>>                 OPT_BIT(0, "directory", &dir.flags,
>> @@ -705,12 +708,17 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *cmd_prefix)
>>                 tag_skip_worktree =3D "S ";
>>                 tag_resolve_undo =3D "U ";
>>         }
>> +       if (show_sparse) {
>> +               prepare_repo_settings(the_repository);
>> +               the_repository->settings.command_requires_full_index =3D=
 0;
>> +       }
>>         if (show_modified || show_others || show_deleted || (dir.flags &=
 DIR_SHOW_IGNORED) || show_killed)
>>                 require_work_tree =3D 1;
>> -       if (show_unmerged)
>> +       if (show_unmerged || show_sparse)
>>                 /*
>>                  * There's no point in showing unmerged unless
>>                  * you also show the stage information.
>> +                * The same goes for the --sparse option.
>
> Yuck, haven't you just made --sparse an alias for --stage?  Why does
> it need an alias?

It doesn't, but --unmerged, the one other option which purely modifies
--stage output implies --stage.

So it's in line with existing UI convention in the command, it's
probably better to keep following that than have new options behave
differently.

But yeah, we could spell out --stage --sparse in the tests.

> Was the goal just to get a quick way to make the command run under
> repo->settings.command_requires_full_index =3D 0 without auditing the
> codepaths?  It seems to rely on them having been audited anyway, since
> it just falls back to the code used for --stage, so I don't see how it
> helps.  It also suggests the command might do unexpected or weird
> things if run without the --sparse option?  If people manually
> configure a sparse-checkout and cone mode AND a sparse-index (it's
> annoying how they have to specify all three instead of having to just
> pass one flag somewhere), then now we also need to force them to
> remember to pass extra flags to random various commands for them to
> operate in a sane manner in their environment??
>
> I think this is a bad path to go down.

Those are probably good points, I don't have enough overview of the
whole sparse thing yet to say.

I just thought it didn't make sense to have a series changing the nature
of the index without corresponding tooling changes to interrogate the
state of the index.

> However, if you want to write the necessary tests to make it so that
> ls-files can operate with command_requires_full_index =3D 0, then I
> think that's useful.  If you want to add a special flag so that folks
> in a sparse-checkout-with-cone-mode-with-sparse-index setup want to
> operate densely (i.e. to show what files would be in the index if it
> were fully populated), then I think that's useful.  But having
> sparse-yes-with-cone-yes-very-sparse folks need to specify an extra
> flag to commands to get sparse behavior just seems wrong to me.

Maybe, but what else do you suggest for getting this information out of
the index?

>>                  */
>>                 show_stage =3D 1;
>>         if (show_tag || show_stage)
>> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkou=
t-builtin.sh
>> index ff1ad570a2..c823df423c 100755
>> --- a/t/t1091-sparse-checkout-builtin.sh
>> +++ b/t/t1091-sparse-checkout-builtin.sh
>> @@ -208,12 +208,13 @@ test_expect_success 'sparse-checkout disable' '
>>  test_expect_success 'sparse-index enabled and disabled' '
>>         git -C repo sparse-checkout init --cone --sparse-index &&
>>         test_cmp_config -C repo true extensions.sparseIndex &&
>> -       test-tool -C repo read-cache --table >cache &&
>> -       grep " tree " cache &&
>> +       git -C repo ls-files --sparse >cache &&
>> +       grep "^040000 " cache >lines &&
>> +       test_line_count =3D 3 lines &&
>>
>>         git -C repo sparse-checkout disable &&
>> -       test-tool -C repo read-cache --table >cache &&
>> -       ! grep " tree " cache &&
>> +       git -C repo ls-files --sparse >cache &&
>> +       ! grep "^040000 " cache &&
>>         git -C repo config --list >config &&
>>         ! grep extensions.sparseindex config
>>  '
>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-c=
heckout-compatibility.sh
>> index d97bf9b645..48d3920490 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -136,48 +136,67 @@ test_sparse_match () {
>>         test_cmp sparse-checkout-err sparse-index-err
>>  }
>>
>> +test_index_entry_like () {
>> +       dir=3D$1
>> +       shift
>> +       fmt=3D$1
>> +       shift
>> +       rev=3D$1
>> +       shift
>> +       entry=3D$1
>> +       shift
>> +       file=3D$1
>> +       shift
>> +       hash=3D$(git -C "$dir" rev-parse "$rev") &&
>> +       printf "$fmt\n" "$hash" "$entry" >expected &&
>> +       if grep "$entry" "$file" >line
>> +       then
>> +               test_cmp expected line
>> +       else
>> +               cat cache &&
>> +               false
>> +       fi
>> +}
>> +
>>  test_expect_success 'sparse-index contents' '
>>         init_repos &&
>>
>> -       test-tool -C sparse-index read-cache --table >cache &&
>> +       git -C sparse-index ls-files --sparse >cache &&
>>         for dir in folder1 folder2 x
>>         do
>> -               TREE=3D$(git -C sparse-index rev-parse HEAD:$dir) &&
>> -               grep "040000 tree $TREE $dir/" cache \
>> -                       || return 1
>> +               test_index_entry_like sparse-index "040000 %s 0\t%s" "HE=
AD:$dir" "$dir/" cache || return 1
>>         done &&
>>
>>         git -C sparse-index sparse-checkout set folder1 &&
>>
>> -       test-tool -C sparse-index read-cache --table >cache &&
>> +       git -C sparse-index ls-files --sparse >cache &&
>>         for dir in deep folder2 x
>>         do
>> -               TREE=3D$(git -C sparse-index rev-parse HEAD:$dir) &&
>> -               grep "040000 tree $TREE $dir/" cache \
>> -                       || return 1
>> +               test_index_entry_like sparse-index "040000 %s 0\t%s" "HE=
AD:$dir" "$dir/" cache || return 1
>>         done &&
>>
>>         git -C sparse-index sparse-checkout set deep/deeper1 &&
>>
>> -       test-tool -C sparse-index read-cache --table >cache &&
>> +       git -C sparse-index ls-files --sparse >cache &&
>>         for dir in deep/deeper2 folder1 folder2 x
>>         do
>> -               TREE=3D$(git -C sparse-index rev-parse HEAD:$dir) &&
>> -               grep "040000 tree $TREE $dir/" cache \
>> -                       || return 1
>> +               test_index_entry_like sparse-index "040000 %s 0\t%s" "HE=
AD:$dir" "$dir/" cache || return 1
>>         done &&
>>
>> +       grep 040000 cache >lines &&
>> +       test_line_count =3D 4 lines &&
>> +
>>         # Disabling the sparse-index removes tree entries with full ones
>>         git -C sparse-index sparse-checkout init --no-sparse-index &&
>>
>> -       test-tool -C sparse-index read-cache --table >cache &&
>> -       ! grep "040000 tree" cache &&
>> -       test_sparse_match test-tool read-cache --table
>> +       git -C sparse-index ls-files --sparse >cache &&
>> +       ! grep "^040000 " cache >lines &&
>> +       test_sparse_match git ls-tree -r HEAD
>>  '
>>
>>  test_expect_success 'expanded in-memory index matches full index' '
>>         init_repos &&
>> -       test_sparse_match test-tool read-cache --expand --table
>> +       test_sparse_match git ls-tree -r HEAD
>>  '
>>
>>  test_expect_success 'status with options' '
>> @@ -394,9 +413,9 @@ test_expect_success 'submodule handling' '
>>         test_all_match git commit -m "add submodule" &&
>>
>>         # having a submodule prevents "modules" from collapse
>> -       test-tool -C sparse-index read-cache --table >cache &&
>> -       grep "100644 blob .*    modules/a" cache &&
>> -       grep "160000 commit $(git -C initial-repo rev-parse HEAD)       =
modules/sub" cache
>> +       git -C sparse-index ls-files --sparse >cache &&
>> +       test_index_entry_like sparse-index "100644 %s 0\t%s" "HEAD:modul=
es/a" "modules/a" cache &&
>> +       test_index_entry_like sparse-index "160000 %s 0\t%s" "HEAD:modul=
es/sub" "modules/sub" cache
>>  '
>>
>>  test_expect_success 'sparse-index is expanded and converted back' '
>> --
>> 2.31.0.260.g719c683c1d
>
> I do like the tests and your idea that we can use ls-files to list
> whatever entries are in the index, I just think the tests should use
> --stage to do that.

