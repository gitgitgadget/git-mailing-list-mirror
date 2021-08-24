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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E556AC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 13:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFDDA61262
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 13:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbhHXNWW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 09:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbhHXNWV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 09:22:21 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EBBC061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 06:21:37 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id x140so6704497ybe.0
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 06:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dQpfzvHVgQxLN6I6Msnu/QssAc6cFLmWP3Z6qwIu7+U=;
        b=bI93PZKReiNsL0Wt9g+fUuL/gqG8K7Oko2VBuyxDwGKVTPQFLwouvBHvysnMpHSCRk
         PFbIM4gFgW2TdOqJe8BKCbyUS09mnNuBfjqND19isR63tj1lHAuCtMqTXpX0b/7dY8kE
         oKcYf/gn5S/WEAY8mDVOTdSBDmRXb8ODChhBddXLoAZiofKcyiILuvdl5f5Eyc1qquHk
         7jNar6h6KUk9DkwSoxSIworElblBmBI/h8Q5/xhwYtJgm6h38CKiqfc/RvM4k/TPv0yu
         6xy8csCfpHAf9xSBf3Jfy8EJYFJ1F3SmEZzNYdTBinFgQvL7yX7QLhEi3HHsLVSb+xJm
         /xPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dQpfzvHVgQxLN6I6Msnu/QssAc6cFLmWP3Z6qwIu7+U=;
        b=hjCxE5tULaD5tln5wt/julVinpVIvfBdrPvt8ZdkydRLworZuVapyFbsYnzkAVtTiP
         OGSOa8XoT0EY6lsYS9pWA0nWLroAJi79/+uGQrqmbINl9gzLSgSdDiWuILnvBe9Kyf3m
         QczmL1s+GBvnZ7lB8PXT415WhKDzyulEMeddOvPvfn6GrPLMXug1JqXs8HP+fPw9iOkT
         zOqCBFIBwJy/kYLkEc8zF0Bj6Wg7t9enVwPWOgGOJbTT+kBGlxn/gdSIwE2wS1DFRHuM
         WI0cljmipN1fe16U+dxh0HxVOlsoJi/JvbeiryXkIsd/b7xII8Wdfg6/ETfZSAXqIeE4
         CXIg==
X-Gm-Message-State: AOAM532AXlF+bsBGFFfVMx4je2B1y1hHjjzXpEpUg722IAgotgg1awFu
        qItODkyfdZxgnaOwTZduV0qpUhuVnO3OF9TRNwzfyypY0FCm8c/1
X-Google-Smtp-Source: ABdhPJxgpGvV2XvQ1UEalPMGfq0HQNTHAsmkH1bt0OA/EFpxHxLjycLD5W4DqHvGsHV0+/Q1AA621SHlYxUMDIgwLKo=
X-Received: by 2002:a25:a20a:: with SMTP id b10mr51122514ybi.478.1629811296319;
 Tue, 24 Aug 2021 06:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210822161325.22038-1-worldhello.net@gmail.com>
 <20210822161325.22038-2-worldhello.net@gmail.com> <nycvar.QRO.7.76.6.2108232232460.55@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2108232232460.55@tvgsbejvaqbjf.bet>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 24 Aug 2021 21:21:25 +0800
Message-ID: <CANYiYbE6=+jbhea71r7Swqc012EOpaNiRequTeZQqfWnnB8gNw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ci: new github-action for git-l10n code review
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 5:03 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> It is a good idea to automate this.
>
> I am a bit concerned that the `ci-config` approach, even if we use it in
> the Git project itself, is quite cumbersome to use, though. So I hope tha=
t
> we can find an alternative solution.
>
> One such solution could be to make the `git-po-helper` job contingent on
> part of the repository name. For example:
>
>   git-po-helper:
>     if: endsWith(github.repository, '/git-po')
>     [...]
>
> would skip the job unless the target repository's name is `git-po`.

Yes, this is a solution I also want to try at the very beginning. But
some l10n team leaders may fork their repositories directly from
git/git, and name their repo as "{OWNER}/git".  I want to try another
solution: check existence of file "ci/config/allow-l10n" in branch
"ci-config" using a GitHub API, instead of cloning the ci-config
branch and execute the shell script "ci/config/allow-l10n".

> A couple more questions/suggestions are below:
>
> > +  git-po-helper:
> > +    needs: ci-config
> > +    if: needs.ci-config.outputs.enabled =3D=3D 'yes'
> > +    runs-on: ubuntu-latest
> > +    steps:
> > +    - uses: actions/checkout@v2
> > +      with:
> > +        fetch-depth: '0'
>
> There is code below to specifically fetch the base commit, but setting th=
e
> `fetch-depth` to zero means to do a full clone anyway.
>
> So maybe the `git fetch` code below should be dropped, or the
> `fetch-depth` override?
>
> Since we cannot know how deep we need to fetch, though, I figure that it
> would be indeed better to have a non-shallow clone (and a code comment
> would help clarify this).

