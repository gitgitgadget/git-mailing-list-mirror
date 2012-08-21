From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fallback on getpwuid if envar HOME is unset
Date: Tue, 21 Aug 2012 12:22:18 -0700
Message-ID: <7vvcgccaol.fsf@alter.siamese.dyndns.org>
References: <CAFFUb6WiXJ0n4NkhOQ=+mcfs+uaAo2_G6TOs7L=AuPwPVfxyMg@mail.gmail.com>
 <20120821023033.GB20271@sigill.intra.peff.net>
 <CAFFUb6UypNJ-8p8Hs14+QMGeU3KSG+pQX7NJTeh3OtBoTZoO3g@mail.gmail.com>
 <7vzk5ocdg7.fsf@alter.siamese.dyndns.org>
 <CAFFUb6XMGgG=6uUzd0Xs1TXWFbJhDpMz1FeFdC8jHqaRi8Y58A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Conley Owens <cco3@android.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 21:22:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3u26-0005nV-As
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 21:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551Ab2HUTW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 15:22:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49997 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754043Ab2HUTWX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 15:22:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBA268CE6;
	Tue, 21 Aug 2012 15:22:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c/he0dMzHgixC0coPlB5UcXFyf0=; b=hJzJZL
	/dD1IjeUJjXw1vSFwomtopX/Akur85pVtRd6e3pCBEXzWQ1AhrFgivFgu/Y5pdXT
	fG9cb5veLi4Av9re+WUJiD+vM5Se8WZuIoIhVPm98eBw+TyAqG1nVL3R9XAuzGGy
	KHy+rxNS9hot5iuMFMjREXE7tAv1S1erQvMXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jrb09uwo/l1t0IySxKYIsLjys+D7c9c1
	LIc9VeuwUM8zW673Q4QDjxzsE2pq5seLqd/V0U8afymbO7dPalLSBy0UOXV9wG5C
	wlau7TA37/DOkH6McnhrDjL/94cCjfVqRcWIHAXw+I5yxXnG2JEdbnH60FRAbUr0
	9c4YTeYhJwA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9F498CE5;
	Tue, 21 Aug 2012 15:22:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 096108CE4; Tue, 21 Aug 2012
 15:22:19 -0400 (EDT)
In-Reply-To: <CAFFUb6XMGgG=6uUzd0Xs1TXWFbJhDpMz1FeFdC8jHqaRi8Y58A@mail.gmail.com> (Conley
 Owens's message of "Tue, 21 Aug 2012 11:33:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 86CC8E98-EBC5-11E1-B26E-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203986>

Conley Owens <cco3@android.com> writes:

> Yes, that's the upstart I'm referring to.  This makes sense.  However, it's a
> confusing situation to run into.  Would a warning about an unset $HOME be
> appropriate?

Unsetting HOME is an easy way to skip what is in ~/.gitconfig when
helping other people on this list, and I wouldn't mind such a
warning while I knowingly unset it, I can imagine other helpful
people may find such a warning irritating and complain "I know I do
not have $HOME set, as I earlier explicitly did unset it myself!".

So, I am on the fence on this one, but because

 (1) no warning would mean upstart scripts writers need to be aware
     of lack of $HOME, but they need to be aware of it for reasons
     unrelated to Git anyway; and

 (2) a warning while trying vanilla Git behaviour to help others
     might be irritating, it is not an every day use anyway.

I do not think it matters either way in practice.
