From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/6] Make test-lib.sh emit valid TAP format
Date: Fri, 7 May 2010 20:49:08 +0000
Message-ID: <AANLkTimvWnaoZs7k-fxCWTvnO8LxjAcvA-2-7_CHGfF6@mail.gmail.com>
References: <1273261025-31523-1-git-send-email-avarab@gmail.com>
	 <m37hnffow2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 22:49:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAUU0-0006zL-QK
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 22:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113Ab0EGUtL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 16:49:11 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:57163 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab0EGUtJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 16:49:09 -0400
Received: by yxe1 with SMTP id 1so1040335yxe.33
        for <git@vger.kernel.org>; Fri, 07 May 2010 13:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=r1buvq8VOynpYn3vVEQZ4QP9hvUsP6tLArhcq7GOcuU=;
        b=QSMb6M3qcDfU+D0O+P/R7tDPvNcRbjpz9lM/FcgUzf4O18gWp17yaJrb4Rkx1b0Q8p
         KRLi7QEECA8I0vtNcZkyW906N79seQF43MMl1K84/vHK7zKYqfPWGJAw0JeoS/B0YVJp
         wHhT1dZidURASJItfIg6cz89XOPVIy0norHX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wWqUk/vJjGHqFLm57NGhbX9nN2hoqYDocR+xZJTWn5+rIbDRZLjY2e9uH2rDGjEq04
         3d8BQ3lLU6VN6I6g6SVOHmtMBnR01IMLYgvWZ+5KBXRtrrPHxaxq5c7DyLwktc6LNKKY
         3sr3jnQldlU62lu9XXYInUeUH6wWsA1IwZZeM=
Received: by 10.231.166.85 with SMTP id l21mr288696iby.14.1273265348339; Fri, 
	07 May 2010 13:49:08 -0700 (PDT)
Received: by 10.231.160.11 with HTTP; Fri, 7 May 2010 13:49:08 -0700 (PDT)
In-Reply-To: <m37hnffow2.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146594>

On Fri, May 7, 2010 at 20:17, Jakub Narebski <jnareb@gmail.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> TAP, the the Test Anything Protocol, is a simple text-based interfac=
e
>> between testing modules in a test harness. test-lib.sh's output was
>> already very close to being valid TAP. This change brings it all the
>> way there.
>>
>> The advantage of using TAP is that any program that reads the format
>> (a "test harness") can run the tests. The most popular of these is t=
he
>> prove(1) utility that comes with Perl. It can run tests in parallel,
>> display colored output, format the output to console, file, HTML etc=
=2E,
>> and much more.
>>
>> On my quad Xeon server running the test suite with `make test` takes
>> 21 minutes. Running it with `prove -j 15 ./t[0-9]*.sh` takes just ov=
er
>> 5 minutes.
>>
>> With parallel tests the whole test suite doesn't have to stall becau=
se
>> tests like t3404-rebase-interactive.sh take a long time.
>
> I would have thought that it would be better for git test suite to
> enable TAP output with --tap switch. =C2=A0On the other hand changing
> output to TAP, replacing old format, would be less code to maintain.

That was my thinking as well. TAP is human readable like the old
format, the only difference is that TAP is standardized and can be
read by a wide variety of existing programs. For comparison:

Before the patch:

    $ ./t0005-signals.sh
    *   ok 1: sigchain works
    * passed all 1 test(s)

After:

    $ ./t0005-signals.sh
    ok 1 - sigchain works
    # passed all 1 test(s)
    1..1

Or alternatively:

    $ prove ./t0005-signals.sh
    ./t0005-signals.sh .. ok
    All tests successful.
    Files=3D1, Tests=3D1,  0 wallclock secs ( 0.03 usr  0.00 sys +  0.0=
1
cusr  0.02 csys =3D  0.06 CPU)
    Result: PASS

> I am not sure if testing with 'prove' and TAP output is compatibile
> with all current git test suite options, i.e. --debug, --tee,
> --verbose and --immediate, and with GIT_SKIP_TESTS environmental
> variable.

If you pass things like the --verbose output through prove it'll
work. This is because TAP specifies that any unknown output can be
ignored (i.e. lines that don't match /^(?:not)? ok/).

> Also valuable way of checking where the error occurs in the test,
> namely 'sh -x ./tXXXX-test.sh' would not work, I think, with
> 'prove'.

This doesn't break any method of currently running tests (e.g. running
them manually). You don't *have* to run prove, you just can if you
want to.

> Note also that having Perl (and 'prove') installed is not requirement
> for git runnig, and I think it should not be requirement for git
> development.

It should not be. Using fancy TAP formatting tools (whether it's prove
or something else) is purely optional.

> P.S. I think that such series would be better with the cover letter.

I'll make sure to submit one in the future if I send a large patch
series again, sorry.
