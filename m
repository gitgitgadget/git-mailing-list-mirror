From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: [PATCH] init - Honour the global core.filemode setting
Date: Tue, 30 Sep 2014 18:55:16 -0700
Message-ID: <CAE1pOi1dAO7XFZtrgZyNm-eLVKQx=KpeejbGmF8khCofAppDLg@mail.gmail.com>
References: <CAE1pOi0zhnUNNdHsrq+4H_6LiFnr-qoY-owrcJquy6dyG+Mk4g@mail.gmail.com>
 <5427F68E.5030003@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 01 03:55:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZ98q-0007N2-9S
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 03:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbaJABzk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Sep 2014 21:55:40 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:65353 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbaJABzi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Sep 2014 21:55:38 -0400
Received: by mail-lb0-f175.google.com with SMTP id u10so103116lbd.6
        for <git@vger.kernel.org>; Tue, 30 Sep 2014 18:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=oHoTNbwKgB16ax5nH+TS9Yj+QIaC9PmQ6Nie9Hu9nt0=;
        b=e+6nJIsXNN0tcwZ67lQtNhh7YfReu2AxwYkIY0mGrc8Df8yj/lEWyLdKwFwdSTwsWI
         sjPrItfAeZn2RuHtZUZMuFXLptoohzxFNWv5iLXUvASbpv3SVHdsj1IR5OnvU+H5BHTs
         hKGnc9Kz4hWyp4Pi7GzDeHFbeJURWih0ANwPKS8xHkl/z8XaFKet8x7SPlRQu2CY1MLN
         hWRhgm6I8P6RjBNvUlAO4g9q6irtLBavawvTsN3eNu/XcP0dB1R1rXlElek0XhugmRl4
         GsQPN6rg+xxPQXJ5ioI0RU5XZLh5RUqmD/OTT6FfNYoD8xsqiFe1J41bntO+UvuTomr7
         1AWw==
X-Received: by 10.112.63.104 with SMTP id f8mr14965261lbs.91.1412128537170;
 Tue, 30 Sep 2014 18:55:37 -0700 (PDT)
Received: by 10.112.197.37 with HTTP; Tue, 30 Sep 2014 18:55:16 -0700 (PDT)
In-Reply-To: <5427F68E.5030003@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257689>

Hi Torsten,

Thank you for taking the time to review my patch.

On 28 September 2014 04:52, Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
> On 2014-09-28 02.37, Hilco Wijbenga wrote:
>> If "~/.gitconfig" contains a "core.filemode" entry then "git init"
>> should honour that setting.
>>
>> Signed-off-by: Hilco Wijbenga <hilco.wijbenga@gmail.com>
>> ---
>> This bit me at work where I have to work with Windows. Git on Cygwin
>> and the Eclipse Git plugin do not agree on file attributes so I had
>> set "filemode =3D false" in ~/.gitconfig.
> This feels strange.
> Each and every repo has a core.filemode setting.
> Or should have.
>
> Did you manage to create a repo without core.filemode in repo/.git/co=
nfig ?
> And if yes, how?

Perhaps I completely misunderstand the meaning of core.filemode but I
thought it determined whether Git cared about changes in file
properties? So this is client OS related and independent of the repo?

>> A few weeks later, I did a "git init" and, some time later yet, I
>> noticed the strange behaviour of Cygwin/Eclipse again.
> I do not fully understand which "strange behaviour" you experied,
> so I need to guess.

The problem is simply that Eclipse's Git sees changes that Cygwin's
Git does not. It's some sort of unfortunate consequence of trying to
pretend to be Linux on Windows, I guess. The only way to get them to
agree was to set core.filemode to false. Now you might rightly argue
that Eclipse and/or Windows and/or Cygwin should be fixed but that's a
much bigger undertaking than simply setting an existing Git property.
:-)

