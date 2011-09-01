From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Dropping '+' from fetch = +refs/heads/*:refs/remotes/origin/*?
Date: Thu, 01 Sep 2011 11:39:22 -0700
Message-ID: <7vhb4ww1id.fsf@alter.siamese.dyndns.org>
References: <7vliu8w25g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 01 20:39:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzCAm-00057r-Tm
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 20:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757354Ab1IASjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 14:39:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56960 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757320Ab1IASjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 14:39:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88CC05C15;
	Thu,  1 Sep 2011 14:39:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hpOBxrDWSKtnPqo6eQmA4DqUdy8=; b=MHnrDH
	Ljpf6vImDmXzk93k31OHHfQchjQ8bYi555zgGD5SSGWv1A8TrV/XaMBLDP7oYW3o
	OpvIq1pRmOWRGqfZX2gQS0alGVWYQFL5cO94cYjgkh6FJ4ovRik3RIBGQTjjh2zl
	oQH0dohj+4l8MMv6k97WSN5Te4j7mJLxZ64pM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kbgQrayNpL4sZdJa0O3kSMT2ILWwitls
	//2ZKlW6mhQcqqB4AE0Zt7IBB4xMwIF+++9jYfxaUGTjMq3nRAoSXmpPzwLsH5gy
	TjBm6vU9z18I5ZVgX1mV827ycPWSWS9UUvQPTO3+sR7TR4990CZlSDxaY2SEyEqA
	PZRCm3XXV50=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 806045C14;
	Thu,  1 Sep 2011 14:39:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1577D5C13; Thu,  1 Sep 2011
 14:39:23 -0400 (EDT)
In-Reply-To: <7vliu8w25g.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 01 Sep 2011 11:25:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6C4D38A-D4C9-11E0-A3C3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180562>

Junio C Hamano <gitster@pobox.com> writes:

> Suggested reading:
>
>   http://git-blame.blogspot.com/2011/08/how-to-inject-malicious-commit-to-git.html
>
> I am wondering if we are better off applying something along the lines of
> this patch, so that with the default configuration, users can notice if
> their upstream unexpectedly rewound their branches.
>
> It would produce
>
> 	[remote]
>         	url = git://.../git.git/
>                 fetch = refs/heads/*:refs/remotes/origin/*
>
> upon cloning from my repository, and your "git fetch" will fail because
> the pu (proposed updates) branch is constantly unwinding, but that can be
> easily fixed with
>
>
> 	[remote]
>         	url = git://.../git.git/
>                 fetch = refs/heads/*:refs/remotes/origin/*
>                 fetch = +refs/heads/pu:refs/remotes/origin/pu
>
> as the explicit refspec trumps the wildcard one.

It appears that we have a glitch somewhere in the implementation. We
should make the explicit refspec trump the wildcarded ones.
