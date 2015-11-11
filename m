From: Stanislav <s.seletskiy@gmail.com>
Subject: git clone --recursive should run git submodule update with flag --remote
Date: Wed, 11 Nov 2015 12:46:30 +0000 (UTC)
Message-ID: <loom.20151111T133121-436@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 13:50:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwUqu-0004je-U3
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 13:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563AbbKKMuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 07:50:09 -0500
Received: from plane.gmane.org ([80.91.229.3]:41315 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440AbbKKMuI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 07:50:08 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZwUqj-0004Wv-BK
	for git@vger.kernel.org; Wed, 11 Nov 2015 13:50:05 +0100
Received: from 195.19.70.32 ([195.19.70.32])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 13:50:05 +0100
Received: from s.seletskiy by 195.19.70.32 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 13:50:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 195.19.70.32 (Mozilla/5.0 (X11; Linux x86_64; rv:41.0) Gecko/20100101 Firefox/41.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281162>

Consider two repositories, A and B.

Repo A is embedded into B by using submodule:

  git submodule add -b master <url-to-A> sub-a

So, submodule sub-a is set to track master branch of the repo A.

Running git submodule update --remote inside repo B will automatically
update and checkout submodule sub-a to the latest master commit (as expected).

However, when using git clone --recursive <url-to-B>, repo B will be cloned
with submodule A checkouted to the commmit which was recorded on git
submodule add command, not the master commit.

Expected behaviour is to automatically update checkout commit pointed by
branch, that was specified by -b flag in the git submodule add invocation.

Reason for this behaviour is that line:

  https://github.com/git/git/blob/master/builtin/clone.c#L99

I guess, it should be changed to include --remote flag.
