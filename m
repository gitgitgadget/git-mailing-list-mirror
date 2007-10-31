From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Recording merges after repo conversion
Date: Wed, 31 Oct 2007 09:43:29 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710310928490.3340@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0710090807060.26773@ds9.cixit.se>
 <200710311537.30384.johan@herland.net> <Pine.LNX.4.64.0710311503120.4362@racer.site>
 <200710311621.09845.johan@herland.net>
 <Pine.LNX.4.64.0710311553510.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Peter Karlsson <peter@softwolves.pp.se>,
	Lars Hjemli <hjemli@gmail.com>,
	Benoit SIGOURE <tsuna@lrde.epita.fr>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 17:45:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InGge-0006yN-Ns
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 17:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757007AbXJaQol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 12:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756989AbXJaQol
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 12:44:41 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49578 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756929AbXJaQoj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Oct 2007 12:44:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9VGhUIj031333
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 31 Oct 2007 09:43:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9VGhTxW012488;
	Wed, 31 Oct 2007 09:43:29 -0700
In-Reply-To: <Pine.LNX.4.64.0710311553510.4362@racer.site>
X-Spam-Status: No, hits=-2.731 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62848>



On Wed, 31 Oct 2007, Johannes Schindelin wrote:
> 
> Seriously, your proposal does not make any sense.  If you have to set up a 
> hook to get the _sane_ behaviour, something is really wrong.  So I do not 
> really understand why you brought up this idea here and now.

Well, I think this does kind of have some commonality with another issue 
that has come up before: git clone only clones the really core repository 
data.

That's generally a big feature, and I think it's absolutely the correct 
thing to do.

But I can also see that sometimes, you might want to clone more than the 
actual repository, and get things like SVN metadata, branch reflogs, 
various hooks and all the config options too.

Of course, in practice, at least right now, the right thing to do for that 
is to just do a recursive filesystem copy and then a "git status", but I 
think the background here is that some people simply do end up wanting to 
transfer more infrastructure than just the actual repository data.

One thing to note: one reason for *not* allowing that is that incremental 
upgrades of non-repo data is obviously not possible. You might be able to 
*clone* a repo with config info and other metadata (if nothing else, then 
by just doing that raw filesystem copy), but you will never ever be able 
to _fetch_ the updates, because they aren't part of the core repository, 
and aren't versioned.

So I think I can understand why some people would want to do things like 
this, but I do think it's broken. Yes, you can make the grafts file (or 
the config file) be part of the repo, and even just add a symlink to your 
.git/ directory, but it's simply not a very good model.

So I think it always does end up breaking (other people might rebase, and 
break your grafts, or just not want them in the first place, or they don't 
care about the same things, and mess up "your" configuration etc etc). So 
the git repo layout is designed to have the minimally required shared 
state, and not anything else.

		Linus
