From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: make show_line more portable
Date: Sun, 08 Mar 2009 18:35:35 -0700
Message-ID: <7vhc23iil4.fsf@gitster.siamese.dyndns.org>
References: <1236561326-1231-1-git-send-email-benji@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 02:38:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgURa-0007dy-Vf
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 02:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbZCIBfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 21:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753839AbZCIBfl
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 21:35:41 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34598 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767AbZCIBfl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 21:35:41 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 59100492D;
	Sun,  8 Mar 2009 21:35:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B482B492C; Sun, 
 8 Mar 2009 21:35:36 -0400 (EDT)
In-Reply-To: <1236561326-1231-1-git-send-email-benji@silverinsanity.com>
 (Brian Gernhardt's message of "Sun, 8 Mar 2009 21:15:26 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 98836408-0C4A-11DE-8879-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112666>

Brian Gernhardt <benji@silverinsanity.com> writes:

> On OS X the printf specifier "%.0s" outputs the entire string instead
> of 0 characters as POSIX states.
>
> In addition, for * width or precision printf expects an integer
> argument.  On systems were regoff_t is 64-bit, unexpected results can
> occur.

I would prefer to see these two issues solved as separate issues.

Specifically, I'd like to know if the patch from me to you a few message
ago solves the issue.

If you still need a "some implementations of printf is broken with respect
to 0 precision" workaround on top of that patch, we would want to add it
separately, but it may have to cover not just this printf(), as I am not
convinced this is the only place that lets (integer) 0 passed to the
"%.*s" format.  That patch needs to be written after a separate auditing
of output from "git grep -n -e 'printf.*%\.\*s'", which I do not think
happened yet (at least I haven't done that, and I somehow do not think you
have yet either).
