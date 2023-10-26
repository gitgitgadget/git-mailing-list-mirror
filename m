Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEA63B7BB
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apollographql.com header.i=@apollographql.com header.b="gsK6/teh"
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF1CB9
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 12:59:54 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-41cbf31da84so9187671cf.0
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 12:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=apollographql.com; s=google; t=1698350393; x=1698955193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CkBik1rFNv9J7IO0Of0LjQs0WNwwaJfmVjoiG+xpqE=;
        b=gsK6/teh8uFbAGvoYjElF+M2tFop+aHB31vm82kS9ACC0aFEIImnA2GKA/aa3vsmZ0
         WGBMEcYJcDApWSdbFkB2Wl6WWhpxDYW+RFJfQOHmaq5MbbfcaWgtBYCgrGlEKe1gKXEQ
         QOywyO8KwQMc+/MgctUwPLldZoRxC5MjTowEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698350393; x=1698955193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CkBik1rFNv9J7IO0Of0LjQs0WNwwaJfmVjoiG+xpqE=;
        b=YbCLtBww/flbBzsaPfyKhSc31ng9PauaQy6rnR8tpc80P5jeE5OLHcqFHLTwbA5tmk
         dqfat/wCN1oTDJQ2lQAbC3I+PDxFxezViwYjaY4xDyG63shZ22TKe35GhCmoTaXDYXnP
         6e3GBYYxMNRtOXZKAhENoGJKrVtNh5c/NkJ2OjKM59vpJ3Ri9ocMBIH3o6Ig3TJHUbFB
         FWNgIhoAPCyDiixm/4kfm86LJ/r2Bu5pxuEuO5OyJfvdh65gdKSdbTI71QLjZjOO/02A
         uQXZaRP3Y/aMlA6P85IrREp0A18ky/JoVJHbQ6e5cHi4ekxR1oVFcnH4HMRy0caz3CG6
         uoxQ==
X-Gm-Message-State: AOJu0Yz77adhJi6v57zCfcxwIzVt22GXUx7IqDIFYPg7+MMTvwsYN/6Y
	NY5jY1sORoC/pKj+BQrbvoz2x3jzNLqx1O8mPbYxr1WzRq9VHgNFjwM=
X-Google-Smtp-Source: AGHT+IE9+ezs5OCa/139xqmABI3gOiGQ3snNxNoq/c+VG8KlTMurGogfTZz8LmgpMoLyCTFxj2QkN5jYIfFfRjckYKc=
X-Received: by 2002:ac8:7e96:0:b0:41c:c6ca:de58 with SMTP id
 w22-20020ac87e96000000b0041cc6cade58mr636905qtj.36.1698350393363; Thu, 26 Oct
 2023 12:59:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1587.git.1695067516192.gitgitgadget@gmail.com> <xmqqpm2fht2x.fsf@gitster.g>
In-Reply-To: <xmqqpm2fht2x.fsf@gitster.g>
From: Zach FettersMoore <zach.fetters@apollographql.com>
Date: Thu, 26 Oct 2023 15:59:42 -0400
Message-ID: <CAEWN6q3HfeU1Uj4TPiiVW8PO13xwxgqihPH5-cm8T1oK5tHVTQ@mail.gmail.com>
Subject: Re: [PATCH] subtree: fix split processing with multiple subtrees present
To: Junio C Hamano <gitster@pobox.com>
Cc: Zach FettersMoore via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Please do not violate Documentation/CodingGuidelines for our shell
> scripted Porcelain, even if it is a script in contrib/ and also
>please avoid bash-isms.

I believe I have resolved the CodingGuidelines issues.

> Also doesn't "subtree" have its own test?  If this change is a fix
> for some problem(s), can we have a test or two that demonstrate how
> the current code without the patch is broken?

I was able to add a test that validates against some of the metrics that
are tracked when running a split  for processing commits. Validated that
before my fix the test fails, and after my fix the test passes.

>> In the diagram below, 'M' represents the mainline repo branch, 'A'
>> represents one subtree, and 'B' represents another. M3 and B1 represent
>> a split commit for subtree B that was created from commit M4. M2 and A1
>> represent a split commit made from subtree A that was also created
>> based on changes back to and including M4. M1 represents new changes to
>> the repo, in this scenario if you try to run a 'git subtree split
>> --rejoin' for subtree B, commits M1, M2, and A1, will be included in
>> the processing of changes for the new split commit since the last
>> split/rejoin for subtree B was at M3. The issue is that by having A1
>> included in this processing the command ends up needing to processing
>> every commit down tree A even though none of that is needed or relevant
>> to the current command and result.
>>
>> M1
>>  |      \       \
>> M2       |       |
>>  |      A1       |
>> M3       |       |
>>  |       |      B1
>> M4       |       |

