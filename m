From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a 'generation' number to commits
Date: Fri, 15 Jul 2011 17:36:24 -0700
Message-ID: <7vvcv3ysc7.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.02.1107141126300.4159@i5.linux-foundation.org>
 <7v8vrz1g02.fsf@alter.siamese.dyndns.org>
 <CA+55aFw2_n2NkYpm9c1JiKaX_H4W89Ridq4qzBqyamuxpODejA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 16 02:36:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qhsrx-0000Xn-9i
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 02:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902Ab1GPAg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 20:36:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64227 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751883Ab1GPAg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 20:36:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B46EE4922;
	Fri, 15 Jul 2011 20:36:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cDre6d7yIEjX39ZtIuGGba60/9Y=; b=j3BhMU
	wChGkbTsRt09y2OP3dgJ2I3VWeOD02Oc0/+SL9W7TWtGG0/qups7SIL+ABo9Sl0j
	u9Ntriw2jgD0PPNLUlJMse9zS/riKrySSTY+FP7hva3z/1pAjvfj7ng1liFNhnCd
	pAY1hc52n/WO5ulC5OI7JUwH8ELMzHFZX2c0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hJw5F7CaNoFF3F1dqz+TYK+Gn9ONeooN
	fwZ7/XKNoMeAITtbZEmzuM5z2ZCcv7pMJ7gNLwx3vmFd4vN7iL1UzfLFAzXma0Kq
	4keXlCKFaQDbmzuc51NsG/q3FeCk9Zyk4P9M7a11rfMnLNuQL/m/75Bgy3x9kQEz
	5C3mGfm1Y+g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC9CF4921;
	Fri, 15 Jul 2011 20:36:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F09B4920; Fri, 15 Jul 2011
 20:36:26 -0400 (EDT)
In-Reply-To: <CA+55aFw2_n2NkYpm9c1JiKaX_H4W89Ridq4qzBqyamuxpODejA@mail.gmail.com> (Linus
 Torvalds's message of "Fri, 15 Jul 2011 16:58:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A38C9F74-AF43-11E0-898F-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177245>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Jul 15, 2011 at 12:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> I agree this is the way to go if we _were_ to use generation number
>> associated with commit objects in the longer term,
>
> I have to say, if the main issue was "git tag/branch --contains", and
> if the time-based slop approach of the patch I sent out is acceptable,
> I think that we can continue to ignore generation numbers.

I think we are in agreement that "--contains" can be sped up without
generation numbers.

As I mentioned elsewhere, rev-list SLOP and merge-base traversal have
different performance characteristics and requirements from "--contains"
(for one thing, they cannot say "the commit tagged with v2.6.13 is too old
that there is no way this commit made three days ago is contained in it"
to optimize the traversal). And I agree that if we had generation header
in commit in May 2005, optimizing these traversals properly would have
been much cleaner, and it may still be worth doing it.
