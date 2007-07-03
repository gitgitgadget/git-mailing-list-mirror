From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: git-svn dcommit fails if the URL has spaces in it
Date: Tue, 03 Jul 2007 11:49:52 +0200
Message-ID: <468A1BC0.5080302@dawes.za.net>
References: <4680F75A.9010704@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Jul 03 11:51:20 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5f2V-0008UV-DE
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 11:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757012AbXGCJvR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 05:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756969AbXGCJvR
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 05:51:17 -0400
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:57793 "EHLO
	spunkymail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756657AbXGCJvQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jul 2007 05:51:16 -0400
Received: from [192.168.201.100] (dsl-146-27-210.telkomadsl.co.za [165.146.27.210])
	by spunkymail-a4.g.dreamhost.com (Postfix) with ESMTP id A3FE9131A2A;
	Tue,  3 Jul 2007 02:51:14 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
In-Reply-To: <4680F75A.9010704@dawes.za.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51471>

Rogan Dawes wrote:
> Hi folks,
> 
> I used git-svn to clone the webgoat repository at GoogleCode. As 
> mentioned at the time, for some bizarre reason, I ended up getting a 
> directory with a space character in it.
> 
> See http://article.gmane.org/gmane.comp.version-control.git/49179
> 
> In order to get a checkout that looks the same as the SVN checkout, I 
> had to use a command line like:
> 
> git-svn clone -T "trunk/ webgoat" https://webgoat.googlecode.com/svn/
> 
> Unfortunately, this results in git-svn-id metadata entries in the 
> commits that look like:
> 
> git-svn-id: https://webgoat.googlecode.com/svn/trunk/ webgoat@2 
> 4033779f-a91e-0410-96ef-6bf7bf53c507
> 
> (Should be all on one line). As you can see, the space has made it 
> through into the git-svn-id. Which then breaks this pattern match in 
> git-svn:extract_metadata:
> 
> my ($url, $rev, $uuid) = ($id =~ /^git-svn-id:\s(\S+?)\@(\d+)
>                                                 \s([a-f\d\-]+)$/x);
> 
> Unfortunately, hacking it to ignore the space doesn't help either, as I 
> then get:
> 
> [rdawes@lucas webgoat]$ git-svn --username=rogan.dawes dcommit
> ID = git-svn-id: https://webgoat.googlecode.com/svn/trunk/ webgoat@125 
> 4033779f-a91e-0410-96ef-6bf7bf53c507
> ID = git-svn-id: https://webgoat.googlecode.com/svn/trunk/ webgoat@125 
> 4033779f-a91e-0410-96ef-6bf7bf53c507
> RA layer request failed: PROPFIND request failed on '/svn/trunk/ 
> webgoat': PROPFIND of '/svn/trunk/ webgoat': 400 Bad Request 
> (https://webgoat.googlecode.com) at /home/rdawes/bin/git-svn line 406
> 
> Which is entirely unsurprising, since I suspect that the URL was not 
> being quoted/escaped correctly, and we were sending something like:
> 
> PROPFIND /svn/trunk/ webgoat/ HTTP/1.0
> 
> Which is clearly illegal, having an additional field.
> 
> However, I tried encoding the space to %20, and got back to my original 
> problem, i.e.
> 
> Unable to determine upstream SVN information from HEAD history
> 
> If I run "git-svn -n dcommit", however, it does print out a list of 
> "diff-tree <sha>~1 <sha>" entries.
> 
> At this point, I am pretty well stuck. Any suggestions would be much 
> appreciated.
> 
> Regards,
> 
> Rogan Dawes

Anyone got any ideas?

Rogan
