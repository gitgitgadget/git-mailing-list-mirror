Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwU9otcE"
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB5D1AD
	for <git@vger.kernel.org>; Sat, 18 Nov 2023 03:28:58 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5441305cbd1so3952606a12.2
        for <git@vger.kernel.org>; Sat, 18 Nov 2023 03:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700306937; x=1700911737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzdhFzCNCGrRqx9iZGwiBPJNSq8CSva5V9x9F+2dNIw=;
        b=KwU9otcEKQUAQ0gsSz1CQe6t3EuOqfgzW0vO1DD2wUcxSJ2K6tTNB6NvUjESd3nXpu
         3Sm5z9nJ9/nZfiXhAEBY2D6bfjlHW2LDPflBaRkKkzkuQ9H7XIJVdMN/NmdexMFIDa+H
         sksT2w6G7atoDlu5rIH3jyLFC0DJOdRfWcCU9mCFxBwidDO3nP+LQ/PMPEInVPbMhE30
         InTykP05OnHmSvQPVtiNuRGB8q/T7u3Z1P1oWbaD5lEQpG1lDGXgZnf9O7g5nk/PwHae
         t5NRo1MuhYxfCaibn0+BkH/cXcK0tywVaqzbu+RSCG06NBFvkOREVUa7ChE07B6N1a7D
         nyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700306937; x=1700911737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzdhFzCNCGrRqx9iZGwiBPJNSq8CSva5V9x9F+2dNIw=;
        b=AoKpJ50NJZhTrm1Kv2pMJg9C5LlC7pl78LLGVRVGghwES7swVgBfEnABj6hSHxzjkv
         nnm5WMf51fhQa5SZRUbOhtHSBIlE9dh67EtjUpzMPxjBeqvoBMdaq5GGjbX5TI0bGmjX
         RQF5FcmTJJI5J0DuM6muxsr/oL90o9Hiqy4W/sgrLpyEXrkrVq/+gRdfoxLH6zB1u8/N
         3K81Xrlcmv97vdxC19oZ7Ucj9/fNIYE1oTYvWtnTacXjN63hmoL7YgsTPnR+mc8qfHvK
         CMYGlYZuG+1BUaRkZQvgv7p+S8MOT9rtb+oImuK0fFsroJaRSDpKuITJVX/UkUWekmTt
         b8Bg==
X-Gm-Message-State: AOJu0YzxzqdfuqUeuJkPNUQTZsD5bU/IfWbC12z+A/JRawMbIlz+EZRn
	EDFM+JM8O+4owPTASkfHpO4qPdSBAsQiJ94T2J/8CJz/a8c=
X-Google-Smtp-Source: AGHT+IGTwjNUqHCdFSfy3Slc/zrlFi+RAKJ7INEMrxiIYMDyuV6C/1M9Xvfiw1TsYIiGFEuhoYBqCQfPA02RZVUEpyE=
X-Received: by 2002:a17:907:c20b:b0:9e5:e7da:8cfd with SMTP id
 ti11-20020a170907c20b00b009e5e7da8cfdmr1681633ejc.11.1700306936509; Sat, 18
 Nov 2023 03:28:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1587.v3.git.1696019580.gitgitgadget@gmail.com> <pull.1587.v4.git.1698347871200.gitgitgadget@gmail.com>
In-Reply-To: <pull.1587.v4.git.1698347871200.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 18 Nov 2023 12:28:42 +0100
Message-ID: <CAP8UFD18Hh=m8HQibAgZW1KNAn6zg_rxe9asg0ViC5z27W=Smw@mail.gmail.com>
Subject: Re: [PATCH v4] subtree: fix split processing with multiple subtrees present
To: Zach FettersMoore via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Zach FettersMoore <zach.fetters@apollographql.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 9:18=E2=80=AFPM Zach FettersMoore via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Zach FettersMoore <zach.fetters@apollographql.com>
>
> When there are multiple subtrees present in a repository and they are
> all using 'git subtree split', the 'split' command can take a
> significant (and constantly growing) amount of time to run even when
> using the '--rejoin' flag. This is due to the fact that when processing
> commits to determine the last known split to start from when looking
> for changes, if there has been a split/merge done from another subtree
> there will be 2 split commits, one mainline and one subtree, for the
> second subtree that are part of the processing. The non-mainline
> subtree split commit will cause the processing to always need to search
> the entire history of the given subtree as part of its processing even
> though those commits are totally irrelevant to the current subtree
> split being run.

