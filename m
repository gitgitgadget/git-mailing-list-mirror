From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PU PATCH] Fix git fetch for very large ref counts
Date: Mon, 12 Feb 2007 19:18:07 -0800
Message-ID: <7vd54e4ufk.fsf@assigned-by-dhcp.cox.net>
References: <11713297014015-git-send-email-julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Julian Phillips" <jp3@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Feb 13 04:18:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGoBJ-0004LA-Uo
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 04:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030637AbXBMDSL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 22:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030630AbXBMDSL
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 22:18:11 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:57405 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030637AbXBMDSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 22:18:09 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070213031808.ZQNT21668.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Mon, 12 Feb 2007 22:18:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NrJ81W00j1kojtg0000000; Mon, 12 Feb 2007 22:18:09 -0500
In-Reply-To: <11713297014015-git-send-email-julian@quantumfyre.co.uk> (Julian
	Phillips's message of "Tue, 13 Feb 2007 01:21:38 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39484>

"Julian Phillips" <jp3@quantumfyre.co.uk> writes:

> The updated git fetch in pu is vastly improved on repositories with very
> large numbers of refs.  The time taken for a no-op fetch over ~9000 refs
> drops from ~48m to ~0.5m.
>
> However, before git fetch will actually run on a repository with ~9000
> refs the calling interface between fetch and fetch--tool needs to be
> changed.  The existing version passes the entire reflist on the command
> line, which means that it is subject to the maxiumum environment size
> passed to a child process by execve.
>
> The following patches add a stdin based interface to fetch--tool allowing
> the ~9000 refs to be passed without exceeding the environment limit.

Thanks.

But the ones in 'pu' were done primarily as demonstration of
where the bottlenecks are, and not meant for real-world
consumption.  I think the final shaving of 0.5m down to a few
seconds needs to move the ls_remote_result string currently kept
as a shell variable to a list of strings represented in a
git-fetch largely rewritten in C, and at that point the
interface from outside fetch--tool to throw 9000 refs at it
would be an internal function call and the code you fixed along
with new function you introduced would probably need to be
discarded.
