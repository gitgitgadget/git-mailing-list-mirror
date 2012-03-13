From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: error out when seeing -b/--binary
Date: Tue, 13 Mar 2012 10:31:03 -0700
Message-ID: <7v62e8la9y.fsf@alter.siamese.dyndns.org>
References: <20120312064855.GB16820@burratino>
 <20120312085820.GA11569@1wt.eu> <20120312152004.GB9380@kroah.com>
 <20120312152453.GB12405@1wt.eu> <87aa3l4vqq.fsf@thomas.inf.ethz.ch>
 <20120312165703.GB18791@burratino> <7vvcm9snko.fsf@alter.siamese.dyndns.org>
 <87399dpk48.fsf@thomas.inf.ethz.ch> <20120312215607.GB11362@burratino>
 <874ntto4t8.fsf@thomas.inf.ethz.ch> <20120312222227.GC11362@burratino>
 <87fwdcldqj.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Willy Tarreau <w@1wt.eu>, Greg KH <greg@kroah.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
X-From: linux-kernel-owner@vger.kernel.org Tue Mar 13 18:31:31 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S7VZJ-0005QG-A7
	for glk-linux-kernel-3@plane.gmane.org; Tue, 13 Mar 2012 18:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758899Ab2CMRbL (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 13 Mar 2012 13:31:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39102 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758650Ab2CMRbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Mar 2012 13:31:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CF4D7C2A;
	Tue, 13 Mar 2012 13:31:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:message-id:references:date:mime-version
	:content-type; s=sasl; bh=08aFGA/guUWv9Xt/LF+s70EzLPs=; b=a2F3pb
	T0gBYO0iAYv4ohFhSToz5E0adDkkRmvoID3p4puPbRXuGd/RjFV2oB3cp8yiayU5
	TxPE10fJKaMUUjHn/HNiAj9wzyHp65aJl+x/1Kk2kVWFkxd1nBBqTC6gqs89iaZw
	R9wO/eLQrqRRXRtH9rRId7xSyunQdOtWAUFxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:message-id:references:date:mime-version
	:content-type; q=dns; s=sasl; b=JNDdZqexnFIUTD4BeRAjIaUGhx/QaJgU
	/X4HQNg8eNlhFoy+VkzHX7Xqr+gny8fVfurIujUBcOA5bbmVp5GnYLQi/L6UxrJ/
	Vnd8ekfNsseVzDtf6cBOTZwjM6WOP+4+yB1C0dxg5sAe4GalolCPjdXI0PrFK7sV
	DHTY6uRLTys=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92F487C29;
	Tue, 13 Mar 2012 13:31:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 18A9D7C27; Tue, 13 Mar 2012
 13:31:05 -0400 (EDT)
In-Reply-To: <87fwdcldqj.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 13 Mar 2012 16:31:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4FBD02C8-6D32-11E1-8CC3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193039>

Thomas Rast <trast@student.ethz.ch> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> 	--binary)
>> 		: ;;
>> 	-b)
>> 		gettextln >&2 "The -b option (a no-op short for --binary) was removed in 1.7.10."
>> 		die "$(gettext "Please adjust your scripts.")"
>> 		;;
>>
>> Mentioning deprecation in 1.6.0 in the message left me uneasy because
>> we never actually did anything to actively deprecate the option; it
>> just has not been needed since 1.4.3 and we stopped advertising it in
>> the manpage in 1.6.0.  So I don't like the implication of "this is all
>> right because we told you so" --- on the contrary, it is "in practice
>> nobody seems to be using this option and we hope nobody will notice
>> when we take it away".
>
> Hmm, I had an alternate patch ready in the morning, but Junio beat us to
> it and applied the old one to master.

I really don't think it is a good idea to avoid mentioning 1.6.0, at
which we *removed* description of the option in our manual pages and
from the "git am -h" help message. How much more active deprecation
would a user want?

To put it another way, think what your answer would be when somebody
sees the message and says "eh? all of a sudden it was removed?".
Wouldn't you tell him "At 1.6.0 we deprecated it and stopped
advertising it"?  Why not give that answer upfront?

Especially when you think "in practice nobody seems to be using
this" is true?
