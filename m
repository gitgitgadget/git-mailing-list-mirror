From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [BUG] git-svn: HEAD pointing to a tag after cloning
Date: Mon, 11 May 2009 13:50:06 +0200
Message-ID: <4A0810EE.9030209@drmicha.warpmail.net>
References: <37678.10.0.0.1.1242040118.squirrel@intranet.linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@linagora.com>
X-From: git-owner@vger.kernel.org Mon May 11 13:50:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3U1a-00082j-Nv
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 13:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755882AbZEKLuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 07:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbZEKLuQ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 07:50:16 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52015 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755012AbZEKLuP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2009 07:50:15 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 59C1B33F566;
	Mon, 11 May 2009 07:50:15 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 11 May 2009 07:50:15 -0400
X-Sasl-enc: UPadJi47WLmhxEbenp3DsFFxvumeAdfevWbcr3oXrM9P 1242042615
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C8C2D2DD1;
	Mon, 11 May 2009 07:50:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090511 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <37678.10.0.0.1.1242040118.squirrel@intranet.linagora.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118793>

Yann Dirson venit, vidit, dixit 11.05.2009 13:08:
> The following happens with git 1.6.3.  For some reason git-svn sets HEAD
> to the wrong branch.  Not sure what happens here, $self->full_url seems to
> be used for a wrong purpose somewhere in the code.
> 
> 
> (you can see a commit on the "tag" branch, which got committed at the
> wrong place because the user did not notice that HEAD was not pointing to
> the correct branch)
> 
> $ git svn clone --stdlayout svn://xxxx/at-remote test
> [....]
> Successfully followed parent
> r3287 = 08b210cf2e97caeb6d431a4a0bc594702aa9c6d2 (tags/luciole-2.0.4)
> Found possible branch point: svn://xxxx/at-remote/trunk =>
> svn://xxxx/at-remote/tags/luciole-2.0.5, 3352
> Found branch parent: (tags/luciole-2.0.5)
> ddff7cedbd1d66c836153606db1f80ad3ce6b00d
> Following parent with do_switch
> Successfully followed parent
> r3367 = 35b21f3f8e206c391f09a788ba9cb6b35f21752d (tags/luciole-2.0.5)
>         M       at-remote
> r3652 = faeb3bab02016b23a7fb7256bbabea305f599022 (tags/luciole-2.0.5)
> Checked out HEAD:
>   svn://xxxx/at-remote/tags/luciole-2.0.5 r3652
> $
> 
> 

svn allows you to commit to tags as if they were branches - indeed they
are branches just as much as svn branches are branches.

Therefore, git-svn represents svn tags as git remote branches (not
tags). After the clone is done, git-svn checks out the branch on which
the last commit was done.

So, git-svn is doing as it should, under the restrictions that svn puts
on its operations.

One may argue that master should point to trunk (for --stdlayout)
instead after git svn clone, just like master points to master after git
clone. But which one is "the correct branch"? I would claim that the
client cannot know and there should be no master (maybe a detached head
with the last commit, i.e. HEAD) but last I tried I remained a
1-person-minority ;)

Cheers,
Michael
