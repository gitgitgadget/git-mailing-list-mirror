From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 0/3] Reflogs for deleted refs: fix breakage and suggest
 namespace change
Date: Sat, 18 Aug 2012 17:02:33 -0700
Message-ID: <7vehn3rbom.fsf@alter.siamese.dyndns.org>
References: <20120719213311.GA20385@sigill.intra.peff.net>
 <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu>
 <7vboi8rl2q.fsf@alter.siamese.dyndns.org>
 <B88EFDF9-0AB6-49AC-87E5-7515B99AE601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Alexey Muranov <alexey.muranov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 02:03:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2szH-0005hv-2v
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 02:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520Ab2HSACj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 20:02:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57354 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353Ab2HSACh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 20:02:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22DFD9F81;
	Sat, 18 Aug 2012 20:02:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8mfWgGkUFQrKkCws/dtxlEu2ANk=; b=jnPFrW
	RysQFX3hYwiQa5PfMunu0ot6EjfmYyzaex7Rjp4ZmB2T6yyWx7Cq4aGBP4E7qHA5
	B1auS9r64IlCix0JaTrBD7h54mdeuq0Us0+ipijc5DYKrAih6OUMdmI4yJl4rwGQ
	xdkSIBXj7VY9BgpF6X1ShQ8vL7i7PWUncqP3g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mYBxi+lIWN2YJ4N0+hTJfFUEMqxx0oOc
	QrxTmZatXNO3MRiVWqqodIYZIWXZF9+1UxS4SMHQ2JnAwZrdpWOFwQP4dfX9HTHm
	5HfKirAHO4ccnfBSfp3C/W9HZqzs9u8UqBkSI+fzzrSMTAJhbJI8MM2I7s7+vhTz
	FJsa38gsPlw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B58D9F80;
	Sat, 18 Aug 2012 20:02:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49DB69F7E; Sat, 18 Aug 2012
 20:02:35 -0400 (EDT)
In-Reply-To: <B88EFDF9-0AB6-49AC-87E5-7515B99AE601@gmail.com> (Alexey
 Muranov's message of "Sat, 18 Aug 2012 23:11:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E44D25C-E991-11E1-95BC-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203708>

Alexey Muranov <alexey.muranov@gmail.com> writes:

> On 18 Aug 2012, at 22:39, Junio C Hamano wrote:
>
>> Do we _know_ already what the "ultimate destination" looks like?  
>> 
>> If the answer is yes, then I agree, but otherwise, I doubt it is a
>> good idea to introduce unnecessary complexity to the system that may
>> have to be ripped out and redone.
>> 
>> I didn't get the impression that we know the "ultimate destination"
>> from the previous discussion, especially if we discount the tangent
>> around "having next and next/foo at the same time" which was on
>> nobody's wish, but I may be misremembering things.
>
> Excuse me if i miss something again, but i might be willing to
> discuss the "ultimate destination".  Could you possibly state in
> simple terms what the problem with determining the "ultimate
> destination" is?

Decide if it makes sense to break backward compatibility of loose
ref representation merely to support having a branch "next" and
another branch "next/foo" in the same repository, and if it does,
what the new loose ref representation looks like.

> I hope my opinion might be useful because i do not know anything
> about the actual implementation of Git,...

That sounds like contradiction.

> To just give a quick idea of my ideas, i thought that 'fetching'
> in Git was an inevitable evil that stands apart from other
> operations and is necessary only because the computer
> communication on Earth is not sufficiently developed to keep all
> Git repositories constantly in sync,...

It is a feature, not a symptom of an insufficiently developed
technology, that I do not have to know what random tweaks and
experiments are done in repositories of 47 thousands people who
clone from me, and I can sync with any one of them only when I know
there is something worth looking at when I say "git fetch".
