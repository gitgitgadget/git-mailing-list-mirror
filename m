From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: [PATCH 2/2] Introduce git submodule attached update
Date: Mon, 6 Jan 2014 00:22:23 +0100
Message-ID: <CALas-ijydCqhx5mgmMkcBE73TqNVckRooZ5x22uSq1Ldm4CGDA@mail.gmail.com>
References: <1388890249-3577-1-git-send-email-ceztko@gmail.com>
 <1388890249-3577-2-git-send-email-ceztko@gmail.com> <20140105203349.GB3737@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Jan 06 00:22:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vzx1t-0007G4-Lv
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 00:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbaAEXWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 18:22:45 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:37157 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbaAEXWo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jan 2014 18:22:44 -0500
Received: by mail-ob0-f175.google.com with SMTP id uz6so17550673obc.20
        for <git@vger.kernel.org>; Sun, 05 Jan 2014 15:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EZBaYlUvUEkmAXeZpd0Cl4kkG/ExTCyf9c6dYzES1j8=;
        b=I2hLxC0/1+0Tj4znG4LvXXa8+eR+ZbbynJYU0MdNnHOclH55NXJN5edRhhMGMCDmkT
         OarsWcunJkKBMJEykqwVhKjuiYp5MtbLeSvUa2FT3qy1oL7oh6IADXfzcKMt45Z8H1iH
         +bZC4S7voPXY6iP7mvfD6tyeFgJaZNDeec+sLA+iNSd0G6P+gLzwqnW/3a/hV3cnYId4
         Mm3/m2nGIPWB4F5wMIqpLZXoWPJY9dy4YiqdLreG/VKnD+tjsWnI/c5gsEaKgBJK4sEL
         J8petQsajfw86yeZuyh90Ba3RVXSyttnyF+ChZ0/++BUoehFXDuN/7zzCa1OBrhTHvuu
         9SxQ==
X-Received: by 10.182.18.102 with SMTP id v6mr2512obd.71.1388964163631; Sun,
 05 Jan 2014 15:22:43 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Sun, 5 Jan 2014 15:22:23 -0800 (PST)
In-Reply-To: <20140105203349.GB3737@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239979>

2014/1/5 Heiko Voigt <hvoigt@hvoigt.net>:
> Could you please extend the description of your use-case so we can
> understand your goal better?
>

Maybe I found better words to explain you my goal: the current git
submodule use-case threats the submodule as a project independent
dependency. My use case threats the submodule as part of the
superproject repository. It could be easier to say that in this way
submodules would behave very similarly to "svn:externals", something
that is actually missing in git. My goal is obtain this without
altering git behavior for the existing use case.

>  - In which situations does the developer or maintainer switch between
>    your attached/detached mode?

As I told you in the other answer this is voluntary done by the
developer, as he prefers. I came to the conclusion that the
"--attach|--detach" switches for the "update" command are not that
useful and can be removed. It's still possible to obtain the switch
between detached/attached very easily in this way:

# Attach submodule
$ git config submodule.<name>.attached "true"
$ git submodule update

# Detach submodule
$ git config submodule.<name>.attached "false"
$ git submodule update

# Unset property in both ".gitmodules" and ".git/config" means -> do nothing
$ git config --unset submodule.<name>.attached
$ git submodule update

Also my "submodule.<name>.attached" property at the moment behaves
like "submodule.<name>.update": it is copied in ".git/config" by "git
submodule init". This is probably a mistake: the overridden value
should be stored in ".git/config" only at the developer will, so the
maintainer has still a chance to modify it in ".gitmodules" and
propagate the behavior.

I would send an updated patch but at this point I prefer to wait for a
full review.

Thank you,
Francesco
