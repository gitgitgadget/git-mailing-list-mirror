From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/8] alloc.c: remove the alloc_raw_commit_node() function
Date: Tue, 15 Jul 2014 13:06:48 -0700
Message-ID: <xmqq4myiv12f.fsf@gitster.dls.corp.google.com>
References: <20140713064116.GA4768@sigill.intra.peff.net>
	<20140713064140.GA4852@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 15 22:07:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X790D-0005tB-2R
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 22:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933004AbaGOUHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 16:07:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60513 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756840AbaGOUG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 16:06:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 60A9C29450;
	Tue, 15 Jul 2014 16:06:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qBv6cEHXE9SXfzazJRJOyUIPyxI=; b=pRRWTG
	u/bfSflAAcoX5gStIMVWrA2+hv5nU0e3ku+L6hduigiJNgt9WbpzBD3wM4MCC1E3
	3jrQiS8OrxmI30ObGkZTxJSfGMyvN1hDVxiVPWPIdqN+LxO3lFnmei1X62nUxumJ
	+xsZ1/6EKJMNK8Gjw1ZSelEJwLvXxuKOscQ/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SJwwKVILxX5HAWL4wnhPV7hOuRXu3S/C
	yJIXQrp1vBRWloeXTAjfrDEDuJ7vKcwTja9Fv/Sf8mgmh8uNPNbAcLiWGdEuyJvq
	1cKIY4MfS/0jn32Cae2yCSNeMSX7VLJCWACG5FvVVbAT9B/qEMbPXxEbo0EDUEIy
	g76ZZTULrgo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5724B2944F;
	Tue, 15 Jul 2014 16:06:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 553642943C;
	Tue, 15 Jul 2014 16:06:32 -0400 (EDT)
In-Reply-To: <20140713064140.GA4852@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 13 Jul 2014 02:41:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 83F8AE14-0C5B-11E4-97B7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253597>

Jeff King <peff@peff.net> writes:

>  #define DEFINE_ALLOCATOR(name, type)				\
> +static struct alloc_state name##_state;				\
>  void *alloc_##name##_node(void)					\
>  {								\
> +	return alloc_node(&name##_state, sizeof(type));		\
>  }

This is really nice.  Thanks.

> +static struct alloc_state commit_state;
> +
>  void *alloc_commit_node(void)
>  {
>  	static int commit_count;
> -	struct commit *c = alloc_raw_commit_node();
> +	struct commit *c = alloc_node(&commit_state, sizeof(struct commit));
>  	c->index = commit_count++;
>  	return c;
>  }
