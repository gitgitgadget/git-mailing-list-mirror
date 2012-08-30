From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] name-rev: --weight option (WIP)
Date: Wed, 29 Aug 2012 20:53:49 -0700
Message-ID: <7vharlujaq.fsf@alter.siamese.dyndns.org>
References: <7vharmxkzl.fsf@alter.siamese.dyndns.org>
 <1346275044-10171-1-git-send-email-gitster@pobox.com>
 <1346275044-10171-4-git-send-email-gitster@pobox.com>
 <7vligxuv6l.fsf@alter.siamese.dyndns.org>
 <20120830033611.GA32268@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 30 05:54:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6vpO-0002CM-Ci
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 05:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409Ab2H3Dxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 23:53:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50364 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990Ab2H3Dxv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 23:53:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4142889D4;
	Wed, 29 Aug 2012 23:53:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7OB7DuMiguHVMrc8V/6jaqc+bIw=; b=Ir3YvC
	kMsxE6LFJZNCVTQX8dSqasToYm7QTbFow+FNGtJTdEtb323Iz0kzPKqI86Y6kgit
	j/3BHXGD3iOW9qhxuuU4iNRdwCljpLJeO7aaSKa/pRFqbdQ7PixisG0kQUr8xd5g
	X6yXcAmA8LQBCRf8dYFWIEffJjJ0XDKqR+AX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eB4Mh/M/vMvoQfCGn1zU3D/2ybAOM+iT
	Ilii8R4p1wv9szCwutipAF+Q5HnPd0SUMjwU9pcWuaR8Z1GjG2FvELffjuwQiuo9
	qCxC9rKYwPVBIIgPiY4U9EFujiIJO+bXvTMbLWUhbqP0+R2YSDcRU5cWXl6bpJE2
	Ji52Bz01Jio=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E3C989D3;
	Wed, 29 Aug 2012 23:53:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A018989D2; Wed, 29 Aug 2012
 23:53:50 -0400 (EDT)
In-Reply-To: <20120830033611.GA32268@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 29 Aug 2012 23:36:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F23166E-F256-11E1-97D0-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204517>

Jeff King <peff@peff.net> writes:

> I wonder if you can
> define the weight as a recursive function of the parents.

I do not think we can.  A merge Z between X (that has N commits
behind it) and Y (that has M commits behind it) has at most N+M+1
commits behind it (counting itself), but we cannot tell how many
among these N and M are shared.

> That would double-count "A" and "B" in this example. But maybe there is
> a clever way to define it that avoids that.

We've dealt with this issue long time ago when we optimized the
bisection count, which involves exactly the same issue.
