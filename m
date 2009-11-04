From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit -c/-C/--amend: reset timestamp and authorship to 
 committer with --reset-author
Date: Tue, 03 Nov 2009 17:23:18 -0800
Message-ID: <7v639rnkvt.fsf@alter.siamese.dyndns.org>
References: <1257282551-9999-1-git-send-email-erick.mattos@gmail.com>
 <20091104073822.6117@nanako3.lavabit.com>
 <55bacdd30911031551k1bfd3151t940864e4793f5a37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 02:23:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5UbG-000113-Rk
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 02:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217AbZKDBXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 20:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752690AbZKDBXX
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 20:23:23 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61578 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbZKDBXW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 20:23:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 76F39917B2;
	Tue,  3 Nov 2009 20:23:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DuqXyw5SsrFImq/LwUEfP4r3ueE=; b=jsfKrt
	sQuTbVcylP/Jy2pq1S0tN0xJYonNwCDvhA9LTR8f27pmLJQ1GZO9Gp+4DJeIf0Ek
	8WBQwWRH+XTc2ZMFe/sO5kaqx1Wmc0Wp6LGkMRXIT4NJ8/9YRYb0GxE8npDtRjko
	v5uqSaro9soJBgHOy7mbnNrCtMMXCp9zTQe0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OALQpWqYeTMARN8mp7x/mkfAZUW5Q9zM
	Qllf0l+3ZEtJdp4+/lHsoo9DMIoW/gwf/Pv0I60O9SVYGe3sGtgZKN39Bsc7BIGi
	h0KJWIUS2QROPOPZW504ZoLQpmWb7ZGanRIK2p6Gl3425fA0aJ5yfbSkaTEty77j
	xJjjKra0zqU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B227917B0;
	Tue,  3 Nov 2009 20:23:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E1576917AB; Tue,  3 Nov 2009
 20:23:19 -0500 (EST)
In-Reply-To: <55bacdd30911031551k1bfd3151t940864e4793f5a37@mail.gmail.com>
 (Erick Mattos's message of "Tue\, 3 Nov 2009 21\:51\:43 -0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A58176E2-C8E0-11DE-BE96-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132020>

Erick Mattos <erick.mattos@gmail.com> writes:

> ... I had already sent another patch with the
> suggestions he made in a previous email.

That happens in real life with people working in different timezones.

> The new option only touches on getting new author or copying the
> original so that is why I made the first check in whole and the others
> only by author.  If people think that this operation is so uncertain,
> then everything should be compared: parent, author and message on all
> tests.

You probably have misunderstood why we write tests; it is not about making
sure _your_ implementation is Ok.  If that were the case, using knowledge
of implementation details to short-circuit the tests would perfectly be
acceptable.

We write tests so that long after you get bored and stop visiting the git
project mailing-list, if somebody _else_ changes the program and its
behaviour gets changed in a way _you_ did not expect, such a mistake can
be caught, even if you are not monitoring the mailing list to actively
catch such a bad change to go into the system.  So we prefer to test both
sides of the coin without saying "this option only affects this codepath
(currently) so it never can break this part, it is not worth checking this
and that (right now)" when it is not too much trouble.  It is a win in the
long run.

In any case, I like --reset-author better than --mine.  I didn't think of
diamond-mine, though ;-)
