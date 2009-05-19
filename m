From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: any way to apply tag across all branches in repository?
Date: Tue, 19 May 2009 13:36:46 -0500
Message-ID: <NFLo0xGp2o-oBdtr_pq1jvwATe1ZALaD9dHkr5hmKNkU30gr_isMpQ@cipher.nrlssc.navy.mil>
References: <4A12DDB9.60608@nortel.com> <Y0WmOpNg_9ptwbJ3VHYrzAgFtDvPi5pn4Tz-0w5Phhlo9frjieUaeA@cipher.nrlssc.navy.mil> <4A12F0ED.4070707@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Friesen <cfriesen@nortel.com>
X-From: git-owner@vger.kernel.org Tue May 19 20:37:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6UBS-0006pv-2y
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 20:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518AbZESSgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 14:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753350AbZESSgx
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 14:36:53 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40064 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952AbZESSgx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 14:36:53 -0400
Received: by mail.nrlssc.navy.mil id n4JIalVW015814; Tue, 19 May 2009 13:36:47 -0500
In-Reply-To: <4A12F0ED.4070707@nortel.com>
X-OriginalArrivalTime: 19 May 2009 18:36:46.0703 (UTC) FILETIME=[C3C437F0:01C9D8B0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119557>

Chris Friesen wrote:
> Brandon Casey wrote:
> 
>> If I understand you correctly, you are doing your primary development on
>> the "main" branch and then merging this into the architecture specific
>> branches which contain additional architecture specific changes.
> 
> Correct.
> 
>> All you need to do is tag the "main" branch.  Actually, you are tagging
>> the commit that the branch currently points at.  When this branch is
>> merged into the other branches, they will also contain this commit, and
>> 'git describe' will use the tag you created when generating the version
>> string.
> 
> I think this would work if the most recent commit is on the main branch.
> 
> However, if I make a change on the arch-specific branch, then tag the
> main branch and merge it into the arch-specific branch, git tells me
> the arch-specific branch is already up-to-date and the tag doesn't
> get propagated.

Tags aren't versioned.  They exist outside of the branch namespace.
So merging doesn't have any direct effect on tags.  It is the _commits_
that are merged in (which the tags point to).  If you have already
merged the main branch into the arch-specific branch, then there is
nothing else for git to do.  Your repository looks something like this
graph:

    --o--o---o---o---o---o--o   "arch"
     /                  /
   -o--o---o---o---o---o        "main"
                       |
                      my_tag

When you merge "main" into "arch", the "main" DAG* becomes a part of the
"arch" DAG.  The tag points to a specific commit, which represents a state
of the DAG, which is also now part of the "arch" DAG.

The output of 'git describe $arch_branch' will likely change after you
create the tag though.

Try these commands:

  git describe $main
  git describe $arch_branch
  git tag -m 'a test tag' my_tag $main
  git describe $main
  git describe $arch_branch

-brandon

* DAG - directed acyclic graph
