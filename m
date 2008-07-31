From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] revision traversal: show full history with merge
 simplification
Date: Thu, 31 Jul 2008 01:18:58 -0700
Message-ID: <7vd4kuzcst.fsf@gitster.siamese.dyndns.org>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com>
 <200807260512.40088.zippel@linux-m68k.org>
 <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain>
 <46a038f90807282015m7ce3da10h71dfee221c960332@mail.gmail.com>
 <Pine.LNX.4.64.0807291433430.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807291716060.3334@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0807291738280.3334@nehalem.linux-foundation.org>
 <7vej5b3ozz.fsf@gitster.siamese.dyndns.org>
 <7vhca6zcuy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Roman Zippel <zippel@linux-m68k.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 10:20:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOTOO-0002nj-3F
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 10:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbYGaITL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 04:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbYGaITL
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 04:19:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbYGaITK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 04:19:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AFE2244BF6;
	Thu, 31 Jul 2008 04:19:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id F38B744BF5; Thu, 31 Jul 2008 04:19:00 -0400 (EDT)
In-Reply-To: <7vhca6zcuy.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 31 Jul 2008 01:17:41 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 58812FF8-5ED9-11DD-8DE1-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90910>

If you look at the output from the "kernel/printk.c" with this patch, you
would notice that there still are somewhat meaningless merges shown in the
history (e.g. scroll down to 185a257f2f73bcd89050ad02da5bedbc28fc43fa).

The mainline side keeps making steady changes to the path, but the side
branch that made tty_write_message available to others with b346671
([PATCH] Export tty_write_message() for GFS2 quota code, 2006-01-16) keeps
many "Merge from master" until it is merged back to the mainline, even
after the earlier change is reverted by 02630a1 ([GFS2] Remove dependance
on tty_write_message(), 2006-07-03).

I wonder if we can do something clever to reduce these pointless (from the
point of view of explaining kernel/printk.c's evolution, at least) merges
from the output.  This might be another example of the reason why it is a
good thing that you keep teaching people: "On your xyzzy topic, you are
doing xyzzy development, not xyzzy development plus random changes ---
don't merge my tree into yours!", and we could dismiss these extra merges
we see in the output as artifacts from a bad practice, but as long as we
are spending extra cycles, it would be better if we could reduce such
clutter.

I am still undecided about the option name.

The existing --full-history is "show history fully without simplifying the
merge at all".  This is "show history fully with merge simplification".
Perhaps --simplify-merges?
