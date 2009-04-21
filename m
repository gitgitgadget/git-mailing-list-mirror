From: Sam Vilain <sam@vilain.net>
Subject: Re: reviving a git-svn clone
Date: Tue, 21 Apr 2009 18:51:52 +1200
Message-ID: <1240296712.3424.8.camel@maia.lan>
References: <20090420104316.GA11433@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Apr 21 08:53:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw9rP-0000CR-Uj
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 08:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbZDUGwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 02:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbZDUGwE
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 02:52:04 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:49284 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbZDUGwD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 02:52:03 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 5396121C326; Tue, 21 Apr 2009 18:51:45 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.182] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 9B4D321C31D;
	Tue, 21 Apr 2009 18:51:40 +1200 (NZST)
In-Reply-To: <20090420104316.GA11433@lapse.rw.madduck.net>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117097>

On Mon, 2009-04-20 at 12:43 +0200, martin f krafft wrote:
> I am now trying to revive the clone, but git-svn remains "unable to
> determine the upstream SVN information from the working tree
> history". This baffles me.
> 
> Here are my steps:

> -8<--8<--8<-
> alioth:~|master|% git clone /git/collab-maint/hibernate.git hibernate-svnsync
> Initialized empty Git repository in /srv/alioth.debian.org/chroot/home/users/madduck/hibernate-svnsync/.git/
> 
> alioth:~|master|% cd hibernate-svnsync
> 
> alioth:~/hibernate-svnsync|master|% git branch --no-track upstream origin/upstream
> 
> alioth:~/hibernate-svnsync|master|% cat >> .git/config <<_eof
> heredoc> [svn-remote "svn"]
> heredoc>        url = svn+ssh://svn.suspend2.net/svn/hibernate-script
> heredoc>        fetch = trunk:refs/remotes/upstream/trunk
> heredoc>        branches = branches/*:refs/remotes/upstream/*
> heredoc>        tags = tags/*:refs/remotes/upstream/tags/*
> heredoc> _eof

for git-svn to resume, it needs the refs all in the right place.  If you
clone a git-svn repository they will be in the wrong place.

eg for this use case something like this to copy the
refs/remotes/origin/* refs to refs/remotes/upstream/*:

  git for-each-ref --format="%(refname)" refs/remotes/origin/* |
     perl -le '$x = $_; $x =~ s{origin}{upstream};
       system "git update-ref $x $_"'

It's a bit hard to test without access to the upstream svn!

Good luck,
Sam.
