From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: rebasing merges
Date: Tue, 23 Sep 2008 02:46:53 -0500
Organization: Exigence
Message-ID: <20080923024653.a3bb8666.stephen@exigencecorp.com>
References: <20080922155749.c8070681.stephen@exigencecorp.com>
	<20080922231927.ef18f420.stephen@exigencecorp.com>
	<48D88813.9060400@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 23 09:48:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki2cz-0000Jq-6P
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 09:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbYIWHq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 03:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752097AbYIWHq7
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 03:46:59 -0400
Received: from smtp152.sat.emailsrvr.com ([66.216.121.152]:40164 "EHLO
	smtp152.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbYIWHq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 03:46:59 -0400
Received: from relay5.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay5.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 6C202251EAB;
	Tue, 23 Sep 2008 03:46:58 -0400 (EDT)
Received: by relay5.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id AE6CC24AED7;
	Tue, 23 Sep 2008 03:46:57 -0400 (EDT)
In-Reply-To: <48D88813.9060400@viscovery.net>
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96531>


> This is the expected behavior and not up for debate.

Cool, thanks for the reply. However, I debate... :-)

>   ---o--o--o--o--o--o         <-- origin
>                      \
>                       A'--B'  <-- master

Nice. That makes sense in your scenario.

Here is mine:

 ---A--B--C--D           <-- origin/stable
     \       |
      E--F   |           <-- origin/topica
          \  |
             g--h        <-- topica

All the upper case commits have been published to origin. Other
devs, etc., know about them, their hashes are in the bug tracking
system.

I'm bringing topica up to date, but with a merge because I have
published history already on topica, so I merge stable and get a
new merge commit: g. And maybe make another change: h.

Everything's cool...now, with surprising frequency, someone beats
me to moving origin/topica:

 ---A--B--C--D           <-- origin/stable
     \       |
      E--F---|--I        <-- origin/topica
          \  |
             g--h        <-- topica

Pushing h gets rejected as a rewind. Good. I want to pull, which
we had previously always used "--rebase" for, and the desired output
of a pull --rebase, to me, would be:

 ---A--B--C--D           <-- origin/stable
     \        \
      E--F--I |          <-- origin/topica
             \|
              g'--h'     <-- topica

Instead, I get:

 ---A--B--C--D           <-- origin/stable
     \
      E--F--I            <-- origin/topica
             \
              B'-C'-D'-h'<-- topica

So, yes, linearized history with no merges. However, this leads
to quizzical looks when B'/C'/D' hit the email list, bug tracker, etc.
as new commits.

Currently I just try to pull/merge/push in quick succession, but
it's a manual collaboration hack ("okay, I'm merging now, no
committing...") that would be nice to not have to worry about.

I need to investigate the interactive rebase more, but my hesitant
assertion is that it's parent rewriting seems smart enough to handle
this. Perhaps not, and I admit our desired DAG output may not be
attainable without manual intervention.

I apologize--I should have included the example DAGs in my first
post, but since I didn't I felt the need to clarify. So, humoring
me, is the B'/C'/D' from this example really the expected behavior?

I can work on a new test in t3400/etc. if that is of interest.

Thanks for your time,
Stephen