If we want do a shallow clone, maybe we can try like this:

1.  Make 'git-po-helper' works with a bare repository, so the initial clone
    can be a shallow bare repository without checkout.
2.  Will get two revisions, base and head revision, when the workflow is
    triggered. (In patch v1, base and head revision are named as
    commit_from and commit_to)
3. Fetch the base revision and head revision using command:
    git fetch origin --depth=3D100 <base> <head>

We used a fixed depth 100, because we don't know how many commits
these two revisions are diverged.

Will feed the result of "git rev-list <base>..<head>" to
"git-po-helper", if depth 100 is not deep enough, rev-list will fail,
and should try to
run "git rev-list <head> -100".

I think the first version of l10n.yml should use a full clone, and try
to refactor later to use a shallow or partial clone.

> An even better alternative would be a partial clone, of course, but I fea=
r
> that there is no convenient way yet to configure `actions/checkout` to do
> so.

Good idea.

> > +    - uses: actions/setup-go@v2
> > +      with:
> > +        go-version: ">=3D1.16"
> > +    - name: Install git-po-helper
> > +      run: |
>
> Since this is a one-liner, it would probably make sense to avoid that `|`
> continuation.

Will do.

> > +      run: |
> > +        if test "${{ github.event_name }}" =3D "pull_request"
> > +        then
> > +          commit_from=3D${{ github.event.pull_request.base.sha }}
> > +          commit_to=3D${{ github.event.pull_request.head.sha }}
> > +        else
> > +          commit_from=3D${{ github.event.before }}
> > +          commit_to=3D${{ github.event.after }}
> > +          if ! echo $commit_from | grep -q "^00*$"
>
> This would probably read better as:
>
>                 case "$commit_from" in
>                 *[^0]*|'') ;; # not all zeros
>                 *)

It's better than my version "echo .. | grep".

>                         [...]
>                         ;;
>                 esac
>
> But we might not need it anyway. See the comment on the `git fetch`
> command below.
>
> > +          then
> > +            if ! git rev-parse "$commit_from^{commit}"
> > +            then
> > +              git fetch origin $commit_from
>
> As pointed out above, we cannot know how many commits we need to fetch.
> Therefore, I would suggest to simply drop this `git fetch`.

v2 renamed $commit_from to $base, and renamed $commit_to to $head.

For a force push, the base commit is missing from the initial clone,
and the missing revision can be only accessed (fetched) using a full
SHA. For a "pull_request_target" event, the "head" revision is also
missing, because "pull_request_target" only the base commit is
checkout.

> > +            fi
> > +          fi
> > +        fi
> > +        exit_code=3D0
> > +        git-po-helper check-commits --github-action -- \
> > +          $commit_from..$commit_to >git-po-helper.out 2>&1 ||
>
> What does the `--github-action` option do? Might be good to document this
> here.

The option "--github-action" will enable "--no-gpg" and
"--no-gettext-back-compatible" options. To make the workflow
"l10n.yml" stable, I introduced the "--github-action" option. You can
see I introduced another option "--github-action-event=3D<push |
pull_request_event>", and the boolean option "--github-action" can be
omitted.

> > +        exit_code=3D$?
> > +        echo "::set-output name=3Dexit_code::$exit_code"
> > +        has_error_msg=3D
> > +        has_warning_msg=3D
> > +        if test $exit_code -ne 0
> > +        then
> > +          has_error_msg=3Dyes
>
> Do we really need this `has_error_msg` variable? It would be much easier
> to test the condition `env.ERROR_MSG !=3D ''` in subsequent steps, and th=
at
> would already do the job, without having to go through output variables.

"env.ERROR_MSG" is an environment variable which contains multiple
lines.  Shell script like `if test ${{ env.ERROR_MSG }} !=3D ""` may
break.

> > +          if test "${{ github.event_name }}" =3D "pull_request"
> > +          then
> > +            echo "ERROR_MSG<<EOF" >>$GITHUB_ENV
> > +            grep -v -e "^level=3Dwarning" -e WARNING git-po-helper.out=
 |
> > +              perl -pe 's/\e\[[0-9;]*m//g' >>$GITHUB_ENV
>
> This is a bit dangerous. First of all, how can you be sure that
> `git-po-helper.out` does not contain lines that consist of the letters
> `EOF` (and would therefore interfere with the here-doc)?

Will replace possible "EOF$" from the output file.

> Second, isn't it conceivable to have an `error:` line which contains the
> characters `WARNING` too? That line would be filtered out...

Will report errors and warnings all together.

> Third, can `git-po-helper` be convinced _not_ to print color codes? The
> output was redirected into a file, after all, and it does not go to a
> terminal...

