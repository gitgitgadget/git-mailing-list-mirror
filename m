From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Merging changes from branches where file paths have changed
Date: Sat, 14 Apr 2012 21:21:26 +0200
Message-ID: <4F89CE36.4000607@kdbg.org>
References: <CA+39Oz7m1hGrTEdpSAjBP3EDFSVyKdc6T9CORcwQkjuEbvD4Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Thomas Adam <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 21:21:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ8XQ-0003lL-Pr
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 21:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756028Ab2DNTVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 15:21:31 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:58880 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755885Ab2DNTVa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 15:21:30 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D3051130044;
	Sat, 14 Apr 2012 21:17:54 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id A91F119F69F;
	Sat, 14 Apr 2012 21:21:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.28) Gecko/20120306 SUSE/3.1.20 Thunderbird/3.1.20
In-Reply-To: <CA+39Oz7m1hGrTEdpSAjBP3EDFSVyKdc6T9CORcwQkjuEbvD4Ug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195507>

Am 14.04.2012 15:15, schrieb Thomas Adam:
> The commits though coming from "git log" in RepoA touch files in
> distrib/build/sources/coretree/tree, yet the files to which I want the
> changes for in RepoB are not in "distrib/build/sources/coretree/tree"
> -- there all in "./" at the top-level directory for RepoB.  The files
> in both once shared the same history -- it's just that now the
> locations of those files in RepoB which have changed.
> 
> I want to cherry-pick the commits I obtained from the "git log"
> command in RepoA, and have them contained in RepoB.  So I thought
> something like this would work:
> 
> [ In RepoB.... ]:
> % git remote add repoA file:///path/to/repoA/
> % git fetch repoA
> % git checkout specific/branch
> % git cherry-pick $SOME_COMMIT_FROM_REPOA

You have these histories


  A--o--B--C--o--o--D--o--E   <- RepoA

  A'----B'-C'                 <- RepoB

and you want to cherry-pick D and E to RepoB. Right?

I suggest that you install a graft in RepoB, then cherry-pick D and E:

  echo $(git rev-parse C' C) >> .git/info/grafts
  git cherry-pick D
  git cherry-pick E

Then it will look as if everything outside the directory was removed,
and everything else was moved from the directory to the root with 100%
similarity, which makes the merge process easy. (This works only if
there are no files with the same names in C's and C''s root; a Makefile
in each would pose a problem.)

(Remove the graft when you're done.)

-- Hannes
