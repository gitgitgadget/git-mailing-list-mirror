From: Junio C Hamano <gitster@pobox.com>
Subject: Re: diff --check is stupid about blank lines
Date: Wed, 20 Aug 2008 11:13:35 -0700
Message-ID: <7v7iabsgfk.fsf@gitster.siamese.dyndns.org>
References: <20080820140517.GA1304@atjola.homenet>
 <20080820172825.GC27773@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 20 20:14:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVsCp-0001Fn-Mz
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 20:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbYHTSNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 14:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbYHTSNp
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 14:13:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34595 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbYHTSNp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 14:13:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B50DF5A75E;
	Wed, 20 Aug 2008 14:13:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1AA5A5A757; Wed, 20 Aug 2008 14:13:37 -0400 (EDT)
In-Reply-To: <20080820172825.GC27773@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 20 Aug 2008 13:28:25 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B9598964-6EE3-11DD-8D49-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93005>

Jeff King <peff@peff.net> writes:

> ... The problem seems to be the conditional at
> diff.c:1622:
>
>         if ((data.ws_rule & WS_TRAILING_SPACE) &&
>             data.trailing_blanks_start) {
>                 fprintf(o->file, "%s:%d: ends with blank lines.\n",
>                         data.filename, data.trailing_blanks_start);
>                 data.status = 1; /* report errors */
>         }
>
> that should probably be "if we care about trailing space, and the last
> thing we saw was a trailing blank, _and_ the last hunk adds to
> end-of-file, then...".

Instead, data.trailing_blanks_start is supposed to be reset to 0 every
time we see non-blank newline, a copied context line, or new hunk.

So if this triggers with -U0 I'd understand, but otherwise I do not see
how.
