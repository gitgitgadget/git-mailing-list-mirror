From: Grzegorz Kossakowski <grek@tuffmail.com>
Subject: How to clone git repository with git-svn meta-data included?
Date: Sat, 06 Dec 2008 13:15:40 +0100
Message-ID: <493A6CEC.4060601@tuffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 06 13:29:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8wHQ-0005Vr-Ig
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 13:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755567AbYLFM1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 07:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755558AbYLFM1q
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 07:27:46 -0500
Received: from fallback-out1.mxes.net ([216.86.168.190]:3600 "EHLO
	fallback-in1.mxes.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755522AbYLFM1q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 07:27:46 -0500
X-Greylist: delayed 717 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Dec 2008 07:27:46 EST
Received: from mxout-03.mxes.net (mxout-03.mxes.net [216.86.168.178])
	by fallback-in1.mxes.net (Postfix) with ESMTP id 0E80D1646F0
	for <git@vger.kernel.org>; Sat,  6 Dec 2008 07:18:49 -0500 (EST)
Received: from [192.168.0.125] (unknown [82.210.157.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.mxes.net (Postfix) with ESMTP id 9629423E3FE
	for <git@vger.kernel.org>; Sat,  6 Dec 2008 07:15:45 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102447>

Hello,

Some folks at Apache are experimenting with Git and we are currently seeking for the git-svn
integration that fits our needs and infrastructure.

After some evaluation we decided that our setup could be described using following points:
  a) our svn repository remains our main, official server where every committer is obligated to push
their changes to at some time.
  b) we set up clone of svn repository using git-svn. One of our members, Jukka Zitting, maintains
such a service here[1]. Such repositories should be usable both for our committers (that have rights
to push to svn) and our contributors that want to contribute random patches
  c) we want carefully track who committed/contributed what

Basically, a) implies b) and point b) looks little bit problematic right now.
Jukka has set up his hosting using method described in his e-mail[2] which basically makes use of
git svn. The major problem is that if one clones Jukka's repository then git svn information is not
being cloned so committers have no means to push their changes to main, svn server.

I've tried to play a little bit around with this issue and I tried to copy information from .git
directory found on Jukka's server. This made me able to push my changes but git svn insisted on
rebasing my repository using commits found in svn which is wrong. Basically we want such a setup
that uses git repository (Jukka's clone) for pulling changes and local git svn for pushing changes.
Git svn should never try to rebase local repository because this will lead to two different trees on
two different machines so we won't be able to exchange and merge changesets.

Is it possible with Git right now?


Another point (c) which seems to be brought a couple of times but never a definitive answer has been
given, AFAIK. Let's imagine we have committer C and two contributors A and B.

A and B start to work on some feature and C agreed to help A and B and once their work is finished
to merge their changes into his repository and eventually push them to main, svn repository. Now A
and B work on implementation and from time to time their merge changes from each other. Once they
are finished A asks C to merge their work into C's repository. Everything is fine provided we can
trust both A and B.

What if A was not fair and has rewritten a few commits coming from B so they contain malicious code?
How we can detect something like that and how C be sure that what he merges is really work
attributed by correct names?

Thanks for your answers.

[1] http://jukka.zitting.name/git/
[2] http://markmail.org/message/fzzy7nepk7olx5fl


-- 
Best regards,
Grzegorz Kossakowski
