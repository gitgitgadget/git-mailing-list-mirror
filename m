From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git auto-repack is broken...
Date: Fri, 09 Dec 2011 09:35:04 -0800
Message-ID: <7v4nx9hcmv.fsf@alter.siamese.dyndns.org>
References: <CA+55aFznj49hx6Ce6NhJ1rRd2nvNyOERseyyrC6SNcW-z9dyfg@mail.gmail.com>
 <CACBZZX7Q5qb1r_Oh0QfMiWh9UAM1c6QWBn4abv-xHpFBaKuyKg@mail.gmail.com>
 <CA+55aFyq28vmo9dk-5mVm+nNn86qSjNT6VJGc09iaJo=+OP1Sg@mail.gmail.com>
 <20111202171017.GB23447@sigill.intra.peff.net>
 <7vobvqoozr.fsf@alter.siamese.dyndns.org>
 <20111202174546.GA24093@sigill.intra.peff.net>
 <CA+sFfMdeVoz8XU5j4hNn1qCHHzaiDi0Bw=QbbuU3cwT9mMPZOA@mail.gmail.com>
 <alpine.LFD.2.02.1112071709250.2907@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= 
	<avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Dec 09 18:35:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ4Lq-0008QO-8Y
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 18:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316Ab1LIRfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 12:35:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62726 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752186Ab1LIRfH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 12:35:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A32CD68B1;
	Fri,  9 Dec 2011 12:35:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y0yJWWdidiYag3ZYT9cfYURqsQg=; b=U9ZEiU
	UjuzpZOV/6+jytZ8jM/MPSVqYs18Uusudg5nzwGrUQK3Tg4Boneix0aZGccSd4b2
	ujxmlLb828UIFbquZaL6/ZsvSiOyvZmtlado9YcUaNplhNFvoZFKFFaGywLoLhHo
	3XG9YqrcPrku/6HJnVR7Kly9mrM80zuZ7cnVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X0VOiBLYMJ+xzn0V8dJQB7BhZgGLNYkq
	Vk95uhK7x0J7mkmSDwYmkKx7jiK5kPcWmK4yZl1gaO/GsxOPY/a4Xx8EjIR91RNA
	X/nJpzrj6EwLpFNeO/VZYhSIWwRAWtAy8MJJsGRM49F59HuE/82c1+aBa44ZF3Kt
	oBk+hJOF/lQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B0BB68B0;
	Fri,  9 Dec 2011 12:35:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD01768AE; Fri,  9 Dec 2011
 12:35:05 -0500 (EST)
In-Reply-To: <alpine.LFD.2.02.1112071709250.2907@xanadu.home> (Nicolas
 Pitre's message of "Wed, 07 Dec 2011 17:12:14 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 21E45702-228C-11E1-85C1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186654>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Sat, 3 Dec 2011, Brandon Casey wrote:
>
>> Linus's scenario of fetching a lot of stuff that never actually makes
>> it into the reflogs is still a valid problem.  I'm not sure that
>> people who don't know what they are doing are going to run into this
>> problem though.  Since he fetches a lot of stuff without ever checking
>> it out or creating a branch from it, potentially many objects become
>> unreferenced every time FETCH_HEAD changes.
>
> Maybe  FETCH_HEAD should have a reflog too?

It is a feature that the objects that were fetched for a quick peek become
immediately unreferenced and eligible for early removal unless they are
kept somewhere, e.g. remote tracking refs. What problem are we trying to
solve?

I thought everybody agreed that the current expire window for unreachable
objects is way too conservative, especially given that the only purpose of
that window is to protect live objects from concurrent gcs. Perhaps the
only thing we need to do is to trim that window down to say 2 days or even
8 hours?
