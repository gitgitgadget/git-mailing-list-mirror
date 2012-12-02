From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] ignore SIG{INT,QUIT} when launching editor
Date: Sun, 02 Dec 2012 02:04:43 -0800
Message-ID: <7vboeclqh0.fsf@alter.siamese.dyndns.org>
References: <20121130223943.GA27120@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Fox <pgf@foxharp.boston.ma.us>,
	Krzysztof Mazur <krzysiek@podlesie.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 02 11:05:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tf6Q5-0008Lx-3C
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 11:05:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542Ab2LBKEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2012 05:04:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64310 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751748Ab2LBKEr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2012 05:04:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09A759F00;
	Sun,  2 Dec 2012 05:04:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N8GTqI7vcQJOdvxZQRQLQnmZo78=; b=uqVNqB
	V7sH1XWl3ICj+Fvokcg5/MA9G9Q5i0dbD4i8+xgRQVXAa319jW3CuIdp6gsGawk7
	mRYvM92a8pxb/YfeA5zuBF7ielm7zKB0XADvdudXZNNIH1PDNuo4WZCInGp1qHbl
	M9jiv4vwRJ3cKrBBqkf70u1wEt1CCtc0a4llQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CBVSSL6ajf7axUk4KyF8btdBxU8sEvUb
	skuLHJDcJP4RyIhAybZywxYPN/rIkecUgUsrmJCD6MGPYIftbgj55IwPQ/pp0XQY
	g6pe/2k/woEjisT8NW1q94p+kknCcZQg6LAxbnH9Loo4R4IiRgb76L1kXnp1zDP0
	71loI4LNKKM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6F279EFF;
	Sun,  2 Dec 2012 05:04:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55F289EFD; Sun,  2 Dec 2012
 05:04:45 -0500 (EST)
In-Reply-To: <20121130223943.GA27120@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 30 Nov 2012 17:39:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B2CCE540-3C67-11E2-B4A8-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211007>

Jeff King <peff@peff.net> writes:

> Since this can be thought of as "act more like system(3)", I wondered
> whether the signal-ignore logic should be moved into run-command, or
> even used by default for blocking calls to run_command (which are
> basically our version of system(3)). But it is detrimental in the common
> case that the child is not taking control of the terminal, and is just
> an implementation detail (e.g., we call "git update-ref" behind the
> scenes, but the user does not know or care). If they hit ^C during such
> a run and we are ignoring SIGINT, then either:
>
>   1. we will notice the child died by signal and report an
>      error in the subprocess rather than just dying; the end result is
>      similar, but the error is unnecessarily confusing
>
>   2. we do not bother to check the child's return code (because we do
>      not care whether the child succeeded or not, like a "gc --auto");
>      we end up totally ignoring the user's request to abort the
>      operation
>
> So I do not think we care about this behavior except for launching the
> editor. And the signal-propagation behavior of 5/5 is really so weirdly
> editor-specific (because it is about behaving well whether the child
> blocks signals or not).

Nicely explained.  Very much appreciated.
