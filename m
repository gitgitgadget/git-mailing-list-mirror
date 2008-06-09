From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce get_octopus_merge_bases() in commit.c
Date: Mon, 09 Jun 2008 16:41:06 -0700
Message-ID: <7vlk1edvn1.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0806091458190.1783@racer>
 <1213051426-11530-1-git-send-email-vmiklos@frugalware.org>
 <7v8wxefbtn.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806100024310.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 10 01:42:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5r0H-0007cx-Gr
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 01:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758472AbYFIXl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 19:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758014AbYFIXl2
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 19:41:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46245 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757966AbYFIXl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 19:41:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1A7FC5841;
	Mon,  9 Jun 2008 19:41:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 57DF0583E; Mon,  9 Jun 2008 19:41:21 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806100024310.1783@racer> (Johannes
 Schindelin's message of "Tue, 10 Jun 2008 00:31:23 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 92B27DBE-367D-11DD-B66D-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84456>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> However, your remark about optimizing for the two-head case got me 
> thinking: should we not rather use the simple algorithm Miklos proposed 
> for octopus_merge_bases(), even if it is suboptimal?

Actually a quick glance at git-merge, a rather large case...esac after
that "show-branch --merge-base" tells me that we do not really use the
output from that operation and instead we check if we are fast-forward
from all the other heads by iterating over them.  merge-octupos would
accept it as the base but never looks at it.

So I think with a proper refactoring of the codepath you probably would
not even have to do the blanket "merge-base across all heads" at all.
