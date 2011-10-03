From: Mattias Jiderhamn <mj-lists@expertsystems.se>
Subject: Symbolic references updated by fetch?
Date: Mon, 3 Oct 2011 08:47:55 +0000 (UTC)
Message-ID: <loom.20111003T104608-738@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 11:10:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAeXP-0003Xr-I7
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 11:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963Ab1JCJKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 05:10:11 -0400
Received: from lo.gmane.org ([80.91.229.12]:54265 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844Ab1JCJKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 05:10:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RAeXF-0003Tt-T4
	for git@vger.kernel.org; Mon, 03 Oct 2011 11:10:07 +0200
Received: from 84.19.131.18 ([84.19.131.18])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 11:10:05 +0200
Received: from mj-lists by 84.19.131.18 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 11:10:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 84.19.131.18 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20100101 Firefox/7.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182640>

In our current CVS setup, we have two separate builds in Jenkins CI; one for the
latest and greatest (head of "master" branch) and one for the last/current minor
release of the latest major release. The revisions to include in the minor
release build will be tagged with a tag we can call "next-minor-release" here.
Individual files are branched as needed and the "next-minor-release" tag is
moved onto the branch. The Continuous Integration job will fetch and build the
"next-minor-release" tag. As part of a major release, the "next-minor-release"
tag is moved to the head of the main branch again.

When moving to GIT, the natural thing will be a hotfix branch originating from
each major release. In order to have a fixed name for the current hotfix branch,
primarily for the CI but also simplifying for developers working with hotfixes,
it seems git symbolic-ref will do the trick. After the first major release we
can do something like this in our bare repository whereto developers push and
where from Jenkins pulls code to build:
  git symbolic-ref refs/heads/current-hotfix-branch refs/heads/release-1-hotfixes
and after the next major release, we simply move the referece pointer, as such
  git symbolic-ref refs/heads/current-hotfix-branch refs/heads/release-2-hotfixes

HOWEVER this seems to require that everyone fetching/pulling from that repo -
Jenkins included - delete their local "current-hotfix-branch" tracking branch,
and then refetch it.

Is there an easier way to solve the CI problem, eliminating the need to
explicitly deleting the tracking branch on all remote repos every time the
symbolic ref is moved i.e. at every major release?
How have others solved this? Do you simply reconfigure Jenkins every time...?

Thanks in advance.
