From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] drop some "int x = x" hacks to silence gcc warnings
Date: Thu, 21 Mar 2013 07:58:51 -0700
Message-ID: <7vppysbxzo.fsf@alter.siamese.dyndns.org>
References: <20130321110338.GA18552@sigill.intra.peff.net>
 <514AF2E1.7020409@viscovery.net>
 <20130321115545.GB21319@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 21 15:59:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIgxe-0007IO-7q
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 15:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722Ab3CUO6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 10:58:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40871 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753472Ab3CUO6x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 10:58:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A2E5A812;
	Thu, 21 Mar 2013 10:58:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F00C9xYYmil/5Mtn0wii8ayKFas=; b=Q139Z+
	dophdvcDxv/oAIx3EqFy9tHbU54tM4fd7qABOyu3BhoQQ2/uLpfrnrL/aMZSD0Xw
	Ks3SuEm+SaK8vuUyjZk+C2WZu7vBBDgEDWTFbggv9p5xMVqX4ltb/rFk9lHp6GNS
	K9PamB4bSgorBKwnOp/0nIKsDOyNybbZpnhGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iN/7XgmBVcGuBr8ohJdFRpNTrGZqoyZl
	y67sOYNgDxstOMujRmzibNQvIxk8KxJaKTeg1D9oP2EfG/MMeoDYuPJgH6L+Qg8x
	S/DCIbXut4rwK9mPjyChcYG+y0s7Zgyb7d2OVeHO6nmMVMwPsiJ28AOsAF4wUjwV
	7xzG5xGSZT4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D28EA811;
	Thu, 21 Mar 2013 10:58:53 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2CBDA810; Thu, 21 Mar 2013
 10:58:52 -0400 (EDT)
In-Reply-To: <20130321115545.GB21319@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 21 Mar 2013 07:55:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8720962-9237-11E2-9FD0-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218731>

Jeff King <peff@peff.net> writes:

> Git code was my introduction to it, too, and I was led to believe it was
> idiomatic, so I can't speak further on that. I think it was Junio who
> introduced me to it, so maybe he can shed more light on the history.

I think we picked the convention up from the kernel folks.  At least
that is how I first met the construct.  The uninitialized_var(x)
macro was (and still is) used to mark these "The compiler is too
dumb to realize, but we know what we are doing" cases:

    $ git grep '#define uninitialized_var' include/
    include/linux/compiler-gcc.h:#define uninitialized_var(x) x = x
    include/linux/compiler-intel.h:#define uninitialized_var(x) x

but they recently had a discussion, e.g.

    http://thread.gmane.org/gmane.linux.kernel.openipmi/1998/focus=1383705

so...
