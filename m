From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Dumb "continuous" commit dumb question
Date: Tue, 19 Aug 2008 07:48:53 -0700
Message-ID: <20080819144853.GD20947@spearce.org>
References: <48AA4263.8090606@gmail.com> <e1dab3980808190732i303f06ach50e36e13a624bd23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pat LeSmithe <qed777@gmail.com>, git@vger.kernel.org
To: David Tweed <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 16:50:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVSWz-00089Q-M6
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 16:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbYHSOsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 10:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbYHSOsy
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 10:48:54 -0400
Received: from george.spearce.org ([209.20.77.23]:37470 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbYHSOsx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 10:48:53 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 109DF38375; Tue, 19 Aug 2008 14:48:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <e1dab3980808190732i303f06ach50e36e13a624bd23@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92868>

David Tweed <david.tweed@gmail.com> wrote:
> What I do is have a script that runs every 10 minutes that stages
> files to the index and then, using the low-level git plumbing, creates
> tree and commit objects on a side branch "temp". With this you can
> easily commit to the main branch "main" PROVIDING you are commiting a
> superset of the changes you're storing to the side-branch.

Have the script use "export GIT_INDEX_FILE=.git/temp-branch-index"
so that it stages changes into an index which isn't the main one,
and thus has no impact on the main branch.  Thus you can still
commit a subset of the temp branch at any time.

Actually you can do something like this:

	export GIT_INDEX_FILE=.git/temp-branch-index &&
	cp .git/index $GIT_INDEX_FILE &&
	git add . &&
	git add -u &&
	git update-ref refs/heads/temp $(date | git commit-tree $(git write-tree) -p temp)

;-)

-- 
Shawn.
