From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] mailinfo: ensure handle_filter gets only one line at
 a time
Date: Fri, 15 Feb 2008 22:22:47 -0800
Message-ID: <7vir0pe7yg.fsf@gitster.siamese.dyndns.org>
References: <1203112418-25199-1-git-send-email-jaysoffian@gmail.com>
 <7vodahg5w4.fsf@gitster.siamese.dyndns.org>
 <76718490802151537r7658e109o3c981832ae32154d@mail.gmail.com>
 <7vmyq1e86n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Jay Soffian" <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 07:24:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQGSv-0001fb-TU
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 07:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbYBPGX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 01:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbYBPGX1
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 01:23:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51030 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbYBPGX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 01:23:27 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 08E3122D1;
	Sat, 16 Feb 2008 01:23:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 382C122CF; Sat, 16 Feb 2008 01:23:21 -0500 (EST)
In-Reply-To: <7vmyq1e86n.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 15 Feb 2008 22:17:52 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74017>

Junio C Hamano <gitster@pobox.com> writes:

> The function is intended to be fed one logical line at a time to
> inspect, but a QP encoded raw input line can have more than one
> lines, just like BASE64 encoded one.
>
> Quoting LF as =0A may be unusual but RFC2045 allows it.

Well, this is a bit dark-gray.

The canonical line ending CRLF should not be represented as =0A
and the intention of RFC2045 seems to allow =0A only as part of
binary contents.  So strictly speaking this may not be needed,
but there may always be not quite conforming MUA that would
break the assumption and would bite us, so we'd better be safe
than sorry.
