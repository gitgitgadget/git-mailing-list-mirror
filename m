From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 08:25:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610190757100.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca>
 <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca>
 <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca>
 <87lkncev90.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	Jakub Narebski <jnareb@gmail.com>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 17:26:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaZmK-0002h7-JZ
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 17:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946111AbWJSPZt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 11:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946114AbWJSPZt
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 11:25:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63388 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946111AbWJSPZr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 11:25:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9JFPRaX009592
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 19 Oct 2006 08:25:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9JFPQDG013417;
	Thu, 19 Oct 2006 08:25:26 -0700
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87lkncev90.wl%cworth@cworth.org>
X-Spam-Status: No, hits=-0.472 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29357>



On Wed, 18 Oct 2006, Carl Worth wrote:
> 
> I understand that bzr also has unique identifiers, but it sounds like
> the tools try to hide them, and people aren't in the habit of using
> them for things like this. Do bzr developers put revision numbers in
> their bug trackers? Is there a guarantee they will always be valid?

bzr seems to use the classic UUID format, and it's funny how much it looks 
like a real BK ChangeSet revision number ("key").

Here's the quoted bzr "true" revision ID:

	Matthieu.Moy@imag.fr-20061017152029-4c5a2861bcf23b7d

and here's a BK "ChangeSet Key":

	adi@zaphod.bitmover.com|ChangeSet|20031031183805|57296

(I don't have BK installed anywhere, so I had to google for changeset 
keys, and this was just some random key in the BK bugzilla ;)

Looks very similar, don't they? And yes, the true revision ID is stable 
over time (at least it was in BK, and I assume it is in bzr too).

The biggest difference seems to be that in bzr, the final checksum is 
64-bit, while for BK, it was just a 16-bit checksum/unique number (the 
rest is just user-name/machine-name and date: I assume that the bzr commit 
was done at 10/17/2006 3:20:29PM, and the example BK ChangeSet was created 
10/31/2003 6:38:50PM - it looks like _exactly_ the same date format).

With BK, you can also use a "md5 key", and I don't actually know how they 
work. They may just be the md5 hash of the ChangeSet key, I think that may 
be how those things are indexed. So in bkcvs, you'll see a line like this:

	BKrev: 42516681VmgTWL0bkLcltPGiI6Yk5Q

which is the BK md5 key for my last kernel revision in BK (2.6.12-rc2). 
Again, these numbers are stable, unlike the simple revisions.

Note that from a usability standpoint, the UUID's look more readable to a 
human, but are actually much worse than the md5 keys (or the SHA1's that 
git uses). At least with a hash, the first few digits are likely to be 
unique, so you can do things like auto-completion (or just short names). 
With the email+date+random number kind of UUID, you don't have that.

(Pure hashes obviously also tend to just all have the same length, and are 
easier to parse automatically, so from a programmatic standpoint they are 
a lot easier too - but the surprising thing is how they are actually 
easier on humans too, even if the UUID's look more readable).

			Linus
