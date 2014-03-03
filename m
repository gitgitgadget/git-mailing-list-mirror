From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] implemented strbuf_write_or_die()
Date: Mon, 03 Mar 2014 10:31:27 -0800
Message-ID: <xmqqvbvvqglc.fsf@gitster.dls.corp.google.com>
References: <1393672871-28281-1-git-send-email-faiz.off93@gmail.com>
	<CAJr59C0e22OuDWU5Xc0A=cc+zY32nfum6SXTDU3wLCPyFPF70A@mail.gmail.com>
	<CAPig+cRgc4UtmJMieS9Mdrz7vjUNiu7QFu1PSBppKo22Ln5G-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: He Sun <sunheehnus@gmail.com>, Faiz Kothari <faiz.off93@gmail.com>,
	git <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 19:31:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKXeK-0003Hg-4A
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 19:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720AbaCCSbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 13:31:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62403 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753241AbaCCSba (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 13:31:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1496C6F1FA;
	Mon,  3 Mar 2014 13:31:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v7pgRGQlmpUvPdCowSQdV20rZ4o=; b=V4kSFp
	4ESZ1WLjTZNRjEo6piLnCd2holdVnhNxVXu9EFStG2y/F+cSPnR5OS+TVTCgoELu
	YfAEYkzlUxtIJx1IoSTPUPb0JNydVHsGenUCSC7+oUcW5DWbA96qPJi7ZBEVApK9
	N1qEaCLwxTVUyL0Ii0KYjByrU+UYInqB+Gq8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EYcdeoZXWrqUcW/sMOS2bqTiarK6rGak
	FVB7nHAXj3w0ddoGqVaFIyThZe6dJ7aNAKJkpNzaj4z9XHIpivBKS+duAisdPuw2
	9cjTZP5mktNLjr4tqxP+oSBjFVvy04miQ8B5hua4QlC2p/RuQIHTCWjgIG2entkv
	AcAataXsEbo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E17D26F1F9;
	Mon,  3 Mar 2014 13:31:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C20C6F1F4;
	Mon,  3 Mar 2014 13:31:29 -0500 (EST)
In-Reply-To: <CAPig+cRgc4UtmJMieS9Mdrz7vjUNiu7QFu1PSBppKo22Ln5G-A@mail.gmail.com>
	(Eric Sunshine's message of "Sat, 1 Mar 2014 22:08:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 094D207C-A302-11E3-BE77-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243247>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sat, Mar 1, 2014 at 7:51 AM, He Sun <sunheehnus@gmail.com> wrote:
>> 2014-03-01 19:21 GMT+08:00 Faiz Kothari <faiz.off93@gmail.com>:
>>> diff --git a/remote-curl.c b/remote-curl.c
>>> index 10cb011..dee8716 100644
>>> --- a/remote-curl.c
>>> +++ b/remote-curl.c
>>> @@ -634,7 +634,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
>>>         if (start_command(&client))
>>>                 exit(1);
>>>         if (preamble)
>>> -               write_or_die(client.in, preamble->buf, preamble->len);
>>> +               strbuf_write_or_die(client.in, preamble);
>>>         if (heads)
>>>                 write_or_die(client.in, heads->buf, heads->len);
>>
>> This should be changed. May be you can use Ctrl-F to search write_or_die().
>> Or if you are using vim, use "/ and n" to find all.
>
> It's not obvious from the patch fragment, but 'heads' is not a strbuf,
> so Faiz correctly left this invocation alone.

That is a very good sign why this change is merely a code-churn and
not an improvement, isn't it?  We know (and any strbuf user should
know) that ->buf and ->len are the ways to learn the pointer and the
length the strbuf holds.  Why anybody thinks it is benefitial to
introduce another function that is _only_ for writing out strbuf and
cannot be used to write out a plain buffer is simply beyond me.
