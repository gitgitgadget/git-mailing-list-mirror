From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Questions on passing --depth to git-clone vs. git-fetch
Date: Wed, 6 Jan 2016 13:30:19 +0100
Message-ID: <n6j1cs$p4$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 06 13:30:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGnEh-0001c2-OW
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 13:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbcAFMak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 07:30:40 -0500
Received: from plane.gmane.org ([80.91.229.3]:38867 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989AbcAFMaj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 07:30:39 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aGnEb-0001YI-73
	for git@vger.kernel.org; Wed, 06 Jan 2016 13:30:37 +0100
Received: from 131.228.216.134 ([131.228.216.134])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 13:30:37 +0100
Received: from sschuberth by 131.228.216.134 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 13:30:37 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 131.228.216.134
X-Mozilla-News-Host: news://news.gmane.org:119
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283436>

Hi,

I recently compared the results of doing

    $ git clone --depth=1 https://github.com/git/git.git git-clone-depth-1

versus

    $ mkdir git-fetch-depth-1
    $ cd git-fetch-depth-1
    $ git init
    $ git remote add origin https://github.com/git/git.git
    $ git fetch --depth=1

and noticed a few things:

1. The docs of clone [1] say about --depth "Create a shallow clone with a history truncated to the specified number of revisions" while for fetch the docs [2] say "[...] to the specified number of commits [...]". As in this particular case revision are always commits, I think the clone docs should also say "commits".

2. In the fetch docs --depth is described to "Deepen or shorten the history of a shallow repository created by git clone". That sounds as if my example from above where I initialze a repo manually would not allow fetch to be called with --depth as I did not clone before. But in fact my example works fine. I guess we need some clarfication in the wording here.

3. When running "git log --all -oneline" in the two working trees I get different results, which is not what I'd expect:

    $ cd git-clone-depth-1
    $ git log --all --oneline
      7548842 Git 2.7

versus

    $ cd git-fetch-depth-1
    $ git log --all --oneline
      b819526 Merge branch 'jk/notes-merge-from-anywhere' into pu
      e2281f4 What's cooking (2016/01 #01)
      ef7b32d Sync with 2.7
      7548842 Git 2.7
      833e482 Git 2.6.5

So in the clone case only the specified number of commits from the tip of the default branch (master in this case) is fetched, not of each remote branch history. fetch in the other hand really gets the specified number of commits from the tip of each remote branch history. I don't know whether this behavior is inded or not as I cannot find any docs on it either way. But it seems inconsistent to me that clone with --depth only gets the history for the default branch, as clone without --depth would give me the history of all branches.

For completeness, I'm using Git for Windows 2.7.

Any comments?

[1] https://git-scm.com/docs/git-clone
[1] https://git-scm.com/docs/git-fetch

-- 
Sebastian Schuberth
