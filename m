From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] rebase -i: auto-squash commits
Date: Thu, 18 Jun 2009 09:20:11 +0200
Message-ID: <4A39EAAB.70402@alum.mit.edu>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>	<43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>	<7vvdmurfao.fsf@alter.siamese.dyndns.org> <20090618063348.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 09:21:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHBvf-0005mr-3G
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 09:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474AbZFRHUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 03:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753429AbZFRHUs
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 03:20:48 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:35838 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034AbZFRHUs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 03:20:48 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n5I7KEbD027049
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 18 Jun 2009 09:20:15 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.21) Gecko/20090318 Thunderbird/2.0.0.21 Mnenhy/0.7.6.666
In-Reply-To: <20090618063348.6117@nanako3.lavabit.com>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121798>

Nanako Shiraishi wrote:
> When the commit log message begins with "squash to ...", and there
> is a commit whose title begins with the same ..., automatically
> modify the todo list of rebase -i so that the commit marked for
> squashing come right after the commit to be modified, and change
> the action of the moved commit from pick to squash.

It seems to me that even this requires more steps than strictly
necessary, namely a commit then a rebase, and conveying the information
from the commit step to the rebase step is somewhat awkward.  Since I
have to specify a magic commit message to trigger this behavior, I
obviously know at the time of the commit that I want to squash the new
changes onto an older commit.  So why not implement this functionality
as a variant of "commit"?  Something like:

git commit --fix=old-commit

which would commit the changes in index as an amendment to the specified
old-commit (requiring no new log message) and then rebase later commits
on top of the new (combined) commit.

If a conflict arises while applying the changes in index to old-commit,
then probably the whole process should be undone and aborted.  If a
conflict arises while rebasing later commits on top of the combined
commit, then the usual rebase conflict-handling machinery would be invoked.

Michael
