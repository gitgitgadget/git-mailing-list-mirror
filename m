From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use child_process_init() to initialize struct child_process variables
Date: Tue, 04 Nov 2014 13:56:15 -0800
Message-ID: <xmqq4muepr40.fsf@gitster.dls.corp.google.com>
References: <54500212.7040603@web.de> <20141029172109.GA32234@peff.net>
	<xmqqlhnyy9e2.fsf@gitster.dls.corp.google.com>
	<20141030213523.GA21017@peff.net>
	<FEC7DC4C920D4F97B5F165B10BC564D2@PhilipOakley>
	<xmqqvbmzsyfy.fsf@gitster.dls.corp.google.com>
	<20141101033327.GA8307@peff.net>
	<F44397C122BB4E63B89EC9BE26007B2E@PhilipOakley>
	<xmqqmw88rvh3.fsf@gitster.dls.corp.google.com>
	<20141103220408.GA12462@peff.net>
	<xmqq389zrguw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 04 22:56:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xlm5P-00088i-QE
	for gcvg-git-2@plane.gmane.org; Tue, 04 Nov 2014 22:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbaKDV4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2014 16:56:20 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752188AbaKDV4T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2014 16:56:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CE87D1AD5C;
	Tue,  4 Nov 2014 16:56:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4i2zZFFx19YeLWPro+qeUEEgK/Y=; b=hptoMN
	j5JxbU4uX1V3wL+oGTNp9OLzAD3Byb26bBnnN3qrcel1lbtQWt93Wps+D0cBVUL+
	4vpo9odbN/bhtio+2wRPRaIYfwCOXvYgHh06D6ZAxZkhRpUYwI3Lud0/gkRK1eSU
	ESCrWuCB4FQkUuO2Ar9fsFNFjScZXjxQSUXMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hK2Y+juriJsV/nfc/lv721nW6yMEM1w9
	U04C93lvLm7PHjVgZ2FHReDGTaQfhKjXIbhAd4cTzJF1FuypFqmTZe1kh0GHGCUv
	jHwTP0S6BIqYxggL4xiYcLMYJTOVFZzF7QxtxLVFOh+H7inH0Z6PwD/PFsUUZ3zE
	LUPqCOr4Hr4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C3FB91AD5B;
	Tue,  4 Nov 2014 16:56:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2C0651AD5A;
	Tue,  4 Nov 2014 16:56:17 -0500 (EST)
In-Reply-To: <xmqq389zrguw.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 03 Nov 2014 15:42:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6719CA48-646D-11E4-B54B-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I peeked at libgit2 and I think it does not support bundles at all yet,
>> so that is safe. Grepping for "bundle" in dulwich turns up no hits,
>> either.
>>
>> Looks like JGit does support them. I did a very brief test, and it seems
>> to silently ignore a HEAD ref that has the NUL (I guess maybe it just
>> rejects it as a malformed refname).
>>
>> We could make JGit happier either by:
>>
>>   1. Only including the symref magic in ambiguous cases, so that regular
>>      ones Just Work as usual.
>>
>>   2. Including two lines, like:
>>
>>         $sha1 HEAD\0symref=refs/heads/master
>> 	$sha1 HEAD
>>
>>      which JGit does the right thing with (and git.git seems to, as
>>      well).
>
> Sounds sensible, even though it looks ugly X-<.

I have a mild preference for a syntax that is more similar to the
on-wire protocol, so that connect.c::parse_feature_value() can be
reused to parse it and possibly annotate_refs_with_symref_info() can
also be reused by calling it from transport.c::get_refs_from_bundle().
