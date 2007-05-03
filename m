From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: "bisect run" can be given bangs before the run script.
Date: Wed, 02 May 2007 22:29:42 -0700
Message-ID: <7vmz0m3261.fsf@assigned-by-dhcp.cox.net>
References: <20070503070607.fa2ffe92.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu May 03 07:30:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjTt8-00086I-0U
	for gcvg-git@gmane.org; Thu, 03 May 2007 07:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766556AbXECF3q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 01:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767388AbXECF3p
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 01:29:45 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:58783 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766556AbXECF3o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 01:29:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070503052942.XRSV24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Thu, 3 May 2007 01:29:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id uVVj1W0031kojtg0000000; Thu, 03 May 2007 01:29:43 -0400
In-Reply-To: <20070503070607.fa2ffe92.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 3 May 2007 07:06:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46064>

I am not convinced that '!' is a good extension for two and half
reasons.

 * The expected use is not quite clear.  If it is not used to
   run a custom test script but something stock as "make", by
   the nature of UNIX exit status convention, you are looking
   for the commit that _fixed_ some breakage (i.e. "which commit
   fixed the compilation error?").  While sometimes that is a
   useful thing to do, it feels somewhat of limited value.

   On the other hand, if you are running a custom test script, I
   do not think it is unreasonable to always require that a test
   script to signal "bad" with small non-zero, "good" with zero,
   and error with high non-zero status, as we already do.

 * How should this interact with the "high non-zero status means
   an error and we cannot bisect" return convention?

 * I was hoping that we can officially support "don't know,
   cannot test this one, please give me another" for interactive
   use, and at the same time allow the run-script used by
   "git bisect run" to signal such with a special exit value
   (perhaps "exit 42").  Taken together with the previous point,
   it is not clear how '!' should interact with such an
   enhancement.
