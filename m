From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: Removing some files from history
Date: Fri, 17 Oct 2008 12:52:26 +0200
Message-ID: <48F86E6A.7080102@fastmail.fm>
References: <96ed5eac0810170338s292fe858s1c092428a44a7ad2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gennady Kushnir <genkush@rujel.net>
X-From: git-owner@vger.kernel.org Fri Oct 17 12:53:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqmxp-0000Wn-Kl
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 12:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbYJQKwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 06:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbYJQKwa
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 06:52:30 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:38446 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751295AbYJQKw3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Oct 2008 06:52:29 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 10A9C18124B;
	Fri, 17 Oct 2008 06:52:29 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 17 Oct 2008 06:52:29 -0400
X-Sasl-enc: jIG9CJLAftuIulVH0aJK2mI3b2dq/quai4NB9KqVGAj6 1224240748
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7B648D08C;
	Fri, 17 Oct 2008 06:52:28 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <96ed5eac0810170338s292fe858s1c092428a44a7ad2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98472>

Gennady Kushnir venit, vidit, dixit 17.10.2008 12:38:
> Hello all
> I'm not yet subscribed, but I wish I shall get reply anyway
> 
> I'm going to make my repository public, but I have found that one of
> my files contains some private data that I would not like to share.
> Is it possible to remove that file from all commits in my local
> repository history before publishing it?
> Or it would be easier to start publishing with just my current state
> (whith all private data cleaned up)?
> 
> Thanks in advance.
> Gennady
Use

git filter-branch --index-filter 'git rm --cached secret' -- --all

or

git filter-branch --tree-filter 'rm -f secret' -- --all

where 'secret' is the name of the file to be removed.

After that, make sure you clean up your repo before publishing:
Clean out the original references (command on 1 line):

git for-each-ref  --format='%(refname)' refs/original |while read ref;
do git update-ref -d $ref;done

Clean out the reflog:

git reflog --expire=0 expire

Remove the old objects and packs:

git prune
git repack -adf

[Makes me feel this should be easier.]

Michael
