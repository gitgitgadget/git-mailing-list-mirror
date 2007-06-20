From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: RFC2822 compliant Message-ID
Date: Wed, 20 Jun 2007 13:18:39 -0700
Message-ID: <7vlkeetm5c.fsf@assigned-by-dhcp.pobox.com>
References: <11823459011323-git-send-email-michael@ndrix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Hendricks <michael@ndrix.org>
X-From: git-owner@vger.kernel.org Wed Jun 20 22:18:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I16dY-0003om-4S
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 22:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbXFTUSn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 16:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbXFTUSm
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 16:18:42 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:58676 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbXFTUSl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 16:18:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070620201839.IIPQ4247.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Jun 2007 16:18:39 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id DwJf1X0071kojtg0000000; Wed, 20 Jun 2007 16:18:39 -0400
In-Reply-To: <11823459011323-git-send-email-michael@ndrix.org> (Michael
	Hendricks's message of "Wed, 20 Jun 2007 07:25:01 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50566>

Michael Hendricks <michael@ndrix.org> writes:

> RFC 2822 section 3.6.4 suggests that a "good method" for generating a
> Message-ID is to put the domain name of the host on the right-side of
> the "@" character.  Use Perl's Sys::Hostname to do the heavy lifting.
> This module has been in the Perl core since version 5.

Probably is a good idea for 50% of properly configured hosts.  I
think hosts can be configured so that hostname() already returns
fqdn in which case your patch is fine but they can also be
configured so that hostname() plus its domainname becomes fqdn,
in which case it is probably not.  In any case it is mere
suggestion (not MUST nor even SHOULD), so we should judge its
merits a bit carefully.

What happens if the machine you run send-email on does not have
a valid hostname configured yet?  People on home machines or
laptops whose only contact outside are with their ISP
mailservers should be able to send their patches without having
to configure /etc/hostname, shouldn't they?  Does Sys::Hostname
die under some condition, such as "the host is not configured
well enough"?  If so I suspect the change to replace the
existing one is not acceptable.

I think we should use something safe that gives reasonably
unique identifier and the existing $message_id_from based method
is one way to do so.

The message from vger mailmaster (DSM) suggests that somehow
$message_id_from method returned an empty string.  Maybe make
your patch used as a fallback in such a case?

Finally could you resend this with your updated git-send-email?
I suspect that this line in the mail header of your patch:

	Message-ID: <11823459011323-git-send-email-michael@ndrix.org>

should have read like so:

	Message-ID: <11823459011323-git-send-email@ndrix.org>
