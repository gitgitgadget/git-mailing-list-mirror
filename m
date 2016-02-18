From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/22] add the FORMATPRINTF macro to declare the gcc function
Date: Thu, 18 Feb 2016 13:59:23 -0800
Message-ID: <xmqqd1rtfzno.fsf@gitster.mtv.corp.google.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
	<xmqq37szxh52.fsf@gitster.mtv.corp.google.com>
	<20160211223323.GB641@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 18 22:59:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWWbj-00057C-69
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 22:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425010AbcBRV71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 16:59:27 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53115 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423751AbcBRV7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 16:59:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CE10246DA6;
	Thu, 18 Feb 2016 16:59:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+M8ZUV2Qn7lf1euWB3LtPTe5bYY=; b=kCWNre
	R5hBuC3Zbb9guYJ9FJ6KDVqkv00aiXx5rwOVXTslgaPhcANavETPJcKclPXp47Lp
	dK2UoO3GEXlXevjTAVT341Vfs2UgWRjklPKkeYJFA15ztmHy9MTJQO9HA9E7tbn/
	YxVKGkjIGcXpflQOgXBqjIyb4X/81ikU7tTJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IaPatWYk6RTYHFaeV2ID6kqcfv7Dwlsm
	LUnvxr53q/A9+uDDl9TTNIVoYEv4XbpqFjwt3l2IJO/CK0ErEDus7myfPHRSGwKA
	U4XEVDl0ZKHI8VkbIcw23LGPyahYVNKTLIDgm93ondw5rPtfeW5xXvuqe2BBdfHy
	QUvD7KTmOJ4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C44C846DA5;
	Thu, 18 Feb 2016 16:59:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2C96546DA4;
	Thu, 18 Feb 2016 16:59:24 -0500 (EST)
In-Reply-To: <20160211223323.GB641@sigill.intra.peff.net> (Jeff King's message
	of "Thu, 11 Feb 2016 17:33:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DF2086CC-D68A-11E5-BB36-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286622>

Jeff King <peff@peff.net> writes:

> On Thu, Feb 11, 2016 at 09:59:21AM -0800, Junio C Hamano wrote:
>
>> Elia Pinto <gitter.spiros@gmail.com> writes:
>> 
>> > Add the FORMATPRINTF macro for declaring the gcc function attribute 'format printf'
>> > for code style consistency with similar macro that git already use for other gcc
>> > attributes. And use it where necessary.
>> >
>> > Elia Pinto (22):
>> >   git-compat-util.h: add the FORMATPRINTF macro
>> 
>> Hmm.  Given that we already have
>> 
>> #ifndef __GNUC__
>> #ifndef __attribute__
>> #define __attribute__(x)
>> #endif
>> #endif
>> 
>> in git-compat-util.h, it is really between:
>> 
>>     __attribute__((format (printf, 1, 2)))
>>     void advise(const char *advice, ...);
>> 
>>     __attribute__((format (printf,2,3)))
>>     extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
>> 
>> and
>> 
>>     FORMATPRINTF(1,2)
>>     void advise(const char *advice, ...);
>> 
>>     FORMATPRINTF(2,3)
>>     extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
>> 
>> 
>> Perhaps I am biased for staring at our source code for too long, but
>> somehow the latter looks unnecessarily loud, spelled in all caps.
>> 
>> I dunno.  What does this really buy us?
>
> I had the same thought on reading this. I think the "similar macro" Elia
> mentions is probably NORETURN. But in that case, we cannot rely on
> __attribute__, because it is spelled so many different ways (e.g.,
> __declspec(noreturn)).
>
> This series would be helpful to us if there was a platform that
> understood the format attribute, but needed to spell it differently
> somehow. But short of that, I think it is a net negative.

Yes, exactly.

I've been carrying this in my tree for about a week, but I think
this does not buy us very much.  Let's drop it.