Thanks for your continued work on this!

I am not familiar with git subtree so I might miss obvious things. On
the other hand, my comments might help increase a bit the number of
people who could review this patch.

> In the diagram below, 'M' represents the mainline repo branch, 'A'
> represents one subtree, and 'B' represents another. M3 and B1 represent
> a split commit for subtree B that was created from commit M4. M2 and A1
> represent a split commit made from subtree A that was also created
> based on changes back to and including M4. M1 represents new changes to
> the repo, in this scenario if you try to run a 'git subtree split
> --rejoin' for subtree B, commits M1, M2, and A1, will be included in
> the processing of changes for the new split commit since the last
> split/rejoin for subtree B was at M3. The issue is that by having A1
> included in this processing the command ends up needing to processing
> every commit down tree A even though none of that is needed or relevant
> to the current command and result.
>
> M1
>  |        \       \
> M2         |       |
>  |        A1       |
> M3         |       |
>  |         |      B1
> M4         |       |

About the above, Junio already commented the following:

-> The above paragraph explains which different things you drew in the
-> diagram are representing, but it is not clear how they relate to
-> each other.  Do they for example depict parent-child commit
-> relationship?  What are the wide gaps between these three tracks and
-> what are the short angled lines leaning to the left near the tip?
-> Is the time/topology flowing from bottom to top?

and it doesn't look like you have addressed that comment.

When you say "M3 and B1 represent a split commit for subtree B that
was created from commit M4." I am not sure what it means exactly.
Could you give example commands that could have created the M3 and B1
commits?

> So this commit makes a change to the processing of commits for the split
> command in order to ignore non-mainline commits from other subtrees such
> as A1 in the diagram by adding a new function
> 'should_ignore_subtree_commit' which is called during
> 'process_split_commit'. This allows the split/rejoin processing to still
> function as expected but removes all of the unnecessary processing that
> takes place currently which greatly inflates the processing time.

Could you tell a bit more what kind of processing time reduction is or
would be possible on what kind of repo? Have you benchmark-ed or just
timed this somehow on one of your repos or better on an open source
repo (so that we could reproduce if we wanted)?

> Added a test to validate that the proposed fix
> solves the issue.
>
> The test accomplishes this by checking the output
> of the split command to ensure the output from
> the progress of 'process_split_commit' function
> that represents the 'extracount' of commits
> processed does not increment.

Does not increment compared to what?

> This was tested against the original functionality
> to show the test failed, and then with this fix
> to show the test passes.
>
> This illustrated that when using multiple subtrees,
> A and B, when doing a split on subtree B, the
> processing does not traverse the entire history
> of subtree A which is unnecessary and would cause
> the 'extracount' of processed commits to climb
> based on the number of commits in the history of
> subtree A.

Does this mean that the test checks that the extracount is the same
when subtree A exists as when it doesn't exist?

[...]

>  contrib/subtree/git-subtree.sh     | 29 ++++++++++++++++++++-
>  contrib/subtree/t/t7900-subtree.sh | 42 ++++++++++++++++++++++++++++++
>  2 files changed, 70 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree=
.sh
> index e0c5d3b0de6..e69991a9d80 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -778,6 +778,20 @@ ensure_valid_ref_format () {
>                 die "fatal: '$1' does not look like a ref"
>  }
>
> +# Usage: check if a commit from another subtree should be
> +# ignored from processing for splits
> +should_ignore_subtree_split_commit () {

Maybe adding:

    assert test $# =3D 1
    local rev=3D"$1"

here, and using $rev instead of $1 in this function could make things
a bit clearer and similar to what is done in other functions.

> +  if test -n "$(git log -1 --grep=3D"git-subtree-dir:" $1)"
> +  then
> +    if test -z "$(git log -1 --grep=3D"git-subtree-mainline:" $1)" &&
> +                       test -z "$(git log -1 --grep=3D"git-subtree-dir: =
$arg_prefix$" $1)"
> +    then
> +      return 0
> +    fi
> +  fi
> +  return 1
> +}

The above doesn't seem to be properly indented. We use tabs not spaces.

