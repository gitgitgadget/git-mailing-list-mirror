Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9E1C433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 12:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 569FE610F9
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 12:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbhDJMEM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 08:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbhDJMEL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 08:04:11 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE72C061762
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 05:03:56 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r9so12687748ejj.3
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 05:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UGexUgqNlElFOnxJN0pqvleJEFEQ7WkxgYZ1RqlgctE=;
        b=nPQXPtJefYlPg5mGKyKuc+5uy25XzDjvZVf4fTFjzHvX9Vk+Xq9/vsDaMFKfE6asYc
         zwRxcqV/JUkcPcgHN7JiOuOh5w/ildphOKUVlvjBAC1mgjA1LcL4WXabNS/BvAcEp9Jh
         ++66OS09x6cRmi4lx8n8ELt9oMZXm8te7I3f058Xpm2le5yEyESDr40XkM9lthXi67/g
         6xjSLXUhIMk1gZ5VR4n3YMjxAe30WLIavkWg1gzQm8F8lhy+atBx9DNgGxmM5DS8r22h
         mz+rp9CA6KgjsRnA5yEvhKoivxVD+NUvRvmhx21UZstZfKG8JOuqn9NNusTg0N76iUoq
         LtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UGexUgqNlElFOnxJN0pqvleJEFEQ7WkxgYZ1RqlgctE=;
        b=cdz2UczRyHEW+5QmsRR46bi3fDlpTMLvI1EhDAITF2zyvmCN9/MuI08FksowM/ORhD
         Dc7+N6++fIKA5UkG6zQs+WlMGgZ91n4KOibFHKqf9uwB46GuzemW+qBWMWXSd7HbR9L3
         BL8pkXSM0HAdhR8TYhbAIHXcfd7omPgYgCzZiPO3quvA4vuKSfRMxdQ7fiemtkyvdn6Y
         klJbNO8ii3m3VvwCyCBa+pynpInwWQiOITsnfV0IhPjxl8ZaNpFwhcM49p7SU8SHY4+C
         4LWpkdp9n9aWUlt9QE/0dvXcTxNwRncLndpXqiJz5+B9R656ovQoqN5AFPmKEEFw4R86
         v/cw==
X-Gm-Message-State: AOAM532hIbnfVQOtXL5O7aZFWJYmPVVNNY/meR5hUmWmwx4tW1ah3ysy
        CpPG4eR8ebIo3TsVdcNrS82TCFUEUGYCPQnfzE0=
X-Google-Smtp-Source: ABdhPJzv++NVVVhUyqnEmI8wKQ/cVCRSZ3ea6zC8Vib4HeZm+USjpZKbYJwhNYozMdlYV4Kksc5aSV1O/xebt6EemUg=
X-Received: by 2002:a17:906:b104:: with SMTP id u4mr19680288ejy.211.1618056235181;
 Sat, 10 Apr 2021 05:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <195bf718-6226-43c9-8c58-167388d3d99b@gmail.com>
 <f5b9ea24-e2f7-6c54-b4ff-86cef27527f7@gmail.com> <CAP8UFD1PC=vQCXLLoECPzFc8BGGfQxptHE5+Et11F-=3-twZYg@mail.gmail.com>
 <769c7c48-a518-2636-10be-1479997e8f15@gmail.com> <CAP8UFD0RyhnurYdWt1xWF2O-bpk-irSs71+XH1Zd8ghdzRKZ8Q@mail.gmail.com>
 <374a2b8a-0d59-4546-eab3-7229943217ba@gmail.com>
In-Reply-To: <374a2b8a-0d59-4546-eab3-7229943217ba@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 10 Apr 2021 14:03:43 +0200
Message-ID: <CAP8UFD15qSTyOLgRFRDvL5ja4zM_JZjMNq3xaVZF=E2ougjvWQ@mail.gmail.com>
Subject: Re: [GSoC] Draft Proposal (Convert submodule to builtin)
To:     Chinmoy Chakraborty <chinmoy12c@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 8, 2021 at 11:10 AM Chinmoy Chakraborty
<chinmoy12c@gmail.com> wrote:
>
> This is the V2 of the draft proposal after applying the
>
> changes suggested by Christian Couder and Kaartik Sivaraam.

