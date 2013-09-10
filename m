From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/2] Add new @ shortcut for HEAD
Date: Tue, 10 Sep 2013 15:08:12 -0700
Message-ID: <xmqq7geowcs3.fsf@gitster.dls.corp.google.com>
References: <1378103670-3394-1-git-send-email-felipe.contreras@gmail.com>
	<1378103670-3394-3-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2opsprq.fsf@gitster.dls.corp.google.com>
	<CAMP44s1-+i30CuTH5uRpu4Qi_hWhHmygc2-quYkTrrBV+4hZXQ@mail.gmail.com>
	<xmqq38pd38t4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 00:08:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJW6f-0008Um-NA
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 00:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000Ab3IJWIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 18:08:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65328 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751313Ab3IJWIP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 18:08:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D036E416AF;
	Tue, 10 Sep 2013 22:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZOjenmrjaAkiEvD0YASy1PkZI/A=; b=tOzoT3
	pto5xF6o3N1v9IIFuUjEWKs3dKrBR/1MbKLmOfLuugfh9eriqrcptiKlyUthpSS1
	EFQNTSVkb327fht35PWgKb2BFFCzEtXvWYQWc+Q+6l4J1in37+RhTlG7v6XmxQLQ
	iLcI+4ZE4y6aFJMkWiRHtBWl0FPwspPT/X09s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eeG4ywaZEImVfPziVB36e/FLUWfNYddV
	/pMd6R0r242lEt2vWEZHzAoBJfD5Gj4FNbYh9vI7HIvqeZBg8mwxMAbqoF4thE0C
	BSNMNAfSqZXOUojnTYEXYE1f839TO2zeJr4TA75TBFo+zn8F7KYBUdKKmvxu3b3y
	2vulEkMHP4o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6C51416AE;
	Tue, 10 Sep 2013 22:08:14 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F8AD416AB;
	Tue, 10 Sep 2013 22:08:14 +0000 (UTC)
In-Reply-To: <xmqq38pd38t4.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 09 Sep 2013 15:54:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7D043724-1A65-11E3-8F29-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234490>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> Hmph, is the above sufficient?  I added a case that mimics Stefano's
>>> original regression report (which is handled) and another that uses
>>> doubled "@" for the same purpose of introducing a "funny" hierarchy,
>>> and it appears that "checkout -b" chokes on it.
>>
>> This fixes it:
>>
>> --- a/sha1_name.c
>> +++ b/sha1_name.c
>> @@ -1014,6 +1014,8 @@ static int interpret_empty_at(const char *name,
>> int namelen, int len, struct str
>>
>>         /* make sure it's a single @, or @@{.*}, not @foo */
>>         next = strchr(name + len + 1, '@');
>> +       if (next && next[1] != '{')
>> +               return -1;
>>         if (!next)
>>                 next = name + namelen;
>>         if (next != name + 1)
>
> I think this should be sufficient for all cases, as the sequence
> "@{" cannot be a part of valid reference names.
>
> Thanks.
>
> I see v6 was posted yesterday after this message, but it does not
> seem to have this fix, nor the additional test case I gave you in
> the message upthread.  Sent a wrong version of patch by mistake?

Ping?

I could squash the fixup at the tip of on fc/at-head in if you want
me to, but v6 seems to be a mistake to me.
