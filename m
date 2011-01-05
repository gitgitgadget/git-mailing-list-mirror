From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [minor BUG] cherry-pick -x doesn't work if a conflict occurs
Date: Wed, 05 Jan 2011 10:33:07 -0800
Message-ID: <7v1v4rdwv0.fsf@alter.siamese.dyndns.org>
References: <20101229141638.GA14865@pengutronix.de>
 <24C35180-AED6-4848-9F05-908831F911F9@dewire.com>
 <20110105065047.GJ25121@pengutronix.de>
 <AANLkTimi8s7QRYuEgr2x=bqwEuFPqUUQF4E=f=_PsoV0@mail.gmail.com>
 <AANLkTi==nMhcN538ekww3FEYFxhOqDqj4_Z7xg0a0B0Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 19:33:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaYAr-00040L-Nc
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 19:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977Ab1AESdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 13:33:24 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46047 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab1AESdY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 13:33:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 611014D75;
	Wed,  5 Jan 2011 13:33:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W3CZaZ4D6TqIeivcQvrXCam3skY=; b=rxC6kR
	HnyFbtE7snaQN9JdnlNtqy8jitz9yZaUdi6elpgWYcL0bIStidYU1J5jkZDb1fuv
	TPRP8jVKPchbaX65qjUPZWrihmNYVai2f87ld5blEjbTm0l/McLdAFJqnbTLd+ry
	hCgUCU/eD7hjOdkIMBG4Kxo/RzaqWcTTZXqz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AXPL3+lfxuFzmBpW99idzHeAp/2/Lsnp
	2IA3fdONVTIT0IAYnw32Y0Y23UX/CAj6AK+xynTH96qr/T4PDbsT9yctlyPHnb43
	48UnJqCnoqbGUSIjsfjIvfcRajCIsN2TrrBynuNOyhmqTfrp+8UiF/k/GhzLN7Fu
	Gaa9tflYjR0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F4EA4D73;
	Wed,  5 Jan 2011 13:33:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 841444D70; Wed,  5 Jan 2011
 13:33:47 -0500 (EST)
In-Reply-To: <AANLkTi==nMhcN538ekww3FEYFxhOqDqj4_Z7xg0a0B0Z@mail.gmail.com>
 (Jay Soffian's message of "Wed\, 5 Jan 2011 11\:37\:39 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 594D0C76-18FA-11E0-95FA-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164579>

Jay Soffian <jaysoffian@gmail.com> writes:

> Ah, seems to be a documented short-coming after-all:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/61737/focus=61933

Well, it is not.

Shawn might have accepted a documentation patch as such during my absence,
but when I originally wrote the "cherry-picked-from", it was a conscious
design decision not to carry the information forward in a conflicted case,
and the reasoning was exactly what you wrote in your first response.

Because -x has become an optional feature that a user has to explicitly
ask, I however tend to agree with Uwe that it may make sense to throw the
original commit object name in the commit log template these days.  That
would allow the user to edit it further and say something like "Originally
done by Foo in commit 1234, forward ported with conflict resolution."
