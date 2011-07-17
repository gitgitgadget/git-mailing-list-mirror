From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 17/17] revert: Introduce --continue to continue the operation
Date: Sun, 17 Jul 2011 21:41:34 +0530
Message-ID: <CALkWK0==A1a-kzqXuEkjS+FMR1CAzJox8MBdkQGMLukoU15L9w@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-18-git-send-email-artagnon@gmail.com> <20110712204650.GG14909@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 17 18:12:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiTwn-00007q-6w
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 18:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755988Ab1GQQL4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Jul 2011 12:11:56 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65323 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755598Ab1GQQLz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jul 2011 12:11:55 -0400
Received: by wyg8 with SMTP id 8so1649611wyg.19
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 09:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=182sZyoM/9Eiww75S6vraMnY7/ZEza1+YRwQPCiW5M8=;
        b=cVQSpPuNkYPiA0Bw5ZwJdzsch8GWXekWyvi/hUK8/fAUmqzsyBVXPk7Yoc5BzdfcJK
         UukCSqS5+mVG4VktILMrBuvAjs0qu++BcVYUPSeDkMbNU4sToaZ1nd4nMZEJCM3Tmsm/
         959Rhl8luscaN7muVCaeVP1Z0hzNTCnwME/7o=
Received: by 10.216.143.66 with SMTP id k44mr2276968wej.81.1310919114132; Sun,
 17 Jul 2011 09:11:54 -0700 (PDT)
Received: by 10.216.234.143 with HTTP; Sun, 17 Jul 2011 09:11:34 -0700 (PDT)
In-Reply-To: <20110712204650.GG14909@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177302>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Using the information in ".git/sequencer", it is now possible to
>> continue a cherry-pick or continue after a conflict. =C2=A0To do thi=
s, we
>> have to parse the information in ".git/sequencer/opts" into the
>> replay_opts structure and
> [...]
>
> Might be simpler to say:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Introduce a new "git cherry-pick --continu=
e" command which uses
> =C2=A0 =C2=A0 =C2=A0 =C2=A0the information in ".git/sequencer" to con=
tinue a cherry-pick that
> =C2=A0 =C2=A0 =C2=A0 =C2=A0stopped because of a conflict or other err=
or. =C2=A0It works by dropping
> =C2=A0 =C2=A0 =C2=A0 =C2=A0the first instruction from .git/sequencer/=
todo and performing the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0remaining cherry-picks listed there, with =
options (think "-s" and
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"-X") from the initial command listed in .=
git/sequencer/opts.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0So now you can do:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git cherry-p=
ick -Xpatience foo..bar
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0... descriptio=
n conflict in commit moo ...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git cherry-p=
ick --continue
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error: 'cherry=
-pick' is not possible because you have unmerged files.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fatal: failed =
to resume cherry-pick
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$ echo resolve=
d >conflictingfile
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git add conf=
lictingfile && git commit
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git cherry-p=
ick --continue; # resumes with the commit after "moo"

Yep, thanks for the pretty commit message :)

>> During the "git commit" stage, CHERRY_PICK_HEAD will aid by providin=
g
>> the commit message from the conflicting "moo" commit. =C2=A0Note tha=
t the
>> cherry-pick mechanism has no control at this stage, so the user is
>> free to violate anything that was specified during the first
>> cherry-pick invocation. =C2=A0For example, if "-x" was specified dur=
ing the
>> first cherry-pick invocation, the user is free to edit out the messa=
ge
>> during commit time. =C2=A0One glitch to note is that the "--signoff"=
 option