Please add all the reviewers in Cc. I added Kaartic.

> ##Git Contributions##
>
> [Microproject] Replace instances of `the_repository` with =E2=80=98r=E2=
=80=99. (Learning
> the ropes)
> Pull request: https://github.com/gitgitgadget/git/pull/915
> Mailing List:
> https://lore.kernel.org/git/pull.915.git.1616701733901.gitgitgadget@gmail=
.com/
>
>
> [column, range-diff] downcase option description
> Pull request: https://github.com/gitgitgadget/git/pull/920
> Mailing List:
> https://lore.kernel.org/git/pull.920.git.1616913298624.gitgitgadget@gmail=
.com/
>
>
> [Documentation] updated documentation for git commit --date
> Pull request: https://github.com/gitgitgadget/git/pull/918
> Mailing List:
> https://lore.kernel.org/git/pull.918.git.1616926790227.gitgitgadget@gmail=
.com/

Adding a status to let us know if each of your contributions have been
merged to seen, next or master, or even already released (in which
version?) would be nice. You could also add a GitHub or GitLab link to
the merge commit that merged your contribution.

> ##Project Outline##
>
> A few components of git, like `git-submodule.sh`
> are in the form of shell scripts. This causes
> problems in production code in multiple platforms
> like windows. The goal of this project is to
> convert the shell script version of `git-submodule.sh`
> to portable c code. The end goal would be

s/c/C/

> to completely remove `git-submodule.sh` and rename
> `builtin/submodule--helper.c` to `builtin/submodule.c`
> so that the `git submodule` is fully implemented using C.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> ##Why is the project required?##
>
> "Issues with the portability of code"
>
> The submodule shell script uses shell commands like
> `echo`, `grep`, `test`, `printf` etc. When switching
> to non-POSIX compliant systems, one will have
> to re-implement these commands specifically for the
> system. There are also POSIX-to-Windows path conversion
> issues. To fix these issues, it was decided to convert
> these scripts into portable C code.
>
> "Large overhead in calling the command"
>
> The commands implemented in shell scripts are not builtins, so
> they call `fork()` and `exec()` multiple times, hence creating
> additional shells.

s/shells/processes/

> This adds to the overhead in using the
> commands in terms of time and memory.
>
> "No access to low-level API"
>
> The shell commands don=E2=80=99t have access to low level commands
> like `git hash-object`, `git cat-file` etc.

I am not sure it's correct to say that they don't have access to such
low level commands. I think it would be better to say that they don't
have direct access to the internal functions behind such low level
commands.

> As these commands
> are internally required for submodule commands to work, the shell
> script needs to spawn a separate shell to execute these commands.

s/separate shell/separate process/

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> ##How have I prepared?##
>
> I have gone through all the previous works and read through their
> code to make myself accustomed to the intricacies of the code.
> I have also structured my workflow based on the observation of
> the previous discussions on those patches, and taken into
> consideration the issues faced previously.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> ##Previous Work##
>
> A large part of the `git submodule--helper.c` has already been

I would say that it's 'git-submodule.sh' that has been converted. 'git
submodule--helper.c' is the result of that conversion.

> converted by Stefan Beller, Prathamesh Chavan in his GSoC project
> in 2017, and Shourya Shukla in his GSoC project in 2020. This is
> the list of already ported commands.
>
> set-branch
> set-url
> summary
> status
> init
> deinit
> update
> foreach
> sync
> absorbgitdirs
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> ##Work to be done##
>
> The only command that is left to be ported is `git submodule add`.
> The previous work on this by Shourya Shukla in GSoC 2020, did
> not reach a successful merge due to some issues in design and
> the patch was dropped as it had been stale for long.
> See:
> https://github.com/git/git/blob/1861aa482a38ae84f597cede48167ab43e7e50a3/=
whats-cooking.txt#L1158-L1169
> The first and foremost aim of the project will be to finish
> porting the `add` command. Thereafter, the end goal would be to
> completely replace the shell script (git-submodule.sh) with
> an efficient c code.

s/c/C/

