From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git commit generation numbers
Date: Thu, 14 Jul 2011 13:26:32 -0700
Message-ID: <7vmxgg38xz.fsf@alter.siamese.dyndns.org>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
 <20110714183710.GA26820@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 14 22:26:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhSUb-0005jJ-Ko
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 22:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854Ab1GNU0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 16:26:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43827 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753071Ab1GNU0g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 16:26:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 882B5450D;
	Thu, 14 Jul 2011 16:26:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2PDtJnrh0PfKXJA5ZCGP3bzQDJM=; b=iAfBkf
	e5oIFxLcZ7dvqp1GSFiaNUzGdzMBj6t2G8MYixsgYdDQ270nX4XZuOVf2lGpc2S4
	Li4yPHoHKqDhInnaBZpnc3zvoVwP82vHu1xhAJPEeeCU5gQyvwLO5Kf4UlP3hO8h
	DNyPjmDahdgyjlb0ZFbFmXDza0Opf5/Y1y+24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=toqrBFbzwVNCSidH9mBPfoP0UTFXTwPL
	BjOkWeNe8G0Ldb0TYuCplET7R4Cterx6QgqU50U4BM42ieKIcOxafUjNjWV73gs3
	szyGxu+T7N8aAIjAyfsdIF3BcUtBBD2tdk+bJRSVoxPH9FxC0VyyoZRHjpgLKatV
	MmegJrNdhLU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FD9E450C;
	Thu, 14 Jul 2011 16:26:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14E29450B; Thu, 14 Jul 2011
 16:26:34 -0400 (EDT)
In-Reply-To: <20110714183710.GA26820@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 14 Jul 2011 14:37:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 91B3855C-AE57-11E0-AEAE-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177173>

Jeff King <peff@peff.net> writes:

> There's also one other issue with generation numbers. How do you handle
> grafts and object-replacement refs?  If you graft history, your embedded
> generation numbers will all be junk, and you can't trust them.

By the way, I doubt your "invalidate and recompute generation cache when
replacement changes" would really work when we consider object transfer
(which is the whole point of deprecating graft with object replacement
mechanism). For the purpose of connectivity check during object transfer,
we deliberately _ignore_ the object replacements, so you would at least
want to have an ability to show the generation number according to the
"true" history recorded in commits (which can come from Linus's in-commit
generation number once everybody migrates) and the generation number that
takes grafts and replacements into account (for which we cannot depend on
in-commit record).
