From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] reset: accept "git reset HEAD <path>" from unborn
 branch
Date: Tue, 19 Oct 2010 16:08:07 -0700
Message-ID: <7vzku9ye5k.fsf@alter.siamese.dyndns.org>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
 <AANLkTimkovH9OysLSxA+=di89Xi+dTCYL5hRPmNaADDH@mail.gmail.com>
 <20101019175103.GA28847@kytes> <20101019182845.GE25139@burratino>
 <7vhbgiyoo9.fsf@alter.siamese.dyndns.org> <20101019221005.GC32029@burratino>
 <20101019221415.GG32029@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 01:08:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8LIG-0002EA-WE
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 01:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756302Ab0JSXI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 19:08:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50013 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755819Ab0JSXIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 19:08:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 722A4E0D43;
	Tue, 19 Oct 2010 19:08:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zYR88sYvAM0ViUmKDRya9EHUBh0=; b=rvhRdn
	EtK/RsiDzFqFFODzbH6FGbyaJo0SRcocFHduT/4E1+ZeySpF++X6RJG6Mzm1QaJ4
	rWB2/K9PKIs/tlD8W2emmNzYRJKd9wP4ddPHThAWQl1pVMCoMqzqfdDXnEZsr8i8
	NVjZp7P1mNhRxpUqFa8HOFK5mSMBEgZmDLfFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CvJyMYzowIgy2EXBZHqp15PvkAVTljLI
	qSU6DyZzH8UVwa9nTLlalsDmRC7TYs7VyKR1zlQExxBd3GsI9bEwzmmTN32R3q9B
	PBS8xiaYx1sJdliyYMQ0l/sh9tNLlEEQEm+8URwi9sRR00FiV8EhQs+suxyJ2sTK
	zgJwKjxa3bY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F1949E0D41;
	Tue, 19 Oct 2010 19:08:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97CCCE0D3F; Tue, 19 Oct
 2010 19:08:08 -0400 (EDT)
In-Reply-To: <20101019221415.GG32029@burratino> (Jonathan Nieder's message of
 "Tue\, 19 Oct 2010 17\:14\:15 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C1C1B19C-DBD5-11DF-A099-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159377>

Jonathan Nieder <jrnieder@gmail.com> writes:

> If I try:
>
> 	... hack hack hack ...
> 	git add .
> 	rm <path1>; # bad file!
> 	git reset <path1>
>
> git will respond by informing me that this use of <path1> is
> ambiguous.

Which is fixed by 3/4.  I think that is probably a sane thing to do.

> ...  So I might try to disambiguate:
>
> 	git reset HEAD <path1>

I however do not think this is sane, as you are _explicitly_ referring to
HEAD, saying "I want to pull this out of the commit pointed by the HEAD",
while there is _no such commit_.  Sounds somewhat insane.

But why is path1 ambiguous in the first place?  It is because it is not
considered to be a pathname, and it is not a valid refname either, right?

Didn't we discuss a separate topic to teach verify_filename/non_filename
to optionally look into the index?  If we did that, perhaps we do not even
need 3/4, no?

We could make it the caller's responsibility to run read_cache() before
calling these two functions (verify_filename() and verify_non_filename()
will just use active_cache[] without reading the index themselves).
Alternatively, we could add a new option "use_index" (0: do not use index
at all, 1: run read_cache() to the_index and use it for checking, 2: run
read_index() on a temporary in-core index, use it for checking and then
discard the temporary in-core index to keep them free of side-effect) to
them.  I haven't looked at all the call sites of them to see which one is
better, though.
