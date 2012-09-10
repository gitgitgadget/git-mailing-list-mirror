From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: Teach "--edit" action
Date: Mon, 10 Sep 2012 12:57:57 -0700
Message-ID: <7vd31todkq.fsf@alter.siamese.dyndns.org>
References: <1347293683-27996-1-git-send-email-andrew.kw.w@gmail.com>
 <1347293683-27996-2-git-send-email-andrew.kw.w@gmail.com>
 <vpqk3w1j15v.fsf@bauges.imag.fr>
 <CADgNja=z7EDTV8_2CU9Uc7w=Dmtp90GrPkDUFSPbucfyrEsBaQ@mail.gmail.com>
 <20120910165457.GB14201@sigill.intra.peff.net> <504E333B.2010602@kdbg.org>
 <20120910184625.GA32237@sigill.intra.peff.net>
 <CADgNjamB9wG_Vbt1Zwu8Tmt3vQ8XpYys6ngjQeQb2DgnqKeHJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 21:58:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBA7Z-00031R-VU
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 21:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758606Ab2IJT6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 15:58:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52230 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758572Ab2IJT6A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 15:58:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E4E380E8;
	Mon, 10 Sep 2012 15:57:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XYYM/Og9bF8YG1gkTfNjRAFxJOs=; b=d3uPUz
	G8ZnybdwMAJkkUAcdu736DFYhJunxw3MUVGJkj5HU0u/iTTn/nOBmY5v5Mu2hOUP
	9PrtxaUxFqsJybCl/HqJDFgpf9o/ru5AZUbeD/i5enI3bt7EyU4AsZq7pjAGss/x
	YpS7qd4gUdejvnT/Wb7kd1DQSFKLmvkxcv4mw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ueRRMTagcHE7VtXtTl6eEhsVbEep5GSf
	n/l6OuR4kjJEN7Get57ezvFCZYGCluzLLjyO+4Sts0F3FfrkiBILk9qQWj7IJndJ
	94pivh5xlCppNQN8fj9+T8mFJy/ERX8WT3HDVDXcXe6MnKDqgit9zVdkQiyKZlBR
	oWRzZNqG5bU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BC1C80E7;
	Mon, 10 Sep 2012 15:57:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1C4980E5; Mon, 10 Sep 2012
 15:57:58 -0400 (EDT)
In-Reply-To: <CADgNjamB9wG_Vbt1Zwu8Tmt3vQ8XpYys6ngjQeQb2DgnqKeHJg@mail.gmail.com> (Andrew
 Wong's message of "Mon, 10 Sep 2012 15:33:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D1EFCCB6-FB81-11E1-B688-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205167>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> On Mon, Sep 10, 2012 at 2:46 PM, Jeff King <peff@peff.net> wrote:
>> On Mon, Sep 10, 2012 at 08:36:43PM +0200, Johannes Sixt wrote:
>>
>>> > [1] It does preclude using "--edit" to make a note about a later commit
>>> >     while you are in the middle of resolving a conflict or something.
>>> >     You'd have to do it at the end. I don't know if anybody actually
>>> >     cares about that.
>>>
>>> Yes, I do care. At times I tend to have a very short attention span. Or
>>> it is Windows's slowness that expires my short-term memory more often
>>> than not. ;)
>>
>> OK, then I withdraw my proposal. :)
>>
>> It sounds like it would be safe to do:
>>
>>   git rebase --edit-todo
>>   hack hack hack
>>   git rebase --continue
>
> Johannes took the words right out of my mouth.  Also, "edit and _not_
> continue" also gives the user a chance to second guess while editing
> the todo.

do you mean "double check"?

> That got me thinking... Currently, the todo list has this line at the bottome:
>     # However, if you remove everything, the rebase will be aborted.
>
> We'd probably want to remove that line, since "remove everything" no
> longer aborts the rebase. It'll just finish the rebase.

Good precaution.

> It might also be nice to add a note to remind the user that they're
> editing a todo file in a stopped rebase state. i.e. not a fresh
> interactive rebase

Hrm...  They see the contents of the todo file immediately after
they say "rebase --edit-todo" and the sole reason they said that
command is because they wanted to edit the todo file.  Is it likely
they need a reminder?
