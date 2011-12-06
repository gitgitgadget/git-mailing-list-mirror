From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 12/13] credentials: add "store" helper
Date: Tue, 06 Dec 2011 13:50:58 -0800
Message-ID: <7vzkf5e5dp.fsf@alter.siamese.dyndns.org>
References: <20111206062127.GA29046@sigill.intra.peff.net>
 <20111206062305.GL29233@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 06 22:51:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY2v9-00014z-JB
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 22:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516Ab1LFVvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 16:51:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38111 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752988Ab1LFVvB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 16:51:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A606679A;
	Tue,  6 Dec 2011 16:51:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V8N/YtBl3VgjPbWp7kc9VmaOHMI=; b=hbjrTj
	qk/3zCUlKxRHppRcYe8t/1W5PH24+U7B7KmC3n9Snlt+cTLKDfN/85ejSbzVaa2Y
	UQyWdsPqv09+RLzB8jFHtQIZW25feFLmcmGbTrSGqZt4YwzxIK+dX4LZuAWsgLiE
	3ll/6anw4tMwUdlZK9Zeb5MPZZxO4LMVG7nXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=USdFrGSWeTWjnEFtqvJiB4cKqcFPEADu
	oyfFGsk+c0OpHQ459XgzxYQY6WdtWy0Lv2GtlUijQzQd70Dz2zWULiVWxZaurWIV
	5QqhhIvtDIEckw/N2HmwxUN/zxaSXZMYYDF4okqnGSR45AbyyYW1uuoPQx8S2BaP
	H5MtdpKaafo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9256B6799;
	Tue,  6 Dec 2011 16:51:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0AA136796; Tue,  6 Dec 2011
 16:50:59 -0500 (EST)
In-Reply-To: <20111206062305.GL29233@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 6 Dec 2011 01:23:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 628CADB6-2054-11E1-9FFF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186395>

Jeff King <peff@peff.net> writes:

> +static void store_credential(const char *fn, struct credential *c)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	/*
> +	 * Sanity check that what we are storing is actually sensible.
> +	 * In particular, we can't make a URL without a protocol field.
> +	 * Without either a host or pathname (depending on the scheme),
> +	 * we have no primary key. And without a username and password,
> +	 * we are not actually storing a credential.
> +	 */
> +	if (!c->protocol || !(c->host || c->path) ||
> +	    !c->username || !c->password)
> +		return;

Very nicely explained. I wish all our patches had comments like this to
explain tricky bit that looks as if the choice was arbitrarily made but
in fact the logic was carefully constructed.

Thanks.
