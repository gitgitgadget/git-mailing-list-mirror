From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv5 01/16] test-lib: make test_expect_code a test command
Date: Sun, 3 Oct 2010 13:29:40 -0600
Message-ID: <AANLkTik-ztiY6o=S09UyJ1zg4xxtnBXaXaK1yuLZQ0-+@mail.gmail.com>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
	<1286082644-31595-2-git-send-email-newren@gmail.com>
	<20101003141339.GB17084@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 21:29:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2UFn-0005mR-Ol
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 21:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703Ab0JCT3m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 15:29:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62447 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373Ab0JCT3l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 15:29:41 -0400
Received: by fxm14 with SMTP id 14so1392302fxm.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 12:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PakzaHsIOmpT/uY3B5/eZPGMz9pGCPyApiK8WmzzYLc=;
        b=PWXY49+YPkgXi3TWUmkWg9y8VY/rQf2RBzl1pIbaS9hq7RtZB7r/h+siKtJZ2er1N5
         fupJ0RdAjQIxC0ERhRH81IBShOKtNCybmoYPgE/pQPc0FCtXPtWviCjOc8RRPfF+qNF3
         fSPW/57GN0+eJeiJw5Cz1MtoVFdLG1t0Utgt4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WnNdLwxDNKf2WGdGMX1GhSO3ChCFAaRbKrVYI/AHJjB8WEP0+Uplg9exe7kjAGLIsa
         pI71Puq/x6HQ9nDOfnczwROdaMA9vBTt+YS135JN5KSrOViyLSK7KnZXiQwrejLOJmmX
         YV2H7I/kXBfu6ZpJWiO29ZE5vgA7PIQPyM1w8=
Received: by 10.223.104.20 with SMTP id m20mr1787208fao.99.1286134180163; Sun,
 03 Oct 2010 12:29:40 -0700 (PDT)
Received: by 10.223.126.70 with HTTP; Sun, 3 Oct 2010 12:29:40 -0700 (PDT)
In-Reply-To: <20101003141339.GB17084@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157894>

I'll have to let =C3=86var respond to most of these, but two quick item=
s...

On Sun, Oct 3, 2010 at 8:13 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Elijah Newren wrote:
>
>> --- a/t/README
>> +++ b/t/README
>> @@ -482,6 +475,15 @@ library for your script to use.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 'Perl API' \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "$PERL_PATH" "$TEST_DIRECTORY"/t9=
700/test.pl
>>
>> + - test_expect_code <exit-code> <git-command>
>> +
>> + =C2=A0 Run a git command and ensure that it exits with the given e=
xit
>> + =C2=A0 code. For example:
>> +
>> + =C2=A0 =C2=A0 test_expect_success 'Merge with d/f conflicts' '
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_expect_code 1 git m=
erge "merge msg" B master
>> + =C2=A0 =C2=A0 '
>
> Side note: this helper should be safe to use even for non-git
> commands. =C2=A0"Huh?" you might ask. "But test_must_fail and
> test_might_fail..." =C2=A0Well, the distinction is this: test_must_fa=
il and
> test_might_fail rely on details of git's funny exit code conventions
> --- e.g., that 130 is not a controlled failure and 129 is one ---
> while test_expect_code has simpler, more generally valid semantics.
>
> But maybe in practice this helper would only be used for git commands
> anyway.

Perhaps, but I agree that it at least makes sense to be used by other
commands, so I'll change the documentation here to replace "git
commands" with just "commands".

[...]

>> +test_expect_code () {
>> + =C2=A0 =C2=A0 want_code=3D$1
>> + =C2=A0 =C2=A0 shift
>> + =C2=A0 =C2=A0 "$@"
>> + =C2=A0 =C2=A0 exit_code=3D$?
>> + =C2=A0 =C2=A0 if test $exit_code =3D $want_code
>> + =C2=A0 =C2=A0 then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo >&2 "test_expect_co=
de: command exited with $exit_code: $*"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0
>
> This makes the tests noisier on success. =C2=A0I have no strong feeli=
ngs
> either way about that, but it's probably worth mentioning in the comm=
it
> message.

I added a brief note in the commit mesage, which I'll resend with the
fixed-up series in a minute.
