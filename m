From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/7] revert: allow cherry-pick --continue to commit before resuming
Date: Wed, 14 Dec 2011 19:56:20 +0530
Message-ID: <CALkWK0miBzT4BXRDYOhz8JqF2jeyz1L3=pwaGKVm654oHtQbtQ@mail.gmail.com>
References: <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net> <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112001.GF7399@elie.hsd1.il.comcast.net> <7vr50zd5x0.fsf@alter.siamese.dyndns.org>
 <20111123012721.GA14217@elie.hsd1.il.comcast.net> <4ECCB3A2.5030102@viscovery.net>
 <20111123100452.GA30629@elie.hsd1.il.comcast.net> <4ECCC935.7010407@viscovery.net>
 <20111210124644.GA22035@elie.hsd1.il.comcast.net> <20111210124925.GC22035@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 15:26:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RapnM-0002mT-EW
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 15:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122Ab1LNO0q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Dec 2011 09:26:46 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42658 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840Ab1LNO0m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2011 09:26:42 -0500
Received: by wgbdr13 with SMTP id dr13so1908814wgb.1
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 06:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=h138F0NR/Jh0sPQPhkBFBiddXSeiyQwZm15XR/xMyp8=;
        b=WJRZWrUHnBHxdzJAuW3pFfr/aafvsCgJbNqvv39x+rLwRL88P0i0KTP982UTkMnmeP
         M6Y2LrculoY6cENJzeYLdD+rbUTpF0v9P2Z8nq4VOP9OLHgjWXBCVZcSfUNfByvC4yyj
         kcC8wgvjXshQxQwjSPDCT8Br4Hj74hpFWw3FM=
Received: by 10.227.203.10 with SMTP id fg10mr2467044wbb.1.1323872801241; Wed,
 14 Dec 2011 06:26:41 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Wed, 14 Dec 2011 06:26:20 -0800 (PST)
In-Reply-To: <20111210124925.GC22035@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187120>

Hi again,

Jonathan Nieder wrote:
> When "git cherry-pick ..bar" encounters conflicts, permit the operato=
r
> to use cherry-pick --continue after resolving them as a shortcut for
> "git commit && git cherry-pick --continue" to record the resolution
> and carry on with the rest of the sequence.

Sounds good.  I remember my implementation being quite complicated;
let's see how you've done this.

> Example: after encountering a conflict from running "git cherry-pick
> foo bar baz":
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0CONFLICT (content): Merge conflict in main=
=2Ec
> =C2=A0 =C2=A0 =C2=A0 =C2=A0error: could not apply f78a8d98c... bar!
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hint: after resolving the conflicts, mark =
the corrected paths
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hint: with 'git add <paths>' or 'git rm <p=
aths>'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hint: and commit the result with 'git comm=
it'
>
> We edit main.c to resolve the conflict, mark it acceptable with "git
> add main.c", and can run "cherry-pick --continue" to resume the
> sequence.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git cherry-pick --continue
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[editor opens to confirm commit message]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[master 78c8a8c98] bar!
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 files changed, 1 insertions(+), 1 delet=
ions(-)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[master 87ca8798c] baz!
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 files changed, 1 insertions(+), 1 delet=
ions(-)

I like the presentation of this example: much clearer than my examples.

> =C2=A0builtin/revert.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 23 ++++++-
> =C2=A0t/t3510-cherry-pick-sequence.sh | =C2=A0139 +++++++++++++++++++=
+++++++++++++++++++-
> =C2=A02 files changed, 156 insertions(+), 6 deletions(-)

Oh, good -- lots of new tests :)

