From: John Keeping <john@keeping.me.uk>
Subject: Re: git clone does not understand insteadOf URLs
Date: Sun, 26 May 2013 20:00:19 +0100
Message-ID: <20130526190019.GM27005@serenity.lan>
References: <51A11DD0.4040802@svario.it>
 <CA+EOSB=ow9Vc2J8qb3GAp4xj2GgY8qes=5Q-k-rH6VsVLjzCsg@mail.gmail.com>
 <51A24C75.3090100@svario.it>
 <87a9nhhb9c.fsf@hase.home>
 <51A24FF4.4010102@svario.it>
 <20130526181430.GL27005@serenity.lan>
 <51A252B9.7040008@svario.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Gioele Barabucci <gioele@svario.it>
X-From: git-owner@vger.kernel.org Sun May 26 21:00:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UggBF-0007UR-BV
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 21:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847Ab3EZTA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 15:00:29 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:36035 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673Ab3EZTA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 15:00:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 2E6A8606502;
	Sun, 26 May 2013 20:00:28 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PbYOLKRSXaGO; Sun, 26 May 2013 20:00:27 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id A81796064F1;
	Sun, 26 May 2013 20:00:27 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 9CB0A161E3A1;
	Sun, 26 May 2013 20:00:27 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vycqj2Lc1PJy; Sun, 26 May 2013 20:00:27 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 9F410161E3F9;
	Sun, 26 May 2013 20:00:21 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <51A252B9.7040008@svario.it>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225562>

On Sun, May 26, 2013 at 08:21:45PM +0200, Gioele Barabucci wrote:
> Il 26/05/2013 20:14, John Keeping ha scritto:
> > On Sun, May 26, 2013 at 08:09:56PM +0200, Gioele Barabucci wrote:
> >> Il 26/05/2013 20:00, Andreas Schwab ha scritto:
> >>>> Simple, I keep all my projects on the same server, so I would like to
> >>>> refer to that server + path using 'remote-repo'.
> >>>>
> >>>> "git+ssh://git.example.org//users/gioele/projects" insteadOf "remote-repo"
> >
> > In what way do you think that `git remote add` handles the path?
> >
> > All `git remote add` does is add a new "remote.<name>.url" entry to the
> > configuration file with the value as given on the command line.  The
> > insteadOf mapping will only be applied when you try to fetch from/push
> > to the remote.
> 
> Regardless of the implementation of the commands, if I do
> 
>      mkdir projectA
>      cd projectA
>      git init .
>      git remote add origin remote-repo/projectA.git
>      git pull origin master
> 
> I get a working repository. If I do
> 
>      git clone remote-repo/projectA.git
> 
> all I will get is an error.

So the problem is that "git clone" does not seem to perform normal
remote processing if you give it something that looks like a path.

More specifically, it looks like the problem is that if you give clone
something that does not contain a colon (':') it considers it to be a
local path and dies if that path does not exist.  Adding a colon as
Andreas suggested makes it look like a remote URL so it will be handled
correctly.
