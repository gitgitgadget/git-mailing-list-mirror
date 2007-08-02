From: David Kastrup <dak@gnu.org>
Subject: Re: minor makefile issues
Date: Thu, 02 Aug 2007 21:00:55 +0200
Message-ID: <853az1223c.fsf@lola.goethe.zz>
References: <46B21CB9.9050303@nuovasystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joe Eykholt <joe@nuovasystems.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 21:01:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGfv7-0004Il-AB
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 21:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbXHBTBG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 15:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbXHBTBE
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 15:01:04 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:57520 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752263AbXHBTBC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Aug 2007 15:01:02 -0400
Received: from mail-in-07-z2.arcor-online.net (mail-in-07-z2.arcor-online.net [151.189.8.19])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 0DA5812FF2;
	Thu,  2 Aug 2007 21:01:00 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-07-z2.arcor-online.net (Postfix) with ESMTP id EC3372C6A1A;
	Thu,  2 Aug 2007 21:00:59 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-024-023.pools.arcor-ip.net [84.61.24.23])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id BDA0930A940;
	Thu,  2 Aug 2007 21:00:59 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 6CC6B1D0344E; Thu,  2 Aug 2007 21:00:56 +0200 (CEST)
In-Reply-To: <46B21CB9.9050303@nuovasystems.com> (Joe Eykholt's message of "Thu\, 02 Aug 2007 11\:04\:41 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3847/Thu Aug  2 13:26:26 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54586>

Joe Eykholt <joe@nuovasystems.com> writes:

> Hi All,
>
> Due to my unusual environment, I ran into two issues when installing
> git 1.5.2.4 from source.
> Although these are unusual, they might not be unique and the fixes are easy:
>
>    1.  The make install failed because of line 49 in templates/Makefile:
>           (cd blt && $(TAR) cf - .) | \
>           (cd '$(DESTDIR_SQ)$(template_dir_SQ)' && $(TAR) xf -)
>    because I have CDPATH set, the 'cd blt' actually outputs the new
> directory on stdout
>    which confuses the second tar.  Changing this to 'cd ./blt' fixes
> it.  Perhaps this could
>    be considered a bash bug.

No, it is a user bug.  You don't want a script to _ever_ walk around
on its own volition, so you must _not_ export CDPATH.  Instead, set it
in .bashrc without exporting it.  That way, it will be available with
every interactive shell, and not interfering with scripts.

>    2.  My home directory containing my build tree is NFS-mounted, and
> root doesn't have any
>    permission to write it.  So, when doing 'make prefix=/usr/local
> install-doc' as root, I got these errors:
>
>    # make prefix=/usr/local install-doc
>    make -C Documentation install
>    make[1]: Entering directory
> /net/da01/home/jre/build/git-1.5.2.4/Documentation'
>    rm -f doc.dep+ doc.dep
>    rm: cannot remove `doc.dep': Permission denied
>    make[1]: *** [doc.dep] Error 1
>    make[1]: Leaving directory
> /net/da01/home/jre/build/git-1.5.2.4/Documentation'
>    make: *** [install-doc] Error 2
>
> I'm not sure what the best fix is for the second problem.  rm -f
> ignores non-existent files but not permission errors.
> I guess you could do 'rm -f doc.dep || true'.

First do "make doc" for your normal user, then make doc-install as
root.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
