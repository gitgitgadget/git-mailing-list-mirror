From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] minor: wrong handling of GIT_AUTHOR_DATE
Date: Sat, 16 Aug 2008 19:46:22 -0700
Message-ID: <7vr68obbpd.fsf@gitster.siamese.dyndns.org>
References: <20080816205325.GD10729@mrq1.org>
 <alpine.LFD.1.10.0808161543160.3324@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808161613520.3324@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hermann Gausterer <git-mailinglist@mrq1.org>,
	Git Mailinglist <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 17 04:48:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUYK3-0001jr-TQ
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 04:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbYHQCqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 22:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbYHQCqb
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 22:46:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50419 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbYHQCqa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 22:46:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2841E642FE;
	Sat, 16 Aug 2008 22:46:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8352D642FD; Sat, 16 Aug 2008 22:46:24 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B0B96016-6C06-11DD-AFD9-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92564>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Junio, your call. But this one gets the date right for strings that just 
> randomly have some big number in them, ie
>
> 	[torvalds@nehalem git]$ ./test-date "17:25:54 917476713 2008-06-04 -0700"
> 	17:25:54 917476713 2008-06-04 -0700 -> 1212625554 -0700 -> Wed Jun  4 17:25:54 2008
> 	17:25:54 917476713 2008-06-04 -0700 -> Wed Jun  4 17:25:54 2008

Being able to parse this is a very low priority.

You've taught people here and on the kernel list that the "date" can use
any non-digit-non-word as a word separator, and "git log --since 2.days"
is something you often do.

People who followed that advice would have gotten used to this already, e.g.

   $ git reflog delete master@{07.04.2005.15:15:00.-0700}

should not be broken.

I think your first hunk needs to distinguish between "very-long-precision
posint" (in which case we ignore because it is likely to be nanoseconds
fraction) and others.