>  # Usage: process_split_commit REV PARENTS
>  process_split_commit () {
>         assert test $# =3D 2
> @@ -963,7 +977,20 @@ cmd_split () {
>         eval "$grl" |
>         while read rev parents
>         do
> -               process_split_commit "$rev" "$parents"
> +               if should_ignore_subtree_split_commit "$rev"
> +               then
> +                       continue
> +               fi
> +               parsedParents=3D''

It seems to me that we name variables "parsed_parents" (or sometimes
"parsedparents") rather than "parsedParents".

> +               for parent in $parents
> +               do
> +                       should_ignore_subtree_split_commit "$parent"
> +                       if test $? -eq 1

I think the 2 lines above could be replaced by:

+                       if ! should_ignore_subtree_split_commit "$parent"

> +                       then
> +                               parsedParents+=3D"$parent "

It doesn't seem to me that we use "+=3D" much in our shell scripts.
https://www.shellcheck.net/ emits the following:

(warning): In POSIX sh, +=3D is undefined.

so I guess we don't use it because it's not available in some usual shells.

(I haven't checked the script with https://www.shellcheck.net/ before
and after your patch, but it might help avoid bash-isms and such
issues.)

> +                       fi
> +               done
> +               process_split_commit "$rev" "$parsedParents"
>         done || exit $?

It looks like we use "exit $?" a lot in git-subtree.sh while we use
just "exit" most often elsewhere. Not sure why.

>         latest_new=3D$(cache_get latest_new) || exit $?
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900=
-subtree.sh
> index 49a21dd7c9c..87d59afd761 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -385,6 +385,48 @@ test_expect_success 'split sub dir/ with --rejoin' '
>         )
>  '
>
> +test_expect_success 'split with multiple subtrees' '
> +       subtree_test_create_repo "$test_count" &&
> +       subtree_test_create_repo "$test_count/subA" &&
> +       subtree_test_create_repo "$test_count/subB" &&
> +       test_create_commit "$test_count" main1 &&
> +       test_create_commit "$test_count/subA" subA1 &&
> +       test_create_commit "$test_count/subA" subA2 &&
> +       test_create_commit "$test_count/subA" subA3 &&
> +       test_create_commit "$test_count/subB" subB1 &&
> +       (
> +               cd "$test_count" &&
> +               git fetch ./subA HEAD &&
> +               git subtree add --prefix=3DsubADir FETCH_HEAD
> +       ) &&
> +       (
> +               cd "$test_count" &&
> +               git fetch ./subB HEAD &&
> +               git subtree add --prefix=3DsubBDir FETCH_HEAD
> +       ) &&
> +       test_create_commit "$test_count" subADir/main-subA1 &&
> +       test_create_commit "$test_count" subBDir/main-subB1 &&
> +       (
> +               cd "$test_count" &&
> +               git subtree split --prefix=3DsubADir --squash --rejoin -m=
 "Sub A Split 1"
> +       ) &&

Not sure why there are so many sub-shells used, and why the -C option
is not used instead to tell Git to work in a subdirectory. I guess you
copied what most existing (old) tests in this test script do.

For example perhaps the 4 line above could be replaced by just:

+               git -C "$test_count" subtree split --prefix=3DsubADir
--squash --rejoin -m "Sub A Split 1" &&

> +       (
> +               cd "$test_count" &&
> +               git subtree split --prefix=3DsubBDir --squash --rejoin -m=
 "Sub B Split 1"
> +       ) &&
> +       test_create_commit "$test_count" subADir/main-subA2 &&
> +       test_create_commit "$test_count" subBDir/main-subB2 &&
> +       (
> +               cd "$test_count" &&
> +               git subtree split --prefix=3DsubADir --squash --rejoin -m=
 "Sub A Split 2"
> +       ) &&
> +       (
> +               cd "$test_count" &&
> +               test "$(git subtree split --prefix=3DsubBDir --squash --r=
ejoin \
> +                -d -m "Sub B Split 1" 2>&1 | grep -w "\[1\]")" =3D ""
> +       )
> +'

It's not clear to me what the test is doing. Maybe you could split it
into 2 tests. Perhaps one setting up a repo with multiple subtrees and
one checking that a new split ignores other subtree split commits.
Perhaps adding a few comments would help too.

Best,
Christian.
