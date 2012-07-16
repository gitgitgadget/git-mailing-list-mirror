From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: fix several access(NULL) calls
Date: Mon, 16 Jul 2012 09:56:38 -0700
Message-ID: <7vbojf4pbt.fsf@alter.siamese.dyndns.org>
References: <877gu9wh05.fsf@thomas.inf.ethz.ch>
 <1342094660-3052-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vtxxcc36v.fsf@alter.siamese.dyndns.org> <vpq1ukgai4e.fsf@bauges.imag.fr>
 <7vwr28agcq.fsf@alter.siamese.dyndns.org> <vpq1ukg82st.fsf@bauges.imag.fr>
 <20120713130021.GA2553@sigill.intra.peff.net>
 <vpqliin6bva.fsf@bauges.imag.fr> <87hatboiwr.fsf@thomas.inf.ethz.ch>
 <vpq1ukf68ow.fsf@bauges.imag.fr> <7vy5mn8v2k.fsf@alter.siamese.dyndns.org>
 <vpqmx3011la.fsf@bauges.imag.fr> <7vipdn4qbk.fsf@alter.siamese.dyndns.org>
 <vpq7gu3wtgo.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	<git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 16 18:56:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqobG-0004Cz-Dq
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 18:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181Ab2GPQ4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 12:56:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52190 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752211Ab2GPQ4k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 12:56:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 350288443;
	Mon, 16 Jul 2012 12:56:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/gE/2l+UOvSegCZtUvcvMf42nSY=; b=yNuLto
	K7oKumOXkW9n5DdZMelmU/rckLKUGGNjpP8Vvi7zJQJgNviHhh717mPXVmw+UsHS
	9UWbUJeLb6g1KHWU83rJg18T7x8PoPalgPDJNkdwck7LDe1W7z6x1zEQJ5OerC8l
	Q9M3AZoav22WZ3klNKKY4a/K4f3Q1DCRp5qDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rvavI3tjTpFJxa40GI+w7tP5MMCmZnAS
	vyTlDGHK6bc1Jm8rPvCkOk40iVKOJdOXFAYd1XOyHUjpL0QFs22c7e8uSHFXl7dG
	C5QOEntD3t2h13IyslBC+07R1AKa3b3+vhr4PTAhZYU3tqq6Z02Vc+7AfMPueK+n
	6pxxazGq+bI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21B128442;
	Mon, 16 Jul 2012 12:56:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F6218441; Mon, 16 Jul 2012
 12:56:39 -0400 (EDT)
In-Reply-To: <vpq7gu3wtgo.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 16 Jul 2012 18:39:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 362CACAE-CF67-11E1-8AE5-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201531>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I would think that it is plausible that the user wanted to write
>> into XDG one and used "unset HOME" as a way to signal that wish. 
>
> I didn't think of this case, but it makes sense.
>
> Anyway, I don't really care either way, so I leave it up to you (either
> your patch below, or the fixup in pu).

I do not care deeply either, as there always is "config -f $file" if
somebody wants to write into a specific location.

But if you do something that is different from a straight-and-dumb
conversion from access(A, B) to (A ? access(A, B) : -1), the
conversion is bound to be questioned by somebody in 2 years "isn't
this a misconversion?".  If you did that on purpose, a comment to
explain why it is not a misconversion would help them understand the
reasoning behind it.
