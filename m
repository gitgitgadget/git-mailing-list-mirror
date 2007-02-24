From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] object name: introduce ':::<oneline prefix>' notation
Date: Fri, 23 Feb 2007 17:18:42 -0800
Message-ID: <7vzm741hfx.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702231930290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0702232347310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 24 02:18:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKlYs-0006Oa-9Y
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 02:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933300AbXBXBSo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 20:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933305AbXBXBSo
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 20:18:44 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:53402 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933300AbXBXBSn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 20:18:43 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070224011843.PSLD2394.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Fri, 23 Feb 2007 20:18:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TDJi1W00f1kojtg0000000; Fri, 23 Feb 2007 20:18:43 -0500
In-Reply-To: <Pine.LNX.4.63.0702232347310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 23 Feb 2007 23:48:38 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40477>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 23 Feb 2007, Johannes Schindelin wrote:
>
>> To name a commit, you can now say
>> 
>> 	git rev-parse ':::Initial revision of "git"'
>
> Alex Riesen and Shawn Pearce suggested ":/" instead of ":::", to reflect 
> the searching nature ("/" is the key to search in "less" output).
>
> Comments?

Sounds good.  "git show :/path" does not currently mean "find
/path in the index", so I do not see offhand it would interfere
with anything.

However, it would be worthwhile to plant an escape hatch for
future extension.  Using short-and-sweet ":/" for the most
common case such as exact prefix match would be fine, but we
might want to say:

	':/!' syntax is reserved for future extension and does
	not look for a string that begins with "!".
	one extension "do not do anything special" is defined
	and is spelled as "!!" - so if you want to look for a
	commit that begins with "!something", please spell it
	as ':/!!something'

or something like that.

Obvious extension possibilities include:

	":/!(r=regexp)"
        ":/!(a=author)"
	":/!(d=2001-09-17)"
	":/!(p=Documentation/)"

or various combination of them e.g.

	":!(p=Documentation/)!(a=Johannes)Update command list"

to look for a commit by Johannes that touches Documentation/
area and oneline begins with "Update command list".

By the way, where do you start digging from?  From all refs?
