From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] revert: allow cherry-pick --continue to commit
 before resuming
Date: Wed, 14 Dec 2011 10:48:26 -0600
Message-ID: <20111214164826.GB481@elie.hsd1.il.comcast.net>
References: <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112001.GF7399@elie.hsd1.il.comcast.net>
 <7vr50zd5x0.fsf@alter.siamese.dyndns.org>
 <20111123012721.GA14217@elie.hsd1.il.comcast.net>
 <4ECCB3A2.5030102@viscovery.net>
 <20111123100452.GA30629@elie.hsd1.il.comcast.net>
 <4ECCC935.7010407@viscovery.net>
 <20111210124644.GA22035@elie.hsd1.il.comcast.net>
 <20111210124925.GC22035@elie.hsd1.il.comcast.net>
 <CALkWK0miBzT4BXRDYOhz8JqF2jeyz1L3=pwaGKVm654oHtQbtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 17:48:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ras0X-0000x8-2b
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 17:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757362Ab1LNQsg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Dec 2011 11:48:36 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34312 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755078Ab1LNQsf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2011 11:48:35 -0500
Received: by faar15 with SMTP id r15so1368444faa.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 08:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rzdZFiRk+tcgrLYtIdl+BZh4qvPUz3ESsHBcDEfOZFY=;
        b=ZvqTyN8ZYTL5Z0olKLCbIAN0GvHzIMOKNfVTmcTJw094xvab/F90tiqtpS5dfkQtiG
         xKKF+YyOhRo9uAPHjdxQA0nle8lDSnA25toRZTvnvfMg6YGvRucL4T59yHH9WrG9nfSW
         M2WML6LzSMOw/+v8rb8cF+MCZ9IBYR0GtOT3g=
Received: by 10.180.74.211 with SMTP id w19mr6438275wiv.7.1323881314105;
        Wed, 14 Dec 2011 08:48:34 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ca18sm4307544wib.13.2011.12.14.08.48.30
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 08:48:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0miBzT4BXRDYOhz8JqF2jeyz1L3=pwaGKVm654oHtQbtQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187143>

Ramkumar Ramachandra wrote:

> Sounds good.  I remember my implementation being quite complicated;
> let's see how you've done this.

I have to confess that I don't remember the implementation you are
referring to.  Maybe I could have taken inspiration from it.

The rest of this message is about tests.

[...]
> Jonathan Nieder wrote:

>> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-s=
equence.sh
>> index 2c4c1c85..4d1883b7 100755
>> --- a/t/t3510-cherry-pick-sequence.sh
>> +++ b/t/t3510-cherry-pick-sequence.sh
>> @@ -2,6 +2,7 @@
>>
>> =C2=A0test_description=3D'Test cherry-pick continuation features
>>
>> + + =C2=A0conflicting: rewrites unrelated to conflicting
>> =C2=A0  + yetanotherpick: rewrites foo to e
>> =C2=A0  + anotherpick: rewrites foo to d
>> =C2=A0  + picked: rewrites foo to c
>
> Note to self: this list of commits is becoming quite unwieldy.  We
> should probably refactor these sometime.

To clarify, "conflicting" is sitting on a separate branch from the
rest of the commits.  This --help text uses "git show-branch"-style
output, which is perhaps out of fashion but compact and used by some
existing tests.

>> @@ -27,6 +28,7 @@ test_cmp_rev () {
>> =C2=A0}
>>
>> =C2=A0test_expect_success setup '
>> + =C2=A0 =C2=A0 =C2=A0 git config advice.detachedhead false
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo unrelated >unrelated &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0git add unrelated &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_commit initial foo a &&
>
> Huh, why are you moving this line up?  Oh, right: there are
> "test_commit" statements in the setup- good catch.

Nah, it's for the pristine_detach, not the test_commit.

I did miss an &&, though.  Not enough to justify rerolling on its own
but seems worth fixing if resending anyway.

>> @@ -35,8 +37,8 @@ test_expect_success setup '
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_commit picked foo c &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_commit anotherpick foo d &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_commit yetanotherpick foo e &&
>> - =C2=A0 =C2=A0 =C2=A0 git config advice.detachedhead false
>> -
>> + =C2=A0 =C2=A0 =C2=A0 pristine_detach initial &&
>> + =C2=A0 =C2=A0 =C2=A0 test_commit conflicting unrelated
>> =C2=A0'
>
> Looks fishy- I wonder why you're doing this.  Let's read ahead and fi=
nd out.

