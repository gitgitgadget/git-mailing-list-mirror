From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Allow git-apply to fix up the line counts
Date: Thu, 05 Jun 2008 11:39:05 -0700
Message-ID: <7v4p873ewm.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0806051115570.21190@racer>
 <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer>
 <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 20:40:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4KNe-0007IX-G8
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 20:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759438AbYFESjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 14:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758507AbYFESjR
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 14:39:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48915 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757726AbYFESjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 14:39:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E0FAE5471;
	Thu,  5 Jun 2008 14:39:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 29629546F; Thu,  5 Jun 2008 14:39:08 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806051441560.21190@racer> (Johannes
 Schindelin's message of "Thu, 5 Jun 2008 14:47:24 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B16B370C-332E-11DD-B209-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83953>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> As I said, the data is in the _hunks_, but I maybe should have added _not 
> in the hunk headers_.

So you _are_ ignoring the line counts recorded in the hunk headers.  It is
not even 'adjust' but 'count lines to guess'.

If the incoming patch text does not have confusing contents at the end,
the guessing is reasonably safe.  You need to watch out for blank lines,
which means the same as /^ $/, and mail signature separators /^-- $/.
They can confuse you into guessing wrongly and include more preimage lines
than there actually are.

So it would be more like

--ignore-line-counts::
	Ignore number of lines recorded in the hunk headers; instead count
        lines that look like hunk contents to determine how big each hunk
	is.

I haven't started to nitpick the actual code yet but I know the original
is a tricky pice of code, so we may find something interesting ;-)
