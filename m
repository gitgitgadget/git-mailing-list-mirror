From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 09:29:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609270919220.3952@g5.osdl.org>
References: <20060927140918.65775.qmail@web51004.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 27 18:30:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GScHw-0008QU-C4
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 18:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWI0Q3d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 12:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWI0Q3d
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 12:29:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56460 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030236AbWI0Q3c (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 12:29:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8RGTNnW010051
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Sep 2006 09:29:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8RGTMvc031354;
	Wed, 27 Sep 2006 09:29:22 -0700
To: Matthew L Foster <mfoster167@yahoo.com>
In-Reply-To: <20060927140918.65775.qmail@web51004.mail.yahoo.com>
X-Spam-Status: No, hits=-0.468 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.154 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27912>



On Wed, 27 Sep 2006, Matthew L Foster wrote:
> 
> Perhaps git should record three(+) timestamps, adding when the change was committed into this
> repository?

If you ask for logging, that's exactly what you get.

Well, almost. 

You cannot connect the time to a _commit_, since a commit (very much by 
design) is totally immutable. Once you have created any git object, it's 
done. It can never be changed ever again, and this is not just a small 
detail, it's what the whole system builds up on, and it's where the 
security and trustworthiness fundamentally comes from (it's also where the 
naming scheme comes from - things are named by their contents, so if you 
were to ever change them again, they'd have to be renamed - they 
effectively _become_ something different).

Also, you fundamentally couldn't do it anyway, since the third time isn't 
actually even well-defined in a distributed manner. It only makes sense 
very much in a local way, and as such can never be part of the distributed 
data - and trying to add something like that to the commit would be 
fundamentally incorrect.

BUT.

What you CAN do is to connect (in any particular private repository) a 
_branch_update_ with the time it was done. That is Shawn Pierces "reflog" 
work - you can track a particular branch _locally_. It's purely local to 
that _one_ repository, though. It by definition makes no sense anywhere 
else, and it's not tracking commits, it's literally tracking how branches 
changed in a local copy.

To enable it, just add a

	[core]
		logAllRefUpdates=true

thing to your .git/config file (or, if you want to do it for _all_ the 
projects you track, you can just do it in your ~/.gitconfig file, and it 
should be the default for everything you do).

(Althernatively, you can choose to log just a _single_ branch by just 
creating the ".git/logs/refs/heads/<branchname>" file - git should start 
logging that branch automatically)

This is a reasonably new feature, so old git versions need not apply.

			Linus
