From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: test merge base if good rev is not an ancestor
 of bad rev
Date: Thu, 10 Jul 2008 16:10:04 -0700
Message-ID: <7vej61nxo3.fsf@gitster.siamese.dyndns.org>
References: <20080710054152.b051989c.chriscool@tuxfamily.org>
 <200807102126.37567.chriscool@tuxfamily.org>
 <7vd4llpkxq.fsf@gitster.siamese.dyndns.org>
 <200807110036.17504.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 01:11:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH5ID-0002BS-Tr
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 01:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403AbYGJXKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 19:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753260AbYGJXKS
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 19:10:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37937 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166AbYGJXKR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 19:10:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 33AB2256AD;
	Thu, 10 Jul 2008 19:10:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5FB4D256A5; Thu, 10 Jul 2008 19:10:09 -0400 (EDT)
In-Reply-To: <200807110036.17504.chriscool@tuxfamily.org> (Christian Couder's
 message of "Fri, 11 Jul 2008 00:36:17 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5B8D83CC-4ED5-11DD-BBE9-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88050>

Christian Couder <chriscool@tuxfamily.org> writes:

> Another idea to fix the problem, might be to bisect as usual and at the end 
> before saying "X is first bad commit" to check if some of X parents are 
> merge bases between the bad rev and a good rev. If that is the case, then 
> we could ask the user to check that these parents are all good. On average 
> this would probably reduce the number of revs the user must check.

I do not think that would fly well.  After spending long bisection cycle,
you will be telling the user that it was a wild goose chase (iow, the user
did an invalid bisection and what we stopped at was not the first
breakage).  If the bisection topology is invalid, we should tell the user
before he wastes too much time.

The sad part is that the biesction log from such an initial round would
not be very useful for reusing even if the user then chooses to hunt for
the "fix" on the side branch to forward port, in which case the meaning of
good and bad needs to be swapped from the beginning.
