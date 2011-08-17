From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [BUG] git-svn: error importing git repository in svn when first
 git commit was empty
Date: Wed, 17 Aug 2011 13:17:19 +0200
Message-ID: <4E4BA33F.8060103@drmicha.warpmail.net>
References: <CAAzBVjAjqr8hDFdMc2s6d=ZXttswSnLiig-aFKsZG5EJjAyAig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: s b <sberder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 13:17:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qte7m-0002Ia-33
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 13:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189Ab1HQLRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 07:17:22 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:43851 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753158Ab1HQLRW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2011 07:17:22 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7B82720EF2;
	Wed, 17 Aug 2011 07:17:21 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 17 Aug 2011 07:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=MDmwDY906ePOffKnT5GoPx
	IGljs=; b=L1GKb0T9sgvNgtsZNySgtmlnmUIeJsgfzPY9gQl52FumOnpV1J8qSe
	ceabFpSHMdekqOjv/fwN7JaCZAuUn4LDiF41SUVyoTlfP2cYy/gYH8/kGT2u2THu
	nKEZz9aiogMyFqIO0KLzB54kj5wN1bEUtD+Jf62oM5HayPti7xR2o=
X-Sasl-enc: kXX0+VS1FrDviQrhRPcT1o4fvPrSpl1ACMHh6Gb307ME 1313579841
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E74B141F03C;
	Wed, 17 Aug 2011 07:17:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
In-Reply-To: <CAAzBVjAjqr8hDFdMc2s6d=ZXttswSnLiig-aFKsZG5EJjAyAig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179509>

s b venit, vidit, dixit 11.08.2011 11:13:
> Couldn't find any bugtracker for git so I supposed it would be ok to
> post the bug here.
> 
> # Situation:
> I usually start my projects with git as it's quick and simple to track
> modifications. If the code grows and is of any interest for my work I
> push it to the corporate svn. I usually use this tutorial
> (http://eikke.com/importing-a-git-tree-into-a-subversion-repository/)
> which makes it a simple thing to do.
> Some time ago I started having a first empty commit in my git
> repository using 'git commit --allow-empty' as I read (can't remember
> where) it could help for some cases. I don't have need for those edge
> cases yet but remember thinking I could need them in the future.
> 
> # Problem:
> When your first git commit is empty, git-svn fails with the following message :
> $ git svn dcommit
> Committing to https://svn/repo/trunk ...
> No changes
> 71fb4051d840e27a43b87b071ccc7ea70bd0c5e8~1 ==
> 71fb4051d840e27a43b87b071ccc7ea70bd0c5e8
> No changes between current HEAD and refs/remotes/trunk
> Resetting to the latest refs/remotes/trunk
> Unable to extract revision information  from commit
> 867ee195730507fb769e794eb4abe09d0e2e7c8f~1
> 

Shot in the dark (gray): Try

git svn dcommit --no-rebase

> At the same time, it also completely breaks the logs.
> 
> # How to reproduce: (the svn repository just has one commit for usual
> trunk/branches/tags folders)
> $ mkdir foobar
> $ cd foobar/
> $ git init
> Initialized empty Git repository in /home/hr/tmp/foobar/.git/
> $ git commit --allow-empty -m "Project init"
> [master (root-commit) 0f1e71a] Project init
> $ echo "foo" > test.txt; git add test.txt; git commit -m "Initial version"
> [master 119fc0a] Initial version
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 test.txt
> $ echo "bar" > test.txt; git commit test.txt -m "Second version"
> [master 77b2681] Second version
>  1 files changed, 1 insertions(+), 1 deletions(-)
> $ git svn init -s https://code/svn/foobar/
> $ git svn fetch
> r1 = 8bc83d5d63b4191509d29aa90e35e24edba393c1 (refs/remotes/trunk)
> $ git log --pretty=oneline master
> 77b268140a03cbe98215ea160704ba14ce79e096 Second version
> 119fc0a55d1eb851fcedfe0bdc6de3c1ab047601 Initial version
> 0f1e71a283d7b4b27d23debaac091b654d495124 Project init
> $ git show-ref trunk
> 8bc83d5d63b4191509d29aa90e35e24edba393c1 refs/remotes/trunk
> $ echo "0f1e71a283d7b4b27d23debaac091b654d495124
> 8bc83d5d63b4191509d29aa90e35e24edba393c1" >> .git/info/grafts
> $ git log --pretty=oneline
> 77b268140a03cbe98215ea160704ba14ce79e096 Second version
> 119fc0a55d1eb851fcedfe0bdc6de3c1ab047601 Initial version
> 0f1e71a283d7b4b27d23debaac091b654d495124 Project init
> 8bc83d5d63b4191509d29aa90e35e24edba393c1 * Init project, mkdir trunk branches ta
> $ git svn dcommit
> Committing to https://code/svn/foobar/trunk ...
> No changes
> 0f1e71a283d7b4b27d23debaac091b654d495124~1 ==
> 0f1e71a283d7b4b27d23debaac091b654d495124
> No changes between current HEAD and refs/remotes/trunk
> Resetting to the latest refs/remotes/trunk
> Unable to extract revision information  from commit
> 119fc0a55d1eb851fcedfe0bdc6de3c1ab047601~1
> $ git log
> commit 8bc83d5d63b4191509d29aa90e35e24edba393c1
> Author: root <root@e969a563-e91d-45ef-9946-abb13e32418c>
> Date:   Thu Jul 7 06:40:59 2011 +0000
> 
>     * Init project, mkdir trunk branches tags.
> 
>     git-svn-id: https://code/svn/foobar/trunk@1 e969a563-e91d-45ef-9946-abb13e32
> 
> # Solution:
> Not really a solution but instead of using the first commit for the
> grafts, I use the second one (that is non empty).
> 
> Hope this can help getting a better git-svn!!
> 
> Stefan
