From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-daemon: use getnameinfo to resolve hostname
Date: Wed, 14 Jan 2009 03:33:43 -0800
Message-ID: <7vsknm2kbs.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.2.00.0901141147120.16109@fbirervta.pbzchgretzou.qr>
 <alpine.LSU.2.00.0901141148130.16109@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 12:35:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN41n-0008P4-F2
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 12:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542AbZANLdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 06:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755487AbZANLdx
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 06:33:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65392 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755003AbZANLdw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 06:33:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DE6231C80E;
	Wed, 14 Jan 2009 06:33:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 894271C80D; Wed,
 14 Jan 2009 06:33:47 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 37D453DC-E22F-11DD-98FE-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105620>

Jan Engelhardt <jengelh@medozas.de> writes:

> parent v1.6.1
>
> git-daemon: use getnameinfo to resolve hostname
>
> This is much shorter than inet_ntop'ing, and also translated
> unresolvable addresses into a string.

translated?  (I think you meant "translates" but my English is bad, so I
am double checking).

This indeed is much nicer, provided if it is available at least as widely
as inet_ntop() is.

We seem to ship inet_ntop() in compat/; a few questions.

 (1) Do we need similar compat/ function for getnameinfo()?  I am guessing
     that most likely places are the ones that need NO_INET_NTOP and
     NO_INET_PTON, and googling seems to indicate old Cygwin and HP-UX
     11.00 may be among them.

 (2) Do we still use inet_ntop() elsewhere, and if not, can we remove the
     compat/ definitions?
