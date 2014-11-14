From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] allow TTY tests to run under recent Mac OS
Date: Fri, 14 Nov 2014 12:16:27 -0800
Message-ID: <xmqqfvdl35d0.fsf@gitster.dls.corp.google.com>
References: <1415918419-20807-1-git-send-email-blume.mike@gmail.com>
	<546656C8.3070009@kdbg.org>
	<CAO2U3QgmuwatfDDO8f461cwq2SctPx+owL8gDMBpNyDcaxaWGQ@mail.gmail.com>
	<20141114200239.GA11581@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Blume <blume.mike@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 14 21:16:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpNIJ-00012v-3Z
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 21:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161891AbaKNUQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 15:16:31 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64247 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161833AbaKNUQa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 15:16:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DA3A1E241;
	Fri, 14 Nov 2014 15:16:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fYAd50ZZRcpXxh4ZOF8mwVvcqhg=; b=l3IBsU
	nOoFPBAfm91sny9YeU16HR71G1IR+kC7cMcwBpl979lpcDW8Lirx3yjwKcZRo6n7
	U0mD9Yj08me4y9Ht/ANp3/QI7bDsMy83KjaKxRceyo3W+WXRymOAKvxaaOjc7LvM
	dlynOLnJVmmyE3vQxD4f3D0o67LcxRTDg6ccc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JvslV+jL/KbCGtyju0ppT+Xka+4A9xK3
	g0pCDwWivZ8hBdPXxaw3XxdQESP9Lb6ISBAN2guxMsrFT0B36karbk+VfN+WTruA
	lYkeIFcvH0tjaAEBJMzC0loS1pigxZzbFYZ9hiwArivXE9SWkXMzgLK4uezwBTk9
	U+t7G7m1vPQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4354C1E240;
	Fri, 14 Nov 2014 15:16:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BA5F01E23F;
	Fri, 14 Nov 2014 15:16:28 -0500 (EST)
In-Reply-To: <20141114200239.GA11581@peff.net> (Jeff King's message of "Fri,
	14 Nov 2014 15:02:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1DDB9520-6C3B-11E4-8E15-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Nov 14, 2014 at 11:48:36AM -0800, Michael Blume wrote:
>
>> My understanding is that && and || have equal precedence, and this
>> seems to be borne out in testing at my shell. If the if/then method is
>> clearer I'm happy to go with that.
>
> I think the problem is that there are earlier parts of the chain. It
> currently looks like:
>
>   foo &&
>   bar &&
>   do_something
>
> but you are making it:
>
>   foo &&
>   bar || baz &&
>   do_something
>
> which will do_something whether or not "foo" is true. You need to put
> your "||" at a lower precedence than the rest of the chain. The "if"
> that Johannes mentioned works, though I think
>
>   test_have_prereq PERL &&
>   {
>     test "$(uname -s)" != Darwin ||
>     test "$(uname -r | cut -d. -f1)" -ge 13
>   } &&
>   ...
>
> is more obvious to read (but that's subjective, of course).

Thanks.

While I was reading this earlier I wondered the same thing and
concluded it was OK based on the equal precedence, but like Michael
I missed that there is yet another test before it.
