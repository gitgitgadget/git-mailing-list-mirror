From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] wincred: add install target and avoid overwriting
 configured variables
Date: Wed, 30 Apr 2014 11:21:17 +0200
Message-ID: <CABPQNSZsviaGqFeKZE4ofF6HoUQrPvNPuowar4YDjk_Mbu5iCQ@mail.gmail.com>
References: <20140430064610.GA22094@camelia.ucw.cz>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Apr 30 11:22:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfQiU-00017O-0m
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 11:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758575AbaD3JWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 05:22:03 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:61382 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758570AbaD3JV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 05:21:59 -0400
Received: by mail-ie0-f179.google.com with SMTP id lx4so1601241iec.10
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 02:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=uSeQ4UFTfr2EI2cMCzqTDTtAGoSVxpidnZVoYDrfbKc=;
        b=lpbQTUNEs8LpZLEb7No1KJWCtCxtRLgUNpDF5kcoJzx8gVn2W6NXX0B096fuKbywto
         RT9d0zgDQ67xUZiHB8L9uzjBjbph5c9olxIyZ0mn2fnnwNixU35KUeDsiGhPABSQhyA0
         F0AipxXEzSyvvpxsuVFaY3k83AQ5BssIrk8sgGK7SBmumu81i7PEL+zsUs8g4yKouxeT
         0czkzGszB6dYgbv3n610qhwQV4/8dxS75WDERadNyfA42E60D6SqF0PZDO08m32jMA2x
         YEIe3KugFRj8SCN398EEBDK68xG6krIU/LncYFKvW0rbZON7kYZWhQLv4paMaa1aPxzM
         pvDg==
X-Received: by 10.50.85.18 with SMTP id d18mr3075665igz.42.1398849717401; Wed,
 30 Apr 2014 02:21:57 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Wed, 30 Apr 2014 02:21:17 -0700 (PDT)
In-Reply-To: <20140430064610.GA22094@camelia.ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247687>

On Wed, Apr 30, 2014 at 8:46 AM, Stepan Kasal <kasal@ucw.cz> wrote:
> From: Pat Thoyts <patthoyts@users.sourceforge.net>
> Date: Wed, 24 Oct 2012 00:15:29 +0100
>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> ---
> Another one from msysGit project.
> Original subject by Pat; I would suggest:
>     wincred: improve Makefile

I'm a little bit unsure about this, because the makefile was basically
just copied from contrib/credential/osxkeychain/Makefile (which was
the first credential helper) and tweaked slightly.

So, what makes wincred special compared to gnome-keyring, netrc and
osxkeychain wrt installation? Shouldn't all helpers get the same
treatment?

>  contrib/credential/wincred/Makefile | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/contrib/credential/wincred/Makefile b/contrib/credential/wincred/Makefile
> index bad45ca..3ce6aba 100644
> --- a/contrib/credential/wincred/Makefile
> +++ b/contrib/credential/wincred/Makefile
> @@ -1,14 +1,20 @@
> -all: git-credential-wincred.exe
> -
> -CC = gcc
> -RM = rm -f
> -CFLAGS = -O2 -Wall
> -
>  -include ../../../config.mak.autogen
>  -include ../../../config.mak
>
> -git-credential-wincred.exe : git-credential-wincred.c
> +prefix ?= /usr/local
> +libexecdir ?= $(prefix)/libexec/git-core
> +
> +INSTALL ?= install
> +
> +GIT_CREDENTIAL_WINCRED := git-credential-wincred.exe

Why this variable? IMO, it's just as "GIT_CREDENTIAL_WINCRED" easy to
miss-spell as "git-credential-wincred.exe", and it doesn't seem to be
possible to overload.

> +
> +all: $(GIT_CREDENTIAL_WINCRED)
> +

Also, why move the all-target down from the top? Is it simply because
of the definition above?
