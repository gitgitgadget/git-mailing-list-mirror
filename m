From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 12/14] revert: Introduce --reset to cleanup sequencer data
Date: Wed, 6 Jul 2011 20:02:29 +0530
Message-ID: <CALkWK0nhH=_3+Gj=O4Ov2zOGBoVquzD--+RW_QYYnb8YMAHniA@mail.gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com> <1309938868-2028-13-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 16:33:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeT9r-00076Y-Um
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 16:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177Ab1GFOcv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jul 2011 10:32:51 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43136 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913Ab1GFOcu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2011 10:32:50 -0400
Received: by wwe5 with SMTP id 5so7015841wwe.1
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 07:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=L4/qo9s4bizUF9eu47NOEP8VapkXQMqcBvQKqFkN+J0=;
        b=eIDWfAjp5x02KakY9BLAQ6c6qsd1Ko2Q6GqWvtYkXZd1imod+rEPgFIOohywuIQSnG
         sSwUhVqEVfpV5g79+IQ0Y8j+wbx3GLRyj06QERX22Y+cV6WZbGoa/c0NOb6ulnjjFt0V
         my8HWl85ndf+QIfAnZNtD1Hq/yEJu9R7aYd6M=
Received: by 10.216.187.65 with SMTP id x43mr6046141wem.62.1309962769191; Wed,
 06 Jul 2011 07:32:49 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 6 Jul 2011 07:32:29 -0700 (PDT)
In-Reply-To: <1309938868-2028-13-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176706>

Hi,

Ramkumar Ramachandra writes:
> =C2=A0builtin/revert.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 54 ++++++++++++++++++++++++++++++-----
> =C2=A0git-rebase--interactive.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 25 +++++++++++++---
> =C2=A0t/t3032-merge-recursive-options.sh | =C2=A0 =C2=A02 +
> =C2=A0t/t3501-revert-cherry-pick.sh =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0=
1 +
> =C2=A0t/t3502-cherry-pick-merge.sh =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
9 ++++-
> =C2=A0t/t3504-cherry-pick-rerere.sh =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0=
2 +
> =C2=A0t/t3505-cherry-pick-empty.sh =C2=A0 =C2=A0 =C2=A0 | =C2=A0 14 +=
+++-----
> =C2=A0t/t3506-cherry-pick-ff.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 =C2=A03 ++
> =C2=A0t/t3507-cherry-pick-conflict.sh =C2=A0 =C2=A0| =C2=A0 24 ++++++=
++++++---
> =C2=A0t/t3510-cherry-pick-sequence.sh =C2=A0 =C2=A0| =C2=A0 14 ++++++=
+++
> =C2=A0t/t7502-commit.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
> =C2=A011 files changed, 121 insertions(+), 28 deletions(-)

By making `reset --hard` blow away the sequencer state, and trying
hard not to modify existing scripts, the diffstat still contains these
files:
builtin/revert.c
git-rebase--interactive.sh
t/t3032-merge-recursive-options.sh
r/t3505-cherry-pick-empty.sh
r/t3507-cherry-pick-conflict.sh
r/t3501-cherry-pick-sequence.sh

> diff --git a/t/t3032-merge-recursive-options.sh b/t/t3032-merge-recur=
sive-options.sh
> index 2b17311..81191ae 100755
> --- a/t/t3032-merge-recursive-options.sh
> +++ b/t/t3032-merge-recursive-options.sh
> @@ -113,8 +113,10 @@ test_expect_success '--ignore-space-change makes=
 merge succeed' '
> =C2=A0test_expect_success 'naive cherry-pick fails' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git read-tree --reset -u HEAD &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git cherry-pick --no-commit=
 remote &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --reset &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git read-tree --reset -u HEAD &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git cherry-pick remote &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --reset &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git update-index --refresh =
&&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0grep "<<<<<<" text.txt
> =C2=A0'
> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pi=
ck.sh
> index 595d2ff..e0c805d 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -96,6 +96,7 @@ test_expect_success 'revert forbidden on dirty work=
ing tree' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo content >extra_file &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git add extra_file &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git revert HEAD 2>errors &&
> + =C2=A0 =C2=A0 =C2=A0 git revert --reset &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_i18ngrep "Your local changes would be=
 overwritten by " errors
