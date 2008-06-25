From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: update-index --assume-unchanged doesn't make things go fast
Date: Wed, 25 Jun 2008 12:30:21 -0700 (PDT)
Message-ID: <m33an1josg.fsf@localhost.localdomain>
References: <32541b130806250944x717cf609x7aa520c77a7c6911@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 21:31:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBaiA-0006z7-0F
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 21:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168AbYFYTa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 15:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755661AbYFYTaZ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 15:30:25 -0400
Received: from ik-out-1112.google.com ([66.249.90.182]:47337 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755217AbYFYTaY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 15:30:24 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1741223ika.5
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 12:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=BbFw2CVZ5aN8teEvCdjfPEJp0lmu7phuKI2+8gVxtVU=;
        b=uTjOcFSgpB5sLuWYEV5cXtyNRXzd3L9JQHnQtxSZP5DYwcrhKwqqs5y4jWBinsXhpH
         4b+MOTbCDamws956ttzhkhefoaUwLaxD6om/PfNWt1cmZasOxgZEihQHIYhJIRhpSrou
         ZJJaFosVbY4iGaj5dLY2NpNobFqEs3cfaPMxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Ja/kZ2592P1n7GBWhy/Ed/1J6SVtCimy048pDSDBUvSI7g6IZG8yJYOyFx9kv/xJ2S
         y/P9PVnujQ/OBS86iyY0PKe3JZtI1egkqWnlg55jddTurrYbn3SGcqB96EaYl/3fAAEL
         6G/KtTcoq+3NY+GHzok6bsM5em/FnSM0qYpxc=
Received: by 10.210.133.19 with SMTP id g19mr2193893ebd.83.1214422222235;
        Wed, 25 Jun 2008 12:30:22 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.220.164])
        by mx.google.com with ESMTPS id i8sm1942202nfh.20.2008.06.25.12.30.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Jun 2008 12:30:21 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5PJUFY6017220;
	Wed, 25 Jun 2008 21:30:16 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5PJU8C3017215;
	Wed, 25 Jun 2008 21:30:08 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <32541b130806250944x717cf609x7aa520c77a7c6911@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86327>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> Hi all,
> 
> Using git 1.5.6.64.g85fe, but this applies to various other versions
> I've tried.
> 
> I have a git repo with about 17000+ files in 1000+ directories.  In
> Linux, "git status" runs in under a second, which is perfectly fine.
> But on Windows, which can apparently only stat() about 1000 files per
> second, "git status" takes at least 17 seconds to run, even with a hot
> cache.  (I've confirmed that stat() is so slow on Windows by writing a
> simple program that just runs stat() in a tight loop.  The slowness
> may be cygwin-related, as I found some direct Win32 calls that seem to
> go more than twice as fast... which is still too slow.)

Which git version do you use? Does it have the following configuration
variable (also available as command option):

  status.showUntrackedFiles::
        By default, linkgit:git-status[1] and linkgit:git-commit[1] show
        files which are not currently tracked by Git. Directories which
        contain only untracked files, are shown with the directory name
        only. Showing untracked files means that Git needs to lstat() all
        all the files in the whole repository, which might be slow on some
        systems. So, this variable controls how the commands displays
        the untracked files. Possible values are:

        - 'no'     - Show no untracked files
        - 'normal' - Shows untracked files and directories
        - 'all'    - Shows also individual files in untracked directories.

HTH.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
