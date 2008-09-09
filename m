From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] push: prepare sender to receive extended ref
	information from the receiver
Date: Tue, 9 Sep 2008 09:03:20 -0400
Message-ID: <20080909130320.GA25935@coredump.intra.peff.net>
References: <1220948830-3275-1-git-send-email-gitster@pobox.com> <1220948830-3275-2-git-send-email-gitster@pobox.com> <1220948830-3275-3-git-send-email-gitster@pobox.com> <1220948830-3275-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 15:04:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd2tS-0006wi-3X
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 15:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbYIINDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 09:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbYIINDX
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 09:03:23 -0400
Received: from peff.net ([208.65.91.99]:1197 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493AbYIINDW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 09:03:22 -0400
Received: (qmail 8010 invoked by uid 111); 9 Sep 2008 13:03:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 09 Sep 2008 09:03:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Sep 2008 09:03:20 -0400
Content-Disposition: inline
In-Reply-To: <1220948830-3275-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95380>

On Tue, Sep 09, 2008 at 01:27:09AM -0700, Junio C Hamano wrote:

> +struct extra_have_objects {
> +	int nr, alloc;
> +	unsigned char (*array)[20];
> +};

This declaration made me double-take. I think it is correct, and you are
saving an extra pointer over a malloc. But the syntax ends up a little
confusing:

        hashcpy(&(extra->array[extra->nr][0]), sha1);

Using a struct probably would have been a little easier to read. I don't
know if this is worth changing.

> +	if (extra->alloc <= extra->nr)
> +		ALLOC_GROW(extra->array, extra->nr + 1, extra->alloc);

Isn't the conditional superfluous (ALLOC_GROW already makes this check)?

-Peff
