From: Jon Loeliger <jdl@jdl.com>
Subject: git daemon directory munging?
Date: Sat, 03 Jun 2006 19:13:45 -0500
Message-ID: <E1FmgFV-0001i6-Kc@jdl.com>
X-From: git-owner@vger.kernel.org Sun Jun 04 02:13:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmgFa-00048m-O7
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 02:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWFDANr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 20:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWFDANr
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 20:13:47 -0400
Received: from jdl.com ([66.118.10.122]:5602 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1750934AbWFDANr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 20:13:47 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1FmgFV-0001i6-Kc
	for git@vger.kernel.org; Sat, 03 Jun 2006 19:13:46 -0500
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21234>

Scrapped right off the #git IRC channel...


<jdl> I stumbled across some git-daemon quirk for which I'd like opinions on
      possible solutions.						[18:56]
<jdl> I run a server that houses multiple virtual hosts on one physical
      machine.
<jdl> It has multiple Apache based websites on it, and I want to front
      multiple git repositories with gitweb.  That all works fine.	[18:57]
<jdl> But when I set up my repository stores, ie the /pub/scm/repo.git places,
      it falls apart.
<jdl> I want to maintain separate sets of git repos for each virtual site.
									[18:58]
<jdl> That is, www.foo.com can't see the repos of www.bar.com and vice versa.
<jdl> So I have an Apache directory set up that maps www.foo.com/pub/scm to
      some place like /pub/foo/scm using an alias for /pub/scm.		[18:59]
<jdl> Similarly, for www.bar.com I map /pub/scm to /pub/bar/scm
<jdl> Now, when I clone using http: all is well as it correctly maps the URL
      using the Apache Alias entry.					[19:00]
<jdl> However, when cloning via git: it doesn't do the Alias mapping based on
      the given website prefix part of the URL.
<jdl> I would have to clone using git://www.foo.com/pub/foo/scm even though I
      would clone using http://www.foo.com/pub/scm/			[19:01]
<jdl> So my proposed solution is to setup a genarlization of the git-daemon
      -baser-path=path argument.
<jdl> Instead of a single --base-path, there are potentially multiple
      --base-path entries that match multiple a URL prefixes.		[19:02]
<jdl> Thus, I'd use something like:
      --map-base=www.foo.com/pub/scm:/pub/foo/scm
      --map-base=www.bar.com/pub/scm=/pub/bar/scm			[19:04]
<dormando> mod_rewrite for git :|
<jdl> Quick prefix hack, yeah.						[19:05]
<jdl> Um, stop me before I hack....? :-)				[19:06]
<dormando> you're going to end up needing something that supports basic
	   regexes before long
<dormando> I can't think of many cases where you'd want to directly map like
	   that, and especially in that specific manner.		[19:07]
<jdl> I can't hear you.
<dormando> sorry.
* dormando was going to have similar problems for his hosting service
