From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix read-tree storing wrong tree reference with modified
 index
Date: Thu, 08 Jul 2010 16:42:51 -0700
Message-ID: <7vvd8po804.fsf@alter.siamese.dyndns.org>
References: <20100708224653.GB50404@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Jul 09 01:43:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX0kD-0001tU-I2
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 01:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758793Ab0GHXnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 19:43:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755563Ab0GHXm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 19:42:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 35516C24D2;
	Thu,  8 Jul 2010 19:42:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6mPIcujcuedZGkxCp+EOjkzkTo4=; b=EIlTpi
	yBoetnqNM0VRP3WdSRFO8DZDExDkr5KEJTmj+mMbw/nMVHR4HNYyqQyXzwWVAqXl
	LVB1w++FamGAEqc+m4Q3vGvqV02RY0IX/h9XGh9ttCV/7UUmIXoXHo2S68cOmHOP
	4Gbo8vosRdgehundA5dJR4EJuX1CFdvAV+b8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dR+7GCGGiT5RWO6QcdZpME60uoHMocVz
	NelvQ4nb9IthUt1Qc9vhFlgrSSC/ekYekfC205cJGk6GkKzAYFgIu7OQ4UeYOfqO
	7O9uxk1wZNtZR1SkHWrKgt8H1zuL5yNhj3gjR68qBcqKYuD2G+oQUZjbEPnCJhH5
	wPU1Taa5NoE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DF9DC24D1;
	Thu,  8 Jul 2010 19:42:56 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61383C24CF; Thu,  8 Jul
 2010 19:42:53 -0400 (EDT)
In-Reply-To: <20100708224653.GB50404@book.hvoigt.net> (Heiko Voigt's message
 of "Fri\, 9 Jul 2010 00\:46\:53 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 886DEDDE-8AEA-11DF-B4F2-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150621>

Heiko Voigt <hvoigt@hvoigt.net> writes:

>  	 * The same holds true if we are switching between two trees
> -	 * using read-tree -m A B.  The index must match B after that.
> +	 * using read-tree A B (without -m). The index must match B
> +	 * after that. With given -m it can be a mix of the old index
> +	 * and the read one.

I think the justification of the original patch is completely bogus.  Why
not just drop the priming instead?  Two-tree read-tree without -m does not
make much sense but the result would look like an overlay of two trees,
and is not likely to match either of the trees.
