From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Sat, 13 Feb 2010 18:00:05 -0800
Message-ID: <7v1vgo4lwa.fsf@alter.siamese.dyndns.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100213121238.GA2559@progeny.tock> <20100213133951.GA14352@Knoppix>
 <201002131539.54142.trast@student.ethz.ch> <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <alpine.DEB.1.00.1002140249410.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 14 03:00:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgTn1-0003u7-Jk
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 03:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145Ab0BNCAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 21:00:24 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932068Ab0BNCAW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 21:00:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 93430990D7;
	Sat, 13 Feb 2010 21:00:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KSWxnMTyWByNASvIZnEQcIiP0Fg=; b=OiBfsi
	TrO3tJ//+uKjtqo159Ml/PbDjeinmho1xa6rFA6dPLvK7IcwyOJ6tHEYJEHduxH5
	UYhdsaEuTOdu5t/HYRaeavy1Q5hnK5TPEmCgtCiX6ouDZy5BL6eegG4wPvdUnQLG
	Orw3HoPgqHV/n6Nzbg6pxSt5O/a4fS0yTPNl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XqpWyKQS0WxDzwHN98tOIrnZN1eEKNWl
	wra9s4LKTPd+D1tCDq4l39DWRuYniHawV8Gr6nlNha8ib2HD+MJ9Tm2OGfy6G/XY
	kkK++Lm+fm+Y8XPbxjFoEF3uoDQHbCEWas6JZ6c505iMIWR1DXzI7Uc92Izhonq6
	g03WKGxB8r8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 24663990CF;
	Sat, 13 Feb 2010 21:00:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D50A9990C9; Sat, 13 Feb
 2010 21:00:06 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1002140249410.20986@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sun\, 14 Feb 2010 02\:53\:58 +0100
 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B169A714-190C-11DF-BECA-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139881>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> And even if you could be certain, a hint is missing that strbuf_read(), 
> its name notwithstanding, does not read NUL-terminated strings. Oh, and 
> the size is just a hint for the initial size, and it reads until EOF. That 
> has to be said in the commit message.

It is healthy to ask for explanation, especially when the patch cannot
justify itself by reading only the diff but reviewer needs to check the
surrounding code.

I however think you are asking a little too much in this particular case.
That strbuf_read() code is exactly the same as in used for "reading from
pipe and we don't know how big it is" case in the original code.  You can
see it in the lines deleted by the patch.
