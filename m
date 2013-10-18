From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/9] http: update base URLs when we see redirects
Date: Fri, 18 Oct 2013 11:25:13 -0700
Message-ID: <xmqqk3hawi5y.fsf@gitster.dls.corp.google.com>
References: <20130928082956.GA22610@sigill.intra.peff.net>
	<20130928083405.GA2782@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Kyle J. McKay" <mackyle@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 18 20:25:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXEjv-000213-RL
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 20:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756868Ab3JRSZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 14:25:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33790 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756580Ab3JRSZR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 14:25:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 515EA4B0D3;
	Fri, 18 Oct 2013 18:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NiTI0uOMXYseMbZFBvaIQyIai/E=; b=k5+VwS
	+DYLZPrW1rYeg3qML7LmU/BYJy4gud2rZ1QkCg+gbcdOORTiIVY311W+3rJEl9+R
	JLaCcZb5AdFeQZPfcr055cxp4AsiKWT4xzuHckqwFnUVZm5LD9OI1T0D3zzsGcgR
	nkUrcf680fEmlkK4ggDz8vYYFPDGMvYbavU4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hqLkdP5tmWrCrg8J3/UeBpHNVP0deOvG
	wUYS/FrupMyOKfwccIQJhBGk6oASj1+Jt2QIVQdUVvFgDglMSqhj8MUFOat3FuAO
	FezEnx/Vt+zdXZu+WkO1MqVoLtdeHDIEaCkMcJ8EdsfgB/hy1r5O0c2J9OhqJLkD
	5sk/kkE//Ak=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EAAA4B0D2;
	Fri, 18 Oct 2013 18:25:16 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 91A864B0CF;
	Fri, 18 Oct 2013 18:25:15 +0000 (UTC)
In-Reply-To: <20130928083405.GA2782@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 28 Sep 2013 04:34:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A2686E9C-3822-11E3-AAC3-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236361>

Jeff King <peff@peff.net> writes:

> + * Our basic strategy is to compare "base" and "asked" to find the bits
> + * specific to our request. We then strip those bits off of "got" to yield the
> + * new base. So for example, if our base is "http://example.com/foo.git",
> + * and we ask for "http://example.com/foo.git/info/refs", we might end up
> + * with "https://other.example.com/foo.git/info/refs". We would want the
> + * new URL to become "https://other.example.com/foo.git".

Not "https://other.example.com/foo.git/info/refs"?
