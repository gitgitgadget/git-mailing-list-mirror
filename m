From: Matthias Hopf <mhopf@suse.de>
Subject: git-rebase nukes multiline comments
Date: Fri, 16 Jun 2006 19:12:51 +0200
Message-ID: <20060616171251.GA29820@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: xorg@lists.freedesktop.org
X-From: git-owner@vger.kernel.org Fri Jun 16 19:13:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrHsO-0007TB-Pj
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 19:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWFPRMy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 13:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWFPRMy
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 13:12:54 -0400
Received: from ns2.suse.de ([195.135.220.15]:35303 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750915AbWFPRMx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 13:12:53 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 289291EBD8;
	Fri, 16 Jun 2006 19:12:52 +0200 (CEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org, xorg@lists.freedesktop.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21949>

Hi all,

I'm using git-1.2.4 on SL10.1, in centralized style development (for X.org).

I wanted to commit a set of changes (4 local commits) upstream, so I had
to do a git-rebase first (in that particular case a git-pull would have
been possible as well, but git-rebase fits the CVS style development
better). After git-fetch, git-rebase origin, and git-push all my changes
had only the first line of the changelog comment, the remainder was
nuked.

To reproduce:

mkdir /var/tmp/blaup
cd /var/tmp/blaup
git-init-db
echo test > foo
git-add foo
git-commit      (any comment)
cd ..
git-clone /var/tmp/blaup bla
cd bla
echo test2 >>foo 
git-commit foo  (multiline comment)
cd ../blaup
echo test3 >bar
git-add bar
git-commit      (any comment)
cd ../bla
git-fetch
git-log         (shows multiline comment for 'test2')
git-rebase origin
git-log         (shows only the first line of the multiline comment!)


I doubt this is intended behavior.


Also, while trying to reproduce this with the original upstream
repository, I would have had to git-fetch my origin branch (upstream
master), but not to get _all_ new commits, but only up to a certain
revspec (the one *before* my own commits).

I tried "git-fetch <refspec>:", but this didn't work, neither did
anything else I tried.  This is clearly beyond my understanding of git,
so how can this be done?

Thanks

Matthias

-- 
Matthias Hopf <mhopf@suse.de>       __        __   __
Maxfeldstr. 5 / 90409 Nuernberg    (_   | |  (_   |__         mat@mshopf.de
Phone +49-911-74053-715            __)  |_|  __)  |__  labs   www.mshopf.de
