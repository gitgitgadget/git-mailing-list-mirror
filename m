From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/5] config: make parsing stack struct independent from actual data source
Date: Sun, 12 May 2013 21:56:39 -0700
Message-ID: <7vfvxrscjc.fsf@alter.siamese.dyndns.org>
References: <20130511131721.GA17991@book-mint>
	<20130511132013.GD17991@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon May 13 06:56:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbkoY-0004i1-DO
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 06:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744Ab3EME4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 00:56:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33017 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751448Ab3EME4m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 00:56:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC6371988C;
	Mon, 13 May 2013 04:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=cxQl6YiddPQHftQ/SE06eWooboc=; b=Z6aTEKwgBt0scG48WMmx
	kJr3vYSNh/3C4EQ3E60i71XsUyT70+s/ZrRBJ0k+WZItIOM3yks8QD+pZkgyVzQm
	liJgTCGjGix+TwBzCyCGajPOmOOebLRSA2bkZvp8PNDsb9BS3NexyRw7pgRNDKoM
	1AlGjxyr/ESEBClwFQFtSXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=nX7w4DoPow+Dvr0bW+8/1aUsXEXA3ijZF7XnSGqeq+/zbl
	EI5oXBX/cpsnAnskkmENpno3wb7GTpPkTHCJyQALp0gnddaYpaxzsYX04v1KQWEc
	2PiJ97WLe/lmpYD/8s13toqbmrKjChX6Y8wdXP2tpdaumIHMG0fJ3KKc47bhA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A42501988A;
	Mon, 13 May 2013 04:56:41 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 24FDE19888;
	Mon, 13 May 2013 04:56:41 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8047C2C4-BB89-11E2-9FDB-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224084>

Heiko Voigt <hvoigt@hvoigt.net> writes:

>  /*
> - * The fields f and name of top need to be initialized before calling
> + * All source specific fields in the union, name and the callbacks
> + * fgetc, ungetc, ftell of top need to be initialized before calling
>   * this function.
>   */
> -static int do_config_from(struct config_file *top, config_fn_t fn, void *data)
> +static int do_config_from_source(struct config_source *top, config_fn_t fn, void *data)

This renaming may have made sense if we were to have many different
do_config_from_$type functions for different types of source, but as
this patch introduces a nice "config_source" abstraction, I do not
think it is unnecessary. Shortening do_config_from() to do_config()
may make more sense, if anything.

But that is a very minor point, as this is entirely internal with a
single caller.
