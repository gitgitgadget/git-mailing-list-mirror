From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 05/13] parse the -L options
Date: Mon, 19 Jul 2010 16:53:29 -0700
Message-ID: <7veiezni4m.fsf@alter.siamese.dyndns.org>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
 <AANLkTimNAyKZNdIIc6R5ylHuOVJho7UF0fnYC8jiaF9i@mail.gmail.com>
 <7vwrsrnwg0.fsf@alter.siamese.dyndns.org>
 <201007200048.18284.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bo Yang <struggleyb.nku@gmail.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 20 01:53:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ob09a-0000YP-Ry
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 01:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916Ab0GSXxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 19:53:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50125 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827Ab0GSXxk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 19:53:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 61F8BC42F1;
	Mon, 19 Jul 2010 19:53:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h0ZWDpBLyTskWNPkI8ANQAHtu2M=; b=BjUJbq
	bJqm/AaiaBku5HLafxInXQwC/xedX0Vi+lKSrpZLGWAAxPFKdAYh9s5lgQvVsSLz
	XjuPCSXAE59WlaDZ59/IrMh2kPK45W+cDqBWiTxk4hP0cqAQUfad72THYR4u5j64
	Ps846Zpd61HL3AUQJcIHxiNFZlRZQIiHWl67I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t3fmVB86Npx7L5BLZXeQHch+YqCpT6Mo
	wfyEKMex7xrCWoLJ2u3mEmU/0qM3APECGtHnJBhFGShIUv/IOI0FFuT5HRlZs9ii
	CUaW3VSG5GzsjD6Az4WJMtMGAEGXd1h0KpnZykw3VNhgvnJyEioQ9dqNwol7mo0Q
	rOJ3YrACGyI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DA73C42ED;
	Mon, 19 Jul 2010 19:53:35 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 349C4C42EA; Mon, 19 Jul
 2010 19:53:31 -0400 (EDT)
In-Reply-To: <201007200048.18284.trast@student.ethz.ch> (Thomas Rast's
 message of "Tue\, 20 Jul 2010 00\:48\:17 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D7E2BEB8-9390-11DF-84B4-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151292>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano wrote:
>> It almost feels as if you want to have something more like
>> 
>>     -L <begin>,<end>[,<path>]
>> 
>> where <path> is mandatory for the first use of -L (i.e. missing ,<path>
>> means the same path from the previous -L that has one) to make it clear
>> that this is completely different from the normal pathspec.
>
> I think that would just needlessly break the analogy to git-blame.[0]
> With the current code,
>
>   git blame -L 2,3 <path>
>   git log -L 2,3 <path>
>
> work the same.  Multiple -L options could be retrofitted to git-blame,
> making
>
>   git {blame,log} -L 2,3 -L 4,5 <path>
>
> work as expected.

I like the general direction, but I am not sure how far we want to take
that analogue with blame, though.

For example, Bo's "log -L" thing also works on more than one path, no?  I
suspect it might be be reasonable to teach "blame" to annotate more than
one path (with ranges) the same way.  There is no technical limitation in
the underlying scoreboard mechanism to prevent it from happening.

Very similar to "blame" but quite differently from any normal "log"
operation, "log -L" allows only one positive commit (starting point).

Perhaps these argue that this new feature shouldn't be a new option of
"log" at the UI level after all; rather, I wonder if this should be better
presented as a new mode of "blame" (e.g. "blame --log", unlike showing
"cvs annotate" like output, shows history like "git log" does).

I _think_ I've already said the above at least a few times, though.