> Before porting the `git submodule add` command the initial work
> would be dedicated to the implementation of small helper functions
> in the form of small patches, which would be directly used by the
> `add` command. This workflow is based on the suggestion by
> Junio C Hamano on the thread:
> https://lore.kernel.org/git/xmqqd01sugrg.fsf@gitster.c.googlers.com/.
>
> This workflow would help in the following ways:
>
> - It would help in sending patches in a small digestible format.
> - It would help the reviewers easily review those small units
>    of patches in a single sitting.
> - It would help keep small logical units of code in different clean commi=
ts.
>
> An additional test tweak would also be required in
> `t7400-submodule-basic.sh`,
> to prepend the keyword =E2=80=98fatal=E2=80=99 since the command dies out=
 in case
> of absence of commits as pointed out by Kaartic Sivaraam on the thread:
> https://lore.kernel.org/git/ce151a1408291bb0991ce89459e36ee13ccdfa52.came=
l@gmail.com/.

Ok.

> The following helper functions would be required to be implemented -
>
> - A function to guess the path name from the repository string.
>    Example prototype: static char *guess_dir_name(const char *repo)
>    Returns the path name.
>
> - A function to assure repo is absolute or relative to parent.
>    Example prototype: static char *get_real_repo(const char *repo)
>    Returns the correct repo name.
>
> - A function for normalizing path, that is, removing multiple
>    //; leading ./; /./; /../; trailing / .
>    Example prototype: static char *normalize_path(const char *path)
>
> - A function to check if the path exists and is already a git
>    repo, else clone it.
>    Example prototype: static int add_submodule(struct add_data *info)
>    `add_data` is a struct which stores the config of the submodule.
>
> - A function to set the submodule config properly.
>    Example prototype: static void config_added_submodule(struct add_data
> *info)

How would you test these helper functions? Would they be used by any
code in 'builtin/submodule--helper.c'?

> - After implementation of all these helper methods, the main
>    `module_add()` function would be implemented using the helper
>    functions listed above as well as those helper functions which
>    are predefined.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> ##Project Timeline##
>
> "Present Day - May 17"
> I=E2=80=99ll utilize this time in exploring the codebase more properly an=
d
> solving more issues, which would help me properly familiarize
> myself with the codebase. I=E2=80=99ll also try to structure a more
> solidified, detailed workflow and come up with a draft patch

A draft patch of what? I thought that you wanted to create many
patches, each one implementing a small step, maybe a single function
that you described above.

> based on the previous work and discussions.
>
> "May 17 - June 7 (Community bonding period)"
> - Get familiar with the community.
> - Discuss proper workflow with mentors.
> - Make changes in the timeline, if necessary.
> - Discuss the structure of the series of patches.
>
> "June 7 - June 25 (Initial coding phase)"
> - Finish implementation of the helper functions.
> - Work on a proper structure of the implementation of the
>    `submodule add` command

I am not sure what this means.

> and implement additional helper
>    functions if required.
> - Update proper documentation of the helper functions.
>
> "June 25 - July 5 (Binding the code)"
> This time would be used to code the main `submodule add`
> command using all the helper functions implemented in the
> initial phase of coding.

So how would the helper functions be useful and tested before this step?

> This includes binding all the code
> together and then completing the command through incremental
> reviews. Also, the necessary documentation would be updated
> parallelly.
>
> "July 5 - July 12 (Initiate porting of command)"
> - Discuss how to go about porting the entire submodule script.
> - Initiate porting of the `git-submodule.sh` script.
>
> "July 12 - July 16 (Phase 1 evaluation)"
>
> "July 16 - July 26 (Semester exams)"
> I will be taking my semester examinations during this
> time. As such, I=E2=80=99ll try to be in touch with the mentors
> and take out as much time as possible (around 20 hours a week).
>
> "July 26 - August 10 (Porting the complete script)"
> This period would be utilized in the complete conversion of
> `git-submodule.sh` into c code and combine it with

s/c code/C code/

> `submodule--helper.c` to make a single `builtin/submodule.c`.
> As I=E2=80=99ll be completely free from academics during this period,
> I=E2=80=99ll try to compensate as much time as possible for the above
> period of July 16 - July 26.
