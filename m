From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 10/14] trailer: execute command from 'trailer.<name>.command'
Date: Thu, 06 Feb 2014 16:18:10 -0800
Message-ID: <xmqq4n4bwzb1.fsf@gitster.dls.corp.google.com>
References: <20140206194123.325.99451.chriscool@tuxfamily.org>
	<20140206202004.325.54178.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Feb 07 01:18:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBZ9R-00071c-Ca
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 01:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbaBGASd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 19:18:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53841 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbaBGASc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 19:18:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C53D6A4AF;
	Thu,  6 Feb 2014 19:18:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5IoQBC7sa9F62hRy/HUxjJAaPgs=; b=jsB1+C
	5qCUU6JKYMWCQRUssZ8n+/4o1IbHS5NWycqwJR6XWYZ9NR4NpKROO2b4GKsZD283
	MoYr5xK3iq31kpqYxrWEk4kR7Z+eKmyBXq6NCMOHVpbMnNVP/wWo3ffBFJM8xTWF
	e8qRyelRqRXgkxAAeLaiArb/aSJ5uVIrr0QiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dSTJBZQSYzGpXZeDfzmtlSULTgIBQlow
	PZ/6oDDaXFmhsqzv/cA4ZYQGNJniiOUJGoBH5qzXUc6aDcsbwaymfe+G86tIIgvh
	4WMBY1xtAhibVmoxvdWFFCQeLQjrPanSyo/ygCHe0BVcIqNRZudOsQ5TEpBXqP3F
	M7zDqiCfndg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 198E06A4AE;
	Thu,  6 Feb 2014 19:18:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41DAF6A485;
	Thu,  6 Feb 2014 19:18:13 -0500 (EST)
In-Reply-To: <20140206202004.325.54178.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 06 Feb 2014 21:19:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 552EFC64-8F8D-11E3-9615-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241755>

Christian Couder <chriscool@tuxfamily.org> writes:

> +#define TRAILER_ARG_STRING "$ARG"

No need to support users who may want to use a string that happens
to match this substring literally as part of the command line?

>  struct trailer_item {
>  	struct trailer_item *previous;
>  	struct trailer_item *next;
> @@ -56,6 +60,13 @@ static inline int contains_only_spaces(const char *str)
>  	return !*s;
>  }
>  
> +static inline void strbuf_replace(struct strbuf *sb, const char *a, const char *b)

Same comment about "inline" for an earlier patch applies.
