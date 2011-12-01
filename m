From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/2] pull: pass the --no-ff-only flag through to
 merge, not fetch
Date: Thu, 01 Dec 2011 10:06:54 -0800
Message-ID: <7vvcq0np35.fsf@alter.siamese.dyndns.org>
References: <1322703537-3914-1-git-send-email-naesten@gmail.com>
 <7vborsq45x.fsf@alter.siamese.dyndns.org>
 <CAJYzjmep7sKxiSNhMzAX2DRYJhANDQkPL5pX4HOZ9CssJxcWbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Samuel Bronson <naesten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 19:07:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWB2F-0002Y2-6q
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 19:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756013Ab1LASG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 13:06:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56862 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755432Ab1LASG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 13:06:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A41954B8;
	Thu,  1 Dec 2011 13:06:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tH0w17V+a6fes1w9odC4KnpaeZg=; b=N3ylCS
	GDsdxJ8qOHOyZl1iLt34cuCJSE0n+zYB5JeGvDwMNEGiOEch65JyLh4dq8PiZTAL
	Ds73nTTbQs+RtXe+ducyLXxRsQ0OqXMLBXiy7r578eebIsNk1+E2w2W7kRGdf4wU
	3Yl09hRjdwi1zASaMhzY1OA0vZDB8PRq66lk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qxhQFkUAePtDB6g7JzRUdquZaJOXfIvA
	NYT1svvFFqW6F8z+GqU/PWgXsBw7FdIBkT7BA/hlCCPStpxGzJFm0oJmxttWirUr
	eot9bcHGrZm4ml7nMD56YAuPi9T05HO5trQVpib3fXDhvJtNTyR1BNoEjuUDfzDR
	B1MJpxoX80w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BAA954B6;
	Thu,  1 Dec 2011 13:06:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B60554B2; Thu,  1 Dec 2011
 13:06:55 -0500 (EST)
In-Reply-To: <CAJYzjmep7sKxiSNhMzAX2DRYJhANDQkPL5pX4HOZ9CssJxcWbw@mail.gmail.com> (Samuel
 Bronson's message of "Thu, 1 Dec 2011 12:18:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40FE0E3A-1C47-11E1-9124-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186178>

Samuel Bronson <naesten@gmail.com> writes:

> Hmm, yes, I had noticed that it was a tristate (merge.ff clearly is),
> and I guess --no-ff-only is a pretty ugly flag. I do have to ask,
> though: why give --ff these new values? Wouldn't it make more sense to
> reuse the values accepted by merge.ff; namely, 'true' (the implied
> default), 'false', and 'only'?

The 'true' and 'false' values to merge.ff are carry-over from the days
when it was a boolean, _not_ a tristate. If we were to make the UI more
rational by making it clear that this is not a boolean, it is a good time
for us to aim a bit higher than merely repeating the mistakes we made in
the past due to historical accident. In other words, we could add a
synonym for the "default" mode in addition to "--ff=true" (and for the
"always merge" mode in addition to "--ff=false") that makes it clear that
the value is _not_ a boolean [*1*]. If we were to go the "--ff=<value>"
route, we have to add support for other ways to spell boolean 'true'
(e.g. 'yes', '1', and 'on') anyway, so it is not that much extra work to
do so, I would think.

> Otherwise, this looks like a very nice way to implement what I want: I
> guess it is probably a mistake that the existing (documented) flags do
> not behave in this way?

Yeah, right now if you say "merge --ff-only --no-ff", we say these are
mutually exclusive (which is true), but if you think about the tristate
nature of the 'ff' option and spell it differently in your head, i.e.
"merge --ff=only --ff=never", it is reasonable to argue that we should
apply the usual "last one overrides" rule and behave as if "merge --no-ff"
were given (for the purpose of "last one overrides", the configured
defaults can be treated as if they come very early on the command line).
After all "merge --no-ff --ff" does seem to use the "last one overrides"
rule.

[Footnote]

*1* Perhaps 'allowed' instead of 'normal' (which I wrote out of thin-air;
I do not have any strong preference on the actual values) may be a better
choice for such a "this is not a boolean" spelling for the default mode.
