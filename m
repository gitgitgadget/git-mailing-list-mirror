From: Junio C Hamano <gitster@pobox.com>
Subject: Re: config-glob-octopus
Date: Sat, 16 Jun 2007 18:43:31 -0700
Message-ID: <7vtzt71hks.fsf@assigned-by-dhcp.pobox.com>
References: <Pine.LNX.4.64.0706162039530.4740@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Jun 17 03:43:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hzjni-0001iZ-1m
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 03:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756320AbXFQBnd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 21:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754311AbXFQBnc
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 21:43:32 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:37907 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbXFQBnc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 21:43:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070617014332.OEZD2558.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sat, 16 Jun 2007 21:43:32 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id CRjX1X0071kojtg0000000; Sat, 16 Jun 2007 21:43:31 -0400
In-Reply-To: <Pine.LNX.4.64.0706162039530.4740@iabervon.org> (Daniel
	Barkalow's message of "Sat, 16 Jun 2007 21:02:25 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50328>

Daniel Barkalow <barkalow@iabervon.org> writes:

> With this configuration:
>
> [remote "config-glob"]
> 	fetch = refs/heads/one:refs/remotes/rem/one
> 	fetch = refs/heads/two:refs/remotes/rem/two
> 	fetch = refs/heads/three:refs/remotes/rem/three
> [branch "br-config-glob-octopus"]
> 	remote = config-glob
> 	merge = refs/heads/one
> 	merge = two
> 	merge = remotes/rem/three
>
> It seems to me like "two" should be marked for merge, since "two" 
> canonicalizes to "refs/heads/two", which matches the pattern and is 
> fetched. However, current git-fetch marks it not-for-merge, and the test 
> demands this.
>
> Shouldn't the value of "merge" permit the same shortcuts that the lhs of 
> "fetch" permits, even if the matching fetch line isn't using them in this 
> case? (And vice versa, for a canonical value of merge when the fetch is a 
> shortcut)

I do not see much reason for that kind of complication.
Honestly speaking, I do not like the fallback that we use for
the third one (using the remote tracking name).

When you are righting down your configuration file, you are
doing so to reuse that entry over and over, so why not be
explicit for once and not worry about cases where the remote
adds ambiguous 'two' that is not refs/heads/two?
