From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2 1/3] t/gitweb-lib.sh: print to stderr when gitweb_run
 has errors
Date: Sat, 19 Feb 2011 17:17:39 +0100
Message-ID: <AANLkTimFyue2F6aRg7KdqOJZw9dOHY+B0XWCiVBYNOeg@mail.gmail.com>
References: <1298124654-12051-1-git-send-email-avarab@gmail.com>
	<1298129262-10468-2-git-send-email-avarab@gmail.com>
	<201102191646.02543.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 17:17:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqpVM-00070U-64
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 17:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221Ab1BSQRm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 11:17:42 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63325 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708Ab1BSQRl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Feb 2011 11:17:41 -0500
Received: by fxm17 with SMTP id 17so200105fxm.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 08:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FFPWm+fdphgB8AEstSOD7OZ5OR3R4ZWhH2RvcJsHp0o=;
        b=hSwtStb08o0JJcOmcwrNUchS1WERGIdWD5/XykSNSS+XX2AK5QYgwKra7WiJA+9eD+
         6ieG3zLQHjdQCOqW6mSEbrwCOe8j1ksptb0HPgSoP6Lx3thE3wfFgW03N8ZquRzJJL8W
         PhuNUfkExfo9BJli1KiJpw1RbYRvsgIy3XtZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ll6fil9RQhp5d2N7M0HlrSpTYq03aVmnrGe47tXTHPfeMKbiPdYpo2pdLtj8lGLyNs
         o1mWIGqmXhCzTuovEY+dJVGguub9repyAl585w13jBmZAbfe8Tc7L1uEur2e+49b+V/t
         WrR+jQD2I0vHbiQowu0znxHLd0YeqsDSnyo0k=
Received: by 10.223.54.132 with SMTP id q4mr140661fag.117.1298132259907; Sat,
 19 Feb 2011 08:17:39 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Sat, 19 Feb 2011 08:17:39 -0800 (PST)
In-Reply-To: <201102191646.02543.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167298>

On Sat, Feb 19, 2011 at 16:46, Jakub Narebski <jnareb@gmail.com> wrote:
> On Sat, 19 Feb 2011, =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason wrote:
>
>> Change the gitweb_run test subroutine to spew errors to stderr if
>> there are any, previously it would just silently fail, which made
>> tests very hard to debug.
>>
>> Before you'd get this output, when running tests under `--verbose
>> --immediate --debug`:
>
> Which test?
>
> [...]
>> --- a/t/gitweb-lib.sh
>> +++ b/t/gitweb-lib.sh
>> @@ -82,7 +82,12 @@ gitweb_run () {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close O;
>> =C2=A0 =C2=A0 =C2=A0 ' gitweb.output &&
>> - =C2=A0 =C2=A0 if grep '^[[]' gitweb.log >/dev/null 2>&1; then fals=
e; else true; fi
>> + =C2=A0 =C2=A0 if grep '^[[]' gitweb.log >/dev/null 2>&1; then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cat gitweb.log >&2
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 false
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 true
>> + =C2=A0 =C2=A0 fi
>
> I don't understand this change. =C2=A0Either it is not necessary, bec=
ause
> test suite (or at least t9500) has
>
> =C2=A0test_debug 'cat gitweb.log'
>
> after each test, so that error messages would be printed with `--debu=
g`,
> or it doesn't go far enough: if the above is used then those test_deb=
ug
> should be removed.

The way you're using test_debug() is incompatible with
--immediate. The test dies, but I'll never see your debug message
because I'm using --immediate.

It would be better to just use test_debug in gitweb_run (instead of my
"cat gitweb.log").

Anyway, if you feel like fixing that feel free, I wan't pursue this
further (going to hack on what I was going to do before gitweb tests
started failing).

Junio, you can drop this patch since it'll produce duplicate output if
the test fails and the user *doesn't* use --immediate, but IMO this
should be fixed by doing the debug output differently.
