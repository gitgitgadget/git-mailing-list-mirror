From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Storing refs in the odb
Date: Mon, 20 May 2013 11:28:51 -0700
Message-ID: <7va9npv730.fsf@alter.siamese.dyndns.org>
References: <CALKQrgcBkdoJdJGam=VkE=nXHQ8WB5judY3C3nNQBJCns-_f+A@mail.gmail.com>
	<7vbo85wos9.fsf@alter.siamese.dyndns.org>
	<CALKQrgdWx5mw3NCd4JOr3x9M34c2rNjm_tz_C7fm7g7g-LUJZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 20 20:29:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeUpP-0001Y8-NT
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 20:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757721Ab3ETS2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 14:28:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46377 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755618Ab3ETS2y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 14:28:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10AE820B6D;
	Mon, 20 May 2013 18:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8WBeO0MZqxguj+uohaokYKMxAJw=; b=KlRKeO
	g47TkQqtOCTykAoBGyKQvSE9ycZCHFUuC5UqxUrMDppMI8wwv11mGlyCUO2ISetI
	8OxaQUWA22yqXIr3T9ENnwRUPvJhgv/X7+J8ddh7ZnBq21g1EFLqtdW9Rd2KM6JT
	J4EsgRPe91CrDWQc2Q1a47RAZ1TI9ZoBnxWg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RM/IFNfyxKnOaAUopPQLKkPnIv7sUNJF
	yDx4QgVBxdPS6zpGaaYdk7n8PEEKwHxjrvrH3ou7TU41SPgM8omH3HTE4Dpssuyd
	j8iJZtfVa37vA5dslGfWvXlMsVUSE+V01XYfAphguhPN7qZAtSybOYwlgX2EgAAg
	vqGJ894biSI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0790220B6C;
	Mon, 20 May 2013 18:28:54 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 719C620B6A;
	Mon, 20 May 2013 18:28:53 +0000 (UTC)
In-Reply-To: <CALKQrgdWx5mw3NCd4JOr3x9M34c2rNjm_tz_C7fm7g7g-LUJZQ@mail.gmail.com>
	(Johan Herland's message of "Mon, 20 May 2013 19:37:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FE43F14-C17B-11E2-BD34-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224972>

Johan Herland <johan@herland.net> writes:

> I wasn't considering disallowing _anything_, rather open up to the
> idea that a tree object might refer to tag objects as well as
> commits/trees/blobs. E.g. in my suggested-but-pretty-much-retracted
> scheme, I was considering whether the tree entry at the "virtual" path
> "refs/tags/v1.0" should look like this:
>
>   100644 blob 123456... v1.0
>
> where the blob at 123456... contains the object id of the v1.0 tag
> object, or whether we should allow the crazyness that is:
>
>   ?????? tag 987654... v1.0
>
> Just a thought experiment...

I was reacting to this part of your earlier message:

>>> Of course in either case we couldn't use a tree object directly, because
>>> these new "reference tree" objects would refer not only to blobs and
>>> other trees but also to commits and tags.
>>
>> Indeed. I don't know if the best solution would be to actually _allow_
>> that (which would complicate the object parsing code somewhat; a tree

You cannot disambiguate, with the thought-experiment in your message
I am responding to, between these two:

    ?????? tree 987654... v2.6.11-tree
    ?????? tree 987654... sub

where the former is a light-weight tag for that tree, while the
latter is merely a subhierarchy in refs/sub/hier/archy, but if you
disallow v2.6.11-tree, and if you know this kind of tree is only to
express the ref hierarchy, then everything is unambiguous (a commit
is not a submodule but is a ref that points at a commit, a blob is a
ref that points at a blob like refs/tags/junio-gpg-pub, and tag is a
ref that points at the tag).

So it was "workable" alternative implementation of refs (I am not
saying it is an "improvement", with the atomicity and performance
implications we already discussed), if we did not have to worry
about a light-weight tag that directly point at a tree.
