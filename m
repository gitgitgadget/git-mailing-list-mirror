From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: t7800-difftool.sh failure on pu
Date: Mon, 2 Apr 2012 13:19:31 -0400
Message-ID: <CAFouetg2ME6f7=p191qPq=YC7Z7ZeBpm23tgb_wDmsEmwV7etw@mail.gmail.com>
References: <4F74A604.3040402@ramsay1.demon.co.uk>
	<7v7gy3qesv.fsf@alter.siamese.dyndns.org>
	<CAJDDKr50oDwih2fyb5iuFqYDsXSD3EXje4vZJwO=1_JBvuMYsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 19:19:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEkuq-0007Xo-Qv
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 19:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686Ab2DBRTd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Apr 2012 13:19:33 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42686 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669Ab2DBRTc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Apr 2012 13:19:32 -0400
Received: by gghe5 with SMTP id e5so1344825ggh.19
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 10:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Kkpa3Z3t8mE78HySKLHuSwDMRZ7YnkWkpGBgtamot/s=;
        b=Q9Cj5oH0KZIx0VCXLrtAtc5dcrkXDBKIip0L5SDu2HbxP855zli81XbFgxPSs0RRxA
         k6ugWMVc0lsiDNtyML8uR3PxpYGu+E4QUUjDmty+q4FarKLT/kXOOjn7nCBatiq6yk/S
         jDH2t0aTrCKp7gAeY2yFD6N8PJ2nm7iM6aAqunPjGfLVmQ7wEX0AoXgCWr0zUH2ZcK/B
         LQ1E9NghzVUwr5P3uO8Hvq5ePrLNXYwHQoi59H3nZ2IMvuIpa8vCUrjhZV9X4XpfUnfA
         FmVWlP7KNSc1tD8OL1ovOb7wmJ2dEtPw3i76GlXSfHVY4WKChqszEhV8WbIDIRgYR2j7
         D0aw==
Received: by 10.50.188.138 with SMTP id ga10mr6325363igc.51.1333387171473;
 Mon, 02 Apr 2012 10:19:31 -0700 (PDT)
Received: by 10.42.225.193 with HTTP; Mon, 2 Apr 2012 10:19:31 -0700 (PDT)
In-Reply-To: <CAJDDKr50oDwih2fyb5iuFqYDsXSD3EXje4vZJwO=1_JBvuMYsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194540>

On Sat, Mar 31, 2012 at 12:05 AM, David Aguilar <davvid@gmail.com> wrot=
e:
> On Thu, Mar 29, 2012 at 2:26 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>>
>>> The first option is to (effectively) revert commit 0440ed72 ("difft=
ool: replace
>>> system call with Git::command_noisy", 22-03-2012), like so:
>>>
>>> -- >8 --
>>> diff --git a/git-difftool.perl b/git-difftool.perl
>>> index e1754ff..49613b1 100755
>>> --- a/git-difftool.perl
>>> +++ b/git-difftool.perl
>>> @@ -237,5 +237,7 @@ if (defined($dirdiff)) {
>>>
>>> =C2=A0 =C2=A0 =C2=A0 $ENV{GIT_PAGER} =3D '';
>>> =C2=A0 =C2=A0 =C2=A0 $ENV{GIT_EXTERNAL_DIFF} =3D 'git-difftool--hel=
per';
>>> - =C2=A0 =C2=A0 git_cmd_try { Git::command_noisy(('diff', @ARGV)) }=
 'exit code %d';
>>> + =C2=A0 =C2=A0 my @command =3D ('git', 'diff', @ARGV);
>>> + =C2=A0 =C2=A0 my $rc =3D system(@command);
>>> + =C2=A0 =C2=A0 exit($rc | ($rc >> 8));
>>> =C2=A0}
>>> -- 8< --
>>
>> I would prefer this, regardless of the issue.
>>
>> I actually recall asking Tim about the exit status when I reviewed t=
his
>> change.

This breakage is a surprise to me.  All the tests in t7800 have passed
for me since my first modifications to them.  They continue to pass
for me on Ubuntu.  That being said, the simple tests that Ramsay
posted in his email (simply printing $!) also fail for me on msysgit.


> I would also prefer this.
>

This change will involve:
  - Dropping 7/9 from the series
  - Editing 8/9 to replace 'git_cmd_try' with simple system calls

Would it be better to resend the entire series or just edit and resend =
8/9?


> A question for the msysgit/cygwin folks:
>
> would we need to go back to use "git.exe" as well?

I would welcome some feedback from other Windows users.  I have been
successfully using this series on Win7 with msysgit, but obviously
some setups differ.
