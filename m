From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] make __git_ps1 accept a third parameter in pcmode
Date: Wed, 26 Dec 2012 12:32:20 -0800
Message-ID: <7vfw2so8q3.fsf@alter.siamese.dyndns.org>
References: <7vvcbpp846.fsf@alter.siamese.dyndns.org>
 <20121226191505.GA29210@simaj.xs4all.nl>
 <7vmwx0oavn.fsf@alter.siamese.dyndns.org> <20121226201944.GA15039@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: piotr.krukowiecki@gmail.com, git@vger.kernel.org
To: Simon Oosthoek <s.oosthoek@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Dec 26 21:32:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tnxef-0003wR-8E
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 21:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878Ab2LZUcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 15:32:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45275 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841Ab2LZUcX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 15:32:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07B66AA2C;
	Wed, 26 Dec 2012 15:32:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EZvv13LSTYslX28pbuXNY6MVOrs=; b=QAtWBc
	pxlJU+ebfaNj162vWSYop+s3iGLio9Tk9udDX4/4eRm/id0+Cf967aRnsu9GbOUg
	2zjCUDxS1d6mseCQwO9ngx7tRndKsvnr/ieEAu9xaFWxI0EuHtke8DV6SSR1BgRm
	Dhm4BtYPSSO7RBab0bnS9zR8ATQ3RLIdse3MA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iJozAlOJiGgFEUAQvHvFGuZeKx+Uqaab
	1KhnluODtAgJxqIKVTAt2UGMDzYY0mSOhsNhrByX8mMvGKPJI2TQslXii1xkUN5m
	OfIiwpdBXM5uBSaawflj6WDdlW7Zg5MtWONz+9tMSt2NpzWZJNlhmR6ZW6iUL0Fl
	rpK52wRgpAQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8B35AA2B;
	Wed, 26 Dec 2012 15:32:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CC0EAA2A; Wed, 26 Dec 2012
 15:32:22 -0500 (EST)
In-Reply-To: <20121226201944.GA15039@xs4all.nl> (Simon Oosthoek's message of
 "Wed, 26 Dec 2012 21:19:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A033F94-4F9B-11E2-BC5B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212150>

Simon Oosthoek <s.oosthoek@xs4all.nl> writes:

> The problem with doing it in pre-post is when inside non-git
> directories. You want to avoid any gitstring output, including the
> brackets, when not inside a repository.

Ah, Ok, that is probably what I missed.

>> Or we could go the other way and drop "pre/post" strings, making
>> them part of the printf_format string.  Perhaps that might be a
>> better interface in the longer term.  Then people can use the same
>> "<pre>%s<post>" format string and do either of these:
>> 
>> 	PS1=$(__git_ps1 "<pre>%s<post>")
>> 	PROMPT_COMMAND='PS1=$(__git_ps1 "<pre>%s<post>")'
>> 
>> without __git_ps1 having a special "prompt command" mode, no?
>
> But how to determine which mode to use?
> In pcmode, you must set the PS1, in command-subsitute mode, you must print a formatted gitstring.

The point of the above two was that __git_ps1 does not have to set
PS1 as long as the insn says user to use PROMPT_COMMAND that sets
PS1 himself, exactly as illustrated above.  In other words, replace
the last PS1=...  in the "prompt command" mode with an echo or
something and make the user responsible for assigning it to PS1 in
his PROMPT_COMMAND.

Or put it in another way, I was hoping that we can do without adding
the prompt command mode---if there is no two modes, there is no need
to switch between them.

But as I said, there probably is a reason why that approach does not
work, that is why I said...

>> I have a feeling that I am missing something major, though...
