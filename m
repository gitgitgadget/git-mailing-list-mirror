From: Junio C Hamano <junkio@cox.net>
Subject: Re: Possible regression in git-rev-list --header
Date: Tue, 02 Jan 2007 14:13:45 -0800
Message-ID: <7vps9xrs9y.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com>
	<Pine.LNX.4.63.0612301955340.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v7iw9jftv.fsf@assigned-by-dhcp.cox.net>
	<7vlkkphvrb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612310211300.25709@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v64bsj0s4.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550612310345j4c882b7av51879ca1175a1c6b@mail.gmail.com>
	<Pine.LNX.4.63.0612311613180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<e5bfff550612310743t4ca1b017ubceddffafd06ac59@mail.gmail.com>
	<7vodpja0u8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701022219050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 23:13:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1rtH-0007ab-JL
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 23:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991AbXABWNs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 17:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932907AbXABWNs
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 17:13:48 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:42391 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754991AbXABWNr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 17:13:47 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070102221346.NDQS3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Tue, 2 Jan 2007 17:13:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6NCy1W00r1kojtg0000000; Tue, 02 Jan 2007 17:12:59 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701022219050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 2 Jan 2007 22:32:24 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35829>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> The reason we did the latter, by the way, does not have anything
>> to do with helping broken parsers.  We drop the header after
>> re-coding the log message into an encoding specified by the user
>> (which is presumably different from what the commit was
>> originally recorded in) because the encoding recorded on
>> "encoding" header would not match the re-coded log message
>> anymore.
>
> By the same reasoning, you'd have to rewrite the committer line to reflect 
> the current GIT_COMMITTER_IDENT, or hide it. If you want to convince me, 
> you have to try harder.

Sorry, but you completely lost me with that analogy.

I think showing log message in the user's preferred encoding is
more like passing the output to the colorization mechanism and
then to the pager.  We are interacting with humans at that
point, and we are changing the presentation without changing the
semantics of the data.  

I do not see why committer identity needs to be rewritten nor
hidden by the same reasoning.

> And Marco has to fix the header parsing anyway.

No question about that.  If iconv() punts, qgit will see
"encoding" header to deal with even when the re-coding is in
effect.  I think it may be a sensible thing for qgit to replace
the log message and show "log message in this encoding, which
cannot be shown in this window" instead in such a case, but that
is up to Porcelain.
