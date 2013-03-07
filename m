From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] p4merge: swap LOCAL and REMOTE for mergetool
Date: Wed, 06 Mar 2013 23:23:53 -0800
Message-ID: <7vd2vboepi.fsf@alter.siamese.dyndns.org>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi>
 <1362601978-16911-2-git-send-email-kevin@bracey.fi>
 <7vlia0nj0i.fsf@alter.siamese.dyndns.org> <513830AD.10302@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Ciaran Jessup <ciaranj@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Thu Mar 07 08:24:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDVBe-0001ND-5K
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 08:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327Ab3CGHX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 02:23:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41721 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752732Ab3CGHX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 02:23:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 436D48AFC;
	Thu,  7 Mar 2013 02:23:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58028NLBXTNPHtY5OvS/wsEMLds=; b=OC5bFT
	I53iN53irV4lJBtjUaJybd9SE3ssrkxEBiYY1luwSX0y0+6pCPDCwlweU3Q5U1+7
	RPJpXDE9L8McBjBChhbXP2e9dhYDTQV1M0YjRzvaDLVcCsycOCUIOVH7zaKQLxOr
	eo9xZTDUL88GHx7jB7U5HmSmU/9Molu0Py0N8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pZG7LDSjV3NFJGucGJwgPKohk7CHNCkU
	Q9BKOSLTkJKSu+EHIPMSL3ofCIoBvBk1W5tDBwoQSuC4+WUeOYjq+Gw8nXGN2Ody
	bN+6T+iJGTeUjR1UyjHA1GjKQCnKEntbN1xZidlRmgY/GFpWIhsrZQpDg4IIRsUE
	LT17En885R8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37FC58AFB;
	Thu,  7 Mar 2013 02:23:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB7558AFA; Thu,  7 Mar 2013
 02:23:54 -0500 (EST)
In-Reply-To: <513830AD.10302@bracey.fi> (Kevin Bracey's message of "Thu, 07
 Mar 2013 08:16:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F7CEE424-86F7-11E2-91E5-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217576>

Kevin Bracey <kevin@bracey.fi> writes:

> I agree that this is the controversial patch of the two. It's going to
> chuck away 3-4 years of what Git users are used to, albeit in favour
> of a decade of what Perforce users are used to. And it also makes it
> inconsistent with all the other mergetools (at least assuming their
> display matches their command line).

If p4merge GUI labels one side clearly as "theirs" and the other
"ours", and the way we feed the inputs to it makes the side that is
actually "ours" appear in p4merge GUI labelled as "theirs", then I
do not think backward compatibility argument does not hold water. It
is just correcting a longstanding 3-4 year old bug in a tool that
nobody noticed.

For people who are very used to the way p4merge shows the merged
contents by theirs-base-yours order in side-by-side view, I do not
think it is unreasonable to introduce the "mergetool.$name.reverse"
configuration variable and teach the mergetool frontend to pay
attention to it.  That will allow them to see their merge in reverse
order even when they are using a backend other than p4merge.

With such a mechanism in place, by default, we can just declare that
mergetool.p4merge.reverse is "true" when unset, while making
mergetool.$name.reverse for all the other tools default to "false".
People who are already used to the way our p4merge integration works
can set mergetool.p4merge.reverse to "false" explicitly to retain
the historical behaviour that you are declaring "buggy" with such a
change.

How does that sound?  David?
