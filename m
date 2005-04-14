From: "C. Scott Ananian" <cscott@cscott.net>
Subject: another perspective on renames.
Date: Thu, 14 Apr 2005 18:22:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504141759440.7261@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Fri Apr 15 00:20:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMCgS-0007GF-Jw
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 00:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVDNWW5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 18:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVDNWW5
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 18:22:57 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:42442 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261573AbVDNWWz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 18:22:55 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DMCjf-0006oT-00
	for <git@vger.kernel.org>; Thu, 14 Apr 2005 18:22:55 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Perhaps our thinking is being clouded by 'how other SCMs do things' ---
do we *really* need extra rename metadata?  As Linus pointed out, as long 
as a commit is done immediately after a rename (ie before the renamed file 
is changed) the tree object contains all the information one needs: you 
can notice that a given object's content-hash is named 'foo' in the first 
version and 'bar' in the second version.

Ingo thought that this was insufficient because two *different* objects 
(ie having different revision histories) might be mutated to a point where 
they had a *same* contents (and then would be condensed into a single 
blob).  But isn't that a feature of the git-fs history generally (ie not a 
renaming-specific issue)?

One solution would be to invent a new 'file-revision-history' annotation 
on top of git-fs in order to keep these derivation paths seperate...

...but perhaps we might think of this as a 'feature' of our SCM instead?
The 'history' of a file may have join points where a single 'content' may 
have been derived by two or more completely different paths.  Explicit 
guidance to the front-end tools is required to 'unmerge' these files after 
this occurs (ie updating the directory cache for one, but not the others). 
This makes sense for include/arch/{foo,bar}/baz.h, but maybe not so much 
for (say) the empty file.

Anyway, maybe it's worth thinking a little about an SCM in which this is a 
feature, instead of (or in addition to) automatically assuming this is a 
bug we need to add infrastructure to work around.
  --scott

PBFORTUNE Soviet  cryptographic D5 SLBM MI5 CIA postcard WASHTUB [Hello to all my fans in domestic surveillance] 
explosion Sigint Bush ODEARL FJHOPEFUL assassination Uzi Hussein Nader
                          ( http://cscott.net/ )