"git-po-helper" uses the package "logrus" for logging. The default
format of "logrus=E2=80=9D to write log to file is for machines, not user
friendly. The only way is provide an additional option "ForceColor" to
it. So I must clear the color code from the output file, if I want to
create a comment for pull request. But the ansi colors are nice to
display in the report of the action workflow.

> > +            echo "EOF" >>$GITHUB_ENV
> > +          fi
> > +        fi
> > +        if grep -q -e "^level=3Dwarning" -e WARNING git-po-helper.out
> > +        then
> > +          has_warning_msg=3Dyes
> > +          if test "${{ github.event_name }}" =3D "pull_request"
> > +          then
> > +            echo "WARNING_MSG<<EOF" >>$GITHUB_ENV
> > +            grep -v -e "^level=3Derror" -e ERROR git-po-helper.out |
> > +              perl -pe 's/\e\[[0-9;]*m//g' >>$GITHUB_ENV
> > +            echo "EOF" >>$GITHUB_ENV
> > +          fi
> > +        fi
> > +        echo "::set-output name=3Dhas_error_msg::$has_error_msg"
> > +        echo "::set-output name=3Dhas_warning_msg::$has_warning_msg"
> > +    - name: Report errors in comment for pull request
> > +      uses: mshick/add-pr-comment@v1
> > +      if: steps.check-commits.outputs.has_error_msg =3D=3D 'yes' && gi=
thub.event_name =3D=3D 'pull_request'
> > +      continue-on-error: true
> > +      with:
> > +        repo-token: ${{ secrets.GITHUB_TOKEN }}
>
> This requires the `GITHUB_TOKEN` to have write permissions, which I would
> highly recommend not to require.

The action "mshick/add-pr-comment@v1" needs this token. See:
https://github.com/mshick/add-pr-comment .

> Instead, it would probably make more sense to keep the output in the logs
> of the workflow run.

You can see this nice post from ecco:
https://github.community/t/github-actions-are-severely-limited-on-prs/18179

For a successful git-l10n workflow, there are no errors, but may have
warnings for possible typos found in a ".po" file.  There may be lots
of false positives in these warnings.  If I hide these warnings in the
log of a workflow, git-l10n contributors may not notice them. So I
need a way to create comments in pull requests.

See some typical code reviews for git-l10n:

* https://github.com/git-l10n/git-po/pull/541
* https://github.com/git-l10n/git-po/pull/555

> > +        repo-token-user-login: 'github-actions[bot]'
> > +        message: |
> > +          Errors found by git-po-helper in workflow ${{ github.workflo=
w }}:
> > +          ```
> > +          ${{ env.ERROR_MSG }}
> > +          ```
> > +    - name: Report warnings in comment for pull request
> > +      uses: mshick/add-pr-comment@v1
> > +      if: steps.check-commits.outputs.has_warning_msg =3D=3D 'yes' && =
github.event_name =3D=3D 'pull_request'
> > +      continue-on-error: true
> > +      with:
> > +        repo-token: ${{ secrets.GITHUB_TOKEN }}
> > +        repo-token-user-login: 'github-actions[bot]'
> > +        message: |
> > +          Warnings found by git-po-helper in workflow ${{ github.workf=
low }}:
> > +          ```
> > +          ${{ env.WARNING_MSG }}
> > +          ```
> > +    - name: Report and quit
> > +      run: |
> > +        if test "${{ steps.check-commits.outputs.has_error_msg }}" =3D=
 "yes"
>
> This would be easier to read and maintain if it was upgraded to an `if:`
> condition:
>
>     - name: Report errors
>       if: step.check-commits.outputs.has_error_msg =3D "yes"
>       run: |
>         [...]
>
> And then do the same for warnings.

When users check the log of a workflow, they will only expand the
failed step.  So warnings and errors are reported in one step.

> Also, it would be more natural if the `Run git-po-helper` step was allowe=
d
> to fail when `git-po-helper` outputs errors. You would then have to use
> this conditional in the `Report errors` step:
>
>       if: failure() && step.check-commits.outputs.has_error_msg =3D "yes"
>
> (compare to how Git's `CI/PR` workflow prints errors:
> https://github.com/git/git/blob/v2.33.0/.github/workflows/main.yml#L120).
>
> For the `Report warnings` step, you would however have to use something
> slightly less intuitive:
>
>       if: (success() || failure()) && step.check-commits.outputs.has_warn=
ing_msg =3D "yes"

Will try.

> Finally, I _do_ think that this line would be easier to read like this,
> while basically doing the same thing but with less effort (because the
> outputs would no longer have to be set):
>
>       if: (success() || failure()) && env.WARNING_MSG !=3D ""
>
> Ciao,
> Dscho
