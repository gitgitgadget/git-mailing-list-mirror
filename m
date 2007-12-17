From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] HP-UX does not have select.h
Date: Mon, 17 Dec 2007 13:00:22 -0800
Message-ID: <7v8x3t6nq1.fsf@gitster.siamese.dyndns.org>
References: <20071217192306.5da48540@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Dec 17 22:01:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4N5H-0007ZI-ON
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 22:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761500AbXLQVAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 16:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759763AbXLQVAn
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 16:00:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56654 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761182AbXLQVAm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 16:00:42 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E9E174BB1;
	Mon, 17 Dec 2007 16:00:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B80D4BAD;
	Mon, 17 Dec 2007 16:00:31 -0500 (EST)
In-Reply-To: <20071217192306.5da48540@pc09.procura.nl> (H. Merijn Brand's
	message of "Mon, 17 Dec 2007 19:23:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68619>

"H.Merijn Brand" <h.m.brand@xs4all.nl> writes:

> HP-UX does not have select.h, but it offers all select () functionality.
> The defines are in <sys/types.h> and <X11/fd.h>

Will apply the patch as-is for now, only because I do not want major
surgery during rc period, but I think is can be improved.

POSIX.1-2001 expects <sys/select.h> declares select(2).  With earlier
standards, including <sys/time.h>, <sys/types.h> and <unistd.h> would
have given it.

HP-UX cannot be the only pre-POSIX system; "#ifndef _HPUX_SOURCE" feels
very wrong.

Besides, isn't _HPUX_SOURCE a feature-test macro?  Feature test macros
are for the application to define, and for the implementation (iow, the
header files) to find out what set of names the application wants to
see.  You are making the application examine the symbol to see what
implementation it is on, which feels backwards to me.
