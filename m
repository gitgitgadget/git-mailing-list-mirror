From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] interpret_nth_last_branch(): avoid traversing the
 reflogs twice
Date: Sat, 17 Jan 2009 23:25:31 -0800
Message-ID: <7vprilyt1w.fsf@gitster.siamese.dyndns.org>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org>
 <1232163011-20088-1-git-send-email-trast@student.ethz.ch>
 <alpine.DEB.1.00.0901170646560.3586@pacific.mpi-cbg.de>
 <200901171438.22504.trast@student.ethz.ch>
 <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <7vljt97nld.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901172028470.3586@pacific.mpi-cbg.de>
 <7vmydp5tqj.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901180201070.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 08:27:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOS3l-0001ni-TD
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 08:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759097AbZARHZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 02:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757594AbZARHZl
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 02:25:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64055 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756077AbZARHZl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 02:25:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 480201CC31;
	Sun, 18 Jan 2009 02:25:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 348AA1CC30; Sun,
 18 Jan 2009 02:25:32 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901180201070.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sun, 18 Jan 2009 02:12:02 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 35630B98-E531-11DD-8BB7-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106145>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Note: these are the memory requirements after some really unrealistically 
> high activity, and the memory is free()d during parameter parsing.
>
> A much more realistical expectation would be to switch branches maybe 20 
> times a day, which would amount to something like 36 kilobyte.  And again, 
> they are free()d before the action really starts.

My HEAD reflog is 7MB long with 39000 entries, and among them, 13100
entries have "checkout: moving ".

I know I will never want to switch back to the 10000th from the last
branch.  I am quite sure that I would forget which branch I was on after
switching branches three or four times (hence my original hardcoded
limitation of 10 which "should be plenty").  When I know I only have to
keep track of 10 entries, having to keep track of 13100 entries, even if
it is 36kB (it would actually be 260kB in my case) feels there is
something wrong in the design.
