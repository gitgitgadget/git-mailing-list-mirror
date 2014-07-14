From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH/RFH 0/3] stable priority-queue
Date: Mon, 14 Jul 2014 13:02:56 +0200
Message-ID: <87tx6k5hjz.fsf@fencepost.gnu.org>
References: <20140714054021.GA4422@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 14 13:03:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6e2i-0004vx-Ar
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 13:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbaGNLC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 07:02:59 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:32987 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbaGNLC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 07:02:58 -0400
Received: from localhost ([127.0.0.1]:60257 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1X6e24-0007Ni-Ka; Mon, 14 Jul 2014 07:02:56 -0400
Received: by lola (Postfix, from userid 1000)
	id 2CE6DE0610; Mon, 14 Jul 2014 13:02:56 +0200 (CEST)
In-Reply-To: <20140714054021.GA4422@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 14 Jul 2014 01:40:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253486>

Jeff King <peff@peff.net> writes:

> As Junio and I discussed earlier in [1], this series makes the
> prio_queue struct stable with respect to object insertion (which in turn
> means we can use it to replace commit_list in more places).

I don't think that this makes sense in general since it assumes the
appropriate fallback behavior to be FIFO.  Depending on the use case, it
might be the other way round, or something else (like topology-based)
entirely.

commit_list may be unsuitable as such for intermingled addition of
unsorted and extraction of sorted elements (the general use case for
priority queues).

I see that struct commit already contains an integer field called
"index", assigned sequentially, which might conceivably be used for
tie-breaking independent from the actual prio_queue use at no extra
cost.

The resulting order will of course be somewhat arbitrary in a different
way, but at least will correspond to the order the commits have been
discovered/generated, so they should still exhibit a more topological
relation than what prio_queue does without further help.

-- 
David Kastrup
