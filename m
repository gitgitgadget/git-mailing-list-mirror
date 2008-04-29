From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Excruciatingly slow git-svn imports
Date: Tue, 29 Apr 2008 00:03:55 -0700
Message-ID: <20080429070355.GF24171@muzzle>
References: <CC0F600D-71F3-493A-AA9C-AF901C1A58C4@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>,
	Adam Roben <aroben@apple.com>
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 09:04:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqjtN-0005Bk-AD
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 09:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755626AbYD2HD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 03:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755364AbYD2HD5
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 03:03:57 -0400
Received: from hand.yhbt.net ([66.150.188.102]:53637 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754487AbYD2HD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 03:03:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id DD8062DC08B;
	Tue, 29 Apr 2008 00:03:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CC0F600D-71F3-493A-AA9C-AF901C1A58C4@adacore.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80658>

Geert Bosch <bosch@adacore.com> wrote:

> Before trying to brush up my Perl and propose patching fixes for this
> (I doubt the extra execve's take much time at all), I was wondering why
> we don't open a single stream to git-fast-import and have it do
> the heavy lifting. Are there fundamental issues with this?

Last I checked, fast-import doesn't allow rereading freshly imported
objects before that particular fast-import instance is finished running.

Since git-svn imports deltas from SVN instead of full files, so it often
needs to reread objects it imported in the same run to make use of
deltas.

However, Adam Roben's been working on some improvements to git-cat-file
which allow it to avoid many fork+exec calls.  The tests and some code
have some outstanding issues, but the code appears to work, and I'm sure
Adam would love to have you test it more for him :)

 http://thread.gmane.org/gmane.comp.version-control.git/80240

-- 
Eric Wong
