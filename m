From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 4/4] rebase -i: add --refs option to rewrite heads
 within branch
Date: Wed, 23 Dec 2009 10:11:57 -0800
Message-ID: <7vpr65r24y.fsf@alter.siamese.dyndns.org>
References: <20091222222032.GU30538@dr-wily.mit.edu>
 <20091222222316.GY30538@dr-wily.mit.edu>
 <7vzl5awpf1.fsf@alter.siamese.dyndns.org>
 <1ac2d430912222303k6180baa6j291bb4d18c7a4968@mail.gmail.com>
 <4B31DA96.1050608@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg Price <price@ksplice.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Dec 23 19:12:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNVh6-0003oN-0v
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 19:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756665AbZLWSMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2009 13:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756657AbZLWSMP
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Dec 2009 13:12:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39261 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756655AbZLWSMO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2009 13:12:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 63E6F8AA8A;
	Wed, 23 Dec 2009 13:12:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FVAdT93yIEZCuLOipkAgrhtbFVA=; b=lKEOCg
	w8klod4CiNmwyXpSiW+zWFK5tBtvcwbhWxkhHvFLZ9agstbwn1+0L68DR+u0td22
	6Sfl5bPDshm+mpxtU4L4wss8+KUP2A4vvZooBXy9Riww3WY0pWmxMk439VdeQvc5
	yCkY++WdmjoiFG7oONOMQnZaS4fS3UGys68i0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q+pTK09aMFvygaETJH+Zu7/hrSnsdtCb
	cx1Z1EReTrnSyemC7LiPfmT+kvOyoNutsNlUCF7OCW5iGGUuD2GYHs0KvQ2nf0KU
	+lhA7Cxne6q3iE1OLV73jzYeavMmnvxerYIMbSARnAn60Orp4wGfRQDIfF9wIUGs
	XeDNcM/HtZc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 255528AA87;
	Wed, 23 Dec 2009 13:12:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 138148AA7D; Wed, 23 Dec
 2009 13:11:58 -0500 (EST)
In-Reply-To: <4B31DA96.1050608@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed\, 23 Dec 2009 09\:53\:42 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ACFD5CBC-EFEE-11DE-ABE3-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135628>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Greg Price venit, vidit, dixit 23.12.2009 08:03:
> ...
>> Huh, that's an interesting idea.  I hadn't thought of that.  This
>> feature could be nice.  But I am not sure what it would look like.
>> How might the user indicate that they want both "side" and "topic" to
>> be rebased?  I suppose we could extend the familiar command line
>>    git rebase <upstream> [<branch>]
>> to the form
>>    git rebase <upstream> [...<branches>...]
>> so that your example would be
>>    $ git rebase -i --rewrite-heads master topic side
>> If we choose this approach, it might even be independent of
>> --rewrite-refs, though the implementation would presumably rely on the
>> "ref" command.  Was this interface what you were thinking, or do you
>> have another idea?
>
> If I may jump in: I imagine this to be the more common use case, i.e.:
> You have a part of the DAG which you want to rebase, with all kinds of
> refs (branches, tags) pointing to commits in that part of the DAG. If
> you rebase that part of the DAG you typically want some refs rewritten
> (such as the head of the branch you're rebasing) but maybe not others
> (say a release tag or branch). remote refs should never be rebased. So,
> one would need an easy way to specify one ref, all or anything in between...

And warn (or perhaps reject without --force) if the sub-DAG you would
rebase contains an already tagged commit, especially if you are treating
tags as immutable, even the ones you haven't published.

I actually don't think "rebasing side branches while rebasing this branch"
was such a good idea---we have filter-branch for that already ;-).
