From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-rebase skips automatically no more needed commits
Date: Wed, 07 Sep 2011 09:29:07 -0700
Message-ID: <7vk49k48q4.fsf@alter.siamese.dyndns.org>
References: <CAC9WiBg9+30NjO+NKXVdBiWjR-HU2689JQqVY7Rk5+DM7MiNBg@mail.gmail.com>
 <7v1uvta97o.fsf@alter.siamese.dyndns.org>
 <CAC9WiBjrfJeJ854dkJMPwRSwuujRsYLnAd7QX7C_oU8_FdOvQA@mail.gmail.com>
 <4E676F6A.3060906@drmicha.warpmail.net>
 <CAC9WiBi_bkLNJZckq2fr3eb6ie+KVfauE_PyA3GcaW5Ga-isFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 18:39:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1L9i-0005e2-L5
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 18:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901Ab1IGQ3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 12:29:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48229 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680Ab1IGQ3J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 12:29:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31BFA3041;
	Wed,  7 Sep 2011 12:29:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mQ00t1yAkZx5FqtIF4iroPFxGJs=; b=twV2Ht
	KPMQfx9pCXBNrhHn1OQFuepBnjeJvRwvfE9l/3ovsxS938qSa40hB8XFXtsAJCRV
	Qh+1dsScJ4iq/sl/Ir7ZD3UktK+VmCNbVU7N/cdgl4IitnWEpQihsFtkfk+gwB2i
	GpHvZufA8eyO3lpmjf8DfYlBJDQDbafFkNE/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cych+4gMlMElsFBAnUmNC2EWEwJ9qT0x
	9KQKUR8cKVzyb95QwLDQ3JRhXrDwP2F31I8C3dnkCF+IXpvu7kCOZZo8EEpXR4lY
	zCvJc7W1gABoBdcGRDPvUXspDcCZPDY0zaFFQ9OunsZcfFNrrcgtcHoPIm1t4E7X
	VawQLamn6nc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2905B3040;
	Wed,  7 Sep 2011 12:29:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2E78303F; Wed,  7 Sep 2011
 12:29:08 -0400 (EDT)
In-Reply-To: <CAC9WiBi_bkLNJZckq2fr3eb6ie+KVfauE_PyA3GcaW5Ga-isFw@mail.gmail.com> (Francis
 Moreau's message of "Wed, 7 Sep 2011 17:34:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82EED566-D96E-11E0-B957-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180865>

Francis Moreau <francis.moro@gmail.com> writes:

> If I start the rebase process with : "git rebase -i -p master foo"
> then the filtering is happening. Here 'foo' has been created with
> v2.6.39 tag as start point and contains some patches cherry-picked
> from the upstream.
>
> However if I call git-rebase this way: "git rebase -i -p --onto master
> v2.6.39 foo", then it seems that no filtering is done.
>
> Is that expected ?

Because "rebase --onto A B C" has to be usable when commit A does not have
any ancestry relationship with the history between B and C, I wouldn't be
surprised if the command does not look at commits on the history that lead
to A that _might_ be related to the ones between B and C. It does not know
how far to dig from A and stop, and obviously you do not want to dig down
to the beginning of the history. "rebase A B" on the other hand can safely
stop digging the history back from A down to where the history leading to
B forked (i.e. merge base between A and B).

I do not know if "expected" is the right adjective; understandable---yes,
unsurprised---yes, justifiable--- I dunno.
