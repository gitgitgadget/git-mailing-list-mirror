X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Trouble with git-svn when upstream svn URL changed
Date: Fri, 8 Dec 2006 11:13:01 -0800
Message-ID: <20061208191301.GA13944@localdomain>
References: <m21wnai8qe.fsf@ziti.local> <20061208181109.GA10475@localdomain> <m2wt52fd8p.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 19:13:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <m2wt52fd8p.fsf@ziti.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33723>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GslAK-0006xY-M1 for gcvg-git@gmane.org; Fri, 08 Dec
 2006 20:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1426142AbWLHTNG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 14:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426145AbWLHTNF
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 14:13:05 -0500
Received: from hand.yhbt.net ([66.150.188.102]:47733 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1426144AbWLHTND
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 14:13:03 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 6C35B2DC034; Fri,  8 Dec 2006 11:13:01 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 08 Dec 2006
 11:13:01 -0800
To: Seth Falcon <sethfalcon@gmail.com>
Sender: git-owner@vger.kernel.org

Seth Falcon <sethfalcon@gmail.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> > This is incorrect, rebuild is not designed to handle new urls.  
> 
> ok, I was lead astray by this part of the doc for rebuild:
> 
>          A Subversion URL may be optionally specified at the
>          command-line if the directory/repository you're tracking has
>          moved or changed protocols.

Hmm..  it seems that rebuild will work as intended iff you didn't clone
(and therefore still have .git/svn/git-svn/.rev_db intact).  Otherwise,
it will rebuild the .rev_db file and ignore your specified URL.  Perhaps
running rebuild twice (specifying the URL on a second clone) after a
clone would work.  I honestly haven't used or looked at rebuild in a
while.

> > However, git/git-svn are very flexible beasts :)
> >
> >> I guess I can create a fresh git repos using git-svn init and then
> >> fetch all of my dev branches from the original repository.
> >
> > You can look at "Advanced Example: Tracking a Reorganized Repository"
> > in the manpage.  Ignore the text about --follow-parent since you
> > already have the old stuff fetched, and start following the instructions
> > beginning with "# And now, we continue tracking the new revisions:"
> 
> Oh, sorry I didn't find that example.  This worked perfectly, thanks!
> 
> One question: My fingers are in the habit of typing remotes/git-svn.
> Can I do:
>    cd .git/svn
>    rm -r git-svn
>    mv git-newsvn git-svn
> 
> Or is there a safer way to rename?  Or are there other config-file
> ways to make this work -- to provide an alias?

You need to mv refs/remotes/git-newsvn refs/remotes/git-svn, too.  Then
it should be safe.

-- 
