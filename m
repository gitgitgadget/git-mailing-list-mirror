From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/11] Use new compress helpers in fast-import
Date: Sun, 03 Feb 2008 14:53:45 -0800
Message-ID: <7v3as9slc6.fsf@gitster.siamese.dyndns.org>
References: <1201952156-6764-1-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-2-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-3-git-send-email-mcostalba@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 23:54:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLnjN-00021s-MX
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 23:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753203AbYBCWx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 17:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753230AbYBCWx7
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 17:53:59 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33288 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103AbYBCWx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 17:53:58 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 68B7A67BC;
	Sun,  3 Feb 2008 17:53:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E209C67BB;
	Sun,  3 Feb 2008 17:53:52 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72417>

Marco Costalba <mcostalba@gmail.com> writes:

> Here is slightly more difficult, in particular
> a xrealloc() has been substituted with a
> free() + xmalloc() to keep the code simple.
>
> Signed-off-by: Marco Costalba <mcostalba@gmail.com>
> ---
>  fast-import.c |   45 +++++++++++++++------------------------------
>  1 files changed, 15 insertions(+), 30 deletions(-)

I'll let Shawn comment on this.  The realloc() does not seem to
be using the contents in the buffer from the previous round, so
I suspect that a free() followed by an independent alloc() would
be an improvement when the later call uses much larger buffer
than the previous one, but would be a waste if the later one
needs smaller buffer.