Do you mean that you'd prefer this "conflicting" commit not to be
part of the setup shared between tests?

[...]
>> +test_expect_success '--continue of single revert' '
>> + =C2=A0 =C2=A0 =C2=A0 pristine_detach initial &&
>> + =C2=A0 =C2=A0 =C2=A0 echo resolved >expect &&
>> + =C2=A0 =C2=A0 =C2=A0 echo "Revert \"picked\"" >expect.msg &&
>> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git revert picked &&
>> + =C2=A0 =C2=A0 =C2=A0 echo resolved >foo &&
>> + =C2=A0 =C2=A0 =C2=A0 git add foo &&
>> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --continue &&
>
> Huh?  You're continuing a "git revert" with a a "git cherry-pick
> --continue"?

Yep, works fine.

[...]
> 1. I haven't used the "-s" flag of "git diff-tree" before, so I opene=
d
> up the documentation to find this:

Yeah, that documentation sucks.  I'll keep this message marked as a
reminder to look at it.

Just like "git show" is the porcelain command to show a commit, "git
diff-tree" is the corresponding plumbing.

[...]
>> +test_expect_success '--continue after resolving conflicts' '
[...]
> Unchanged from the original: I suspect you've moved the generation of
> expectation messages up to produce a clean diff.

It's just a new test.  If rerolling, I'll make it imitate the style of
the existing test following it better.

[...]
>> +test_expect_success '--continue asks for help after resolving patch=
 to nil' '
>> + =C2=A0 =C2=A0 =C2=A0 pristine_detach conflicting &&
>> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git cherry-pick initial..picke=
d &&
>> +
>> + =C2=A0 =C2=A0 =C2=A0 test_cmp_rev unrelatedpick CHERRY_PICK_HEAD &=
&
>> + =C2=A0 =C2=A0 =C2=A0 git checkout HEAD -- unrelated &&
>> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git cherry-pick --continue 2>m=
sg &&
>> + =C2=A0 =C2=A0 =C2=A0 test_i18ngrep "The previous cherry-pick is no=
w empty" msg
>> +'
>
> I thought it was a bad idea to grep for specific output messages,
> because of their volatile nature?

This test is about --continue asking for help instead of succeeding or
failing in some uncontrolled way, so it seemed useful to check that
the message actually pertains to that.

> Remind me what this test has to do
> with the rest of your patch?

With this change in how --continue works, I wanted to make sure the
semantics that were not supposed to be changed were still intact.

[...]
>> +test_expect_failure 'follow advice and skip nil patch' '
[...]
> Again, what does this test have to do with the rest of your patch?

Likewise.

[...]
>> +test_expect_success '--continue of single-pick respects -x' '
[...]
> I'd have liked s/respects -x/respects opts/ here for symmetry with th=
e
> previous test.

Maybe the previous one should say "respects -x".

I am not sure what it would mean for --continue of a single-pick to
respect --strategy, for example.

>> +test_expect_success '--continue respects -x in first commit in mult=
i-pick' '
[...]
> Can you explain why "first commit in a multi-pick" is a special case?

I guess you mean "how does this differ from the existing '--continue
respects opts' test?".

Good question.  In the existing "--continue respects opts" test, we
explicitly run "git commit" before "git cherry-pick --continue".  This
test checks that running "git cherry-pick --continue" without
commiting first does not cause the commit message to be clobbered.

[...]
>> @@ -306,6 +413,32 @@ test_expect_success '--signoff is not automatic=
ally propagated to resolved confl
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0grep "Signed-off-by:" anotherpick_msg
>> =C2=A0'
>>
>> +test_expect_success '--signoff dropped for implicit commit of resol=
ution, multi-pick case' '
[...]
> Unrelated.
[...]
>> +test_expect_success 'sign-off needs to be reaffirmed after conflict=
 resolution, single-pick case' '

There was no implicit commit of resolution before this patch, so how
can it be unrelated?

[...]
> Thanks for working on this.

Thanks for your attention to detail.

Sincerely,
Jonathan
