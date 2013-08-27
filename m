From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/5] replace: forbid replacing an object with one of a different type
Date: Tue, 27 Aug 2013 13:30:03 -0700
Message-ID: <xmqqk3j6c1x0.fsf@gitster.dls.corp.google.com>
References: <20130827194022.11172.56453.chriscool@tuxfamily.org>
	<20130827194828.11172.73829.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Aug 27 22:30:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEPuA-0003Jh-3N
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 22:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398Ab3H0UaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 16:30:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39405 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753894Ab3H0UaN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 16:30:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D84C3C837;
	Tue, 27 Aug 2013 20:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EqQxRia49LONvWaNQoUsVy/aZ6I=; b=wLkjcY
	lGCYhi20yaJVlGRxkPX8ma60kd76SH59aDtZ/2sjPt+Vvs5YwJXa37JaYULZ5qKy
	kdme/5GADlSgrKwhanJ/cM5Zo1XSAgFARWTgXlZ/HuHMKaIcKOATYHPR/pp1dBYb
	rD52Ec8GFjpMGMTgvAudpsOUaGxUPPrTUufk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rj43mjQAJY7z0a+3y0/t4LqdnJOphIc5
	VFxn4FlXWX2ieTBkHSG0/uayxFoRHTPpNdvrRYsjXVBtI/NnDxrsm15x4nsB9YE2
	Z5CAKdBmSqrCf0jqlnV4uGtNKY30GKHbkiFq7LL9hYayLTqDLvXOW9TlWGZ+ytVW
	yyqHbmBtr0c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EE5A3C836;
	Tue, 27 Aug 2013 20:30:13 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56FD13C824;
	Tue, 27 Aug 2013 20:30:11 +0000 (UTC)
In-Reply-To: <20130827194828.11172.73829.chriscool@tuxfamily.org> (Christian
	Couder's message of "Tue, 27 Aug 2013 21:48:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 78BFEDFC-0F57-11E3-BB8E-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233157>

Christian Couder <chriscool@tuxfamily.org> writes:

> Users replacing an object with one of a different type were not
> prevented to do so, even if it was obvious, and stated in the doc,
> that bad things would result from doing that.
>
> To avoid mistakes, it is better to just forbid that though.
>
> There is no case where one object can be replaced with one of a
> different type while keeping the history valid, because:
>
> * Annotated tags contain the type of the tagged object.

If you replace the tagged object and the tag at the same time,
wouldn't that make the resulting history valid again?

Granted, there may not be a strong reason to reuse the object name
of the tagged object in such a case, but this "there may not be" is
merely "I do not think of offhand", so I am not sure what workflow
of other people we are breaking with this change.  A light-weight
tag may already point at the tagged object (in other words, the
object name of the tagged object is known to the outside world) and
that could be a reason why you would need to reuse the object name
of that object while changing its type.

I dunno.
