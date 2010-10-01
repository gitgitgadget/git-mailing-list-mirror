From: Magnus Hagander <magnus@hagander.net>
Subject: Re: [PATCH] Allow gitweb tab width to be set per project.
Date: Fri, 1 Oct 2010 13:56:12 +0200
Message-ID: <AANLkTimPte3eQMuCE3NTS=03Vv+Q2-nnu8BmXq=4YCbA@mail.gmail.com>
References: <1285673709-24924-1-git-send-email-magnus@hagander.net>
	<m34odagioh.fsf@localhost.localdomain>
	<AANLkTikMjVQgEzLQ5Z95cmb5fkQ5iSzqfA4T=D1zzy=j@mail.gmail.com>
	<201009291122.01272.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 13:56:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1eDq-0004RS-W6
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 13:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756643Ab0JAL4O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Oct 2010 07:56:14 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:33149 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755634Ab0JAL4O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Oct 2010 07:56:14 -0400
Received: by qwh6 with SMTP id 6so1450424qwh.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 04:56:13 -0700 (PDT)
Received: by 10.224.112.204 with SMTP id x12mr3656393qap.170.1285934172917;
 Fri, 01 Oct 2010 04:56:12 -0700 (PDT)
Received: by 10.229.96.207 with HTTP; Fri, 1 Oct 2010 04:56:12 -0700 (PDT)
In-Reply-To: <201009291122.01272.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157750>

On Wed, Sep 29, 2010 at 11:22, Jakub Narebski <jnareb@gmail.com> wrote:
> On Wed, 29 Sep 2010, Magnus Hagander wrote:
>> On Tue, Sep 28, 2010 at 14:25, Jakub Narebski <jnareb@gmail.com> wro=
te:
>>> Magnus Hagander <magnus@hagander.net> writes:
>
>>>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>>>> index a85e2f6..ef92a4f 100755
>>>> --- a/gitweb/gitweb.perl
>>>> +++ b/gitweb/gitweb.perl
>>>> @@ -1465,9 +1465,11 @@ sub unquote {
>>>> =A0# escape tabs (convert tabs to spaces)
>>>> =A0sub untabify {
>>>> =A0 =A0 =A0 my $line =3D shift;
>>>> + =A0 =A0 my $tabwidth =3D git_get_project_config('tabwidth', '--i=
nt');
>>>
>>> Note that untabify() is called once for each _line_ in a file or a
>>> diff...
>>
>> Ha, that's what I get for thinking it was too easy. It actually was =
:-)
>>
>>
>>> This has acceptable performance only because gitweb config is cache=
d
>>> in %config hash by git_get_project_config() subroutine.
>>>
>>>
>>> I'm not sure if it wouldn't be better to have $tabwidth be passed a=
s
>>> an (optional) argument to untabify(), and calculated either in call=
ing
>>> sites for untabify(), or be calculated per-request and save in a
>>> global variable.
>>
>> Given that it's cached, will it actually make a big difference?
>
> Well, I agree that with config cached it could be left like this...
> but I would like very much to perhaps have a comment about this, so o=
ther
> people don't have to wonder.

Check.

>>>> + =A0 =A0 $tabwidth =3D 8 if ($tabwidth <=3D 0);
>>>
>>> git_get_project_config('tabwidth', '--int') can return 'undef' if a
>>> configuration key does not exist, resulting in
>>>
>>> =A0Use of uninitialized value in numeric le (<=3D) at
>>>
>>> warning in web server logs.
>>
>> Ah, I knew that would go somewhere. Interestingly enough, it doesn't
>> show up in the logs of the server I run it on now. But still should =
be
>> fixed.
>
> Whether such warning shows in web server logs might depend on whether
> you are running gitweb under mod_perl, or as plain CGI script.
> Nevertheless it is a good practice to check if a change passess
> appropriate tests from git testsuite; t9500-gitweb-standalone-no-erro=
rs
> should detect this.

Good point. Now I just need to figure out how to be able to run the
tests :-) I guess I should just set off a job to build the whole tree,
and then it will just work..


> Simply use
>
> =A0 =A0+ =A0 =A0 $tabwidth =3D 8 if (!defined $tabwidth || $tabwidth =
<=3D 0);
>
> or
>
> =A0 =A0+ =A0 =A0 $tabwidth =3D 8 if (!$tabwidth || $tabwidth <=3D 0);
>
> (though second version is more cryptic).

Yeah, i definitely prefer the first one - then again, I'm not really a
perl guy...



> P.S. If it is not a %feature, we might want to add description of
> gitweb.tabwidth to the "Per-repository gitweb configuration" section
> in gitweb/README (as next to last item)

Ok. Will add that. Want me to send a new patch with these things includ=
ed?


--=20
=A0Magnus Hagander
=A0Me: http://www.hagander.net/
=A0Work: http://www.redpill-linpro.com/
