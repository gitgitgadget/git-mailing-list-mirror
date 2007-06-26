From: Yann Dirson <ydirson@altern.org>
Subject: Re: GIT + CVS workflow query.
Date: Wed, 27 Jun 2007 00:46:59 +0200
Message-ID: <20070626224659.GH7730@nan92-1-81-57-214-146.fbx.proxad.net>
References: <47281e410706261520r5b3549c7t39d93924d0a8ceea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eoin Hennessy <eoin.hennessy@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 00:47:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3JoY-0003gA-VL
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 00:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681AbXFZWrN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 18:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754906AbXFZWrN
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 18:47:13 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:37435 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752379AbXFZWrM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 18:47:12 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 09C9C817B;
	Wed, 27 Jun 2007 00:47:11 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 7F4B41F151; Wed, 27 Jun 2007 00:46:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <47281e410706261520r5b3549c7t39d93924d0a8ceea@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50984>

On Tue, Jun 26, 2007 at 11:20:24PM +0100, Eoin Hennessy wrote:
> Hi there,
> 
> I'd like to use GIT to track changes in a CVS repository. As well as
> tracking changes, I will also need to push patches back to CVS from
> GIT. My workflow is currently as follows:

I have done a similar thing for some time, with some differences.

>  - Use git-cvsimport to import and update a mirror of the CVS
> repository; 'project.git'.
> - Pull changes from the mirror to a cloned working copy; 'project'.
> - Fix bugs in the working copy

Yes.

> and push commits back to the mirror.

No, the mirror should solely be a mirror of cvs.  If you de-sync your
mirror, you're looking for trouble.

>  - Use git-cherry to identify commits in master not currently in the
> branch updated by git-cvsimport. Then use git-cvsexportcommit to push
> these commits into a CVS checkout.

Rather, the patches you have not committed yet are simply
remotes/origin/master..master.  What I did was simply
git-cvsexportcommit'ing them to my "CVS gateway checkout".

In the next iteration, cvsps will identify your commits as patchsets,
and what I did was registering the "merge to cvs" with an info/grafts
entry.  Nowaday, I would rather have my local commits in an stgit
stack, and "stg pull" would take care of detecting the merged patches
(not to mention that uncommitted patches would trivially map to stgit
patches).


But I occasionally had problems of cvs patches missed by the import,
and other issues because of cvsps not being able to cope with branches
created by cvs 1.12 (which is why I changed my workflow and wrote
stg-cvs, which in turn needs to be replaced).

Hope this helps,
-- 
Yann
