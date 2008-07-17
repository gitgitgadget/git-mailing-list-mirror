From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t/test-lib.sh: Let test_must_fail fail on signals
 only
Date: Wed, 16 Jul 2008 22:38:45 -0700
Message-ID: <7v3am9m5ne.fsf@gitster.siamese.dyndns.org>
References: <1215877672-17049-1-git-send-email-s-beyer@gmx.net>
 <20080716051829.GB4030@segfault.peff.net>
 <7v4p6qwezy.fsf@gitster.siamese.dyndns.org>
 <20080717051833.GA3100@sigio.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 17 07:40:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJMDk-0004Ii-1f
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 07:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296AbYGQFi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 01:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755281AbYGQFiz
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 01:38:55 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47978 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755221AbYGQFiy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 01:38:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1557D2F0FD;
	Thu, 17 Jul 2008 01:38:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 108ED2F0FC; Thu, 17 Jul 2008 01:38:47 -0400 (EDT)
In-Reply-To: <20080717051833.GA3100@sigio.intra.peff.net> (Jeff King's
 message of "Thu, 17 Jul 2008 01:18:34 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A3F7D17A-53C2-11DD-B48F-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88804>

Jeff King <peff@peff.net> writes:

> On Tue, Jul 15, 2008 at 10:54:25PM -0700, Junio C Hamano wrote:
>
>> Anything that returns error() from its cmd_xxx() routine, for example,
>> would end up exiting with (-1).  Is it "such bogus" error codes, though?
>
> I think it is bogus, because it is being implicitly truncated to an
> unsigned 8-bit value (at least on Linux -- I have no idea what other
> platforms do). 

"Only the least significant 8 bits (that is, status & 0377) shall be
available to a waiting parent process".  So it is not just "at least on
Linux" but is a well defined behaviour.

http://www.opengroup.org/onlinepubs/000095399/functions/exit.html

I would however agree that when we do mean 255 we should probably write
255, not (-1).  It is easier to document things that way.
