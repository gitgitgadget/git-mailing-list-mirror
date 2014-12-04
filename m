From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] doc: document error handling functions and conventions (Re: [PATCH 03/14] copy_fd: pass error message back through a strbuf)
Date: Thu, 04 Dec 2014 15:27:17 -0800
Message-ID: <xmqqy4qnq9m2.fsf@gitster.dls.corp.google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
	<20141117233525.GC4336@google.com>
	<CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
	<20141118004841.GE4336@google.com>
	<CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
	<20141203050217.GJ6527@google.com> <20141203051344.GM6527@google.com>
	<xmqqzjb4h823.fsf@gitster.dls.corp.google.com>
	<20141204030133.GA16345@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:27:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwfnx-0004dV-2a
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:27:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933201AbaLDX1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:27:21 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59803 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754730AbaLDX1U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 18:27:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 506F8248A6;
	Thu,  4 Dec 2014 18:27:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kgn7VC/a98t2UNadiUsnTURZ3qs=; b=ct8o6H
	dRTnFr3tdZZbA+RC7nRdqQcb1dbeJAXf0Jh29ThltYKJu1/BqMDqBAAWphxtPMxA
	FjRCbuZeAAl35RB6Y8aD8ZHqPJlx9quSF7UEBWKrSXTE1vKlmnQwXpJ3VkaXIqK2
	2pwIRIgpLr9HmD4uAyHZfXzexUILIT/11I3ss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mE/dnR8xLkyzPeGwVy/WthelBQkwoffX
	e4ThLxGJ5V/hO9vU561FufSTq1tG+I8S9JCB4LtqOGdXBrar+QM/mMRoP0Y8R39X
	p5plzCHkE/uaPA0UpsvSftNdwJqW8S8Lfgh90Kk2z7ZH4bw86isS8L8kupGM+SCv
	faGq7yfngIk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 46651248A5;
	Thu,  4 Dec 2014 18:27:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 99246248A4;
	Thu,  4 Dec 2014 18:27:18 -0500 (EST)
In-Reply-To: <20141204030133.GA16345@google.com> (Jonathan Nieder's message of
	"Wed, 3 Dec 2014 19:01:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 16C7E31A-7C0D-11E4-B197-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260835>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> -extern int copy_fd(int ifd, int ofd);
>>> +extern int copy_fd(int ifd, int ofd, struct strbuf *err);
>>
>> It is not limited to this single function, but what contract do we
>> envision this "error messages are given back to the caller via
>> strbuf" convention should give between the callers and the callee?
>
> Here's a draft for documentation on that.

Thanks; looks reasonable; even if the discussion between you and
Peff took us to a slightly different direction than what you
described here, the earlier description of long established practice
is a welcome addition.




>  Documentation/technical/api-error-handling.txt | 75 ++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/technical/api-error-handling.txt
>
> diff --git a/Documentation/technical/api-error-handling.txt
> b/Documentation/technical/api-error-handling.txt
> new file mode 100644
> index 0000000..fc68db1
> --- /dev/null
> +++ b/Documentation/technical/api-error-handling.txt
> @@ -0,0 +1,75 @@
> +Error reporting in git
> +======================
> +
> +`die`, `usage`, `error`, and `warning` report errors of various
> +kinds.
> +
> +- `die` is for fatal application errors.  It prints a message to
> +  the user and exits with status 128.
> +
> +- `usage` is for errors in command line usage.  After printing its
> +  message, it exits with status 129.  (See also `usage_with_options`
> +  in the link:api-parse-options.html[parse-options API].)
> +
> +- `error` is for non-fatal library errors.  It prints a message
> +  to the user and returns -1 for convenience in signaling the error
> +  to the caller.
> +
> +- `warning` is for reporting situations that probably should not
> +  occur but which the user (and Git) can continue to work around
> +  without running into too many problems.  Like `error`, it
> +  returns -1 after reporting the situation to the caller.
> +
> +Customizable error handlers
> +---------------------------
> +
> +The default behavior of `die` and `error` is to write a message to
> +stderr and then exit or return as appropriate.  This behavior can be
> +overridden using `set_die_routine` and `set_error_routine`.  For
> +example, "git daemon" uses set_die_routine to write the reason `die`
> +was called to syslog before exiting.
> +
> +Library errors
> +--------------
> +
> +Functions return a negative integer on error.  Details beyond that
> +vary from function to function:
> +
> +- Some functions return -1 for all errors.  Others return a more
> +  specific value depending on how the caller might want to react
> +  to the error.
> +
> +- Some functions report the error to stderr with `error`,
> +  while others leave that for the caller to do.
> +
> +- errno is not meaningful on return from most functions (except
> +  for thin wrappers for system calls).
> +
> +Check the function's API documentation to be sure.
> +
> +Caller-handled errors
> +---------------------
> +
> +An increasing number of functions take a parameter 'struct strbuf *err'.
> +On error, such functions append a message about what went wrong to the
> +'err' strbuf.  The message is meant to be complete enough to be passed
> +to `die` or `error` as-is.  For example:
> +
> +	if (ref_transaction_commit(transaction, &err))
> +		die("%s", err.buf);
> +
> +The 'err' parameter will be untouched if no error occured, so multiple
> +function calls can be chained:
> +
> +	t = ref_transaction_begin(&err);
> +	if (!t ||
> +	    ref_transaction_update(t, "HEAD", ..., &err) ||
> +	    ret_transaction_commit(t, &err))
> +		die("%s", err.buf);
> +
> +The 'err' parameter must be a pointer to a valid strbuf.  To silence
> +a message, pass a strbuf that is explicitly ignored:
> +
> +	if (thing_that_can_fail_in_an_ignorable_way(..., &err))
> +		/* This failure is okay. */
> +		strbuf_reset(&err);
