From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH] WIP: Report intra-test progress with TAP subtests
Date: Wed, 11 Aug 2010 16:41:52 +0000
Message-ID: <AANLkTikphSj-tLRZwJ3MPrhYtPObZv2kJ0z4iJLJF=Gy@mail.gmail.com>
References: <1281473829-2102-1-git-send-email-avarab@gmail.com>
	<20100811052830.GA1355@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 18:42:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjENN-0005Wy-Kg
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 18:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754166Ab0HKQly convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 12:41:54 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39943 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318Ab0HKQly convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 12:41:54 -0400
Received: by fxm13 with SMTP id 13so256271fxm.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 09:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=C76HtZmqmrhT22OXIzJRvq+9WnLBY7zILCcrrvVylT8=;
        b=UwtzrTk3CIO4afy0/f7S8ROe33dIQ8DgvYq1qEuPb3L2G0Si9UGp3PDXM+M69MHLMq
         qooyXHARKlkxti4c+epA1v2v+tkOSGklieRaCY0Dyak7RrZg8izOZrA5osBQdpHPxgQB
         4IQPNhWm4aWLGt7hLXU+PW7PFYnW5Lyn2khi0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RQM5gbEc0NomEd2kRm+zOhPLfHfOLX57u0cS+rCrmw7QeqgLpRM8O/XYIo+hwjIAqq
         ++7JA0CJC4C1ghsnsSjNI7e4RgtOfw4cQh2FmOX8GiDc/HzpAF9GG8cS5mtfp5FIfc24
         GbrYvFInaUYthkCDXVzfx3fPQdDZ9zXOKzV5E=
Received: by 10.223.123.145 with SMTP id p17mr20396388far.90.1281544912711; 
	Wed, 11 Aug 2010 09:41:52 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Wed, 11 Aug 2010 09:41:52 -0700 (PDT)
In-Reply-To: <20100811052830.GA1355@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153268>

On Wed, Aug 11, 2010 at 05:28, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Here's an attempt at that, I've convented test_commit, test_merge an=
d
>> test_cmp to report intra-test progress. The only problem is that it
>> doesn't quite work.
>
> I forgot to say: thanks for the demonstration. =C2=A0This is neat stu=
ff.
>
>> =C2=A0 =C2=A0 =C2=A0 eval >&3 2>&4 "$1"
>>
>> So when you run it you'll just get:
>>
>> =C2=A0 =C2=A0 $ ./t0100-previous.sh
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 1..1
>> =C2=A0 =C2=A0 ok 1 - branch -d @{-1}
>> =C2=A0 =C2=A0 ok 2 - branch -d @{-12} when there is not enough switc=
hes yet
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 1..2
>> =C2=A0 =C2=A0 ok 3 - merge @{-1}
>> =C2=A0 =C2=A0 ok 4 - merge @{-1} when there is not enough switches y=
et
>> =C2=A0 =C2=A0 # passed all 4 test(s)
>> =C2=A0 =C2=A0 1..4
>>
>> Is there some filedescriptor saving/redirection magic I can do withi=
n
>> the subtest code to print things to the *real* stdout and stderr
>
> Descriptor 5 is a pass-through for stdout: see v0.99.5~24^2~4
> (Trapping exit in tests, 2005-08-10).
>
> Do you need a pass-through for stderr, too, or was that theoretical?

Nope, thanks. Using >&5 works.

>> @@ -290,20 +295,38 @@ test_tick () {
>>
>> =C2=A0test_commit () {
>> =C2=A0 =C2=A0 =C2=A0 file=3D${2:-"$1.t"}
>> - =C2=A0 =C2=A0 echo "${3-$1}" > "$file" &&
>> - =C2=A0 =C2=A0 git add "$file" &&
>> - =C2=A0 =C2=A0 test_tick &&
>> - =C2=A0 =C2=A0 git commit -m "$1" &&
>> - =C2=A0 =C2=A0 git tag "$1"
>> + =C2=A0 =C2=A0 subtest_count=3D$(($subtest_count + 1))
>> +
>> + =C2=A0 =C2=A0 if echo "${3-$1}" > "$file" &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git add "$file" &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_tick &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git commit -m "$1" &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git tag "$1"
>> + =C2=A0 =C2=A0 then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_ok_ "test_commit fi=
le:<$file> message:<$1> contents<${3-$1}>"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 true
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_failure_ "test_comm=
it file:<$file> message:<$1> contents<${3-$1}>"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 true
>> + =C2=A0 =C2=A0 fi
>
> This would make the test continue after the subtest, right? =C2=A0Is =
that
> intended?

No, should be return 0/1. Changed that in my working branch.

I'm going to drop this for a while until my pending patches to test
stuff get into pu. But initial experiments with using >&5 everywhere
for test progress are promising:

    http://github.com/avar/git/tree/test-intra-progress-using-tap-subte=
sts-v2
