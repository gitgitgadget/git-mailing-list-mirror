From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Generalize and libify index_is_dirty() to
 index_differs_from(...)
Date: Mon, 09 Feb 2009 21:16:23 -0800
Message-ID: <7v63jirhw8.fsf@gitster.siamese.dyndns.org>
References: <1234222843-15577-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Alex Riesen <raa.lkml@gmail.com>, Jeff King <peff@peff.net>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Feb 10 06:18:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWl0a-0004Ju-KP
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 06:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbZBJFQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 00:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbZBJFQl
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 00:16:41 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43604 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667AbZBJFQk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 00:16:40 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 035B19867D;
	Tue, 10 Feb 2009 00:16:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 80F959867C; Tue,
 10 Feb 2009 00:16:29 -0500 (EST)
In-Reply-To: <1234222843-15577-1-git-send-email-s-beyer@gmx.net> (Stephan
 Beyer's message of "Tue, 10 Feb 2009 00:40:43 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FEB772F6-F731-11DD-A273-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109180>

Stephan Beyer <s-beyer@gmx.net> writes:

>   This is one of the sequencer-preparing patches.
>   (The function is used in sequencer several times, most of the time
>    with diff_flags set to DIFF_OPT_IGNORE_SUBMODULES.)
>
>   Alex is on Cc because he introduced the "Is commitable?" (i.e.
>   "Is index dirty?") part in builtin-commit.c.
>
>   Peff is on Cc because he introduced index_is_dirty() in
>   builtin-revert.c.
>
>  builtin-commit.c |   13 ++-----------
>  builtin-revert.c |   13 +------------
>  revision.c       |   15 +++++++++++++++
>  revision.h       |    2 ++
>  4 files changed, 20 insertions(+), 23 deletions(-)

It is a straightforward and clean restructuring, but please do not
contaminate revision.[ch] with this function about "internally running
diff-index".  

revision.[ch] is a library for revision/ancestry traversal and it is
already one of the largest library-ish files. It does not know nor care
about the index, and we want to keep it that way.  Please keep its focus
to revision traversal.

Perhaps diff-lib.c would be a better home for your helper function.
