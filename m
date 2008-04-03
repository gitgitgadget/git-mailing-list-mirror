From: David Mansfield <david@cobite.com>
Subject: Re: [PATCH] cvsps/cvsimport: fix branch point calculation and
	broken branch imports
Date: Thu, 03 Apr 2008 09:49:42 -0400
Organization: Cobite
Message-ID: <1207230582.17329.39.camel@gandalf.cobite.com>
References: <1207100091.10532.64.camel@gandalf.cobite.com>
	 <0C7AA499-56AD-4D20-AED0-9E7DDD0C77DF@zib.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Apr 03 15:50:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhPpu-0008WR-W3
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 15:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758327AbYDCNt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 09:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758334AbYDCNt5
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 09:49:57 -0400
Received: from 208.36.103.2.ptr.us.xo.net ([208.36.103.2]:53600 "EHLO
	iris.cobite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758306AbYDCNtz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 09:49:55 -0400
Received: from localhost (iris.cobite.com [127.0.0.1])
	by iris.cobite.com (Postfix) with ESMTP id 8F8B9E1B2F;
	Thu,  3 Apr 2008 09:49:53 -0400 (EDT)
X-Virus-Scanned: amavisd-new at cobite.com
Received: from iris.cobite.com ([127.0.0.1])
	by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J83RQFxlDKbv; Thu,  3 Apr 2008 09:49:43 -0400 (EDT)
Received: from [208.222.80.105] (208.36.103.2.ptr.us.xo.net [208.36.103.2])
	by iris.cobite.com (Postfix) with ESMTP id B1E56E1B30;
	Thu,  3 Apr 2008 09:49:42 -0400 (EDT)
In-Reply-To: <0C7AA499-56AD-4D20-AED0-9E7DDD0C77DF@zib.de>
X-Mailer: Evolution 2.12.3 (2.12.3-3.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78752>


On Thu, 2008-04-03 at 07:47 +0200, Steffen Prohaska wrote:
> On Apr 2, 2008, at 3:34 AM, David Mansfield wrote:
> 
> > P.S Also, as many people may have imported broken branches already,  
> > can
> > anyone thing of a way to fix the branch, (maybe with git-rebase or
> > something)?  The breakage affects, I believe, files not ever  
> > modified on
> > the branch until any given point in time on the branch...
> >
> 
> The breakage you describe might be the same breakage that I recognized
> in June 2007:
> 
>    http://article.gmane.org/gmane.comp.version-control.git/50736
> 
> At that time, I wrote a script (git-transplant) that fixed a broken
> import from CVS for me:
> 
>    http://article.gmane.org/gmane.comp.version-control.git/50746
> 
> The discussion in
> 
>    http://article.gmane.org/gmane.comp.version-control.git/50789
> 
> explains the reason for the script a bit more detailed.
> 
> But note that I never finished git-transplant and I also failed to
> convince anyone that the idea behind the script is of any general value.
> Instead, I decided that git-cvsimport is not the right tools for me; and
> since then I use parsecvs to convert my repositories.
> 


Yes.  It's the same problem.  It will be fixed with the above patches
once they stabilize.  I'll look at the transplant thing too.  It looks
like a good idea.

The main issue with git-cvsimport stems from an unfixable problem.
cvsps's design goal is to show commits in chronological order.  Based
solely on this data, it's impossible to always reconstruct a branch
point (or a tag) since a person could have committed files after someone
else's commit, but not done an update then tagged.  

So some files are from before the 'other' user's commit, and some files
after.  What can you do?  

It's not per se a flaw in cvsps, it always wanted to show commits in
chronological order, but it is a severe limitation in using cvsps to
generate changesets for git.

By engineering a direct tool (such as parsecvs, I presume) these
obstacles can be overcome by constructing some commits that were never
made by the actual users of the cvs repo in order to get it right.

I'm not sure exactly how this is done, because I've never looked at
parsecvs.

David