> diff --git a/builtin/revert.c b/builtin/revert.c
> index 9f6c85c1..a43b4d85 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -1038,18 +1038,35 @@ static int pick_commits(struct commit_list *t=
odo_list, struct replay_opts *opts)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> +static int continue_single_pick(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 const char *argv[] =3D { "commit", NULL };
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!file_exists(git_path("CHERRY_PICK_HEAD"))=
 &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !file_exists(git_path("REVERT_HE=
AD")))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error(_("no=
 cherry-pick or revert in progress"));
> + =C2=A0 =C2=A0 =C2=A0 return run_command_v_opt(argv, RUN_GIT_CMD);
> +}

Very nice!  I can see how the introduction of REVERT_HEAD simplifies th=
ings :)
I'm totally embarrassed by the horribly convoluted logic in the "New
sequencer workflow!" I posted earlier.

Note to self: don't capitalize error() messages.

> =C2=A0static int sequencer_continue(struct replay_opts *opts)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct commit_list *todo_list =3D NULL;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!file_exists(git_path(SEQ_TODO_FILE)))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error(_("No=
 %s in progress"), action_name(opts));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return continue_si=
ngle_pick();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0read_populate_opts(&opts);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0read_populate_todo(&todo_list, opts);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Verify that the conflict has been resol=
ved */
> - =C2=A0 =C2=A0 =C2=A0 if (!index_differs_from("HEAD", 0))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 todo_list =3D todo=
_list->next;
> + =C2=A0 =C2=A0 =C2=A0 if (file_exists(git_path("CHERRY_PICK_HEAD")) =
||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file_exists(git_path("REVERT_HEA=
D"))) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret =3D contin=
ue_single_pick();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return ret;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 if (index_differs_from("HEAD", 0))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error_dirty=
_index(opts);
> + =C2=A0 =C2=A0 =C2=A0 todo_list =3D todo_list->next;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return pick_commits(todo_list, opts);
> =C2=A0}

Very nicely done.  I can see why 1/7 makes so much sense now:  it
helps think of different operations independently.

> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-se=
quence.sh
> index 2c4c1c85..4d1883b7 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -2,6 +2,7 @@
>
> =C2=A0test_description=3D'Test cherry-pick continuation features
>
> + + =C2=A0conflicting: rewrites unrelated to conflicting
> =C2=A0 + yetanotherpick: rewrites foo to e
> =C2=A0 + anotherpick: rewrites foo to d
> =C2=A0 + picked: rewrites foo to c

Note to self: this list of commits is becoming quite unwieldy.  We
should probably refactor these sometime.

> @@ -27,6 +28,7 @@ test_cmp_rev () {
> =C2=A0}
>
> =C2=A0test_expect_success setup '
> + =C2=A0 =C2=A0 =C2=A0 git config advice.detachedhead false
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo unrelated >unrelated &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git add unrelated &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_commit initial foo a &&

Huh, why are you moving this line up?  Oh, right: there are
"test_commit" statements in the setup- good catch.  This is unrelated
to your patch and should be a separate commit though.

> @@ -35,8 +37,8 @@ test_expect_success setup '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_commit picked foo c &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_commit anotherpick foo d &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_commit yetanotherpick foo e &&
> - =C2=A0 =C2=A0 =C2=A0 git config advice.detachedhead false
> -
> + =C2=A0 =C2=A0 =C2=A0 pristine_detach initial &&
> + =C2=A0 =C2=A0 =C2=A0 test_commit conflicting unrelated
> =C2=A0'

Looks fishy- I wonder why you're doing this.  Let's read ahead and find=
 out.

> @@ -243,7 +245,66 @@ test_expect_success '--continue complains when t=
here are unresolved conflicts' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git cherry-pick --continue
> =C2=A0'
>
> -test_expect_success '--continue continues after conflicts are resolv=
ed' '
> +test_expect_success '--continue of single cherry-pick' '
> + =C2=A0 =C2=A0 =C2=A0 pristine_detach initial &&
> + =C2=A0 =C2=A0 =C2=A0 echo c >expect &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git cherry-pick picked &&
> + =C2=A0 =C2=A0 =C2=A0 echo c >foo &&
> + =C2=A0 =C2=A0 =C2=A0 git add foo &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --continue &&
> +
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect foo &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp_rev initial HEAD^ &&
> + =C2=A0 =C2=A0 =C2=A0 git diff --exit-code HEAD &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git rev-parse --verify CHERRY_P=
ICK_HEAD
> +'

Beautiful.  The tests I wrote are ugly in comparison :\

> +test_expect_success '--continue of single revert' '
> + =C2=A0 =C2=A0 =C2=A0 pristine_detach initial &&
> + =C2=A0 =C2=A0 =C2=A0 echo resolved >expect &&
> + =C2=A0 =C2=A0 =C2=A0 echo "Revert \"picked\"" >expect.msg &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git revert picked &&
> + =C2=A0 =C2=A0 =C2=A0 echo resolved >foo &&
> + =C2=A0 =C2=A0 =C2=A0 git add foo &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --continue &&

Huh?  You're continuing a "git revert" with a a "git cherry-pick
--continue"?  The current 'master' still uses a commit_list, and
doesn't allow mixed "pick" and "revert" instructions yet.

> + =C2=A0 =C2=A0 =C2=A0 git diff --exit-code HEAD &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect foo &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp_rev initial HEAD^ &&
> + =C2=A0 =C2=A0 =C2=A0 git diff-tree -s --pretty=3Dtformat:%s HEAD >m=
sg &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect.msg msg &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git rev-parse --verify CHERRY_P=
ICK_HEAD &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git rev-parse --verify REVERT_H=
EAD
> +'

A couple of notes:

1. I haven't used the "-s" flag of "git diff-tree" before, so I opened
up the documentation to find this:

        By default, 'git diff-tree --stdin' shows differences,
        either in machine-readable form (without '-p') or in patch
        form (with '-p').  This output can be suppressed.  It is
        only useful with '-v' flag.

Very misleading.  TODO: Fix this.

2. Why did you use "diff-tree" to get the commit message?  Isn't
"cat-file commit" much more straightforward?

> +test_expect_success '--continue after resolving conflicts' '
> + =C2=A0 =C2=A0 =C2=A0 pristine_detach initial &&
> + =C2=A0 =C2=A0 =C2=A0 echo d >expect &&
> + =C2=A0 =C2=A0 =C2=A0 cat >expect.log <<-\EOF &&
> + =C2=A0 =C2=A0 =C2=A0 OBJID
> + =C2=A0 =C2=A0 =C2=A0 :100644 100644 OBJID OBJID M =C2=A0 =C2=A0foo
> + =C2=A0 =C2=A0 =C2=A0 OBJID
> + =C2=A0 =C2=A0 =C2=A0 :100644 100644 OBJID OBJID M =C2=A0 =C2=A0foo
> + =C2=A0 =C2=A0 =C2=A0 OBJID
> + =C2=A0 =C2=A0 =C2=A0 :100644 100644 OBJID OBJID M =C2=A0 =C2=A0unre=
lated
> + =C2=A0 =C2=A0 =C2=A0 OBJID
> + =C2=A0 =C2=A0 =C2=A0 :000000 100644 OBJID OBJID A =C2=A0 =C2=A0foo
> + =C2=A0 =C2=A0 =C2=A0 :000000 100644 OBJID OBJID A =C2=A0 =C2=A0unre=
lated
> + =C2=A0 =C2=A0 =C2=A0 EOF
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git cherry-pick base..anotherpi=
ck &&
> + =C2=A0 =C2=A0 =C2=A0 echo c >foo &&
> + =C2=A0 =C2=A0 =C2=A0 git add foo &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --continue &&
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git rev-list HEAD =
|
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git diff-tree --ro=
ot --stdin |
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sed "s/$_x40/OBJID=
/g"
> + =C2=A0 =C2=A0 =C2=A0 } >actual.log &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect foo &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect.log actual.log
> +'

Unchanged from the original: I suspect you've moved the generation of
expectation messages up to produce a clean diff.

> +test_expect_success '--continue after resolving conflicts and commit=
ting' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pristine_detach initial &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git cherry-pick base..anoth=
erpick &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "c" >foo &&

Okay, the diff isn't all that clean :P

> +test_expect_success '--continue asks for help after resolving patch =
to nil' '
> + =C2=A0 =C2=A0 =C2=A0 pristine_detach conflicting &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git cherry-pick initial..picked=
 &&
> +
> + =C2=A0 =C2=A0 =C2=A0 test_cmp_rev unrelatedpick CHERRY_PICK_HEAD &&
> + =C2=A0 =C2=A0 =C2=A0 git checkout HEAD -- unrelated &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git cherry-pick --continue 2>ms=
g &&
> + =C2=A0 =C2=A0 =C2=A0 test_i18ngrep "The previous cherry-pick is now=
 empty" msg
> +'

I thought it was a bad idea to grep for specific output messages,
because of their volatile nature?  Remind me what this test has to do
with the rest of your patch?

> +test_expect_failure 'follow advice and skip nil patch' '
> + =C2=A0 =C2=A0 =C2=A0 pristine_detach conflicting &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git cherry-pick initial..picked=
 &&
> +
> + =C2=A0 =C2=A0 =C2=A0 git checkout HEAD -- unrelated &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git cherry-pick --continue &&
> + =C2=A0 =C2=A0 =C2=A0 git reset &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --continue &&
> +
> + =C2=A0 =C2=A0 =C2=A0 git rev-list initial..HEAD >commits &&
> + =C2=A0 =C2=A0 =C2=A0 test_line_count =3D 3 commits
> +'

Again, what does this test have to do with the rest of your patch?

> =C2=A0test_expect_success '--continue respects opts' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pristine_detach initial &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git cherry-pick -x base..an=
otherpick &&
> @@ -288,6 +372,29 @@ test_expect_success '--continue respects opts' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0grep "cherry picked from" anotherpick_msg
> =C2=A0'
>
> +test_expect_success '--continue of single-pick respects -x' '
> + =C2=A0 =C2=A0 =C2=A0 pristine_detach initial &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git cherry-pick -x picked &&
> + =C2=A0 =C2=A0 =C2=A0 echo c >foo &&
> + =C2=A0 =C2=A0 =C2=A0 git add foo &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --continue &&
> + =C2=A0 =C2=A0 =C2=A0 test_path_is_missing .git/sequencer &&
> + =C2=A0 =C2=A0 =C2=A0 git cat-file commit HEAD >msg &&
> + =C2=A0 =C2=A0 =C2=A0 grep "cherry picked from" msg
> +'

I'd have liked s/respects -x/respects opts/ here for symmetry with the
previous test.

> +test_expect_success '--continue respects -x in first commit in multi=
-pick' '
> + =C2=A0 =C2=A0 =C2=A0 pristine_detach initial &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git cherry-pick -x picked anoth=
erpick &&
> + =C2=A0 =C2=A0 =C2=A0 echo c >foo &&
> + =C2=A0 =C2=A0 =C2=A0 git add foo &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --continue &&
> + =C2=A0 =C2=A0 =C2=A0 test_path_is_missing .git/sequencer &&
> + =C2=A0 =C2=A0 =C2=A0 git cat-file commit HEAD^ >msg &&
> + =C2=A0 =C2=A0 =C2=A0 picked=3D$(git rev-parse --verify picked) &&
> + =C2=A0 =C2=A0 =C2=A0 grep "cherry picked from.*$picked" msg
> +'

Can you explain why "first commit in a multi-pick" is a special case?

> @@ -306,6 +413,32 @@ test_expect_success '--signoff is not automatica=
lly propagated to resolved confl
> =C2=A0 =C2=A0 =C2=A0 =C2=A0grep "Signed-off-by:" anotherpick_msg
> =C2=A0'
>
> +test_expect_success '--signoff dropped for implicit commit of resolu=
tion, multi-pick case' '
> + =C2=A0 =C2=A0 =C2=A0 pristine_detach initial &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git cherry-pick -s picked anoth=
erpick &&
> + =C2=A0 =C2=A0 =C2=A0 echo c >foo &&
> + =C2=A0 =C2=A0 =C2=A0 git add foo &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --continue &&
> +
> + =C2=A0 =C2=A0 =C2=A0 git diff --exit-code HEAD &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp_rev initial HEAD^^ &&
> + =C2=A0 =C2=A0 =C2=A0 git cat-file commit HEAD^ >msg &&
> + =C2=A0 =C2=A0 =C2=A0 ! grep Signed-off-by: msg
> +'

Unrelated.

> +test_expect_success 'sign-off needs to be reaffirmed after conflict =
resolution, single-pick case' '
> + =C2=A0 =C2=A0 =C2=A0 pristine_detach initial &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git cherry-pick -s picked &&
> + =C2=A0 =C2=A0 =C2=A0 echo c >foo &&
> + =C2=A0 =C2=A0 =C2=A0 git add foo &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --continue &&
> +
> + =C2=A0 =C2=A0 =C2=A0 git diff --exit-code HEAD &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp_rev initial HEAD^ &&
> + =C2=A0 =C2=A0 =C2=A0 git cat-file commit HEAD >msg &&
> + =C2=A0 =C2=A0 =C2=A0 ! grep Signed-off-by: msg
> +'

If the previous test were a separate patch preceding this one, this'd
belong here.

Thanks for working on this.

-- Ram
