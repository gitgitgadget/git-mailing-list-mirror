From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/23] Preliminary pack v4 support
Date: Tue, 27 Aug 2013 08:03:49 -0700
Message-ID: <xmqqioyrfa5m.fsf@gitster.dls.corp.google.com>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Aug 27 17:03:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEKoH-00006j-Bv
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 17:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966Ab3H0PDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 11:03:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57662 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753607Ab3H0PDw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 11:03:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F16233C164;
	Tue, 27 Aug 2013 15:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ckK2oQmP7nvRJBF5iczML5c5T0c=; b=DSNMjD
	g3cyCbZatAu4m1McXyQPi0hP7peFbK8eaQBrKBGnoL9yAC+vLAyQ6GXRq3uxwkil
	p2iKK3I27ZChUR/0rp9KoRw0jA1EA2Hv5+m6E+rJEzpajo8udCndDKxu3L1GWSNu
	w5CVA9bKQgUqUu2vF+/S07wxd03ws1U5UUpNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SBwNESxOVmi26I9dywec/nkfSRttGpzn
	BKFr52yc6pMmc98l1krFp2KCj+cMMsD3wFM8wQtES44zZ2DKdWimPZTnNT8+Xhu3
	tzvSWLydzP5gkeRNP7DXCy2cIcf+DN1QEzqI6A7iT5gsS2ehlIh6t0m3zLjlQyHw
	4zJ/0cDaPeQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE2533C163;
	Tue, 27 Aug 2013 15:03:51 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5EB73C162;
	Tue, 27 Aug 2013 15:03:50 +0000 (UTC)
In-Reply-To: <1377577567-27655-1-git-send-email-nico@fluxnic.net> (Nicolas
	Pitre's message of "Tue, 27 Aug 2013 00:25:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E1D6460C-0F29-11E3-A898-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233096>

Nicolas Pitre <nico@fluxnic.net> writes:

> Subject says it all... at last !
>
> This can also be fetched here:
>
> 	git://git.linaro.org/people/nico/git
>
> Demonstration of what it does at the moment:
>
> 	http://article.gmane.org/gmane.comp.version-control.git/233038
>
> I'd like to preserve the author time stamps as they relate to where in
> the world I was when the corresponding code was written.  You'll notice
> I didn't work on the code in the same order as it is now presented.

We can also notice things like "From: user@machine.(none)" ;-)

> Still open question: what to do with a thin pack.  Should we really
> complete it with local objects upon reception, or were we only over
> paranoid at the time we imposed this rule?

I do not think paranoia had much to do with it.  I am afraid that
allowing a delta in a pack to depend on a base in another pack means
that the former pack becomes unusable without the latter, which
would make object store management (e.g. partial repacking) a lot
more cumbersome, no?
