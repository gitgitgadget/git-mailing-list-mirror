From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2013, #07; Thu, 20)
Date: Fri, 21 Jun 2013 13:31:42 -0700
Message-ID: <7vvc57kxxt.fsf@alter.siamese.dyndns.org>
References: <7v1u7woydw.fsf@alter.siamese.dyndns.org>
	<CALkWK0=1e5ospzJBqaz9iLwSiOoTy_+vTxwVMvW-H7kynfkbBg@mail.gmail.com>
	<7vk3lno40x.fsf@alter.siamese.dyndns.org>
	<CALkWK0kDDRicX9VmcRgG9daXVi6W-zGNt=x6ruy7X5MhrHOZbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 22:31:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq7zu-00014w-3x
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 22:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946039Ab3FUUbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 16:31:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55668 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945951Ab3FUUbp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 16:31:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 152D32A045;
	Fri, 21 Jun 2013 20:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rUG7yF1gzCUt963CJDZJMXX9wO8=; b=u0s15c
	gPdBupuzKbcaIGl8FlK5yIedYHKMDvkFv0iLS6CyksEk/HifXIcEmCi2b24PJ9G0
	SqaHXb971I916ikMe3rBZ1RirgWJXbjoVHrSP5unkg59lrUhjgdpb8xv8Ls2QH+L
	c36gQzFyJvsMOWIz25ljpJM1/tkyRwv4HSMUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VQs118IWA9BcsJHFyFDekeDn1S5mFWsJ
	0t7mrZ2U+wa4jkrKv0+PONLp+knAiefC+rxPhNkHHRXYbvWzhULk/zQQpwxwzgee
	u0XSDvT7LusiYzuCRaNrc7zSyzG65rK96IYY4PlhPYVmmb7+jxFNTDGh8j2olNUL
	CS8YGeCS55k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C1A82A044;
	Fri, 21 Jun 2013 20:31:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67CC32A040;
	Fri, 21 Jun 2013 20:31:44 +0000 (UTC)
In-Reply-To: <CALkWK0kDDRicX9VmcRgG9daXVi6W-zGNt=x6ruy7X5MhrHOZbQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 21 Jun 2013 21:37:47 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 968B8C04-DAB1-11E2-A2A2-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228656>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>>> - rr/describe-contains-all at  $gmane/228278.
>>
>> This may overlap with a topic in flight (but I didn't look at it).
>
> Let me know if I can do anything to make it easier for you.  I'm quite
> excited about this one.
>
>>> - rr/mixed-case-aliases at $gmane/227959.
>>
>> Personally, not just uninterested but moderately against.
>
> Okay, but I'd like an explanation.

Because the implementation is too ugly.

The damage to the more generic config parser codepath is a real
downside and the benefit from the little "feature" does not seem to
justify it.

I would however can imagine an alternative implementation which
might be more palatable. It may go like this:

	[alias "lgF"]
		command = "log --oneline --boundary --first-parent"
                help = "show the first parent chain, one line per commit"
		completion = log

so that not just alias.c code can take notice of alias.lgF.command
to expand it, but we can later extend it to help "git help lgF" and
bash/zsh completion (i.e. they would learn "lgF parameter would
complete in a way similar to 'log'" from alias.lgF.completion).
