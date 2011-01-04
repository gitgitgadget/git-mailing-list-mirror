From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Documentation/technical: document quoting API
Date: Tue, 04 Jan 2011 11:21:07 -0800
Message-ID: <7v8vz0fpb0.fsf@alter.siamese.dyndns.org>
References: <20110103063534.GA3661@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 20:21:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaCRk-000554-2q
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 20:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017Ab1ADTVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 14:21:22 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab1ADTVV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 14:21:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6F64D3020;
	Tue,  4 Jan 2011 14:21:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=onpkyAsJT57Kz9iNA269uLDnf/g=; b=eSf/vBZ2vIlARTtEwV9lGs4
	F+okTS7ifvgpBlN+GzXokneYan7bgEKeG65La32YtxWmysuhqLoCyP6qELdgToQV
	GT2BdUkS8ylVqAFm/85LoH4QTNbaK98DvbZ7bkMbepmBPkNnTJaJlXGULOYgcE2O
	/+g6nfbIo57Z1Wvo5JUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=QAAjVib9VU+S1JuelWAmFs7oYpyHC28GibJ/JdE5RYhTNKxEC
	7vKZoqbzyCVI36ZyxMNvwMAvBvskMfUZN3l9dTuRg06UAiYy3SoQ1/KClPd56M0C
	74nmHbdQG+6BJ9374rtSwkQ9QNqnFk+pLcrHuOffzWN5/PvFrNtl8kvKkI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D3F9B301F;
	Tue,  4 Jan 2011 14:21:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 16CD4301E; Tue,  4 Jan 2011
 14:21:44 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E231C2CA-1837-11E0-94E9-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164512>

Jonathan Nieder <jrnieder@gmail.com> writes:

> +C-style quoting
> +---------------
> +
> +`quote_c_style` quotes a string in a manner that might be familiar
> +to C programmers.  This can be used to quote newlines and tabs in
> +filenames for patches, for example.
> +
> +. if sb and fp are both NULL, it returns the number of bytes needed
> +  to hold the quoted version of "name", counting the double quotes
> +  around it but not terminating NUL.  If "name" does not need quoting,
> +  it returns 0.
> +
> +. otherwise, it emits the quoted version of "name" to a stream,
> +  strbuf, or both.  Output will have enclosing double quotes
> +  suppressed if requested with the "no_dq" parameter.

Heh, I didn't know about the "both" case.  That is probably unintended
misfeature that would not hurt but would not be useful in practice either
;-)

> +`quote_two_c_style`::
> +	Quote two paths (prefix + path) in C-style and concatenate them.
> +	One should use this instead of calling `quote_c_style` twice
> +	to avoid unsightly quotation marks in the middle.

Just for the record, "Avoid dqdq in the middle" was never the motivation;
you can run two no_dq invocations and put dq around the result yourself.
The main motivation for using this, before the strbuf was widely used, was
to avoid having to allocate memory only to call quote_c_style, because it
happens so often that we have prefix and path as separate strings.

> +`unquote_c_style`::
> +	This unwraps what quote_c_style() produces in place,
> +	but returns -1 and doesn't touch if the input does not start with
> +	a double-quote or otherwise differs from what quote_c_style
> +	would have produced.  Though note that this function will
> +	allocate memory in the strbuf, so calling `strbuf_release`
> +	is mandatory regardless of the result `unquote_c_style` returns.

s/Though note/Note/ perhaps?

> +Quoting for the shell
> +---------------------
> +
> +`sq_quote` copies its argument quoted for the shell safety.
> +Any single quote is replaced with '\'', any exclamation point
> +is replaced with '\!', and the whole thing is enclosed in a
> +single-quote pair.
> +
> +For example, if you are passing the result to `system()` as an
> +argument:

"... if you are preparing a command line to give to `system(3)`"?

I first misread the above and thought you were doing some operation on the
result coming back from "system()", which of course is nonsensical and not
what you meant.

Thanks.