>
> =C2=A0'

> diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty=
=2Esh
> index c10b28c..dc02227 100755
> --- a/t/t3505-cherry-pick-empty.sh
> +++ b/t/t3505-cherry-pick-empty.sh
> @@ -23,10 +23,9 @@ test_expect_success setup '
> =C2=A0'
>
> =C2=A0test_expect_success 'cherry-pick an empty commit' '
> - =C2=A0 =C2=A0 =C2=A0 git checkout master && {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git cherry-pick em=
pty-branch^
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test "$?" =3D 1
> - =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 git checkout master &&
> + =C2=A0 =C2=A0 =C2=A0 test_expect_code 1 git cherry-pick empty-branc=
h^
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --reset
> =C2=A0'
>
> =C2=A0test_expect_success 'index lockfile was removed' '
> @@ -36,10 +35,9 @@ test_expect_success 'index lockfile was removed' '
> =C2=A0'
>
> =C2=A0test_expect_success 'cherry-pick a commit with an empty message=
' '
> - =C2=A0 =C2=A0 =C2=A0 git checkout master && {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git cherry-pick em=
pty-branch
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test "$?" =3D 1
> - =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 git checkout master &&
> + =C2=A0 =C2=A0 =C2=A0 test_expect_code 1 git cherry-pick empty-branc=
h &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --reset
> =C2=A0'
>
> =C2=A0test_expect_success 'index lockfile was removed' '

> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-co=
nflict.sh
> index 212ec54..86f8626 100755
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -39,6 +39,7 @@ test_expect_success 'failed cherry-pick does not ad=
vance HEAD' '
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0head=3D$(git rev-parse HEAD) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git cherry-pick picked &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --reset &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0newhead=3D$(git rev-parse HEAD) &&
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test "$head" =3D "$newhead"
> @@ -55,6 +56,7 @@ test_expect_success 'advice from failed cherry-pick=
' "
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hint: and commit the result with 'git comm=
it'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0EOF
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git cherry-pick picked 2>ac=
tual &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --reset &&
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_i18ncmp expected actual
> =C2=A0"
> @@ -62,7 +64,8 @@ test_expect_success 'advice from failed cherry-pick=
' "
> =C2=A0test_expect_success 'failed cherry-pick sets CHERRY_PICK_HEAD' =
'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pristine_detach initial &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git cherry-pick picked &&
> - =C2=A0 =C2=A0 =C2=A0 test_cmp_rev picked CHERRY_PICK_HEAD
> + =C2=A0 =C2=A0 =C2=A0 test_cmp_rev picked CHERRY_PICK_HEAD &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --reset
> =C2=A0'
>
> =C2=A0test_expect_success 'successful cherry-pick does not set CHERRY=
_PICK_HEAD' '
> @@ -84,13 +87,15 @@ test_expect_success 'GIT_CHERRY_PICK_HELP suppres=
ses CHERRY_PICK_HEAD' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0export GIT_CHE=
RRY_PICK_HELP &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail=
 git cherry-pick picked
> =C2=A0 =C2=A0 =C2=A0 =C2=A0) &&
> - =C2=A0 =C2=A0 =C2=A0 test_must_fail git rev-parse --verify CHERRY_P=
ICK_HEAD
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git rev-parse --verify CHERRY_P=
ICK_HEAD &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --reset
> =C2=A0'
>
> =C2=A0test_expect_success 'git reset clears CHERRY_PICK_HEAD' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pristine_detach initial &&
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git cherry-pick picked &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --reset &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git reset &&
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git rev-parse --verify CHER=
RY_PICK_HEAD
> @@ -102,7 +107,8 @@ test_expect_success 'failed commit does not clear=
 CHERRY_PICK_HEAD' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git cherry-pick picked &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git commit &&
>
> - =C2=A0 =C2=A0 =C2=A0 test_cmp_rev picked CHERRY_PICK_HEAD
> + =C2=A0 =C2=A0 =C2=A0 test_cmp_rev picked CHERRY_PICK_HEAD &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --reset
> =C2=A0'
>
> =C2=A0test_expect_success 'cancelled commit does not clear CHERRY_PIC=
K_HEAD' '
> @@ -119,7 +125,8 @@ test_expect_success 'cancelled commit does not cl=
ear CHERRY_PICK_HEAD' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail=
 git commit
> =C2=A0 =C2=A0 =C2=A0 =C2=A0) &&
>
> - =C2=A0 =C2=A0 =C2=A0 test_cmp_rev picked CHERRY_PICK_HEAD
> + =C2=A0 =C2=A0 =C2=A0 test_cmp_rev picked CHERRY_PICK_HEAD &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --reset
> =C2=A0'
>
> =C2=A0test_expect_success 'successful commit clears CHERRY_PICK_HEAD'=
 '
