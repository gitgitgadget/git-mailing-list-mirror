From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] Add is_absolute_path(), make_absolute_path() and normalize_path()
Date: Thu, 26 Jul 2007 11:46:08 -0700
Message-ID: <7v4pjr80lr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707260724010.14781@racer.site>
	<7v1wevac63.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707261456040.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 26 20:46:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE8Ln-0007QT-C1
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 20:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933938AbXGZSqL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 14:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765799AbXGZSqL
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 14:46:11 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:62479 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbXGZSqK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 14:46:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070726184609.KSOV1428.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Thu, 26 Jul 2007 14:46:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UJm81X00J1kojtg0000000; Thu, 26 Jul 2007 14:46:09 -0400
In-Reply-To: <Pine.LNX.4.64.0707261456040.14781@racer.site> (Johannes
	Schindelin's message of "Thu, 26 Jul 2007 14:58:59 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53856>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Agree.  Maybe a comment above the function, like
>
> 	/*
> 	 * The function normalize_path() converts ".." and "." names in 
> 	 * the given path so that "foo/../bar/./" will come out as "bar".
> 	 *
> 	 * Note: normalize_path() does not follow symlinks, so if "foo" is
> 	 * a symlink in the example above, the result will not work as 
> 	 * expected.
> 	 */
>
> Hmm?

That comment only states the obvious and does not give a clue to
the callers when it should not be used, I am afraid.  For
example, paths taken out of index or recursively reading trees
are Ok because there will not be ".." and "." in them.  Making a
path given by the user relative to the cwd by prepending what is
returned by setup_git_directory() may or may not be safe,
depending on how setup_git_directory() does things (I think the
original one is safe; I am reasonably sure with the current one
when GIT_WORK_TREE is not in use; I do not know when that
environment variable is there with the current code with or
without your patch series).
