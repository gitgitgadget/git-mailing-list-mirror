From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Has anyone looked at Gettext support for Git itself?
Date: Sun, 16 May 2010 01:12:20 +0000
Message-ID: <AANLkTikgs3d1YagU5lRCkEM9uwWe9dmifbHvIjhsk_wF@mail.gmail.com>
References: <AANLkTinlDF-aKDjwvgZEqtUgzW7MCIuElQ_RfJn_RkZp@mail.gmail.com>
	 <m3pr0wd880.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 16 03:12:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODSP7-00037N-AU
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 03:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376Ab0EPBMY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 May 2010 21:12:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61954 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083Ab0EPBMX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 May 2010 21:12:23 -0400
Received: by fxm6 with SMTP id 6so2649938fxm.19
        for <git@vger.kernel.org>; Sat, 15 May 2010 18:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LWmMzH8fmF6URO9ZBghhdkmASBXLqPu4/VCGQaw6hwI=;
        b=ufWNxPOHhlc7eYNORKtnUqmGX/57ushYVDr6BmsA8T8IfAai24tFnmG+Kxy7bPM54s
         dLa4MnsFnJYlFP/A4X4J9FMLRQtnJZEgyJndG/HGy6mmz6+9iWhUlqOGL27nw49jT7i4
         6Wf/bLHOWQvBUrLfph7uOsb2EOsrFn28ioYbY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DHFtgJniKCg51Cozu1guV8zvEANGikHZHlLtLROZqEZEGBh9525TNGFoAKSSn3bgMO
         4eF63VRKPu4wXk/r1QtzpefSaK60sq36CpOVMhXgp6aRdx2VVTdSh35yOdC/QUw0ZNZn
         +9fRqJVi9gFhcnW47vBBdreYfp0CYxF3iGVtE=
Received: by 10.223.63.76 with SMTP id a12mr3998873fai.10.1273972340537; Sat, 
	15 May 2010 18:12:20 -0700 (PDT)
Received: by 10.223.109.78 with HTTP; Sat, 15 May 2010 18:12:20 -0700 (PDT)
In-Reply-To: <m3pr0wd880.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147172>

On Sun, May 16, 2010 at 00:03, Jakub Narebski <jnareb@gmail.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I couldn't find anything about this in the list archives. Have there
>> been any discussions of adding internationalization support to Git
>> itself? I.e. the interface messages that the core Git utilities emit=
=2E
>>
>> I tried to get started with integrating GNU Gettext, but gnuish
>> assumptions it makes about building make it a bit hard.
>>
>> Is there perhaps another gettext implementation that would be more
>> suitable for Git?
>>
>> I'd be interested in submitting patches to make the existing strings
>> translatable if someone could get the tool + build skeleton going.
>
> First, git uses multiple programming languages: you would need a
> solution that would work for programs in C (gettext), for Perl
> (Locale::Maketext or less known Data::Localize), probably for Python,
> and what would probably give most problems for shell scripts.

All of these languages can read gettext, but you'd need some glue for
each so that they could get to the files.

It would probably make the most sense to have distinct message files
for each program, e.g.:

    /usr/share/locale/*/LC_MESSAGES/git-bisect.mo

That way they could be translated incrementally, and the programs
would load only the small subset of messages they need.

=46or e.g. shellscripts this can be done as (adapted from a localized
script in my /usr/bin/):

    export TEXTDOMAIN=3Dgit-bisect
    export TEXTDOMAINDIR=3D/usr/share/locale/
    GETTEXT=3D`which gettext 2> /dev/null`
    if [ -z $GETTEXT ] ; then GETTEXT=3D'echo -n'; fi

And then just:

    - echo "We are not bisecting."
    + $GETTEXT "We are not bisecting."

> Second, you would need to take care that changing locale wouldn't
> break git. =C2=A0It can be done either via setting LC_ALL=3DC in
> git-sh-setup, or by translation only porcelain, and leaving plumbing
> unchanged.

I think it would be fine to break it if that means that Git would
suddenly start speaking your language, you can always just set LC_ALL
if you have some scripts that break as a result of parsing the current
output in English.
