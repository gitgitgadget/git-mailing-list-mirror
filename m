From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff looping?
Date: Tue, 16 Jun 2009 09:51:24 -0700
Message-ID: <7v3aa0dsvn.fsf@alter.siamese.dyndns.org>
References: <3ae83b000906151837r186221f2q1f8a670f13841877@mail.gmail.com>
	<20090616114726.GA4343@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Bito <jwbito@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 16 18:51:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGbsg-0003pE-Kg
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 18:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759180AbZFPQvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 12:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758941AbZFPQvX
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 12:51:23 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:33106 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758405AbZFPQvW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 12:51:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090616165125.NJBH20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 16 Jun 2009 12:51:25 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 4grQ1c00R4aMwMQ03grQWm; Tue, 16 Jun 2009 12:51:24 -0400
X-VR-Score: -130.00
X-Authority-Analysis: v=1.0 c=1 a=PKzvZo6CAAAA:8 a=uiXLmWGX7og-xaOucUkA:9
 a=NbL_lHeV2Dvf7Y7KZ6I-aMflDy4A:4 a=OdWmie4EkE0A:10
X-CM-Score: 0.00
In-Reply-To: <20090616114726.GA4343@coredump.intra.peff.net> (Jeff King's message of "Tue\, 16 Jun 2009 07\:47\:26 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121688>

Jeff King <peff@peff.net> writes:

> I can reproduce the problem on Solaris 8 using git v1.6.3. It seems to
> be caused by a horribly slow system regex implementation; it really
> chokes on the regex we use to find the "funcname" line for java files.

Hmm.  Is running under LC_ALL=C LANG=C _with_ the slow system regex help?

> I tried building against the code in compat/regex; it completes in a
> reasonable amount of time, though it is still noticeably slow. With
> system regex, the diff given above doesn't complete in less than 90
> seconds (at which I get bored and kill it). With compat/regex, it
> completes in about 2.2 seconds. Disabling the xfuncname, it completes in
> 0.14 seconds.

In this particular case it is clear that a good way to fix the problem is
to replace Solaris's dumb regex implemention with what comes in compat/,
but I at the same time have to wonder if that funcname pattern for java
can somehow be simplified, so that it does not to require so sophisticated
implementation of regexp?
