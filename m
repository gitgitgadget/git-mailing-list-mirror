From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/8] cherry-pick: store rewritten commits
Date: Mon, 03 Jun 2013 11:49:11 -0700
Message-ID: <7vmwr7do7s.fsf@alter.siamese.dyndns.org>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
	<1369799788-24803-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 20:49:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjZok-00084Z-Tr
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 20:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756882Ab3FCStP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 14:49:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54847 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754989Ab3FCStO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 14:49:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A18922417D;
	Mon,  3 Jun 2013 18:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mBJy2AZvG3WERchFfJAz4Uz7KWg=; b=ezwd5z
	3aYuQDxKsygrtedCygWZvztRADBiZqLpZ2qIHlSGC7S5aBjmMr4pBs1x8iTEOeCa
	l7CUk+nMiFPGR3H4ReaOXOR9byJAJeAjStdzjDGn9sQlA3+0fqwNpqIkL+d49DoZ
	IogBBbLOsmU6AWRjzz1aqqKPcbQ+8Z/PQeEJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V+isN1sqs/AczxxVE0UdguIUCxhP0y8F
	xb/e/4TkaaWcaUlWgNljWomPzK7KKqQ/Xcs5YQvEZNXie+PxUm84ehF5NZMnp7PO
	3xRA9ZBawFY8DUOZmF7ZOPJ07s5MNno1GtT5jmSyYX6tZY4i4tAh6ampntlT8yus
	RmrSeYN3H0A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96F5F2417C;
	Mon,  3 Jun 2013 18:49:13 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D18124179;
	Mon,  3 Jun 2013 18:49:13 +0000 (UTC)
In-Reply-To: <1369799788-24803-5-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Tue, 28 May 2013 22:56:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48A5586C-CC7E-11E2-825E-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226262>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> +static void add_rewritten(unsigned char *from, unsigned char *to)
> +{
> +	struct rewritten_list_item *item;
> +	if (rewritten.nr + 1 >= rewritten.alloc) {
> +		rewritten.alloc += 32;
> +		rewritten.items = xrealloc(rewritten.items, rewritten.alloc * sizeof(*rewritten.items));
> +	}

Is there a compelling reason not to use ALLOC_GROW() here?
