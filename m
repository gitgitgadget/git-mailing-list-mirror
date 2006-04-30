From: sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH 3/3] fetch: optionally store the current remote
 information in the config
Date: Sun, 30 Apr 2006 10:30:46 -0400
Message-ID: <BAYC1-PASMTP08069B2CE6005391A1AFF9AEB00@CEZ.ICE>
References: <Pine.LNX.4.63.0604301524080.2646@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 30 16:35:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaD1K-0004ay-1c
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 16:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWD3OfZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 10:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWD3OfZ
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 10:35:25 -0400
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]:43781 "EHLO
	BAYC1-PASMTP08.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751139AbWD3OfY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 10:35:24 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP08.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 30 Apr 2006 07:39:43 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id DD63D644C28;
	Sun, 30 Apr 2006 10:35:22 -0400 (EDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-Id: <20060430103046.35c1385f.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.63.0604301524080.2646@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 30 Apr 2006 14:39:43.0859 (UTC) FILETIME=[EBB33430:01C66C63]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 30 Apr 2006 15:24:22 +0200 (CEST)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Instead of editing files, you can now say
> 
> 	git pull --store junio \
> 		git://git.kernel.org/pub/scm/git/git.git next:next
> 
> and next time, just
> 
> 	git pull junio
> 
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> ---
> 
> 	This is what the patch series is all about.
> 
> 	If there is no interest in a feature like this, let's just forget
> 	about the whole "remote info in config" thing.
> 
> 	If there is interest, I could add the same functionality to
> 	builtin-push.

Well I agree with you that doing something like this is important.  We
should take this moment of moving things to the config file to correct
the terminology and help make things clear.  We're not storing "Pull:"
information, we're storing config/remote.$NICK.fetch data.  It's really
used just by fetch, pull just happens to call fetch.

Along that same line of reasoning, it seems more appropriate to use 
git fetch --store ...  rather than git pull --store ... to set this
information.   And there needs to be a way to change and delete the 
nick information, perhaps git fetch store junio ""  would delete the
entry. Or maybe people should just be instructed to use git-repo-config
for setting, changing and deleting?

Pull needs additional logic that allows it to merge from the proper
local branch after it calls fetch.  Right now it just uses whatever 
fetch sets as FETCH_HEAD.  It's not clear to me what is set as 
FETCH_HEAD when multiple refs are fetched from the remote.  It'll 
be even more confusing once it's possible to fetch from multiple 
remotes at once.

As for these specific patches, it doesn't appear that your change to
builtin-push allows the push variable to hold more than one remote 
repo URI or even more than one refspec, or did I misread that?
Also it seems that the refspec is used from the config file even if
the user tries to override it by specifying an alternative on the
command line.

Sean
