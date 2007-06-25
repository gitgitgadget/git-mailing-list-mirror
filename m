From: Junio C Hamano <gitster@pobox.com>
Subject: Re: DWIM ref names for push/fetch
Date: Sun, 24 Jun 2007 17:09:14 -0700
Message-ID: <7v3b0gq4id.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706241808550.4740@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jun 25 02:09:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2c8r-00009T-PA
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 02:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbXFYAJQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 20:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbXFYAJQ
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 20:09:16 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:46749 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbXFYAJP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 20:09:15 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070625000915.RJOQ17635.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 24 Jun 2007 20:09:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Fc9E1X00T1kojtg0000000; Sun, 24 Jun 2007 20:09:15 -0400
In-Reply-To: <Pine.LNX.4.64.0706241808550.4740@iabervon.org> (Daniel
	Barkalow's message of "Sun, 24 Jun 2007 18:25:12 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50850>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Is this difference simply due to the different languages the matching 
> portions of these were originally written in?

If anything, the semantics on the fetch side is _very_ much
intentional and is done deliberately that way to be usable.  

On the other hand, push started as "matching only", and then
"match tail part of the name" as an afterthought.  It was so
afterthought that it had an idiotic behaviour of independently
match the source and destination side even when there is no
colon, which was fixed only recently.

So if you would want to match fetch and push, you should not
change the semantics on fetch to match what push does, as the
latter was done pretty much without design.

Having said that, I think fetch and push DWIMmery are
fundamentally different, especially when you do not have a
colon.  push without storing anything on the receiving end would
not make any sense whatsoever, but fetch without using tracking
branches does make perfect sense, so push does pretend dst side
has what matched with src side pattern, while fetch treats no
colon pattern as not storing.  IOW, even if we wanted to reuse
the code on both sides as much as possible, I suspect we would
need to have details different between them.
