From: Petr Baudis <pasky@suse.cz>
Subject: Re: Tracking CVS
Date: Thu, 22 Jun 2006 15:58:31 +0200
Message-ID: <20060622135831.GB21864@pasky.or.cz>
References: <9e4733910606220541y15d66fa6t33ab0c80ae05f764@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 22 15:58:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtPhc-0004w7-SD
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 15:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbWFVN6d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 09:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWFVN6d
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 09:58:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:13543 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030276AbWFVN6d (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 09:58:33 -0400
Received: (qmail 16674 invoked by uid 2001); 22 Jun 2006 15:58:31 +0200
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910606220541y15d66fa6t33ab0c80ae05f764@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22341>

Dear diary, on Thu, Jun 22, 2006 at 02:41:16PM CEST, I got a letter
where Jon Smirl <jonsmirl@gmail.com> said that...
> I'm tracking cvs using this sequence.
> 
> cvs update
> cg rm -a
> cg commit
> cg add -r .
> cg commit
> 
> Is there a way to avoid the two commits? If you do the add with out
> the intervening commit it just adds the files back.

I think the most straightforward way is:

	cvs update
	cg-rm -a
	cg-status -wns \? | xargs cg-add
	cg-commit

If you want to be careful about filenames polluted by non-newline
whitespaces,

	cg-status -wns \? | tr '\n' '\0' | xargs -0 cg-add

If you want to be safe even with filenames containing newlines, you need
to go at the Git level:

	git-ls-files -z --others | \
		xargs -0 git-update-index --add --

Perhaps we might make a special command which would sync the index set
with the working copy set...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
