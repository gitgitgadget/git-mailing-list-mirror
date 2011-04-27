From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/1] Documentation/git-filter-branch: add --index-filter
 example
Date: Wed, 27 Apr 2011 22:32:00 +0200
Message-ID: <4DB87D40.9090302@kdbg.org>
References: <1303927684-6513-1-git-send-email-michael.ocleirigh@rivulet.ca> <1303927684-6513-2-git-send-email-michael.ocleirigh@rivulet.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael O'Cleirigh <michael.ocleirigh@rivulet.ca>
X-From: git-owner@vger.kernel.org Wed Apr 27 22:32:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFBP8-0005Z3-R7
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 22:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756920Ab1D0UcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 16:32:04 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:1876 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755722Ab1D0UcD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 16:32:03 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 04A6C13005A;
	Wed, 27 Apr 2011 22:32:00 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 81A1C19F35B;
	Wed, 27 Apr 2011 22:32:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.14) Gecko/20110221 SUSE/3.1.8 Thunderbird/3.1.8
In-Reply-To: <1303927684-6513-2-git-send-email-michael.ocleirigh@rivulet.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172269>

I like the example, particularly because it shows that it is not
necessary to start off with index's content in an --index-filter, and
that the index can be replaced with read-tree -i, i.e., GIT_INDEX_FILE
juggling is not necessary for some tasks.

Am 27.04.2011 20:08, schrieb Michael O'Cleirigh:
> Added an example using git ls-tree on the $GIT_COMMIT and then filtering
> what should remain in the history using egrep.
> 
> This allows multiple paths accross history to be retained when filtering a branch.

Sign-off is missing. Please keep lines well below 75 characters. Write
'Add an example...' rather than 'Added an example...'.

> ---
>  Documentation/git-filter-branch.txt |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> index 9dc1f2a..e80bc01 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -248,6 +248,19 @@ To set a commit (which typically is at the tip of another
>  history) to be the parent of the current initial commit, in
>  order to paste the other history behind the current history:
>  
> +-----------------------------------------------------------------------------------------------------------------------------------
> +git filter-branch --prune-empty --index-filter 'git ls-tree $GIT_COMMIT | egrep \
> +"(top-dir-A|top-dir-B|consolidated-dir-C)" | git mktree | xargs git read-tree -i -m'
> +-----------------------------------------------------------------------------------------------------------------------------------
> +
> +The --subdirectory-filter works great when all commits of interest have
> +that path but sometimes you have a history that contains an irregular 
> +structure. i.e. that was reorganized at some point and you would like to 
> +keep the prior history.
> +
> +For each commit the top-dir-A, top-dir-B and consolidated-dir-C paths (if they exist)
> +are kept (and everything else discarded). 
> +
>  -------------------------------------------------------------------
>  git filter-branch --parent-filter 'sed "s/^\$/-p <graft-id>/"' HEAD
>  -------------------------------------------------------------------

This places the new text in the middle of another example, doesn't it?

The prefered style of examples to give motivation first, then the
example command, then a description of command details. I would drop the
sentence "i.e. ... was reoranized... history" because it does not add
value for the reader (I can think of other equally or even more likely
reason why the interesting path structure is irregular).

The example looks better when it is broken into more lines, e.g. like this:

-----------------------------------------------------------
git filter-branch --prune-empty --index-filter '
		git ls-tree $GIT_COMMIT |
		egrep "(top-dir-A|top-dir-B|other-dir-C)" |
 		git mktree | xargs git read-tree -i -m'
-----------------------------------------------------------

And the dash lines are just as long as necessary.

-- Hannes
