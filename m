From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] quickfetch(): Prevent overflow of the rev-list
 command line
Date: Fri, 10 Jul 2009 23:55:25 -0700
Message-ID: <7vy6qvn1ya.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se>
 <200907091649.26575.johan@herland.net> <4A5618C1.70106@viscovery.net>
 <200907100152.30683.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Jul 11 08:55:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPWUq-00084a-Cw
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 08:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbZGKGzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 02:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbZGKGzh
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 02:55:37 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbZGKGzg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 02:55:36 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7381F2695B;
	Sat, 11 Jul 2009 02:55:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 639A22695A; Sat,
 11 Jul 2009 02:55:26 -0400 (EDT)
In-Reply-To: <200907100152.30683.johan@herland.net> (Johan Herland's message
 of "Fri\, 10 Jul 2009 01\:52\:30 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D4E9435A-6DE7-11DE-A2CC-424D1A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123102>

Johan Herland <johan@herland.net> writes:

> quickfetch() calls rev-list to check whether the objects we are about to
> fetch are already present in the repo (if so, we can skip the object fetch).
> However, when there are many (~1000) refs to be fetched, the rev-list
> command line grows larger than the maximum command line size on some systems
> (32K in Windows). This causes rev-list to fail, making quickfetch() return
> non-zero, which unnecessarily triggers the transport machinery. This somehow
> causes fetch to fail with an exit code.
>
> By using the --stdin option to rev-list (and feeding the object list to its
> standard input), we prevent the overflow of the rev-list command line,
> which causes quickfetch(), and subsequently the overall fetch, to succeed.

I feel uneasy with that "somehow" at the end of the first paragraph, but
nevertheless this is the right thing to do.  Since it is a very isolated
change, I'd queue this directly on 'master' and see if anybody notices a
breakage, as it would be relatively pain-free to revert if it turns out to
be necessary.

Thanks.
