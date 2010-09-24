From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Multiple checkouts active for the same repository
Date: Fri, 24 Sep 2010 16:33:13 +0100
Message-ID: <14b089955184bbb677b6434993682403@212.159.54.234>
References: <4C9C6F8B.3090806@tech.2degreesnetwork.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Gustavo Narea <gnarea@tech.2degreesnetwork.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 17:42:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzAPX-0004bd-CX
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 17:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756840Ab0IXPl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 11:41:58 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:39866 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752805Ab0IXPl6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 11:41:58 -0400
X-Greylist: delayed 509 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Sep 2010 11:41:57 EDT
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 85CDE819E7A6;
	Fri, 24 Sep 2010 16:33:27 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 5E2D1290C13;
	Fri, 24 Sep 2010 16:33:27 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id bRcmnFCoo8Ia; Fri, 24 Sep 2010 16:33:13 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id B0BA4290BE6;
	Fri, 24 Sep 2010 16:33:13 +0100 (BST)
In-Reply-To: <4C9C6F8B.3090806@tech.2degreesnetwork.com>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156999>

On Fri, 24 Sep 2010 10:29:47 +0100, Gustavo Narea
<gnarea@tech.2degreesnetwork.com> wrote:
> Hello.
> 
> We're currently migrating from another DVCS, which allows us to have
> working copies of each branch in separate directories, so that their
> code can be used simultaneously. However, I haven't found a way to do
> this with Git, at least not an easy way. Can you please help me?

The git-new-workdir script to be found in contrib/workdir allows multiple
working copies to share the same repository - though there are some
caveats:

 1) uses symbolic links, so doesn't work on Windows
 2) the working copies are not aware of each other, so if you change a
checked out branch from another working copy you have to remember to git
reset your working copy before doing anything with it to get it back in
sync with the branch
 3) you have to remember not to delete the actual clone
 4) the working copies are not aware of each other, so it is possible for
objects needed by one working copy to get pruned from another one

Personally, I use this script all the time to checkout multiple branches
at the same time taking care to stay away from the issues above, and
everything hums along nicely.

> We are a team of Web developers and testers working on an application.
> There are always a few development branches and a stable branch, and
> testers need all the branches with the very latest code available at all
> times.
> 
> The way we handle it at the moment is very simple because the server
> hosting the remote repository is the same that hosts the deployed
> instances of each branch, so when we push to the remote repository, the
> code for each site is automatically updated.
> 
> We use the following structure:
> /srv/repositories/project/branch1
> /srv/repositories/project/branch2
> /srv/repositories/project/branch3
> 
> Is there any simple way to do this with Git? I can only think of two
> options that involve hooks:
> 
>     * Have a hook that exports each branch to a directory like
>       /srv/repositories/project/branchN
>     * Have one Git repository per branch, so that each repository have a
>       different checkout active. Then the main remote repository will
>       have post-receive hooks that trigger a pull on each individual
> 
> I'm not particularly happy with either way. Is there a better solution?

-- 
Julian
