From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Surprising interaction of "binary" and "eol" gitattributes
Date: Wed, 11 Mar 2015 14:43:45 -0700
Message-ID: <xmqq385b5hwu.fsf@gitster.dls.corp.google.com>
References: <54F88684.3020905@alum.mit.edu>
	<xmqqwq2v14iv.fsf@gitster.dls.corp.google.com>
	<54F9422D.2020800@web.de> <54F9E907.4040703@alum.mit.edu>
	<54FA1C7B.3040906@web.de> <54FF450F.7040506@alum.mit.edu>
	<xmqq385c1v13.fsf@gitster.dls.corp.google.com>
	<54FF6D23.4060301@alum.mit.edu>
	<xmqqsidcxy2q.fsf@gitster.dls.corp.google.com>
	<5500A5F7.1000503@kdbg.org>
	<xmqq7fun5ih6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Torsten =?utf-8?Q?B=C3=B6ger?= =?utf-8?Q?shausen?= 
	<tboegi@web.de>, git discussion list <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Mar 11 22:44:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVoQ2-0007vb-QZ
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 22:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbbCKVnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 17:43:50 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59571 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751525AbbCKVnr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 17:43:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C0AB3E2B0;
	Wed, 11 Mar 2015 17:43:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AlzWIzMFnVdG53Vt0LKV0tSVUEc=; b=Bd8cEE
	cAyu5lHGRPULmpglIiFRFPI8wPIZAz7tpsM+6DIcVunY28YPyd5Mj3Cx+f3shGCU
	6xEPlSnet/QDpGajb1YU3HG+nJh8KdxVgkwHrhU84mT3oT4UKRMcaZf+uwPIkjKf
	zoov67hS6WwWIharnBArFtxu9mxxVmYtDQ1nA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KsP6kqLUYdTSQAGwOBdWL44AdjzFrM5t
	wB8uZfvwkLfcH1JxEZDqIPu1tEsk2c3/rmjnLnEi0h79Yd1wDevF0dBXubjv2tPR
	iHTvB1A3A0BnN+7vlD2mPaq/3YjxlewS1W/3C4byR5PlISAPWbRuZ4YXQTO78mwj
	cFhm1n+PyBA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09A5C3E2AC;
	Wed, 11 Mar 2015 17:43:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8107C3E2A7;
	Wed, 11 Mar 2015 17:43:46 -0400 (EDT)
In-Reply-To: <xmqq7fun5ih6.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 11 Mar 2015 14:31:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B2246308-C837-11E4-898B-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265341>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Isn't it more like: Here we are interested in the "eol" attribute of
>> this file named "a.foo". And the lookup would find the first line that
>> says "eol=crlf". Elsewhere, we are interested in the "binary"
>> attribute of the file named "a.foo", and lookup would find the second
>> line that sets the "binary" attribute. And again elsewhere, we ask for
>> the "text" attribute, and we find the last line that sets the "text"
>> property.
>>
>> Am I totally off track?
>
> In the codepath in question, we say "we are interested in text and
> eol attributes", grab the values (set/unset/set-to-value/unspecified)
> for these two for the path we are interested in from all the
> applicable gitattributes file and then act on the result.

Technically the above is only a half-answer; I know you are
intelligent enough to derive the other untold half from it, but for
the benefit of those reading from sidelines....

The calling convention to (1) prepare the list of attributes you are
interested in upfront and then (2) to ask the set of attributes that
apply among that set for a path is designed to force programmers
avoid doing attribute lookups (which is rather expensive) at random
places in their code.  But in the end, this let us implement the
functionality as you alluded to in the quote paragraph.

If a proposed change wants to make 'text=auto' stronger in the sense
that we decide if we pay attention to 'eol' only after checking if
the contents look non-text, it can do so, just like setting '-text'
to the current code makes settings of 'eol' irrelevant.
