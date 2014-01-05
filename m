From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: [PATCH 2/2] Introduce git submodule attached update
Date: Sun, 5 Jan 2014 22:46:11 +0100
Message-ID: <CALas-ijjzyRVuc0NaAS5QS98pX2198mv4HoHDacgYFYNLXbXFw@mail.gmail.com>
References: <1388890249-3577-1-git-send-email-ceztko@gmail.com>
 <1388890249-3577-2-git-send-email-ceztko@gmail.com> <20140105203349.GB3737@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Jan 05 22:46:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzvWn-0005kA-4S
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 22:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbaAEVqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 16:46:32 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:45047 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbaAEVqc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jan 2014 16:46:32 -0500
Received: by mail-ob0-f173.google.com with SMTP id gq1so17500433obb.4
        for <git@vger.kernel.org>; Sun, 05 Jan 2014 13:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=F6sbZ+xGJwl6h0Lv5sueFFpF8iDVOBvAfPeM4xU6BaE=;
        b=zGoAKIG3jqdU8gIrBK6nlY2cR9oUFqmmXDW0YsY+l5wbmbTWViKCOEJ4rMDXYPmVDH
         4M/W8lSOCqDg2HEQIi+n7Rv+7TxhSqsmHMTj0y9s4K6ZWOyhi5VhJEdIV/bayxcnzvsN
         UFpH8mx2HNNB82XRQ4loymPhG3SGMW5yl4Y1xwuk5djX5Iz+oS5edcqKThwip+VfMuL/
         IHeEhT4EsiXTMTttv/5AmkjCKimzwWMmJVrLCTkpICZsMvxxKlysN6Rs162n5BpQqBN6
         xeU6zdklf4ITz9TYuxHplcuJNI9T+Rzs0BQP5mOQ3b6ouAJcAW9L9DNdRZ1GcHItSE8g
         bOHA==
X-Received: by 10.182.241.8 with SMTP id we8mr164541obc.62.1388958391353; Sun,
 05 Jan 2014 13:46:31 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Sun, 5 Jan 2014 13:46:11 -0800 (PST)
In-Reply-To: <20140105203349.GB3737@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239975>

2014/1/5 Heiko Voigt <hvoigt@hvoigt.net>:
>
> Could you please extend the description of your use-case so we can
> understand your goal better?
>

Just in case you missed the first patch iteration[1].

> The following questions directly pop into my mind:
>
>  - What means the maintainer does not track the submodules sha1? Does
>    that mean the superproject always refers to submodule commits using
>    branches?

It means he doesn't need to control other developers commit to be
checked out so he sets "submodule.<name>.ignore" to "all". In this way
he and the developers can work actively in their submodule copy.

>  - What happens if you want to go back to an earlier revision? Lets say
>    a tagged release? How is ensured that you get the correct revision in
>    the submodules?

"submodule.<name>.branch" is one setting that is not copied in
".git/config" by "git submodule init". "git submodule update" will use
the setting in ".gitmodules" if not overridden voluntarily by the
developer in ".git/config". The maintainer can change that setting in
".gitmodules" and commit the change. Modifies will be propagated by
the next "git pull && git submodule update" of the developer in the
superproject.

>  - In which situations does the developer or maintainer switch between
>    your attached/detached mode?

The developer/maintainer does so optionally and voluntarily and it
effects only its private working tree.

>  - What is the "repository branch" which is given to the developer by
>    the maintainer used for? Who creates this branch and who merges into
>    it?

The branch of course must exist prior submodule adding. In this
use-case it does not really matter who creates it and who merges into
it. Everyone with the right to merge into it has to work in the
submodule seamlessly, as it was working on separate clone of the same
repository used as the submodule.

>  - What are these subsequent "merge" or "rebase" update operations? Do
>    you mean everyone has submodule.name.update configured to merge or
>    rebase?
>

subsequent "merge" or "rebase" update operations are just the ones
after the initial clone/checkout, nothing particular.

Greetings,
Francesco

[1] http://marc.info/?l=git&m=138836829531511&w=2
