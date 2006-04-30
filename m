From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] fetch: optionally store the current remote information
 in the config
Date: Sun, 30 Apr 2006 17:49:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604301743370.3641@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0604301524080.2646@wbgn013.biozentrum.uni-wuerzburg.de>
 <BAYC1-PASMTP08069B2CE6005391A1AFF9AEB00@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 30 17:49:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaEAk-00079S-3m
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 17:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWD3PtJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 11:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWD3PtJ
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 11:49:09 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:11456 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751148AbWD3PtI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 11:49:08 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id C8C49CDE;
	Sun, 30 Apr 2006 17:49:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id BC6C1CD3;
	Sun, 30 Apr 2006 17:49:06 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 9A85ABFB;
	Sun, 30 Apr 2006 17:49:06 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP08069B2CE6005391A1AFF9AEB00@CEZ.ICE>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19342>

Hi,

On Sun, 30 Apr 2006, sean wrote:

> On Sun, 30 Apr 2006 15:24:22 +0200 (CEST)
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > Instead of editing files, you can now say
> > 
> > 	git pull --store junio \
> > 		git://git.kernel.org/pub/scm/git/git.git next:next
> > 
> > and next time, just
> > 
> > 	git pull junio
> > 
> > Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > 
> > ---
> > 
> > 	This is what the patch series is all about.
> > 
> > 	If there is no interest in a feature like this, let's just forget
> > 	about the whole "remote info in config" thing.
> > 
> > 	If there is interest, I could add the same functionality to
> > 	builtin-push.
> 
> Well I agree with you that doing something like this is important.  We
> should take this moment of moving things to the config file to correct
> the terminology and help make things clear.  We're not storing "Pull:"
> information, we're storing config/remote.$NICK.fetch data.  It's really
> used just by fetch, pull just happens to call fetch.

I have no strong feelings either way.

> Along that same line of reasoning, it seems more appropriate to use 
> git fetch --store ...  rather than git pull --store ... to set this
> information.

Both works.

> And there needs to be a way to change and delete the nick information, 
> perhaps git fetch store junio ""  would delete the entry. Or maybe 
> people should just be instructed to use git-repo-config for setting, 
> changing and deleting?

The latter should be done, because "git fetch" really is about fetching, 
not playing games with the config.

> Pull needs additional logic that allows it to merge from the proper
> local branch after it calls fetch.  Right now it just uses whatever 
> fetch sets as FETCH_HEAD.  It's not clear to me what is set as 
> FETCH_HEAD when multiple refs are fetched from the remote.  It'll 
> be even more confusing once it's possible to fetch from multiple 
> remotes at once.

FETCH_HEAD can contain multiple refs. And I don't get the part about 
fetching from multiple remotes: my patch does not allow for that.

> As for these specific patches, it doesn't appear that your change to
> builtin-push allows the push variable to hold more than one remote 
> repo URI or even more than one refspec, or did I misread that?

But it does! Note the "uri_[current_uri++]" part of the patch.

> Also it seems that the refspec is used from the config file even if
> the user tries to override it by specifying an alternative on the
> command line.

No. It is only used when there were no refspecs specified on the command 
line:

        if (refspec_nr == 0)
                set_refspecs((const char**)refspecs_, current_refspec);


Ciao,
Dscho
