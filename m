From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A generalization of git notes from blobs to trees - git
 metadata?
Date: Tue, 09 Feb 2010 21:23:12 -0800
Message-ID: <7vvde5irzz.fsf@alter.siamese.dyndns.org>
References: <2cfc40321002060532g4d22dd4dx403bf312708e1424@mail.gmail.com>
 <201002070236.12711.johan@herland.net>
 <7v1vgxlr9q.fsf@alter.siamese.dyndns.org>
 <20100207050255.GA17049@coredump.intra.peff.net>
 <2cfc40321002062136q64f832aesd979c9cb22f3612@mail.gmail.com>
 <20100207193320.GB3185@coredump.intra.peff.net>
 <7v8wb4aj4m.fsf@alter.siamese.dyndns.org>
 <20100210050902.GD28526@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 10 06:26:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf55c-0002YF-Nv
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 06:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225Ab0BJFX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 00:23:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43891 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab0BJFX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 00:23:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 829509885B;
	Wed, 10 Feb 2010 00:23:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x6848NOB0MJmTteBQeZHoxzT+2E=; b=YdatAA
	Ci3gAwm0GofncB93yD4uu5oxKQxsocOnv/CaHHBtlQt5uGhNDF5QsroS6O9fhBQ8
	lu5A8mjCpTKJwST1NjMOAUsteNsSWwhg8kP/F3Hh9t2VFZki1KQJGWAXXrmFqOom
	SyMKDrsh8hIdXwhstX5wfgMB5UhQs2KNXo1eo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XDkhStkcX5mOfp2EjUdb1yBRxuCpqB3p
	uiG0yn1gqjqIu04bgxPJALmT42U/TksWwFeoHuqRc4jYhjXBWr1AJMxlGSgJbjvC
	M7AZuAIeLlsQDrp7AJuJluXCe5Dl0Yi1q5x1nNJ1+AuHKNwnbU2ClaxVE0LAFDaA
	AsPy3xslAQg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 32EA89885A;
	Wed, 10 Feb 2010 00:23:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C24D98859; Wed, 10 Feb
 2010 00:23:13 -0500 (EST)
In-Reply-To: <20100210050902.GD28526@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 10 Feb 2010 00\:09\:02 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 669D6FB4-1604-11DF-8BED-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139488>

Jeff King <peff@peff.net> writes:

> On Sun, Feb 07, 2010 at 12:25:13PM -0800, Junio C Hamano wrote:
>
>> Suppose Alice, Bob and I are involved in a project, and we annotate
>> commits for some shared purpose (say, tracking regressions).  Alice and
>> Bob may independently annotate overlapping set of commits (and hopefully
>> they have shared root for their notes history as they are collaborating),
>> and they may even be working together on the same issue, but I may not be
>> involved in the area.  What happens when I pull from Alice and Bob and get
>> conflicts in notes they produced, especially the only reason I was
>> interested was because they have new things to say about commits that I am
>> interested in?
>
> Hmm. OK, I see the point of Jakub's message a bit more now. You want to
> create a new view, inconsistent with that of either Alice or Bob (that
> is, you have taken snippets of each's state, but you cannot in good
> faith represent this as a history merge, because your state should not
> supersede either of theirs).

In the message you are quoting, I am not interested in creating a narrowed
view.  If I cannot resolve conflicts between Alice and Bob in a merge in
the contents space, I would ask either of them (because they are more
familiar with the area) to do the merge.  I however was unsure if asking
the same for merges in the notes space is a reasonable thing to do.
