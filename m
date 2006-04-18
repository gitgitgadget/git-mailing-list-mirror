From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: GIT_OBJECT_DIRECTORY
Date: Tue, 18 Apr 2006 11:08:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604181104420.3701@g5.osdl.org>
References: <20060418133847.GC4720@wohnheim.fh-wedel.de>
 <Pine.LNX.4.64.0604180822470.3701@g5.osdl.org> <20060418175853.GA25688@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-154787241-1145383720=:3701"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 20:09:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVudH-0008OM-Eb
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 20:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWDRSIn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 14:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWDRSIn
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 14:08:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64923 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932267AbWDRSIm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Apr 2006 14:08:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3II8ftH011836
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Apr 2006 11:08:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3II8eLL019775;
	Tue, 18 Apr 2006 11:08:40 -0700
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
In-Reply-To: <20060418175853.GA25688@wohnheim.fh-wedel.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18864>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-154787241-1145383720=:3701
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Tue, 18 Apr 2006, Jörn Engel wrote:
> > 
> > 	git clone git://git.kernel.org/... foo/
> 
> Is it possible for non-owners of a kernel.org account to do this?

Yes, kernel.org runs the git daemon.

If a repo isn't packed enough, the git protocol can be pretty CPU 
intensive, but I'm hoping that everybody keeps their repos mostly packed, 
at which point the git protocol should actually be a lot faster than 
rsync.

> > GIT_OBJECT_DIRECTORY, and it makes a lot less sense with pack-files than 
> > it did originally, so it's not getting any testing).
> 
> Well, .git/objects for your kernel still consumes 121M.  It's not
> gigabytes but I still wouldn't want too many copies of that lying
> around.

Right. However, these days we have better approaches than 
GIT_OBJECT_DIRECTORY for that.

In particular, if you create local clones, use "git clone -l -s", which 
shares its base objects with the thing you clone from. It makes the clone 
incredibly fast too (the only real cost is the check-out, which can 
obviously be pretty expensive), and you can then use

	git repack -a -d -l

on all the to repack just the _local_ objects to avoid having packs 
duplicate objects unnecessarily.

		Linus
--21872808-154787241-1145383720=:3701--
