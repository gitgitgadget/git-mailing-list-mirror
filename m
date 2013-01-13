From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] git-completion.bash: add support for path completion
Date: Sun, 13 Jan 2013 14:46:42 -0800
Message-ID: <7vzk0chfal.fsf@alter.siamese.dyndns.org>
References: <1357930123-26310-1-git-send-email-manlio.perillo@gmail.com>
 <50F15CB9.5090603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, szeder@ira.uka.de, felipe.contreras@gmail.com,
	peff@peff.net
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 23:47:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuWKY-0000yZ-0O
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 23:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756100Ab3AMWqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 17:46:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37973 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755609Ab3AMWqp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 17:46:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAA54BF83;
	Sun, 13 Jan 2013 17:46:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TTmXsfLJPNxrWjtux2B+DRqMPj4=; b=KoY0Bu
	MiYa0pFHwshGZsr0C1xI7ubpbmaYJ/TvQxQzPQA+0euJEV/tz2zHjb8IYMiJZSmO
	mEflo4ALinoF2g8HILulfqfQ7erkcZy6uWdh6bpunfAHM3HO96JGfWZITPvusJTM
	4MfGB135QDCQRnGzA3WjqOgUv7cM1jQ2UHDw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bUIUII7p5+cFUzMFQ9clExVRg/TJ79vB
	Nnhn183RaAyOkqsGjvtlwYrIMEktegq7UCvcruh7R1c1RtqOxZpy95XtywHMXWp6
	8jt8vrgv64UQay0ckBv01LFZPgVYKoDQ50BcO1pjT5vaXsRivTyY5UchBu95B0PV
	Kpg0oJg7DMk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C05BABF82;
	Sun, 13 Jan 2013 17:46:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27DF0BF80; Sun, 13 Jan 2013
 17:46:44 -0500 (EST)
In-Reply-To: <50F15CB9.5090603@gmail.com> (Manlio Perillo's message of "Sat,
 12 Jan 2013 13:53:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1AAF4AAE-5DD3-11E2-B965-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213404>

Manlio Perillo <manlio.perillo@gmail.com> writes:

>> +	# Skip "git" (first argument)
>> +	for ((i=1; i < ${#words[@]}; i++)); do
>> +		word="${words[i]}"
>> +
>> +		case "$word" in
>> +			--)
>
> Sorry, I have incorrectly (again) indented the case labels.
> I have now configured my editor to correctly indent this.

Yeah, thanks for spotting.

I wouldn't worry *too* much about the style in this script at this
point, though.  It uses a style on its own that is totally different
from the rest of the system (e.g. "[" instead of "test", semicolon
in "if ...; then", etc.) and it probably is better to emulate the
surrounding code, and leave the style "fixes" to a separate topic,
if we want to (as a contrib/ material that is not POSIX but bash
specific, I do not know if that is even worth it).

>> +				# Good; we can assume that the following are only non
>> +				# option arguments.
>> +				((c = 0))
>> +				;;
>
> Here I was thinking to do something like this (not tested):
>
> 		-*)
> 			if [ -n ${2-} ]; then
> 				# Assume specified git command only
>                                 # accepts simple options
> 				# (without arguments)
> 				((c = 0))
>
> Since git mv only accepts simple options, this will make the use of '--'
> not required.

Unless you have a file whose name begins with a dash, perhaps?
