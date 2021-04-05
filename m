Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD9FC433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 14:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 221BB613A3
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 14:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbhDEOoy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 10:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbhDEOoy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 10:44:54 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE343C061756
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 07:44:44 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r22so322011edq.9
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l4bvFmMk1yoQrgipmWbHKqDIMwtBIfjBqiAoC0m+PZU=;
        b=OwvNF5UT9w8UyW+1HReI/NdlrX0hcYSKnOU78kpGope18Zi/Ft58WC6t0uEEO6n2vh
         qpqUzmqDF1jlNwB2+SZGK5JXYCPNuMbad3W00Nrek16NtTbXvux1uSBeOzXHBtCL0UrS
         YpA0q9aSDdgNpPt0dcIWQKhtfzXIaJlZtYmWuGDQt8cat/8f+/TPQ2BGbd8Wcd4FqV5A
         dhd8O+OfgchtDaz/KwIMSQy1Ts7ux4pyWGRYqa+6Esj67sHt3fWs7IRaf9bBOJRmo5/9
         SttrheS06HDb+/ylUn2krUktv3Rck90wbU6i9gKHQV+SrLks02UfzHpJPezMLdUMmhBx
         Mu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l4bvFmMk1yoQrgipmWbHKqDIMwtBIfjBqiAoC0m+PZU=;
        b=rYm2TjiL8kL0jVBPXCyKKJSE16r193Dir/knKvhD8BkOq+DwvVocBvFZPSR/oOUCJT
         a/TzIvrGlQ+mUtPFdqHzVOKdouKEEH5CXpZi5p7K/07svT5FREP5RbdWc/esE7lq+q1E
         tkghCqGg6P20ixNFP/ULzyqnCaLF1VahGnUVAPKHoMCfNZAZvvsVDwmUbM1FO5ByxmD9
         frIfXZhQraoCt32HyYOYeOx27bA/x4Cgl96RlX5qwyM5AXHwiyq9vHltC+Lrl/jLMnZ6
         DfCxyeNssZPR1DtzDY7W/ikyU1Y4uxzz1TSC8/QUS6EduipWyjuKbSVgT3Po8iqJ+BYd
         yuoA==
X-Gm-Message-State: AOAM533hgMNrUmKdIOmWM8NmOx6/6xxm7kqZ5HYBsrvV81+LucpI7B9O
        hJJLOfYTrtoH1n44L7nX6oTtfgYVA9RUyJ/0MNRAPqDin5Y=
X-Google-Smtp-Source: ABdhPJzB28rYst62RDpDQ/0lh8uA+y701XVXF43n+vmQff7nBJTFd+6Uf71577CD5BO/3fFG1JyLvY+IkDaAz5rH9pw=
X-Received: by 2002:aa7:cf90:: with SMTP id z16mr31900454edx.273.1617633883314;
 Mon, 05 Apr 2021 07:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <195bf718-6226-43c9-8c58-167388d3d99b@gmail.com>
 <f5b9ea24-e2f7-6c54-b4ff-86cef27527f7@gmail.com> <CAP8UFD1PC=vQCXLLoECPzFc8BGGfQxptHE5+Et11F-=3-twZYg@mail.gmail.com>
 <769c7c48-a518-2636-10be-1479997e8f15@gmail.com>
In-Reply-To: <769c7c48-a518-2636-10be-1479997e8f15@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 5 Apr 2021 16:44:32 +0200
Message-ID: <CAP8UFD0RyhnurYdWt1xWF2O-bpk-irSs71+XH1Zd8ghdzRKZ8Q@mail.gmail.com>
Subject: Re: [GSoC] Draft Proposal (Convert submodule to builtin)
To:     Chinmoy Chakraborty <chinmoy12c@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 3, 2021 at 4:13 PM Chinmoy Chakraborty <chinmoy12c@gmail.com> w=
rote:
>
> Here is a textual format of the draft proposal.
>
>
> Convert submodule to builtin
> March 2021
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> ##Personal Information##
>
>
> Name - Chinmoy Chakraborty
> E-mail - chinmoy12c@gmail.com
> Github - https://github.com/chinmoy12c
> Linkedin - https://www.linkedin.com/in/chinmoy12c/
> Major - Information Technology
> Time Zone - IST (UTC+05:30)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> ##Work Environment##
>
> I am fluent in C, Java, Python, and Shell script. I use Git as my VCS,
> Visual Studio Code
> as my primary code editor, and Kali Linux as my primary OS.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
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
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Ok.

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
> `builtin/submodule--helper.c` to `builtin/submodule.c`.

You could add something like "so that the `git submodule` is fully
implemented using C".

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
> additional shells. This adds to the overhead in using the
> commands in terms of time and memory.
>
> "No access to low-level API"
>
> The shell commands don=E2=80=99t have access to low level commands
> like `git hash-object`, `git cat-file` etc. As these commands
> are internally required for submodule commands to work, the shell
> script needs to spawn a separate shell to execute these commands.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Ok.

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
> was kicked out because it has been stale for so long.

Maybe you could explain a bit what "kicked out" means, or replace it
with something more explicit, for people who don't know well how Git
development works.

> The first
> and foremost aim of the project will be to finish porting this
> command.

You mean the "add" sub-command, or the full "submodule" command?

> Thereafter, the end goal would be to completely replace
> the shell script (git-submodule.sh) with an efficient c code.

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

Yeah, nice!

How does this compare with Shourya's work? Will this avoid the design
issues in Shourya's work?

> An additional test tweak would also be required in
> `t7400-submodule-basic.sh`,
> to prepend the keyword =E2=80=98fatal=E2=80=99 since the command dies out=
 in case
> of absence of commits.
>
>
> The following helper functions would be required to be implemented -
>
> - A function to guess the directory name from the repository string.
> - A function for normalizing path, that is, removing multiple
>    //; leading ./; /./; /../; trailing / .
>
> - A function to check for tracked directories properly as pointed
>    out by Kaartic Sivaraam on the thread:
> https://lore.kernel.org/git/ce151a1408291bb0991ce89459e36ee13ccdfa52.came=
l@gmail.com/.
>
> - A function to check if the path exists and is already a git
>    repo, else clone it.
>
> - A function to set the submodule config properly.

Nice! Maybe you could give an example and tell:
- how you would name one of the above function,
- what would be its arguments,
- perhaps how you would test it
...

> - After implementation of all these helper methods, the main
>    `module_add()` function would be implemented using the helper
>    functions listed above as well as those helper functions which
>    are predefined.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Ok, I will review the other parts later.

Thanks!
