From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/14] trailer: process trailers from file and arguments
Date: Fri, 14 Feb 2014 15:57:31 -0800
Message-ID: <xmqqtxc1fdsk.fsf@gitster.dls.corp.google.com>
References: <xmqq38jqsnc2.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1Nq-LkE=FW5dnBZKKd7-ORJPo1BFs3sY+MLGxuXEWuTw@mail.gmail.com>
	<xmqqa9dxr09k.fsf@gitster.dls.corp.google.com>
	<20140214.224133.484636406629780362.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: christian.couder@gmail.com, git@vger.kernel.org, johan@herland.net,
	josh@joshtriplett.org, tr@thomasrast.ch, mhagger@alum.mit.edu,
	sunshine@sunshineco.com, dan.carpenter@oracle.com, greg@kroah.com,
	peff@peff.net
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Feb 15 00:57:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WESdc-0007Ij-Le
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 00:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbaBNX5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 18:57:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40574 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788AbaBNX5k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 18:57:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CC8F6C173;
	Fri, 14 Feb 2014 18:57:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z35lseD+DKHvcRmXXMt2Snw2TrY=; b=EugQfi
	xqbCkJYcWuDM9lFumBFeeL4C3/MT/O/jVgpgdAxlYzEXh/RKSTxULKCZaEz2OIXd
	XDoZEvtSTIz3wsbhbQC4ThahZvrl1PYAojbPPZNGTI6o3gwh3/CPXGcFAhAQNAH0
	DjJB0uO7nlTA5prfLFEtH3B7/r8b0eHGWnn6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fNbW2PGOtVXzZ22N/oLClVtF28uxe7CJ
	l40vPyfXsAQPP8Dxdx9l9yVjzOwZ7ffnx2/8mA9cXpcMsBmMjA7CUlh1fbllulf8
	Vczlz4pEsbSbKZk2egcscCU385lKIMpjgqotvChQhoawVFNdE2/dF4k1NL6p8Lmb
	CGgF0ZC+tAY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 236786C16D;
	Fri, 14 Feb 2014 18:57:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DB2C6C165;
	Fri, 14 Feb 2014 18:57:34 -0500 (EST)
In-Reply-To: <20140214.224133.484636406629780362.chriscool@tuxfamily.org>
	(Christian Couder's message of "Fri, 14 Feb 2014 22:41:33 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C5FA4ECA-95D3-11E3-AFDB-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242164>

Christian Couder <chriscool@tuxfamily.org> writes:

> but we also want to say:
>
>     action = do_Y_if_X_and_Z AND do_U_if_V
>
> For example some people might want:
>
>     if_exists = overwrite
>     if_missing = add
>
> while others might want:
>
>     if_exists = overwrite
>     if_missing = do_nothing
>
> and I don't see how we can say that with just:
>
>     action = do_Y_if_X_and_Z

That is a very relevant illustration that makes me realize why I
found your "if-exists/if-missing = do-Y-if-Z" somewhat distasteful.

Your

     if_exists = add_if_different

says "if the same key is there, add it if the value is different",
but it also implicitly says "donothing if the value is the same".

That is, you are saying with the above

     if_exists = add_if_different AND ignore_if_same

So you already have to support more than one actions depending on
the condition, unless you want to limit the actions for all the
cases other than X to be only "ignore" when you invent your next
"do_Y_if_X", X being "different" in this case, but you support (and
need to support) "different-neighbour" and other random collections
of conditions, I think.  Which is essentially the same as saying
that you need this:

>     action = do_Y_if_X_and_Z AND do_U_if_V

Again, unless all the U's are limited to "ignore", that is.
