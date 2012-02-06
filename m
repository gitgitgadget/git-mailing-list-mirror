From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch --edit-description: protect against mistyped
 branch name
Date: Sun, 05 Feb 2012 17:27:29 -0800
Message-ID: <7v62fkda4e.fsf@alter.siamese.dyndns.org>
References: <4F24E287.3040302@alum.mit.edu>
 <7vwr8bvvxj.fsf@alter.siamese.dyndns.org> <4F263AEE.4080409@alum.mit.edu>
 <7v39axc9gp.fsf@alter.siamese.dyndns.org>
 <20120130214842.GA16149@sigill.intra.peff.net>
 <7vaa4wda60.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 02:27:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuDMm-00060p-4p
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 02:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783Ab2BFB1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 20:27:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53673 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754751Ab2BFB1b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 20:27:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4890C7BE2;
	Sun,  5 Feb 2012 20:27:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Iut/mhv6fptuYhlg+Y22i+5EpQs=; b=d3UozI
	6vnhLMSeuZ3ZUyVOzTCUS6a+YCdWIGQ1TzINWl2Bx+e1Gk/xnl23msi2uB5PBSv3
	9nTp/ffGsSZOdHGXmjGfDAMYLXHxMmCIcrlTwPHLx2HojwVkCuFghJo9kC9YZ9Zu
	RN4qOJ8ZFgFK+HmJJCwUy7xS4NJS2OGgNS/zA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KA66QOL1QOu+/q/JcB6nQIm2tsVLJknF
	zVoqOCbuzaboFKcxXaL7GP29Wuuu/c4BDUygUq+dy0SS+MQf4jCtAreuevgl86u8
	EHF9H1/7eY2KkqQIp+9WE4KJ5OWxeXQOl1wK7gH8DVBr+2AI8IsPACEc5Weax/vW
	5EWb9FluVt0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40B987BE0;
	Sun,  5 Feb 2012 20:27:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3CFC7BDE; Sun,  5 Feb 2012
 20:27:30 -0500 (EST)
In-Reply-To: <7vaa4wda60.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 05 Feb 2012 17:26:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BCD7BC1A-5061-11E1-AAB5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189994>

Junio C Hamano <gitster@pobox.com> writes:

> +		if (!ref_exists(branch_ref.buf)) {
> +			strbuf_reset(&branch_ref);
> +
> +			if (!argc)
> +				return error("No commit on branch '%s' yet.",
> +					     branch_name);
> +			else
> +				return error("No such branch '%s'.", branch_name);
> +		}
> +		strbuf_reset(&branch_ref);
> +

Of course these should be strbuf_release().
