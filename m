From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH] git-daemon: Simplify child management and associated logging by
Date: Wed, 13 Aug 2008 00:56:42 +0200
Message-ID: <20080812225642.GA15265@cuci.nl>
References: <20080812193613.32388.92145.stgit@aristoteles.cuci.nl> <20080812212534.6871.19377.stgit@aristoteles.cuci.nl> <7vzlnhq48b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 00:58:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT2od-0005hl-Bh
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 00:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbYHLW4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 18:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbYHLW4n
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 18:56:43 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:52360 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbYHLW4n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 18:56:43 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 13D255465; Wed, 13 Aug 2008 00:56:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vzlnhq48b.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92150>

Junio C Hamano wrote:
>"Stephen R. van den Berg" <srb@cuci.nl> writes:
>Sorry, but this does too many things in one patch.

Yes, I know, got carried away.  Then again, the code has a lot of
overlapping places (spacewise); I kind of leapt from one place to the
next; you fix one thing, and then the next wart stares you in the face.
I'll see if I can split it up, if that suits you better.

> - Taking advantage of poll() getting interrupted by SIGCHLD, so that you
>   do not have to do anything in the signal handler, is so obvious that I
>   am actually ashamed of not having to think of it the last time we
>   touched this code.  Is there a poll() that does not return EINTR but
>   just call the handler and restart after that as if nothing has
>   happened, I have to wonder...

Only if the signal is set to SIG_IGN on all systems I worked with since
1987.

> - Conversion from silly fixed array to dynamic and configurable maximum
>   would be a good idea, but that is independent from the above, isn't it?

It is, but the code is on the same lines (in large parts).
Separating it causes two things:
a. The patches to become dependent on each other in the timeline.
b. More (redundant) work, because some parts that need to be rewritten, get
   deleted by the following patch(es).

> - I see you have a call to vsyslog, which is the first user of the
>   function.  How portable is it (the patch coming from you, I know
>   Solaris would have it, and recent 4BSD also would, but what about the
>   others)?

Cygwin has it, Solaris does, Linux does, MacOSX does.
AIX and HPUX don't, perhaps.
I'll see what I can do to avoid it, yet simplify the code.
-- 
Sincerely,
           Stephen R. van den Berg.

Father's Day Special at the local clinic -- Vasectomy!
