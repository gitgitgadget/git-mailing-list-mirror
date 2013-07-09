From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Tue, 09 Jul 2013 15:09:58 -0700
Message-ID: <7v38rnv0zt.fsf@alter.siamese.dyndns.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
	<1373399610-8588-1-git-send-email-gitster@pobox.com>
	<1373399610-8588-8-git-send-email-gitster@pobox.com>
	<51DC7199.2050302@kdbg.org> <7vhag3v59o.fsf@alter.siamese.dyndns.org>
	<51DC78C0.9030202@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jul 10 00:10:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwg6p-0004Li-SR
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 00:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400Ab3GIWKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 18:10:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62274 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173Ab3GIWKB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 18:10:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2FA42F6A4;
	Tue,  9 Jul 2013 22:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RJ/7f7AgxBUcMrnSEoAHkJyXcOY=; b=qWonWY
	umF0s2rM8D6Y+hMXBI/mvC6wb2gR1ehK5k5WTCeTeSNab76nEn+N+dk0RVHn+l3S
	3wnJKEBlSctQ0+UEQZwWmIFf9RXOusKuCwrnbS21FD8UVhbs6WwHZOTCTCmbiL2f
	utANQ2w/waqiOXfN3EvrZ4KwImHy4557Fj514=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sKGyv4SDn4OWPcALrg3yMFqLoD1Ac1Ht
	9G0/czerecUuo1wg17wpxjbbmd4JQXTeh+sKqzUVdhgAW6MKcy7K9nq4uRY62RWw
	NUFtbRBvfvTU9yJP6bwk8Y0iniwK81I7XNanWVOeckokxSuVWgXf5Jrr/7wlwXzH
	Q6XKsAc3zMY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0F622F6A2;
	Tue,  9 Jul 2013 22:10:00 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA78A2F69F;
	Tue,  9 Jul 2013 22:09:59 +0000 (UTC)
In-Reply-To: <51DC78C0.9030202@kdbg.org> (Johannes Sixt's message of "Tue, 09
	Jul 2013 22:55:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4BFEA310-E8E4-11E2-BBF7-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230011>

Johannes Sixt <j6t@kdbg.org> writes:

> No. --force means "I know what I am doing, no safety needed, thank you".

I sympathize the desire to keep a big red button to override
everything, but it is still not clear how these two independent
safety should work together and should possibly seletively be
overriden.

A proposed ref update can be in one of the four:

 1. The update fast-forwards, and the ref to be updated is at the
    expected place (or you simply do not care what the current value
    is);

 2. The update does not fast-forward, and the ref to be updated is
    at the expected place (or you simply do not care what the
    current value is);

 3. The update fast-forwards, but the ref to be updated is not at the
    expected place; or

 4. The update does not fast-forward, and the ref to be updated is
    not at the expected place.

So far we had only 1. and 2. because we did not have this "old value
has to be at X".  And --force has been the way to allow 2. to go
through.

Now we are adding 3. and 4. to the mix.

If --force were the big red button that allows all four, is that
sufficient to cover the necessary cases, especially given that some
people seem to want to make the --lockref on by default (implying
that 3. and 4. will both fail by default unless forced in some way)?
For example, would there be a case where we want to allow 3. but not
4. (or vice versa)?

You _could_ structure the safety into hierarchies:

 * safest: no-ff will be rejected, and current value at an
   unexpected place is also rejected.  That would be:

   $ git push --lockref

 * --lockref only: no-ff is not even checked, but current value
     must be at an expected place.  How would that be spelled???

   $ git push --lockref ???

 * --force: anything goes.

   $ git push --force --no-lockref

Where does "ff-check only" fit in the hierarchy?

This is one of the reasons why the original design of "--lockref"
was to even countermand "allow non-fast-forward" (which is the
original meaning of "--force").

I _think_ I am OK if we introduced "--allow-no-ff" that means the
current "--force" (i.e. "rewinding is OK"), that does not defeat the
"--lockref" safety.  That is the intended application (you know that
push does not fast-forward because you rebased, but you also want to
make sure there is nothing you are losing by enforcing --lockref
safety).

If that is what happens, then I think "--force" that means "anything
goes" makes sense.

With the posted series, adding "--force --no-lockref" to the command
line is how to spell that big red button.
