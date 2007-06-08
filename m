From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix failed tag parsing when tag object has no body/message (and thus ends with a single '\n')
Date: Thu, 07 Jun 2007 23:05:38 -0700
Message-ID: <7vd507m159.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
	<Pine.LNX.4.64.0706080023450.4046@racer.site>
	<200706080147.50207.johan@herland.net>
	<200706080208.14571.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Jun 08 08:05:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwXbX-0004DB-QB
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 08:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbXFHGFk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 02:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752845AbXFHGFk
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 02:05:40 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:46487 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048AbXFHGFj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 02:05:39 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070608060539.PXMT9600.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Fri, 8 Jun 2007 02:05:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8u5e1X00B1kojtg0000000; Fri, 08 Jun 2007 02:05:39 -0400
In-Reply-To: <200706080208.14571.johan@herland.net> (Johan Herland's message
	of "Fri, 08 Jun 2007 02:08:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49437>

Johan Herland <johan@herland.net> writes:

> Thanks to Johannes Schindelin <Johannes.Schindelin@gmx.de> for
> discovering this.
>
> Also add a testcase for this condition.
>
> Signed-off-by: Johan Herland <johan@herland.net>

While this certainly is an improvement, I suspect that your
parse_tag() does a little too much.  In a format such as "tag"
object that does header + blank + body, it is customary to allow
header fields that your version does not understand (assuming
that such extention will go after the known fields is fine).

Which means that you should not be even saying "Ok, I've checked all
headers I know about---there should be a double LF to terminate it",
as you do not know if headers have ended.
