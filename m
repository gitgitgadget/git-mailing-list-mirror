From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: git-svn failure when symlink added in svn
Date: Mon, 30 Apr 2007 07:43:46 -0700
Message-ID: <m24pmxrkgt.fsf@ziti.local>
References: <m2slb1c8ps.fsf@fhcrc.org>
	<loom.20070427T005115-751@post.gmane.org>
	<alpine.LFD.0.98.0704271100321.9964@woody.linux-foundation.org>
	<loom.20070428T144858-521@post.gmane.org>
	<7virbgjthr.fsf@assigned-by-dhcp.cox.net>
	<m2odl8fjv1.fsf@ziti.fhcrc.org>
	<7v7irwjql6.fsf@assigned-by-dhcp.cox.net>
	<m2k5vwfbf6.fsf@ziti.fhcrc.org>
	<7vwszwi0h2.fsf@assigned-by-dhcp.cox.net> <m2irbfqlze.fsf@ziti.local>
	<20070429182649.GD12375@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Apr 30 16:44:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiX6g-0001r1-QH
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 16:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423325AbXD3Onv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 10:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423326AbXD3Onv
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 10:43:51 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:3445 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423325AbXD3Ont (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 10:43:49 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1937027nzf
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 07:43:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=C3k6tZV/iwN5viLxnT0XzG+kGPT4Do53bXpIb9qAk1yXdzc8cWk2v7KCtIMM80Ui+I6kjOCs5L1hiT6nmJzPdvuz/4zioM8rivgQ8aQkmfI03/IoURrGMLWLvWrQQEmXhtlo/v6c0p2hBG5biyLtPRcvSceJi/nq61qCzrfjpYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=OkXef9xmSOYmLJJXTk+a7EoG5CdqqzIauWrA3b2zRyMADERynLsS0RVPH6E1VIjv8iva+x0VGRW43MLkJDF5irsvB6zWNy4zTdBKo4AvSrPsq3bP2b8o8lP/yaCH8xkxCeVRkzz01BaB1ZCqFOqKoE0+fjY7kdN8QhI+EIY1LJE=
Received: by 10.114.145.1 with SMTP id s1mr118572wad.1177944228491;
        Mon, 30 Apr 2007 07:43:48 -0700 (PDT)
Received: from ziti.local ( [24.19.44.95])
        by mx.google.com with ESMTP id m28sm724122poh.2007.04.30.07.43.48;
        Mon, 30 Apr 2007 07:43:48 -0700 (PDT)
In-Reply-To: <20070429182649.GD12375@untitled> (Eric Wong's message of "Sun, 29 Apr 2007 11:26:49 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45869>

Eric Wong <normalperson@yhbt.net> writes:

> Seth Falcon <sethfalcon@gmail.com> wrote:
>> Eric: is there any way to undo some of the svn revs that have been
>> retrieved using git-svn fetch and then refetch them? 

> Assuming you're not using something crazy like noMetadata, you can just
> use update-ref on the remote heads to the last known good revisions and
> remove the associated .rev_db files.
>
> Otherwise you'll have to delete entries from the .rev_db files, the
> format is one line per-revision, the revision is the line number of the
> file.

Hmm, not sure I understood.  Here's what I tried:

I'm tracking two branches via git-svn.  For each, I used git log
remotes/<branch> to find a revision that I expect to be ok and noted
the sha1.  Then I did: 

    git-update-ref remotes/git-svn a27b11c1

and similar, but with different sha1 for the other branch.  Next I
removed the .rev_db* files (there was one for each svn branch) and
tried doing git-svn fetch.  This seemed to rebuild the .rev_db, but
eventually I ended up with:

Done rebuilding .git/svn/git-svn/.rev_db.00db46b3-68df-0310-9c12-caf00c1e9a41
        M       src/<somepath>
        M       src/<another>
Incomplete data: Delta source ended unexpectedly at /Users/seth/scm/bin/git-svn line 2982

And if I rerun git svn fetch, I get:

Index mismatch: 9c07a6009029e4a1d834ff126f705c4db3c4bce7 != 67dc53678f759c52a93a281f13fadb08799f86b2
rereading 0f12c8c092600c8a3337ec35d153d3a76ce2329d
        M       src/<somepath>
        M       src/<another>
Incomplete data: Delta source ended unexpectedly at /Users/seth/scm/bin/git-svn line 2982


[where <somepath> and <another> are the same in both cases]

Did I miss a step or misunderstand how to undo?  What's strange is
that if I do git show 0f12c8c, I see a patch that is looks like it came
from a fetch using the my broken version of git-svn -- do I need to
clear out objects before refetching?

Thanks,

+ seth
