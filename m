From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2 2/5] t/t4004-diff-rename-symlink.sh: use three-arg 
	<prereq>
Date: Thu, 29 Jul 2010 01:56:50 +0000
Message-ID: <AANLkTinFMjH6LfDXjCp9XGVEuQF9ZKrL0i8t-p8hmzJ-@mail.gmail.com>
References: <1280313299-721-1-git-send-email-avarab@gmail.com>
	<1280313299-721-3-git-send-email-avarab@gmail.com>
	<20100729010903.GF29156@dert.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 03:57:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeIMu-0000Vy-Jc
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 03:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550Ab0G2B4y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 21:56:54 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58790 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab0G2B4x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 21:56:53 -0400
Received: by fxm14 with SMTP id 14so15729fxm.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 18:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AN+66woXhyngX4vm86JFu/enysVyYBcLG8pZ9GObqZE=;
        b=en3OCelLOXX1pTtK4BHh7Y6UsK7qitTW+gjvns5v1GlTRxrTmPR789M0Q2MQiVF/wH
         KzJCFdMzNocL8mbvUQkeKOFQLbczlbXBDOYzoXo7UgUTlbOsi8xyJqbcitEfTAWjURBr
         wS1doMSHep9RUUJ/anhmSb5s1l6+bR3yUN8b8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xxKSOySLAENaJoQwBjSk0SxEcF57aC5M/BqmVGKZ01z5T1hecOXcDeV7EzNIVr3Z06
         O3Y/fqMZzYCQStTIONmUi/GTxv39eqOTJ8W2Wry2N0FwYk0RdyvUmSalbqDr1Yb0v0O6
         SVTgduwJs41sVMHTXr1+Bxv0boldhyhOWdzW8=
Received: by 10.223.111.200 with SMTP id t8mr10938022fap.31.1280368610153; 
	Wed, 28 Jul 2010 18:56:50 -0700 (PDT)
Received: by 10.223.126.131 with HTTP; Wed, 28 Jul 2010 18:56:50 -0700 (PDT)
In-Reply-To: <20100729010903.GF29156@dert.cs.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152145>

On Thu, Jul 29, 2010 at 01:09, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Change the tests that skipped due to unavailable SYMLINKS support to
>> use the three-arg prereq form of test_expect_success.
>>
>> This is like the "tests: implicitly skip SYMLINKS tests using
>> <prereq>" change, but I needed to create an additional test for some
>> setup code. It's in a separate change as suggested by Jonathan Niede=
r
>> for ease of reviewing.
>
> Hmm, I still don=E2=80=99t understand this. =C2=A0Do you mean that th=
ere is
> some setup that needs to be run before these commands, and so
> the patch fails if that change is not included?
>
> Or is it a matter of "while at it, fix this other problem
> I noticed" (which would be fine, but it is clearer to
> present it as such if so)?

The setup code needs to be inside a test so that it'll only run if we
have SYMLINKS support.

I could also have done:

    if test_have_prereq PERL
    then
        ..setup code..
    fi

But setup code should be inside tests, so that we'll get failure
reporting.

>> diff --git a/t/t4004-diff-rename-symlink.sh b/t/t4004-diff-rename-sy=
mlink.sh
>> index 1a09e8d..92a65f4 100755
>> --- a/t/t4004-diff-rename-symlink.sh
>> +++ b/t/t4004-diff-rename-symlink.sh
>> @@ -40,8 +34,9 @@ test_expect_success \
>> =C2=A0# rezrov and nitfol are rename/copy of frotz and bozbar should=
 be
>> =C2=A0# a new creation.
>>
>> -GIT_DIFF_OPTS=3D--unified=3D0 git diff-index -M -p $tree >current
>> -cat >expected <<\EOF
>> +test_expect_success SYMLINKS 'setup diff output' "
>> + =C2=A0 =C2=A0GIT_DIFF_OPTS=3D--unified=3D0 git diff-index -M -p $t=
ree >current &&
>> + =C2=A0 =C2=A0cat >expected <<\EOF
>> =C2=A0diff --git a/bozbar b/bozbar
>> =C2=A0new file mode 120000
>> =C2=A0--- /dev/null
>> @@ -65,8 +60,9 @@ deleted file mode 100644
>> =C2=A0-xyzzy
>> =C2=A0\ No newline at end of file
>> =C2=A0EOF
>> +"
>
> Tip for the future: if you use 'straight quotes', then readers
> can avoid carefully scanning through for $ and similar oddities
> (and the test script presented with the "expecting success:"
> prompt will use the friendlier $tree instead of 76c98ds89).

Ah, thanks.

> The patch looks good; my only remaining concern is the log
> message as mentioned above.

Hopefully that's cleared up now.
