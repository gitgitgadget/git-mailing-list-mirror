From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/6] Fix some "printf format" warnings.
Date: Wed, 14 Mar 2007 16:41:52 -0700
Message-ID: <7vd53b5r5r.fsf@assigned-by-dhcp.cox.net>
References: <45E9BE46.1020801@ramsay1.demon.co.uk>
	<7v4pp29eok.fsf@assigned-by-dhcp.cox.net>
	<45EAFD21.6010002@ramsay1.demon.co.uk> <45F55DC5.8060702@fs.ei.tum.de>
	<7vfy8as129.fsf@assigned-by-dhcp.cox.net>
	<45F87DC7.7020503@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Mar 15 00:42:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRd6f-0005sB-6w
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 00:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbXCNXly (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 19:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbXCNXly
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 19:41:54 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:47939 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964838AbXCNXlx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 19:41:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314234152.PMN1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 19:41:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id anhs1W00m1kojtg0000000; Wed, 14 Mar 2007 19:41:53 -0400
In-Reply-To: <45F87DC7.7020503@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Wed, 14 Mar 2007 22:57:11 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42252>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

>>> printf("%s%06"PRIo32" %s %d\t", tag, ntohl(ce->ce_mode), ...)
>>>
>>> that's the correct and allegedly portable way I guess.

I do not think this is really worth it.

    printf("%s%06o %s %d\t", tag, (unsigned) ntohl(ce->ce_mode), ...

is perfectly readable for even old timers about git, as long as
they know traditional C and what ntohl() is.  And ce->ce_mode
even fits in 16-bit, so while we are _not_ supporting platforms
whose unsigned int is 16-bit, the above cast is not losing any
useful precision either.

> (the symbols being: uint32_t, uint64_t, uint16_t, uintmax_t)

I think we would want these exact-sized integer types, so if
they are missing the platform ports may want to supply their own
substitute.