> @@ -130,13 +137,15 @@ test_expect_success 'successful commit clears C=
HERRY_PICK_HEAD' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git add foo &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit &&
>
> - =C2=A0 =C2=A0 =C2=A0 test_must_fail git rev-parse --verify CHERRY_P=
ICK_HEAD
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git rev-parse --verify CHERRY_P=
ICK_HEAD &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --reset
> =C2=A0'
>
> =C2=A0test_expect_success 'failed cherry-pick produces dirty index' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pristine_detach initial &&
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git cherry-pick picked &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --reset &&
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git update-index --refresh =
-q &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git diff-index --exit-code =
HEAD
> @@ -160,6 +169,7 @@ test_expect_success 'failed cherry-pick registers=
 participants in index' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git read-tree -u --reset HEAD &&
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git cherry-pick picked &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --reset &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git ls-files --stage --unmerged > actual &=
&
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cmp expected actual
> @@ -176,6 +186,7 @@ test_expect_success 'failed cherry-pick describes=
 conflict in work tree' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0EOF
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git cherry-pick picked &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --reset &&
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sed "s/[a-f0-9]*\.\.\./objid/" foo > actua=
l &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cmp expected actual
> @@ -195,6 +206,7 @@ test_expect_success 'diff3 -m style' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0EOF
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git cherry-pick picked &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --reset &&
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sed "s/[a-f0-9]*\.\.\./objid/" foo > actua=
l &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cmp expected actual
> @@ -227,6 +239,7 @@ test_expect_success 'revert also handles conflict=
s sanely' '
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0head=3D$(git rev-parse HEAD) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git revert picked &&
> + =C2=A0 =C2=A0 =C2=A0 git revert --reset &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0newhead=3D$(git rev-parse HEAD) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git ls-files --stage --unmerged > actual-s=
tages &&
>
> @@ -252,6 +265,7 @@ test_expect_success 'revert conflict, diff3 -m st=
yle' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0EOF
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git revert picked &&
> + =C2=A0 =C2=A0 =C2=A0 git revert --reset &&
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sed "s/[a-f0-9]*\.\.\./objid/" foo > actua=
l &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cmp expected actual

As you can see, there is no "reset --hard" in these, and I don't see
what other command I can piggy-bank on to blow away the sequencer
state.  There is however, one other thing I can do: if there is
nothing left to cherry-pick after a successful conflict resolution +
git commit, I can modify commit.c to blow away the sequencer state
after checking appropriately.  This will also have a nice end-user
experience side-effect:
$ git cherry-pick moo
fatal: Conflict in foo!
$ echo "Resolved" > foo
$ git add moo
$ git commit
$ git cherry-pick --continue # This no-op will be unnecessary

Then again, teaching commit about the sequencer is inelegant, and it's
possible to achieve this effect in another way: when a conflict is
encountered in the sequencer && length(todo_file) =3D=3D 1, throw away =
the
sequencer state.  When I say "throw away", I really mean "move
=2Egit/sequencer to .git/sequencer-old".  Does this seem reasonable?

-- Ram
