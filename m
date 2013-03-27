From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Wed, 27 Mar 2013 15:07:18 -0700
Message-ID: <7vsj3gjy3t.fsf@alter.siamese.dyndns.org>
References: <20130327122216.5de0c336@hoelz.ro>
 <20130327182345.GD28148@google.com> <20130327211554.GH28148@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rob Hoelz <rob@hoelz.ro>, git@vger.kernel.org,
	josh@joshtriplett.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 23:07:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKyVg-00040g-HL
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 23:07:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659Ab3C0WHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 18:07:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64757 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753483Ab3C0WHV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 18:07:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5BE8A453;
	Wed, 27 Mar 2013 18:07:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bwVWiPDXrk2HJcc07IdV07u5puE=; b=i17lrT
	N8cQ9FxsbcQJ1oVojCy1iPShHQ6ys4G+wvuhjq9sD85lgXRqbB0HDE2PfGUhMEyA
	rrxjwzJvxWY0JYLhH2n2+wKES5A32R5Lc/TEcUFWuD50Fct6UHuM+b92ginVYmjs
	ahn1NM5qCnT0mKL5wRYD6EL7zMs2g39YEeD2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AZpHNCzT3PYn4pO3wUZdglsIuWh6kr5X
	ASv//yfGEAruysEkYeqWoVos9jZgnkgx2K4vu+sN2g/YyoCXsulwszZ/LlxA3ahO
	3U1N1qpMOEjhadHN6Hb8TKnocQUMKi/As6PpSQ4+M7biCx/fa47rYRIYhjcaZFai
	L+uzvviMh80=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA215A452;
	Wed, 27 Mar 2013 18:07:20 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A155A451; Wed, 27 Mar 2013
 18:07:20 -0400 (EDT)
In-Reply-To: <20130327211554.GH28148@google.com> (Jonathan Nieder's message
 of "Wed, 27 Mar 2013 14:15:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B1CA9DC2-972A-11E2-B5D9-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219337>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Sorry, typo.  The configuration in the example above should have been
>
> 	[url "git://anongit.myserver.example.com/"]
> 		insteadOf = myserver.example.com:
> 	[url "myserver.example.com:"]
> 		pushInsteadOf = myserver.example.com:
>
> In other words, suppose I set url.*.insteadof to point to a faster
> address for fetching alongside url.*.pushinsteadof requesting that the
> original address should still be used for pushing.

I didn't know we were even shooting for supporting the identity
mapping:

	url.X.pushinsteadof=X

but that would certainly be nice.

By the way, it seems that the original commit 1c2eafb89bca (Add
url.<base>.pushInsteadOf: URL rewriting for push only, 2009-09-07)
wanted to explicitly avoid use of pushInsteadOf aliasing for a
pushURL and it is also documented in config.txt from day one.

I think the intent is "You have a normal URL, and a way to override
it explicitly with pushURL, or a way to rewrite it via the aliasing
the normal URL with pushInsteadOf. Either one or the other, but not
both, as having many levels of indirection would be confusing."

Which I can understand and sympathise.

In anay case, the change proposed in this thread seems to change
that, so the documentation would need to be updated.  Also the tests
the original commit adds explicitly checks that pushInsteadOf is
ignored, which may have to be updated (unless that test is already
broken).
