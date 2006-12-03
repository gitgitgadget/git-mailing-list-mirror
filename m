X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and empty directories in svn (was: [PATCH 1.2/2 (fixed)] git-svn: fix output reporting from the delta fetcher)
Date: Sat, 2 Dec 2006 17:47:56 -0800
Message-ID: <20061203014756.GE1369@localdomain>
References: <loom.20061124T143148-286@post.gmane.org> <20061128054448.GA396@soma> <20061128102958.GA5207@soma> <20061128105017.GA20366@soma> <9e7ab7380611280445r4ebe344cw69cbc18a74c6122f@mail.gmail.com> <9e7ab7380611280732k4e940380tbf2a96146807d671@mail.gmail.com> <m2bqmr1rnw.fsf@ziti.fhcrc.org> <20061128201605.GA1369@localdomain> <m2slg2rzzj.fsf_-_@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 3 Dec 2006 01:48:12 +0000 (UTC)
Cc: Pazu <pazu@pazu.com.br>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <m2slg2rzzj.fsf_-_@ziti.fhcrc.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33079>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqgSe-000631-CF for gcvg-git@gmane.org; Sun, 03 Dec
 2006 02:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424760AbWLCBr6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 20:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759470AbWLCBr6
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 20:47:58 -0500
Received: from hand.yhbt.net ([66.150.188.102]:14234 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1758633AbWLCBr6 (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 20:47:58 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id C72EB2DC034; Sat,  2 Dec 2006 17:47:56 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 02 Dec 2006
 17:47:56 -0800
To: Seth Falcon <sethfalcon@gmail.com>
Sender: git-owner@vger.kernel.org

Seth Falcon <sethfalcon@gmail.com> wrote:
> Hi Eric, and list,
> 
> Eric Wong <normalperson@yhbt.net> writes:
> > Seth Falcon <sethfalcon@gmail.com> wrote:
> >> I think that presently git-svn does not create empty dirs when pulling
> >> from svn.  It would be nice to have such directories created since
> >> some projects will expect the empty dir to be there (no need to track
> >> it in git, IMO).
> >
> > Git itself cannot easily track empty directories (at least as far as
> > update-index and checkout) goes.
> >
> > What I *can* do is run mktree and to force the creation of tree objects
> > with a 4b825dc642cb6eb9a060e54bf8d69288fbee4904 (empty) sub tree and run
> > commit-tree on it, but checkout/checkout-index would still need to be
> > modified to support it.
> >
> > Is that something the git community wants?
> 
> I recently encountered a situation where code wasn't working for me
> because git-svn didn't create an empty dir that is present in svn.
> 
> I'm not trying to argue for the sense/anti-sense of tracking empty
> dirs in an scm, but I think this is an issue worth addressing in some
> fashion.  Here's why.
> 
> I think there are many potential git users out there who are currently
> svn users.  And git-svn is a really nice way to get started, but this
> sort of stumbling block could really turn people off.  For example, it
> made me look pretty dumb when I carelessly complained to my colleague
> about his code not working and then it turns out to be because my
> super-advanced scm tool "messed things up".
> 
> One simple thing (I think it would be simple) is that git-svn could
> issue a loud warning when it encounters an empty directory that it is
> going to ignore.
> 
> I don't understand the implications adding the tracking of empty dirs
> to git.  I suspect it has been discussed before, but haven't yet gone
> fishing in the list archives.  I imagine it would make the argument
> easier for folks wanting to switch a project from svn to git if this
> wasn't one of the differences.  For good or bad, I've often heard this
> svn feature as a motivator to switch from cvs.

I agree that missing empty directories when tracking foreign SVN repos
is annoying.  I've looked into this a bit more; but ended up
trying to reinvent the index :x

Since git-svn misses some other stuff (many property settings,
externals) I'll be working on an internal logging format that can help
track those things.  It'd be nice to have a command like git svn
checkout which works like git checkout; but empty directories are
created.

-- 