>  This was very
>> surprising because things had been working well until then. It took
>> quite a bit of research before I realized that "git init" always set=
s
>> "filemode". I think "filemode" should only be set if not set already
>> in the global config (similar to log_all_ref_updates).
>
> That is part of the whole story:
> In general, "git init" probes the file system, if the executable bit
> is working as expected.
> So if you  create a Git repository under VFAT, the executable bit is =
not supported.
>
> Git will notice that, and set core.filemode =3D false.
>
> NTFS is a different story:
> Cygwin has support for the executable bit under NTFS, but Msysit does=
 not.

Agreed. That is what I concluded from the code.

> So if you "share" a Git repository between Msysgit and cygwin, it may=
 be better
> to set core.filemode to false.

Possibly. I would argue that that is up to the individual developer.

> There is however a problem with your patch, or 2:
>
> When you set core.filemode =3D false in your ~/.gitconfig,
> another developer may have core.filemode =3D true in his config.
> If you manage to share the repo using a network, git will behave diff=
erent
> for the 2 users.

Isn't that what everything in ~/gitconfig is for? So that I can set
attributes appropriate to my working environment? Besides, that is
already the case if developer A uses a VFAT system and developer B
uses NTFS or JFS or EXTn or ..., right? (As you also indicated above.)

> Solution:
> Set core.filemode for this repo alwways in the repo. (as we do today =
in git.git)

I suppose you could set it to false, yes. But then it affects
everybody, that seems like going for the lowest common denominator?

> When you run "git init" with ~/.gitconfig =3D true, you should
> anyway probe the file system, as it may not support file mode, and co=
re.filemode may be false.
>
>
> So the solution that I can see is:
> (Some pseudo-code:)
>
> if (git config (global config ) =3D=3D false) ||
>    (git config (~/.config ) =3D=3D false) then
>   git_config_set("core.filemode", "false");
> else
>   probe the file system and set core.filemode as we do today
> fi

Yeah, I actually considered that (well, something less complete,
actually :-) ) but decided to go for the simpler approach that I
showed. My assumption is that the developer working with the repo
knows what he is doing. It seems wrong for Git to override that
decision. Then again, I don't really see any advantage in setting
core.filemode to true when working with, say, a VFAT filesystem, so
ignoring it in that case might be okay. Would such a setup do active
damage, though?

>> The usual caveat applies: this is my first patch. Having said that,
>> please feel free to be pedantic and strict. It's a small patch so I
>> would imagine that fixing any problems should not take long (assumin=
g
>> it is acceptable at all, of course). I'd like to know I did it right=
=2E
>> :-)
>>
>> AFAICT, all tests passed. Should a separate test be added for this c=
hange?
> I think yes.

Okay, I'll have to figure out how to do that.

> Under which system did you test ?
>
> Windows?
> CYWGIN ?
> MingWW/Msysgit ?
> Linux ?

Only Linux. I don't really run Windows at home.

>> - /* Check filemode trustability */
>> - filemode =3D TEST_FILEMODE;
>> - if (TEST_FILEMODE && !lstat(path, &st1)) {
>> - struct stat st2;
>> - filemode =3D (!chmod(path, st1.st_mode ^ S_IXUSR) &&
>> - !lstat(path, &st2) &&
>> - st1.st_mode !=3D st2.st_mode);
>> + /* Do not override the global filemode setting. */
>> + if (trust_executable_bit =3D=3D -1) {
>> + /* Check filemode trustability */
>> + filemode =3D TEST_FILEMODE;
>> + if (TEST_FILEMODE && !lstat(path, &st1)) {
>> + struct stat st2;
>> + filemode =3D (!chmod(path, st1.st_mode ^ S_IXUSR) &&
>> + !lstat(path, &st2) &&
>> + st1.st_mode !=3D st2.st_mode);
>> + }
>> + git_config_set("core.filemode", filemode ? "true" : "false");
> The indentation seems to be broken ?
> (We use one TAB, for better info please see Documentation/CodingGuide=
lines)
> [snip]

I did. :-) I followed an online tutorial geared to Google mail to
basically run git format-patch | git imap-send but the end result did
not have the tabs that I have in the code. I'll have to research it a
bit more then.

Cheers,
Hilco
