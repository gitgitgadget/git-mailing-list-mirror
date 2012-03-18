From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 7/9] difftool: teach difftool to handle directory diffs
Date: Sat, 17 Mar 2012 20:58:12 -0400
Message-ID: <CAFouetg1JEBsO4SyHxpaphQZQtmbo8ugbHoUWnhSXku4DWuvVA@mail.gmail.com>
References: <1331949574-15192-1-git-send-email-tim.henigan@gmail.com>
	<m3fwd7l2mu.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, davvid@gmail.com, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 18 01:58:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S94Ru-0001wd-OP
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 01:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756392Ab2CRA6O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Mar 2012 20:58:14 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58915 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755312Ab2CRA6N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2012 20:58:13 -0400
Received: by iagz16 with SMTP id z16so7515833iag.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 17:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=11D2XCBClKqwWfh0mZDNyLkZxsr3BGs10fkZDVkTXL4=;
        b=c/jbvD9dV72hZBgkwR7ONmosdunPACmAmOqWLhF0V33crftV2zbdJw7yVA2Gc86fek
         61/2gyraStheXu3sntGEU1t0Aj4TMiPgahW+O1WNJztxgNL2m4OnWsIQh4sLQSNtdNda
         5bI+D4T5F/Cg77r6lr7H36SNbbJZGUIK8rgQNbWbOJ2Wy9s+Qac7uiUEIOC+U+Ndq36R
         tBcf51cyz3hGzvCmOP7qOeff9IMjxoyRE07WSbWsJpE7YrprjgInIgh1ce9KL3PEPcPb
         20VRW7Z7AhN5KpikavUYeRhwAXnB0p/9Nx5SxzlFJ+dt/vVT9N4dgClrAzCbl1PkXCQH
         cyXw==
Received: by 10.42.142.136 with SMTP id s8mr4212047icu.36.1332032292458; Sat,
 17 Mar 2012 17:58:12 -0700 (PDT)
Received: by 10.42.218.65 with HTTP; Sat, 17 Mar 2012 17:58:12 -0700 (PDT)
In-Reply-To: <m3fwd7l2mu.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193353>

On Sat, Mar 17, 2012 at 10:32 AM, Jakub Narebski <jnareb@gmail.com> wro=
te:
> Tim Henigan <tim.henigan@gmail.com> writes:
>
>> + =C2=A0 =C2=A0 foreach my $path (keys %submodule) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (defined $submodule{$=
path}{left}) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 open(SUBMOD, ">$ldir/$path") or die $!;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 print(SUBMOD "Subproject commit $submodule{$path}{left}");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 close(SUBMOD);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (defined $submodule{$=
path}{right}) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 open(SUBMOD, ">$rdir/$path") or die $!;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 print(SUBMOD "Subproject commit $submodule{$path}{right}");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 close(SUBMOD);
>
> Could you please use modern Perl, and use lexical filehandles instead
> of globs, and 3-arg version of 'open', i.e.
>
> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 open my $submod_fh, ">", "$ldir/$path" or die $!;
> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 print $submod_fh "Subproject commit $submodule{$path}{left}";
> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 close $submod_fh;

I will make this change in v2.  Thank you for the review and the remind=
er.


>> +if (defined($dirdiff)) {
>> + =C2=A0 =C2=A0 my ($a, $b) =3D setup_dir_diff();
>> + =C2=A0 =C2=A0 if (defined($extcmd)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 system("$extcmd $a $b");
>> + =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $ENV{GIT_DIFFTOOL_DIRDIF=
=46} =3D 'true';
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 system("git difftool--he=
lper $a $b");
>> + =C2=A0 =C2=A0 }
>
> Why you use 'system' (and not in list form which does not require
> escaping shell characters) instead of git_cmd_try for first
> "git difftool--helper" invocation?

There is no good reason to use 'system' here.  I will change this to
'Git::command_noisy' in v2.


> Is $extcmd and resultof setup_dir_diff() to be treated as shell
> snippet, and used in string form of 'system' without escaping shell
> metacharacters (like ' ' in filename)?

In v2, I will change to the list form of 'system' for the call to
$extcmd. I think I made some bad assumptions about the contents of
$extcmd, $a and $b because of my local test setup.  However, changing
to list form should correct the oversight.
