From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git ls-files -o under .git/ prints all repository files
Date: Fri, 19 Jan 2007 11:38:04 +0100
Message-ID: <81b0412b0701190238o79ce8473t2faf1a797565bc5d@mail.gmail.com>
References: <87r6trsu7n.wl@mail2.atmark-techno.com>
	 <7vwt3jjywc.fsf@assigned-by-dhcp.cox.net>
	 <45B07875.9030506@fs.ei.tum.de>
	 <81b0412b0701182357l3a6d44fel58da50c7895fb6b4@mail.gmail.com>
	 <45B07C26.4000008@fs.ei.tum.de>
	 <81b0412b0701190032w686c9403uacd9b3e1e44be307@mail.gmail.com>
	 <45B0898B.5040804@fs.ei.tum.de>
	 <81b0412b0701190133o70ab9da3ga0441e9ca16991a9@mail.gmail.com>
	 <45B09926.5060306@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Yasushi SHOJI" <yashi@atmark-techno.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 13:59:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7tLU-0005Ue-H9
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 13:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbXASM7s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 07:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbXASM7s
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 07:59:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:19709 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965114AbXASM7r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 07:59:47 -0500
Received: by ug-out-1314.google.com with SMTP id 44so450384uga
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 04:59:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hk2ZPGKUALwY7evmjE2a55NOK4asksCDWkk9KL08OtJ4J4Ylk+OvOfQlPmc6GNDHy7L2lUX5Zh/KbSRysAD3TQSTuJEGk2B9zgB+IeEvaCstKgJOMOMFxOZxpjL5zsBJ9HlFRKY5nnyEKqVoNLRGFR5e4sG7GFAbxhJngZPQ4os=
Received: by 10.78.171.20 with SMTP id t20mr178094hue.1169203084893;
        Fri, 19 Jan 2007 02:38:04 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Fri, 19 Jan 2007 02:38:04 -0800 (PST)
To: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>
In-Reply-To: <45B09926.5060306@fs.ei.tum.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37180>

On 1/19/07, Simon 'corecode' Schubert <corecode@fs.ei.tum.de> wrote:
> Alex Riesen wrote:
> >> >> i would claim .git to be off limits and unrelated to the working dir
> >> >> (file-wise).  if you want to list files there, do a find . or so.
> >> >>  After all you wouldn't expect cd /usr && git-ls-files -o work there
> >> >> unless you have a /.git or /usr/.git, right?
> >> > Right, just see no practical point changing ls-file for that.
> >> right.  .git should be forbidden in higher layers already.
> >
> > That's where I disagree. git-clean shouldn't clean it, but
> > git-ls-files will do no harm to the directory
>
> of course git-ls-files will do no harm.  but "fixing" every consumer of
> git-ls-files seems wrong to me.

There are not that many users of ls-files, which could harm a repo.
Besides of git-clean, cannot think of any.

> okay, what do I expect when doing cd .git && git-ls-files?
>  Either listing *all files* in the repo (like git-ls-files from the
> repo root) or no files at all, or failure (".git is private").

List nothing. That's what it does. It could return non-0
(which it does not), but aside from that,... looks very sensible.

> NAME
>        git-ls-files - Information about files in the index/working directory
>
> That's pretty clear to me.  Working directory.  .git is *not* part of the working directory.
>

Alright, it is not. I can even imagine someone having a script
containing "git-ls-files -o| rm -f; git reset --hard" to get clean working dir,
and starting the script in .git one day. Make "-o" list nothing as well?

> > Works. And the path contains .git component. And git-clean
> > here is ok. The test should check if we are in $GIT_DIR
> > and probably $GIT_DIR/{objects,refs,logs}, not just below
> > .git (with ".git" anywhere in pwd, which the mercurial
> > example seem to suggest).
>
> No, the path does *not* contain a .git component.  You just
> committed to the root of the *inside* repo.

"$OLDPWD/.git/hooks". It does contain ".git" :)
