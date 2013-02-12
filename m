From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/FYI v4 13/12] fixup! t/t3511: add some tests of
 'cherry-pick -s' functionality
Date: Tue, 12 Feb 2013 12:20:24 -0800
Message-ID: <7vliatffnb.fsf@alter.siamese.dyndns.org>
References: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
 <1360664260-11803-14-git-send-email-drafnel@gmail.com>
 <20130212195620.GB12240@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	pclouds@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 21:20:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5MLT-000835-Su
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 21:20:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062Ab3BLUU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 15:20:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57051 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756Ab3BLUU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 15:20:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F4B7B137;
	Tue, 12 Feb 2013 15:20:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K4fU5Kr4fSMfjoAfOdaJXE80T6E=; b=bZL+8E
	puRLW25JcoDj3tpZBZa0mhSyvQBNAezmhiZbWy9ygmbM8wfvsMBo2sqY7WLO+cnK
	iIeSvdov/4hXULYyMwEBdukFPZT6rjvvCrXiYvAFzsYrD/eAMqaykrj/nbX6b+CB
	1vg5ud8TE3jGm9xMC7WdYaMPcUx60n7Zo8xiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OrtZTxQqisUTMlV6TVnAJVGFb3hHSlMZ
	EjWc1E+sK+7GqgOVWeS4jjuthK2rCaFM/EddyfLw/PanL8NBNYz2elWc3/cBuSfE
	d6oqYTrEtXlmm1fpyBiCsmgRGzXqamYBzMMbL+5jrftTh7oywQLI9yQ/T5wn4QiA
	QBVvDX2U43k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 022B2B135;
	Tue, 12 Feb 2013 15:20:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63A83B130; Tue, 12 Feb 2013
 15:20:26 -0500 (EST)
In-Reply-To: <20130212195620.GB12240@google.com> (Jonathan Nieder's message
 of "Tue, 12 Feb 2013 11:56:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A320A06E-7551-11E2-B768-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216187>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Brandon Casey wrote:
>
>> I'm not sure we should apply this though.  I'm leaning towards saying that
>> the 'cherry-pick -s' behavior with respect to a commit with an empty message
>> body should be undefined.  If we want it to be undefined then we probably
>> shouldn't introduce a test which would have the effect of defining it.
>
> Maybe it would make sense to just check that cherry-pick doesn't
> segfault in this case?

;-)

>
> That is, compute the output but don't compare it to expected output, as
> in:
>
> 	test_expect_success 'adding signoff to empty message does something sane' '
> 		git reset --hard HEAD^ &&
> 		git cherry-pick --allow-empty-message -s empty-branch &&
> 		git show --pretty=format:%B -s empty-branch >actual &&
>
> 		# sign-off is included *somewhere*
> 		grep "^Signed-off-by:.*>\$" actual
> 	'

Isn't what the current code happens to do is the best we could do?
We would end up showing one entry whose title appears to be
"Signed-off-by: ..." in the shortlog output if we did so.  If we
added an empty line, then the shortlog output will have a single
empty line that is equally unsightly.

We could force a message like this:

	tree d7f87518a26e9f00714675706f165b94f3625177
        parent f459a4b602c0f4d371e1717572de6d0c4d39c6b1
        author Junio C Hamano <gitster@pobox.com> 1360699963 -0800
        committer Junio C Hamano <gitster@pobox.com> 1360699980 -0800

	!!cherry-picked from a commit without any message!!

        Signed-off-by: Junio C Hamano <gitster@pobox.com>

but I do not think that buys us much; it only replaces a totally
uninformative empty line with another totally uninformative junk.

That ugliness is a price the insane person, who is cherry picking a
commit without any justification made by another insane person,
indicates that he is willing to pay by doing so.  At that point I do
not think we should care.
