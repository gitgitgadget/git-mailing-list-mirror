From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] make __git_ps1 accept a third parameter in pcmode
Date: Wed, 26 Dec 2012 11:45:48 -0800
Message-ID: <7vmwx0oavn.fsf@alter.siamese.dyndns.org>
References: <7vvcbpp846.fsf@alter.siamese.dyndns.org>
 <20121226191505.GA29210@simaj.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: piotr.krukowiecki@gmail.com, git@vger.kernel.org
To: Simon Oosthoek <s.oosthoek@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Dec 26 20:46:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tnwvi-0007IA-Jk
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 20:46:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601Ab2LZTpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 14:45:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55212 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752545Ab2LZTpv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 14:45:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE89B9DCF;
	Wed, 26 Dec 2012 14:45:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h2Tpoy3YnzyDrkuj9pKqTFUdlSw=; b=Zql2pu
	VIiLV9WkPAZ1OusZpiKWdU3mE8HmJT0R2b9bzPOajUC8J+0mSgt+dGKDFUKMRAzG
	YnvnGogBkIVdcFavZWjivUEupCjBV/toDp0h+ZYlA3I5tRD3zL/IFqP/PVZarVg3
	5QK2R2Mj+rycbZNVza1TgcOOwpOoG9EBhAkuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RkHBnEBug0HChrrJbiq059w65uuiQO2b
	k1X4SlU6ktxioWrJh5Ij2wFLkTDxI4zY4hEJlRnS1mMpXtnk84U9G8IuRDx69TJS
	gYyrXVwJ/s7EPBikW3tfQlLGlnlWhom7lR9e1xjS2a7B8DxuifIxcZQ4+P0i0bX2
	mNmdAD/5+c0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC9609DCE;
	Wed, 26 Dec 2012 14:45:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44B4C9DCD; Wed, 26 Dec 2012
 14:45:50 -0500 (EST)
In-Reply-To: <20121226191505.GA29210@simaj.xs4all.nl> (Simon Oosthoek's
 message of "Wed, 26 Dec 2012 20:15:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D9D4C6E0-4F94-11E2-BD77-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212146>

Simon Oosthoek <s.oosthoek@xs4all.nl> writes:

> The optional third parameter when __git_ps1 is used in
> PROMPT_COMMAND mode as format string for printf to further
> customize the way the git status string is embedded in the
> user's PS1 prompt.
>
> Signed-off-by: Simon Oosthoek <s.oosthoek@xs4all.nl>
> ---

Thanks.

If we do not care about the existing users (and in this case,
because PROMPT_COMMAND mode is in no released version, we could
declare there is no existing user), another and simpler approach is
to just drop " (" and ")" altogether and have the user give these as
part of the pre/post strings.

Or we could go the other way and drop "pre/post" strings, making
them part of the printf_format string.  Perhaps that might be a
better interface in the longer term.  Then people can use the same
"<pre>%s<post>" format string and do either of these:

	PS1=$(__git_ps1 "<pre>%s<post>")
	PROMPT_COMMAND='PS1=$(__git_ps1 "<pre>%s<post>")'

without __git_ps1 having a special "prompt command" mode, no?

I have a feeling that I am missing something major, though...

>  				if [ "$w" = "*" ]; then
> -					PS1="$PS1\[$bad_color\]$w"
> +					gitstring="$gitstring\[$bad_color\]$w"
>  				fi

Every time I looked at this line, I wondered why '*' state is
"bad".  Does a user go into any "bad" state by having a dirty
working tree?  Same for untracked ($u) and detached.  These are all
perfectly normal part of a workflow, so while choice of red may be
fine to attract attention, calling it "bad" sounds misguided.
