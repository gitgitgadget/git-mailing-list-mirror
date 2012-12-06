From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git repository and Maven project
Date: Thu, 06 Dec 2012 13:35:20 -0800
Message-ID: <7vzk1qj23r.fsf@alter.siamese.dyndns.org>
References: <50C1075E.1060407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Aleks <oles.slosko@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 22:35:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tgj6e-0000Q4-MP
	for gcvg-git-2@plane.gmane.org; Thu, 06 Dec 2012 22:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947206Ab2LFVf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2012 16:35:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62391 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947164Ab2LFVfX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2012 16:35:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F6A399D7;
	Thu,  6 Dec 2012 16:35:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MGbwWTYWnT5KPJTUk14k6/2kz4U=; b=oMkxpE
	4aKKs/qs83LIc8WPaaQ+7pnL/zOE4vpacGP7rZTJscwh5u9wOXV5757r4miJE9Lr
	e8r/Raom5/reASHsYjbk/W3AG1s3i710vuKkzqfxBA6CjLc0uFbsFtIjK8OGJ6q2
	3Wd4XgbINZkYN4TE/7seHn+Lv/1IQ9lW9yCeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OImQKklcihfGj1kdWT4gUWLgbiNNGpJM
	1xcoF1EW5NRxKJfCXhNOp+PO0LoOU55K4GbTUQqixx7FnjIlxfARIZkN/Pitfz+T
	jwdY/nUyP78ze3wp7efixUE0CE3viTorsooidxv8GmuElF3MZy3I6R026gmJ0UGL
	YBVdbV0stS0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C8B299D6;
	Thu,  6 Dec 2012 16:35:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E98EE99D5; Thu,  6 Dec 2012
 16:35:21 -0500 (EST)
In-Reply-To: <50C1075E.1060407@gmail.com> (Aleks's message of "Thu, 06 Dec
 2012 23:00:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D697CD5E-3FEC-11E2-A953-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211170>

Aleks <oles.slosko@gmail.com> writes:

> Can you help to clarify such question.
> We have 2 different projects.
> Name of first project say "server".
> Second - "client".
> Every project has own maven build structure.
> Server produces the war archive for deployment.
> The Client project produces the client jar for testing Server application.
> Aside from these projects we should store different artefacts like
> prototypes for developing pages for server project.

It depends on how tightly coupled the versions of these three
"potentially separate but could be combined" pieces you would want
to make.  Is a particular version of the "server" software meant to
work with any random version of "prototypes"?  Is a particular
version of the "client" software meant to be used to test any random
version of "server"?

Having all three in the same repository means you are guaranteed,
and more importantly, your developers are *forced* to guarantee, a
checkout of a single commit will contain the state of these three
pieces that work well together.  A commit that changes only the
"server" subtree portion, without updating the corresponding assets
in "prototypes" hierarchy that are needed to support what was added
to the "server" part, would break the entire system, and hopefully
your QA procedure can detect and reject it.

Having all three in separate repositories means your developers can
be more loose but it may lead to QA nightmare if a proper procedure
is arranged around the entire process (which Git is only a small
part of).

> I believe the second approach more proper git-approach.
> Such approach allows team to use such advanced git features like
> branging, merging, stash etc.

There is no single "more proper git-approach"; it depends on your
requirements, which the above "how tightly coupled?" question is
an example of.  Branching, merging, etc. are orthogonal and can and
will be useful regardless of the repository arrangement you choose.
