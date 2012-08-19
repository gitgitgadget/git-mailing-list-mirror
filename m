From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 0/3] Reflogs for deleted refs: fix breakage and suggest
 namespace change
Date: Sun, 19 Aug 2012 10:38:42 -0700
Message-ID: <7v1uj2pysd.fsf@alter.siamese.dyndns.org>
References: <20120719213311.GA20385@sigill.intra.peff.net>
 <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu>
 <7vboi8rl2q.fsf@alter.siamese.dyndns.org>
 <B88EFDF9-0AB6-49AC-87E5-7515B99AE601@gmail.com>
 <7vehn3rbom.fsf@alter.siamese.dyndns.org>
 <A15D5621-7EF5-4409-967A-0DA20B007899@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Alexey Muranov <alexey.muranov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 19:38:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T39Se-00011G-VU
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 19:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138Ab2HSRis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 13:38:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59661 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752326Ab2HSRiq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 13:38:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A24683B3;
	Sun, 19 Aug 2012 13:38:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=17BejfzQl4Gf2oCgdWMOauc0cWI=; b=qQT3WE
	C287EJbw770MhuRU6eoxI/fCFHeXAXse7mruKJFYMTL3JL3o+lreYPzbMWhXkPkX
	tWRJz3mVb1Q8W3asBtkR49OvHjzQFGFsZwMTRQmvGCIVUqFXmchmlKmq+EZeQo0l
	8+8MOLMioSbD7ZIGNM7f8SVi7dcmxrQ5y9d8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ww3FoO4ypC49KgQyrCRyamnQae7gTTWQ
	boM4+QR2y+DKX7IHFESzDUo8yrfj1/XXIt77ltQ80kJWOp/U/yUDyAoq38K9eFPX
	NpkZtetlFqTFcCSjGkTowLSWjiBg9JByf9yJvOfBDJX647MDjusJefZ1uHsD9vWh
	dEtdoCptSuE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB6F183B2;
	Sun, 19 Aug 2012 13:38:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 613D083AF; Sun, 19 Aug 2012
 13:38:44 -0400 (EDT)
In-Reply-To: <A15D5621-7EF5-4409-967A-0DA20B007899@gmail.com> (Alexey
 Muranov's message of "Sun, 19 Aug 2012 13:28:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B929C8C6-EA24-11E1-B619-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203727>

Alexey Muranov <alexey.muranov@gmail.com> writes:

> 2. I think that allowing both "next" and "next/foo" complicates
> the mapping from branch names to file paths, and it does not seem
> necessary if dead reflogs are moved away to "graveyard" anyway.

It is unclear why the first two lines above leads to the conclusion
"it does not seem necessary" (but honestly, I do not particularly
care).

> 3. There remains the question what to do with dead reflogs for
> different branches having the same name.  Maybe, keep the death
> date and time under the graveyard directory and not allow the user
> to delete 2 times in less than 1 second?
>
> /logs/graveyard/yyyy-mm-dd-hhmmss/refs/heads/next/foo

How would that help us in what way?

When I ask "git log -g next/foo" for the "next/foo" branch that
currently exists, I want to see the update history of its tip since
I created it for the last time, and then an entry that says I
created it at such and such time.  If I used to have the branch
before but deleted, then the output should be followed by another
entry that says I deleted it at such and such time, followed by the
history of the tip updates.