>> specified at cherry-pick invocation time is not reflected in the
>> commit message provided by CHERRY_PICK_HEAD; the user must take care
>> to add "--signoff" during the "git commit" invocation.
>
> The -s thing doesn't have much to do with this change. =C2=A0But is i=
t a
> bug or not? =C2=A0If it's not a bug, then this is not so much a glitc=
h to
> note as an important feature to ensure people don't sign off on a
> conflict resolution without thinking about it. =C2=A0(I guess I think=
 it's
> a bug. =C2=A0It's hard to decide.)

Bug, definitely.  It happens because unlike "-x" where the
cherry-picking machinery appends to the commit message, "-s" is
handled at commit-time (when it spawns `git commit`).  Ofcourse, if I
were never to write the sequencing features, this would never been
seen as a bug -- hence the term "glitch"; an implementation detail
that doesn't suit our future plans (namely, this series) very well.

>> --- a/t/t3510-cherry-pick-sequence.sh
>> +++ b/t/t3510-cherry-pick-sequence.sh
>> @@ -101,4 +101,97 @@ test_expect_success '--reset cleans up sequence=
r state' '
> [...]
>> +test_expect_success '--continue complains when no cherry-pick is in=
 progress' '
>> + =C2=A0 =C2=A0 pristine_detach initial &&
>> + =C2=A0 =C2=A0 test_must_fail git cherry-pick --continue >actual 2>=
&1 &&
>> + =C2=A0 =C2=A0 test_i18ngrep "error" actual
>
> This would start to fail if the message ever changed from "error" to
> "fatal", right? =C2=A0I don't think that's a good thing.

Okay, removed this and all similar checks.

>> +test_expect_success '--continue complains when there are unresolved=
 conflicts' '
>> + =C2=A0 =C2=A0 pristine_detach initial &&
>> + =C2=A0 =C2=A0 head=3D$(git rev-parse HEAD) &&
>> + =C2=A0 =C2=A0 test_must_fail git cherry-pick base..picked &&
>> + =C2=A0 =C2=A0 test_must_fail git cherry-pick --continue &&
>> + =C2=A0 =C2=A0 git cherry-pick --reset
>> +'
>> +
>> +test_expect_success '--continue continues after conflicts are resol=
ved' '
>> + =C2=A0 =C2=A0 pristine_detach initial &&
>> + =C2=A0 =C2=A0 head=3D$(git rev-parse HEAD) &&
>
> How is $head used?

Stray line -- copy-pasting from an older version on my own tests.
Removed everywhere.

>> + =C2=A0 =C2=A0 test_must_fail git cherry-pick base..anotherpick &&
>> + =C2=A0 =C2=A0 echo "c" >foo &&
>> + =C2=A0 =C2=A0 git add foo &&
>> + =C2=A0 =C2=A0 git commit &&
>> + =C2=A0 =C2=A0 git cherry-pick --continue &&
>> + =C2=A0 =C2=A0 test_path_is_missing .git/sequencer &&
>> + =C2=A0 =C2=A0 {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git rev-list HEAD |
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git diff-tree --root --s=
tdin |
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sed "s/[0-9a-f]\{40\}/OB=
JID/g"
>> + =C2=A0 =C2=A0 } >actual &&
>
> $_x40 is idiomatic and safer with old seds.

I see.  I actually thought '[0-9a-f]\{40\}' would be more traditional,
and that's why I picked in the first place :p

>> +test_expect_success '--continue respects opts' '
>> + =C2=A0 =C2=A0 pristine_detach initial &&
>> + =C2=A0 =C2=A0 head=3D$(git rev-parse HEAD) &&
>> + =C2=A0 =C2=A0 test_must_fail git cherry-pick -s -x base..anotherpi=
ck &&
>> + =C2=A0 =C2=A0 echo "c" >foo &&
>> + =C2=A0 =C2=A0 git add foo &&
>> + =C2=A0 =C2=A0 git commit -s &&
>> + =C2=A0 =C2=A0 git cherry-pick --continue &&
>> + =C2=A0 =C2=A0 test_path_is_missing .git/sequencer &&
>> + =C2=A0 =C2=A0 git cat-file commit HEAD >anotherpick_msg &&
>> + =C2=A0 =C2=A0 git cat-file commit HEAD~1 >picked_msg &&
>> + =C2=A0 =C2=A0 git cat-file commit HEAD~2 >unrelatedpick_msg &&
>> + =C2=A0 =C2=A0 git cat-file commit HEAD~3 >initial_msg &&
>> + =C2=A0 =C2=A0 test_must_fail test_i18ngrep "Signed-off-by:" initia=
l_msg &&
>
> This will break when GETTEXT_POISON is set --- test_i18ngrep
> automatically succeeds in that case.
>
> Is "Signed-off-by" meant to be translated anyway? =C2=A0I would use
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0! grep
>
> if testing that.

My bad.  Replaced with grep.  Thanks.

> By the way, that probably should go in a separate test assertion
> ("-s is not automatically propagated to resolved conflict") to make
> it easier to change the behavior later.

Separated into another test.  Thanks.

-- Ram
