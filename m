From: =?UTF-8?Q?Beno=C3=AEt_Person?= <benoit.person@ensimag.fr>
Subject: Re: [PATCH/RFC 3/4] git-mw: Adding git-mw.perl script
Date: Sat, 15 Jun 2013 15:22:18 +0200
Message-ID: <CAETqRCidQpBu-Ws7wQ3xx73ozu0OQeeM7atptYg=ei8ZUXRbsA@mail.gmail.com>
References: <1371118039-18925-1-git-send-email-benoit.person@ensimag.fr>
	<1371118039-18925-4-git-send-email-benoit.person@ensimag.fr>
	<vpq4nd2rwq1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Jun 15 15:22:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnqRD-0004vA-5u
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 15:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283Ab3FONWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 09:22:21 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33484 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab3FONWT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 09:22:19 -0400
Received: by mail-ie0-f177.google.com with SMTP id aq17so3592558iec.36
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 06:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=IekI8ZhBfsTLlv2Yqj5bzE4KmkVbWbs/OAUP5lrkbCY=;
        b=YTIc2DbQpiYu3SgMVWWYJLZLJlGXxTdcB02MoOhbJ8EIbWB6JD9kiOrhWzz3rMFoOg
         GhiMjD8Ebk+O2Y4Jvry0D2gji2OCbZfkxJx50XrKzWVeUWRn7kgJCqMuYy+Oz75YbDZk
         kz6gc1QQdpfcE0xHdYsSfjDwnHPD36RxH5YO2zDvLQMDLEOA78IjklQlfZTR9TEn1Wtu
         I427JZTa8p+CmXr2FTSg6yHDAkFCNVuNxzoDU3UqPHusI1fWQGQEmjYcvrYD4tWFLYOq
         cePn0i0mubDZG09xRTjV93fgQ+1oxFn6u95mks/icPphgamCd2utYlEQFwQw4GycQEw4
         UxXQ==
X-Received: by 10.50.61.232 with SMTP id t8mr1046221igr.37.1371302538498; Sat,
 15 Jun 2013 06:22:18 -0700 (PDT)
Received: by 10.42.210.20 with HTTP; Sat, 15 Jun 2013 06:22:18 -0700 (PDT)
In-Reply-To: <vpq4nd2rwq1.fsf@anie.imag.fr>
X-Google-Sender-Auth: 987aFuhTSUhtLtpHXXNzyCLqm4o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227956>

The V3 is ready, but I am still not sure about what is the best way to
do it for this issue though.

On 13 June 2013 15:01, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> benoit.person@ensimag.fr writes:
> How does the "make" Vs "make install" work? How does a developer run the
> tool without installing?
Well it does not work without installing but I think you know that now :)

> I first tried:
>
> $ ../../bin-wrappers/git mw
> git: 'mw' is not a git command. See 'git --help'.
>
> Then, this first seem OK:
>
> $ ./git-mw
> usage: git mw <command> <args>
>
> git mw commands are:
>     Help        Display help information about git mw
>     Preview     Parse and render local file into HTML
>
> BUT, this will take the installed GitMediawiki.pm if it is available,
> and we don't want this (if one hacks GitMediawiki.pm locally, one wants
> the new hacked to be taken into account without "make install"ing it).
>
> To understand better how it works, try adding this in git-mw.perl:
>
>   print "$_\n" for @INC;
>
> I get this:
>
> /home/moy/local/usr-squeeze/share/perl/5.14.2
> /home/moy/local/usr-squeeze/src/MediaWiki-API-0.39/blib/lib
> /etc/perl
> /usr/local/lib/perl/5.14.2
> /usr/local/share/perl/5.14.2
> /usr/lib/perl5
> /usr/share/perl5
> /usr/lib/perl/5.14
> /usr/share/perl/5.14
> /usr/local/lib/site_perl
> .
>
> The '.' is there, but it comes after the hardcoded
> /home/moy/local/usr-squeeze/share/perl/5.14.2 (which has to comes first,
> to let the install version be robust to whatever comes after).
Thanks for the explanations

> I think you need an equivalent of Git's toplevel bin-wrappers/git, or
> perhaps use the same bin-wrapper/git but let "make install" in
> contrib/mw-to-git/ install GitMediawiki.pm in perl/blib/lib
Typo s/make install/make/ ?

For now, I have implemented that one : each time you do `make`, if
there is changes in GitMediawiki.pm, it gets copied to $GITPERLLIB
(perl/blib/lib). But I am not sure it's the best approach here. If we
want something entirely self-contained for GitMediawiki, creating a
new git wrapper seems like the best way. But then, we could say that
since GitMediawiki Makefile uses Git toplevel Makefile, it's not
entirely self-contained :/ maybe it's the "copying file" that makes it
weird ?

> BTW, I just noticed we had a Git::SVN, so perhaps GitMediawiki should be
> Git::MediaWiki.
For that one, I am not really sure Git::Mediawiki makes more sense
than GitMediawiki. The point of the GitMediawiki.pm package is to
contain all the stuff for the bidirectionnal-thingy. So they are not
really Git-related, nor Mediawiki-related. Making it part of a "Git"
directory / namespace does not really feels right, even if it's how
it's done for SVN :/ .

Thank you for the all the reviews, (it works for Ensiwiki now \o/)

Benoit Person
