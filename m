From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsserver: Complete rewrite of the configuration parser
Date: Sat, 12 May 2007 15:43:56 -0700
Message-ID: <7v3b21wtlf.fsf@assigned-by-dhcp.cox.net>
References: <7v8xbvj5mx.fsf@arte.twinsun.com>
	<11789982521112-git-send-email-frank@lichtenheld.de>
	<7v4pmhyfre.fsf@assigned-by-dhcp.cox.net>
	<20070512213153.GC7184@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin.langhoff@gmail.com>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sun May 13 00:44:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn0Jm-0006nK-Kq
	for gcvg-git@gmane.org; Sun, 13 May 2007 00:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbXELWn6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 18:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbXELWn6
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 18:43:58 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:44181 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342AbXELWn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 18:43:57 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512224357.YIWB22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 12 May 2007 18:43:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id yNjv1W00U1kojtg0000000; Sat, 12 May 2007 18:43:56 -0400
In-Reply-To: <20070512213153.GC7184@planck.djpig.de> (Frank Lichtenheld's
	message of "Sat, 12 May 2007 23:31:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47102>

Frank Lichtenheld <frank@lichtenheld.de> writes:

> On Sat, May 12, 2007 at 12:59:49PM -0700, Junio C Hamano wrote:
>> But all of this is post 1.5.2 material; we would want to have a
>> minimal fixup on 'master' before 1.5.2, independent of this
>> rewrite.
>
> Fair enough. So far I see three very minimal solutions, but I can't
> decide which one is the least ugly:
>
> (For all we can begin by limiting the used variables to
> ^gitcvs.((ext|pserver).)? )

That sounds sensible.  And ignore anything that do not match.

> 1) Drop variables named gitcvs.ext and gitcvs.pserver manually

I do not see any need for this; gitcvs.ext or gitcvs.pserver as
variables do not exist, at least right now.  The breakage was
purely that the old parser tried to parse things it does not
even know about (e.g. diff.color) without knowing the rules
there.

> 2) Use the complete variable name as key to the hash instead of
>    using a hash of hashes of hashes
>    { "diff.color => "auto",
>      "diff.color.whitespace" => "blue reverse" }

No need for this nor the next one either.  You understand only
gitcvs.<option> or gitcvs.<method>.<option>, and you know there
is no string that is common in <option> and <method>

> 3) Make the second level always a hash, instead of using a string
>    directly, so that Junio's example would look like this
>    { diff => { color => { value => "auto",
>    			  whitespace => "blue reverse" } } }
>
>
> Opinions?
