From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and empty directories
Date: Sun, 21 Dec 2008 07:08:54 +0000
Message-ID: <20081221070854.GA22014@hand.yhbt.net>
References: <200812161353.49796.thomas.jarosch@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Deskin Miller <deskinm@umich.edu>, git@vger.kernel.org
To: Thomas Jarosch <thomas.jarosch@intra2net.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 08:13:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEIUy-0005F3-84
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 08:13:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbYLUHI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 02:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbYLUHI5
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 02:08:57 -0500
Received: from hand.yhbt.net ([66.150.188.102]:39234 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176AbYLUHI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 02:08:56 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 229742DC01A;
	Sun, 21 Dec 2008 07:08:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200812161353.49796.thomas.jarosch@intra2net.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103689>

Thomas Jarosch <thomas.jarosch@intra2net.com> wrote:
> Hello Eric and Deskin,
> 
> I'm currently looking into preserving empty directories from a SVN repository 
> by automatically creating empty .gitignore files for them.
> 
> The control flow of the git-svn code is still a jungle to me,
> maybe you have a hint how to implement a proof-of-concept code?
> 
> I don't think I can just touch a .gitignore file in get_untracked()
> and those files will magically turn up in git's index...

Hi Thomas,

Modern git-svn never touches the working tree during fetch, it hashes
objects into the database and adds those to the indexes directly.

However, I don't think your proposal is a good idea since it adds too
much "magic".  Complex special cases for delta application if the
.gitignore gets real content and backwards-incompatibility since I know
some git-svn users already rely on pushing .gitignore files (empty or
otherwise) to an upstream SVN repo.

The minor problem of missing empty directories isn't big enough to be
worth the trouble IMHO.

The unhandled.log is made to be machine parseable, so if somebody really
wanted to recreate empty direct after checkout, they could write a
script that parses it and creates it based on the history of the current
working tree.

-- 
Eric Wong
