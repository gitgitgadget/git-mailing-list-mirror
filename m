From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Re: cherry-pick and 'log --no-walk' and ordering
Date: Mon, 13 Aug 2012 10:05:06 -0700
Message-ID: <7vzk5yen99.fsf@alter.siamese.dyndns.org>
References: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
 <50289e50.8458320a.7d31.3c46SMTPIN_ADDED@gmr-mx.google.com>
 <7vhas7fefs.fsf@alter.siamese.dyndns.org>
 <CAOeW2eHprw73+zqVbJRird1eE7ayU_KjCUSoieYsGi1rbL5QBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 19:05:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0y4y-0003vY-EE
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 19:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587Ab2HMRFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 13:05:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47104 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753164Ab2HMRFM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 13:05:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44B1588EC;
	Mon, 13 Aug 2012 13:05:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TwpIRGJVkkHxzwuV0Rp5XQVS0Tg=; b=CmqnvK
	Y22c0kgMGhLYNBvTAaoAB0PC7xn6bzRsoN9vzDz1tWINz9UrfYUpGh9uf1qWEWR6
	G6mHu1m9elHocKqnXmTlmpyPffFNsAdedfehjeapW5ZJ1N2qm/dz01S+mzVZigU3
	q6dOoreyd2NQvWNflDEwfsZwWnE9WoPGZYWiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WxgyurkeMUgFKG5KO5jKlxJOFvXNuxY1
	QDvq2bKbl7bcEiQbLvOPyc02eQnSiSF3IQRWP+LU6gJyrsJMl1jfe2emVsHevfwX
	iXj+RkcgUEh7Kut+wnvVY5HRHpQIDCunylaZQ4jpiIDKMX5e1h+pPsOQe+8LRrDL
	5tcLHX4FV6A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3030A88EB;
	Mon, 13 Aug 2012 13:05:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8254988E9; Mon, 13 Aug 2012
 13:05:08 -0400 (EDT)
In-Reply-To: <CAOeW2eHprw73+zqVbJRird1eE7ayU_KjCUSoieYsGi1rbL5QBQ@mail.gmail.com> (Martin
 von Zweigbergk's message of "Mon, 13 Aug 2012 09:09:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0922B916-E569-11E1-B65A-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203344>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> I also thought the sorting was just a bug. From what I understand by
> looking how the code has evolved, the sorting in the no-walk case was
> not intentional, but more of a consequence of the implementation. That
> patch you suggested was my first attempt and led me to find the broken
> cherry-pick test cases that I then fixed in patch 2/4. But, it clearly
> would break the test case in t4202 called 'git log --no-walk <commits>
> sorts by commit time'. So I started digging from there and found e.g.
>
> http://thread.gmane.org/gmane.comp.version-control.git/123205/focus=123216
>
> For convenience, I have pasted the commit message of the commit
> mentioned in that thread at the end of this email.  So we would be
> breaking at least Johannes's use case if we changed it.

Ok.  Having a way to conveniently sort based on committer date is
indeed handy, and losing it would be a regression.

Not that the accident that supports only on committer date is a
nicely designed feature.  The user may want to sort on author date
instead, but there is no way to do so with --no-walk.  So in that
sense, Johannes's use case happens to work by accident.

> ... so is a migration desired? Or just
> change the default for --no-walk from "sorted" to "unsorted" in git
> 2.0?

I think the proper support for Johannes's case should give users
more control on what to sort on, and that switch should not be tied
to "--no-walk".  After all, being able to sort commits in the result
of limit_list() with various criteria would equally useful as being
able to sort commits listed on the command line with --no-walk.
Think about what "git shortlog A..B" does, for example. It is like
first enumerating commits within the given range, and sorting the
result using author as the primary and then timestamp as the
secondary sort column.

So let's not even think about migration, and go in the direction of
giving "--no-walk" two flavours, for now.  Either it keeps the order
commits were given from the command line, or it does the default
sort using the timestamp.  We can later add the --sort-on option that
would work with or without --no-walk for people who want output that
is differently sorted, but that is outside the scope of your series.

> By the way, git-log's documentation says "By default, the commits are
> shown in reverse chronological order.", which to some degree is in
> support of the current behavior.

That is talking about the presentation order of the result of
limit_list(), predates --no-walk, and was not adjusted to the new
world order when --no-walk was introduced, so I would not take it as
a supporting argument.

But not regressing the current "you can see them sorted on the
commit timestamp (this is merely an accident and not a designed
feature, so you cannot choose to sort on other things)" behaviour is
a reason enough not to disable sorting for the plain "--no-walk"
option.

Thanks.