> The above paragraph explains which different things you drew in the
> diagram are representing, but it is not clear how they relate to
> each other.  Do they for example depict parent-child commit
> relationship?  What are the wide gaps between these three tracks and
> what are the short angled lines leaning to the left near the tip?
> Is the time/topology flowing from bottom to top?

I am realizing I made a few mistakes with trying to illustrate the diagram
which I will attempt to make more clear below. As for the 3 columns in the
diagram, 'M' represents the mainline branch of the repo being developed in,
while column 'A' represents the history of a subtree 'A' included in the
repo, and column 'B' also represents the history of a subtree 'B' in the
repo. The diagram attempts to illustrate when a 'git subtree split --rejoin=
'
is used, that there is a commit made in the subtrees history, and that is
then merged into the mainline repo branch.

M1
 |
 |
M2 --- |
 |     A1
 |     |
M3 ---------- |
 |     |      B1
M4     |      |

Hopefully that helps better illustrate the state of the repo before the new
'git subtree split --rejoin' attempt and why it results in the described is=
sue.

>> +should_ignore_subtree_commit () {
>> +  if [ "$(git log -1 --grep=3D"git-subtree-dir:" $1)" ]
>> +  then
>> +    if [[ -z "$(git log -1 --grep=3D"git-subtree-mainline:" $1)" && -z =
"$(git log -1 --grep=3D"git-subtree-dir: $dir$" $1)" ]]
>
> Here $dir is a free variable that comes from outside.  The caller
> does not supply it as a parameter to this function (and the caller
> does not receive it as its parameter from its caller).  Yet the file
> as a whole seems to liberally make assignments to it ("git grep dir=3D"
> on the file counts 7 assignments).  Are we sure we are looking for
> the right $dir in this particular grep?
>
>  Side note: I am not familiar with this part of the code at
>  all, so do not take it as "here is a bug", but more as "this
>  smells error prone."

From my testing and what I see for '$dir' usage in the 'cmd_split'
function which leads to this code it is the correct '$dir', although
I see your point about it being reassigned in different places which
makes it error prone. I switched this to use the command
line argument '$arg_prefix' since the subtree prefix passed into
the command is what we actually want in this case so we can filter
out commits from other subtrees.

> Also can $dir have regular expressions special characters?  "The
> existing code and new code alike, git-subtree is not prepared to
> handle directory names with RE special characters well at all, so
> do not use them if you do not want your history broken" is an
> acceptable answer.

As far as I can tell from looking at the code (which I only recently
started using) the '$dir' which is based on the subtree prefix is
not setup to handle this.

> The caller of this function process_split_commit is cmd_split and
> process_split_commit (hence this function) is called repeatedly
> inside a loop.  This function makes a traversal over the entire
> history for each and every iteration in "good" cases where there is
> no 'mainline' or 'subtree-dir' commits for the given $dir.
>
> I wonder if it is more efficient to enumerate all commits that hits
> these grep criteria in the cmd_split before it starts to call
> process_split_commit repeatedly.  If it knows which commit can be
> ignored beforehand, it can skip and not call process_split_commit,
> no?

Moved this functionality into the 'cmd_split' function as suggested.

>> +    then
>> +      return 0
>> +    fi
>> +  fi
>> +  return 1
>> +}
>> +
>>  # Usage: process_split_commit REV PARENTS
>>  process_split_commit () {
>>   assert test $# =3D 2
>>   local rev=3D"$1"
>>   local parents=3D"$2"
>
> These seem to assume that $1 and $2 can have $IFS in them, so
> shouldn't ...
>
>> +    if should_ignore_subtree_commit $rev
>
> ... this call too enclose $rev inside a pair of double-quotes for
> consistency?  We know the loop in the cmd_split that calls this
> function is reading from "rev-list --parents" and $rev is a 40-hex
> commit object name (and $parents can have more than one 40-hex
> commit object names separated with SP), so it is safe to leave $rev
> unquoted, but it pays to be consistent to help make the code more
> readable.

Updated this for consistency


On Mon, Sep 18, 2023 at 9:04=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Zach FettersMoore via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > In the diagram below, 'M' represents the mainline repo branch, 'A'
> > represents one subtree, and 'B' represents another. M3 and B1 represent
> > a split commit for subtree B that was created from commit M4. M2 and A1
> > represent a split commit made from subtree A that was also created
> > based on changes back to and including M4. M1 represents new changes to
> > the repo, in this scenario if you try to run a 'git subtree split
> > --rejoin' for subtree B, commits M1, M2, and A1, will be included in
> > the processing of changes for the new split commit since the last
> > split/rejoin for subtree B was at M3. The issue is that by having A1
> > included in this processing the command ends up needing to processing
> > every commit down tree A even though none of that is needed or relevant
> > to the current command and result.
> >
> > M1
> >  |      \       \
> > M2       |       |
> >  |      A1       |
> > M3       |       |
> >  |       |      B1
> > M4       |       |
>
> The above paragraph explains which different things you drew in the
> diagram are representing, but it is not clear how they relate to
> each other.  Do they for example depict parent-child commit
> relationship?  What are the wide gaps between these three tracks and
> what are the short angled lines leaning to the left near the tip?
> Is the time/topology flowing from bottom to top?
>
> > diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtr=
ee.sh
> > index e0c5d3b0de6..e9250dfb019 100755
> > --- a/contrib/subtree/git-subtree.sh
> > +++ b/contrib/subtree/git-subtree.sh
> > @@ -778,12 +778,29 @@ ensure_valid_ref_format () {
> >               die "fatal: '$1' does not look like a ref"
> >  }
> >
> > +# Usage: check if a commit from another subtree should be ignored from=
 processing for splits
>
> Way overlong line.  Please split them accordingly.  I won't comment
> on what CodingGuidelines tells us already, in this review, but have
> a few comments here:
>
> > +should_ignore_subtree_commit () {
> > +  if [ "$(git log -1 --grep=3D"git-subtree-dir:" $1)" ]
> > +  then
> > +    if [[ -z "$(git log -1 --grep=3D"git-subtree-mainline:" $1)" && -z=
 "$(git log -1 --grep=3D"git-subtree-dir: $dir$" $1)" ]]
>
> Here $dir is a free variable that comes from outside.  The caller
> does not supply it as a parameter to this function (and the caller
> does not receive it as its parameter from its caller).  Yet the file
> as a whole seems to liberally make assignments to it ("git grep dir=3D"
> on the file counts 7 assignments).  Are we sure we are looking for
> the right $dir in this particular grep?
>
>         Side note: I am not familiar with this part of the code at
>         all, so do not take it as "here is a bug", but more as "this
>         smells error prone."
>
> Also can $dir have regular expressions special characters?  "The
> existing code and new code alike, git-subtree is not prepared to
> handle directory names with RE special characters well at all, so
> do not use them if you do not want your history broken" is an
> acceptable answer.
>
> The caller of this function process_split_commit is cmd_split and
> process_split_commit (hence this function) is called repeatedly
> inside a loop.  This function makes a traversal over the entire
> history for each and every iteration in "good" cases where there is
> no 'mainline' or 'subtree-dir' commits for the given $dir.
>
> I wonder if it is more efficient to enumerate all commits that hits
> these grep criteria in the cmd_split before it starts to call
> process_split_commit repeatedly.  If it knows which commit can be
> ignored beforehand, it can skip and not call process_split_commit,
> no?
>
> > +    then
> > +      return 0
> > +    fi
> > +  fi
> > +  return 1
> > +}
> > +
> >  # Usage: process_split_commit REV PARENTS
> >  process_split_commit () {
> >       assert test $# =3D 2
> >       local rev=3D"$1"
> >       local parents=3D"$2"
>
> These seem to assume that $1 and $2 can have $IFS in them, so
> shouldn't ...
>
> > +    if should_ignore_subtree_commit $rev
>
> ... this call too enclose $rev inside a pair of double-quotes for
> consistency?  We know the loop in the cmd_split that calls this
> function is reading from "rev-list --parents" and $rev is a 40-hex
> commit object name (and $parents can have more than one 40-hex
> commit object names separated with SP), so it is safe to leave $rev
> unquoted, but it pays to be consistent to help make the code more
> readable.
>
> > +    then
> > +         return
> > +    fi
> > +
> >       if test $indent -eq 0
> >       then
> >               revcount=3D$(($revcount + 1))
> >
> > base-commit: bda494f4043963b9ec9a1ecd4b19b7d1cd9a0518
