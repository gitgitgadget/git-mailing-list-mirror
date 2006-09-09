From: linux@horizon.com
Subject: Re: Change set based shallow clone
Date: 9 Sep 2006 06:31:57 -0400
Message-ID: <20060909103157.23388.qmail@science.horizon.com>
Cc: git@vger.kernel.org, linux@horizon.com
X-From: git-owner@vger.kernel.org Sat Sep 09 12:32:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GM08B-0001fp-10
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 12:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWIIKb7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 06:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWIIKb7
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 06:31:59 -0400
Received: from science.horizon.com ([192.35.100.1]:36135 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751217AbWIIKb7
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Sep 2006 06:31:59 -0400
Received: (qmail 23389 invoked by uid 1000); 9 Sep 2006 06:31:57 -0400
To: mcostalba@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26743>

> If the out of order revisions are a small amount of the total then
> could be possible to have something like
> 
> git rev-list --topo-order --with-appended-fixups HEAD
> 
> Where, while git-rev-list is working _whithout sorting the whole tree
> first_, when finds an out of order revision stores it in a fixup-list
> buffer and *at the end* of normal git-rev-lsit the buffer is flushed
> to receiver, so that the drawing logic does not change and the out of
> order revisions arrive at the end, already packed, sorted and prepared
> by git-rev-list.

I don't think I understand your proposal.  The problem arises when
git-rev-list finds a commit that it should have listed before something
that it has already output.

Just for example:

Commit D: Ancestor B
Commit B: Ancestor A
Commit C: Ancestor B

Commit C is the problem, because if git-rev-list has already output B,
there's no way to back up and insert it in the right place.

How is waiting to output the already-behind-schedule commit C going
to help anything?  The idea in gitk is to rewind the layout algorithm
to before B was added, insert C, and replay from there.  This is
most efficient if C is encountered as soon after its correct place
as possible.
