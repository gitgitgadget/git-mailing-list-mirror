From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 0/2] gitweb: gravatar support
Date: Sun, 21 Jun 2009 15:34:11 -0700
Message-ID: <7vab41qkrg.fsf@alter.siamese.dyndns.org>
References: <1245607025-19296-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Aaron Crane <git@aaroncrane.co.uk>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 00:34:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIVcE-0002Nb-65
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 00:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbZFUWeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 18:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbZFUWeL
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 18:34:11 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:52056 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbZFUWeK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 18:34:10 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090621223412.VKXM20976.fed1rmmtao102.cox.net@fed1rmimpo03.cox.net>;
          Sun, 21 Jun 2009 18:34:12 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 6maC1c0034aMwMQ04maCKa; Sun, 21 Jun 2009 18:34:12 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=9ARE-nLc19oA:10 a=pGLkceISAAAA:8
 a=Lra2EXH2NotomWa3MnsA:9 a=rgsxRx7JdbZ6L6p57ENGxm3HWgwA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <1245607025-19296-1-git-send-email-giuseppe.bilotta@gmail.com> (Giuseppe Bilotta's message of "Sun\, 21 Jun 2009 19\:57\:03 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121996>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> I've done the refactoring in a separate patch, to have a better (IMO)
> view of what I was doing. I can squash them together if needed.

I personally think squashing won't add much value in this case, but I
think swapping would.

The recommended order is that refactor and clean-up come first and then a
new feature is built on the base that is made more solid, thanks to the
refactoring.  That allows the reviewers to see and judge the extent of
damage to the codebase caused by the new feature more fairly.

For example, adding a new feature to an unclean codebase may have to touch
ten different places to add the same code, which would make the feature
look expensive and intrusive.

But if you first refactor the codebase cleanly, these ten places will be
calling a single helper function, and you may be able to add the new
feature by touching only one place, the helper function.  It would be
clear that the change is not intrusive if presented in such an order.

This is a tangent, but the key to a better design is to try to resist the
templation to think that yours will be the last cool feature.  If you
think "with addition of gravatar, the authorship display is complete",
then there is no reason to name the subroutine that is called by
"git_print_authorship" anything but "get_gravatar".  If you resist the
temptation, however, you would realize that other people may want to add
support for different sources of person-label sources, and try to come up
with a more generic name to call it [*1*].

I would not change the name of variable $git_gravatar_enabled, though.
That way, people who would want other kinds of personal-icons can add an
else-if to the sub, without changing other things.


[Footnote]

*1* To put it differently, you can tell where one's imagination ends by
looking at the way that person refactors a piece of code and gives names.
A concrete name (e.g. "gravatar") shows where the boundary of abstraction
lies in that person's imagination.  The patch shows that it was done by
somebody who never thought of the possibility that git_print_authorship
might be able to use service other than gravatar to show small icons
associated with an email if other people build on top of his work.
