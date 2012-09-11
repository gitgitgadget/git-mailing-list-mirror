From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] build: don't duplicate substitution of make
 variables
Date: Tue, 11 Sep 2012 12:52:27 -0700
Message-ID: <7vd31sgww4.fsf@alter.siamese.dyndns.org>
References: <1be62f9a7bbe728e6422e668d982ddf313d016eb.1347378209.git.stefano.lattarini@gmail.com> <1c54b744c0ec6987f7987a41853ab0ae00513d03.1347378210.git.stefano.lattarini@gmail.com> <7vtxv4h3lh.fsf@alter.siamese.dyndns.org> <504F824F.3050903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 11 21:52:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBWVi-0005SZ-FV
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 21:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754828Ab2IKTwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 15:52:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63120 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329Ab2IKTw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 15:52:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5900F8E08;
	Tue, 11 Sep 2012 15:52:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kyln8Fc53JIAwKsXKLSYxNt36mk=; b=bB9Rnx
	XnRYClcfBoPvsOuCzlwJ480QBjo8zPIyLaV0R2uk0n0ZvzHirCcwjGAx57hk9gpJ
	zaASwHCXMBkOOaQDVjP2NGCzLN1R4KDYyltl2Wx37UWvmFeKXWptZYn0HfSkFvU+
	bzVfnZ/nT06/6exnPV1bIyFDp3aBEy06oJ70Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=euvRszz3ITRi7EwLGuxxcbQbn9LEzXoH
	OKtQExURql2gFBLmxcc4Ian95OBqIIm3fNabeidJbaEK/KPmphoVImPp9izvgAFY
	9tTazsTfoOZJZ9Q1d5ONvx1ZBKLl7npdpA74+9jG+yfxep3YAnW1b1gkorQMhHH8
	o8n8aLf+mxU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44CCE8E07;
	Tue, 11 Sep 2012 15:52:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 977438E06; Tue, 11 Sep 2012
 15:52:28 -0400 (EDT)
In-Reply-To: <504F824F.3050903@gmail.com> (Stefano Lattarini's message of
 "Tue, 11 Sep 2012 20:26:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3778DF78-FC4A-11E1-B2A9-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205261>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> On 09/11/2012 07:27 PM, Junio C Hamano wrote:
>> Stefano Lattarini <stefano.lattarini@gmail.com> writes:
>> 
>>> Thanks to our 'GIT_CONF_SUBST' layer in configure.ac, a make variable 'VAR'
>>> can be defined to a value 'VAL' at ./configure runtime in our build system
>>> simply by using "GIT_CONF_SUBST([VAR], [VAL])" in configure.ac, rather than
>>> having both to call "AC_SUBST([VAR], [VAL])" in configure.ac and adding the
>>> 'VAR = @VAR@' definition in config.mak.in.  Less duplication, less margin
>>> for error, less possibility of confusion.
>>>
>>> While at it, fix some formatting issues in configure.ac that unnecessarily
>>> obscured the code flow.
>>>
>>> Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
>>> ---
>>>  config.mak.in |  49 --------------------
>>>  configure.ac  | 144 +++++++++++++++++++++++++++++++---------------------------
>>>  2 files changed, 76 insertions(+), 117 deletions(-)
>> 
>> Whoa ;-).
>>
> Well, I could have converted one variable at the time, but that seemed
> an overkill :-)

No, I was happy to see many lines go ;-)
>> These two hunks suggest
>> that you may be favoring spaces, but other places you seem to use
>> tabs, so...
>>
> I can convert the new tabs to spaces if you prefer (that would have been
> my preference too, but thought trying to follow the "Git preferences"
> was more important).  No big deal either way for me.

If this were other parts of the system, my preference would be to
use tabs, but because I do not help very much in the autoconf part
myself, I do not have a particular preference.  If it is more common
to indent the configure.ac script with spaces, that would be more
familiar to the folks who work on it, and I do not have much against
choosing and sticking to space indented configure.ac file if that is
the policy.

But if this patch is not about cleaning up the style to make it
conform to a policy (whichever it is), I would have preferred to see
a clean-up patch as a separate step, not mixed together with this.

That's all; either way, no big deal.
