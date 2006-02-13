From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-cvsserver & push/commit atomically
Date: Mon, 13 Feb 2006 01:17:23 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602130110590.21465@wbgn013.biozentrum.uni-wuerzburg.de>
References: <46a038f90602121550v4f487edfs788885a78c1b167@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, martyn@catalyst.net.nz
X-From: git-owner@vger.kernel.org Mon Feb 13 01:17:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8RPD-0005Mu-Bf
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 01:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWBMARZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 19:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWBMARZ
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 19:17:25 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:58349 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751464AbWBMARY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 19:17:24 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CD3A3146507; Mon, 13 Feb 2006 01:17:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id BF9839C5;
	Mon, 13 Feb 2006 01:17:23 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 15316146507; Mon, 13 Feb 2006 01:17:23 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90602121550v4f487edfs788885a78c1b167@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16031>

Hi,

On Mon, 13 Feb 2006, Martin Langhoff wrote:

>  - precondition: all the relevant objects are already in the repo
>  - reads old sha1
>  - creates repo.git/refs/<headname>.lock file with new sha1
>  - compares old and current head
>  - runs update hooks
>  - renames repo.git/refs/<headname>.lock into repo.git/refs/<headname>
> 
> So it is mostly race-safe, except for the window while we are running
> update hooks. Only a misbehaving implementation that doesn't fail on
> the creation of repo.git/refs/<headname>.lock  would affect us there,
> though. Would locking repo.git/refs/<headname> make sense?

Correct. The filesystem way to lock is to create a lock file and fail if 
it already exists. Since you are doing something akin to git-commit, I 
think you *must* lock repo.git/refs/<headname>.

> git-cvsserver commits are likely to be slow (not only likely, they
> _are_ slow right now), so we need a way to block other clients for a
> relatively long time.

I don't think there is a way around that. Of course, you could write the 
objects first without locking. But then you probably have loose objects in 
the repository if the commit fails due to another commit in the meantime.

<becomessweatyhands>
	BTW when are we going to see git-cvsserver?
</becomessweatyhands>

Ciao,
Dscho
