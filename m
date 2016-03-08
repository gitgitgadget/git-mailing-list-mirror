From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/15] ref-filter: make "%(symref)" atom work with the ':short' modifier
Date: Tue, 08 Mar 2016 12:19:01 -0800
Message-ID: <xmqqwppck9je.fsf@gitster.mtv.corp.google.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
	<1457265902-7949-9-git-send-email-Karthik.188@gmail.com>
	<xmqqtwkhnaxg.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xqqA=aZ5Nr7YuMnLKAc2E3F4Y31oOb06aAcvunqw+gH4A@mail.gmail.com>
	<CAOLa=ZSSz7F_-fFm70=uyYsu6eGdUT+-SgbphWd8CKXnZqdCtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 21:19:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adO69-0008Jt-7g
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 21:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbcCHUTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 15:19:07 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53707 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751194AbcCHUTF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 15:19:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9AB8B4B904;
	Tue,  8 Mar 2016 15:19:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w6vadR1iI++nf0CfS+Ad8wat23M=; b=KOKrTD
	jjqv9o2Nsx6WkE+hk+uYqA1WZx4QpZMlVTb3YKOOOAK7LnTzT5cU5bcCzozXOB14
	4LAiGql/xNriNGnSMOL5k0j2REw0kkpNKFwOreBJDQ/ET0PB+lVSRI375wYSeCT4
	CkLdCH1HyUcbDZZCiRBEt1n1Pa6Ghfvw7WlEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mx/A5udpUQ0dkOFuD1u10HL6NseSfiih
	1SanCjUU0m2P9dh8oCtoU6xVOxsbTwGSdEEnG938QeeucS2nLGvBzt+ZhXAZ3bEc
	zKWq6YDu0NLSymGUqRs0X8FBw02LXkcwZsUMhv5/2BTme3V5ZSr3I7bMmBXASRtS
	tZfjkA0ukoc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 916124B902;
	Tue,  8 Mar 2016 15:19:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0B35E4B900;
	Tue,  8 Mar 2016 15:19:02 -0500 (EST)
In-Reply-To: <CAOLa=ZSSz7F_-fFm70=uyYsu6eGdUT+-SgbphWd8CKXnZqdCtg@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 8 Mar 2016 11:51:11 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 00198EE8-E56B-11E5-B2CC-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288451>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Tue, Mar 8, 2016 at 7:26 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Mon, Mar 7, 2016 at 3:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> The "%(symref)" atom doesn't work when used with the ':short' modifier
>>>> because we strictly match only 'symref' for setting the 'need_symref'
>>>> indicator. Fix this by using 'starts_with()' rather than 'strcmp()'.
>>>
>>> Does that mean you also accept %(symrefgarbage) without complaining?
>>>
>>>
>>
>> Looks like patch 9 fixes this by introducing symref_atom_parser.
>>
>
> There are two ways this kinda errors can occur:
> 1. %(symrefgarbage) : This is handled by parse_ref_filter_atom() which would
> print a "fatal: unknown field name: symrefgarbage".
> 2. %(symref:garbage): This is handled by populate_value() which would print
> a "fatal: unknown symref: format garbage".
>
> Either ways we do not need to worry about this as existing code would handle
> it. Also like Jacob mentioned Patch 09 would ensure this error checking would
> happen within symref_atom_parser().

You forgot to mention that there is 3., which is that you just
closed the door for a new valid_atom[] that begins with substring
"symref" which does not need to flip need_symref on, I think.

You can check valid_atom[i].name with strcmp() to achieve what you
are trying to do here, instead of checking used_atom[at].name, and I
think that would be a cleaner way to avoid all three problems.
