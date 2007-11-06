From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] some shell portability fixes
Date: Tue, 06 Nov 2007 12:46:35 -0800
Message-ID: <7v8x5bgl04.fsf@gitster.siamese.dyndns.org>
References: <20071106201518.GA6361@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 06 21:46:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpVK7-0003iQ-ET
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 21:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223AbXKFUqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 15:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754203AbXKFUqp
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 15:46:45 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:35374 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139AbXKFUqo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 15:46:44 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 6ED912EF;
	Tue,  6 Nov 2007 15:47:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E665392E7A;
	Tue,  6 Nov 2007 15:47:02 -0500 (EST)
In-Reply-To: <20071106201518.GA6361@ins.uni-bonn.de> (Ralf Wildenhues's
	message of "Tue, 6 Nov 2007 21:15:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63723>

All missing Signed-off-by: lines.

[1/5] In addition to take advantage of the fact that the RHS of
      assignment is not split, I'd prefer replacing `` with $()
      with these cases.	 Much easier to read if your shell
      supports it (and all the modern ones do).

[2/5] Gaah, AIX sed X-<.  I am not opposed to this patch but
      would want to get Yays from people with non GNU sed.  Is
      busybox sed good enough to grok our scripts these days?
      Please ask help and collect Acks at least from folks on
      Solaris, MacOS, FBSD, and OBSD.

[3/5] Arithmetic expansion.  Have you caught _all_ of them, or
      is this patch about only the ones you noticed?

      We used to have expr all over the place as I was one of
      the primary authors of our shell scripts, and I am
      "80-ish" old fashioned.  There was a long discussion on
      scripts in the past and we ruled that $(( ... )) is easier
      to read and supported widely enough to be acceptable.

      This patch goes backwards.  Will drop, unless you can
      demonstrate that an implementation does not support it and
      convince people that the implementation is important.
      /bin/sh on Solaris does not count as you can configure
      SHELL_PATH to point at xpg4 shell or ksh on that platform.

[4/5] I wonder if use of fgrep would be easier to read and more
      portable with this one:

	name=$( GIT_CONFIG=.gitmodules \
		git config --get-regexp '^submodule\..*\.path$' |
		fgrep "submodule.$1.path" |
		sed -e 's/^submodule\.\(.*\)\.path$/\1/'
	)

[5/5] Again, have you covered all of them?  I am not opposed to
      this one, although I am a bit curious who lacks -a/-o in
      practice.
