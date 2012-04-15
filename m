From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5570: use explicit push refspec
Date: Sun, 15 Apr 2012 12:20:06 -0700
Message-ID: <7v7gxg2461.fsf@alter.siamese.dyndns.org>
References: <20120414182907.GA3915@ecki> <20120414183225.GB3915@ecki>
 <7viph1288e.fsf@alter.siamese.dyndns.org> <20120415001133.GB32140@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Zbigniew =?utf-8?Q?J?= =?utf-8?Q?=C4=99drzejewski-Szmek?= 
	<zbyszek@in.waw.pl>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Apr 15 21:21:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJV0j-0001ej-27
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 21:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173Ab2DOTVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 15:21:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63530 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892Ab2DOTUL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 15:20:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2FF86B47;
	Sun, 15 Apr 2012 15:20:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+YEXvMi2iDSxjhg+7/EMg6Nr05U=; b=pGFR7f
	TI88vvIdXA08QvDeVI0SUTmq8bcmctu2gnZh0bcs1gfzW+QfN3KJ88R4nW+eg96I
	iYoFUjKHPurig0jxvbbUzpdp7PdDUAi5WEbr0IQkzVl3i+G9mg5E3/vOASm3X0Gq
	4VbhtWgQ/2SDJLkksUC3bggYpz8LEerZrNCbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iG3zU/rKIbHHBCZdrggDnDMgMrCS9AeV
	QsbhSrUsQkqemdAPvuFhVSkzLF4R4yt0097WP1qFNYl09i42AeRWwPNoow/Rqjqv
	j2zISKjhf6u0QVjJulRb0v42CL5nlwyauzhJYEIJ4o7rM0cYUXZ3MLtYcS0iazzm
	1O+kn5+VUgc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA2BD6B46;
	Sun, 15 Apr 2012 15:20:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E34D6B44; Sun, 15 Apr 2012
 15:20:08 -0400 (EDT)
In-Reply-To: <20120415001133.GB32140@ecki> (Clemens Buchacher's message of
 "Sun, 15 Apr 2012 02:11:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 037E90B2-8730-11E1-96C3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195574>

Clemens Buchacher <drizzd@aon.at> writes:

> On Sat, Apr 14, 2012 at 04:40:01PM -0700, Junio C Hamano wrote:
>> Clemens Buchacher <drizzd@aon.at> writes:
>> 
>> > The default mode for push without arguments will change. Some warnings
>> > are about to be enabled for such use, which causes some t5570 tests to
>> > fail because they do not expect this output. Fix this by passing an
>> > explicit refspec to git push.
>> 
>> I wonder if a better fix is to configure "push.default = matching" in the
>> test repository.  Otherwise wouldn't the result of the push change once
>> the default changes?
>
> The push.default option matters only if a refspec is not specified. By
> adding a refspec, push.default should not matter any more. Unless that
> is going to change as well?

No, I was thinking more about testing cases where there is no refspec on
the command line, which we used to test, but with your patch we no longer
do.  In other words, your fix not just squelches the advice message and
make them pass, but it changes the way the command behaves, no?

Besides, that way you do not have to swap the parameters to test_remote_error
so we do not have scratch our heads wondering why we have changes to test
vectors that run clones and fetches.
