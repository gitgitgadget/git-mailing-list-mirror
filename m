From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] Add 'filter' attribute and external filter driver  definition.
Date: Sat, 21 Apr 2007 23:33:38 -0700
Message-ID: <7v4pn8rk8t.fsf@assigned-by-dhcp.cox.net>
References: <11771520591529-git-send-email-junkio@cox.net>
	<11771520591703-git-send-email-junkio@cox.net>
	<Pine.LNX.4.63.0704211821560.5655@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Lang <david.lang@digitalinsight.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 08:33:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfVdp-0007Wx-8m
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 08:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbXDVGdk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 02:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbXDVGdk
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 02:33:40 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:36470 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964934AbXDVGdj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 02:33:39 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422063339.GWRE1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Apr 2007 02:33:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id q6Ze1W0051kojtg0000000; Sun, 22 Apr 2007 02:33:39 -0400
In-Reply-To: <Pine.LNX.4.63.0704211821560.5655@qynat.qvtvafvgr.pbz> (David
	Lang's message of "Sat, 21 Apr 2007 18:33:13 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45222>

David Lang <david.lang@digitalinsight.com> writes:

> 1. it would be useful in many cases for the filter program to know
> what file it's working on (and probably some other things), so there
> are probably some command-line arguments that should be able to be
> passed to the filter.

I can see that you missed the class when Linus talked about how
messy things would get once you allow the conversion to be
stateful.  I was in the class and remembered it ;-)

Although I initially considered interpolating "%P" with
pathname, I ended up deciding against it, to discourage people
from abusing the filter for stateful conversion that changes the
results depending on time, pathname, commit, branch and stuff.

> 2. should this be done as a modification of the in-memory buffer (s
> this patch does it?) or should it be done at the time of the
> read/write, makeing the filter be responsible for actually doing the
> disk I/O, which would give it the benifit of being able to do things
> like set permissions and other things ...

The conversion is not about overriding the mode bits recorded in
tree objects, nor making git as a replacement for build procedure.

> 3. why specify seperate clean/smudge programs instead of just one
> script with a read/write parameter?

I think the most common two ways have clean as a cleaner and
smudge as a no-op (similar to crlf=input conversion), or clean
and smudge are inverse operations (similar to crlf=true
conversion.  I do not see a sane case where clean and smudge are
the same, unless you are thinking about the toy demonstration
test piece I added to t0021 which uses rot13 as both clean and
smudge filters.
