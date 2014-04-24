From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Harmful LESS flags
Date: Thu, 24 Apr 2014 12:02:04 -0700
Message-ID: <xmqqha5iv9eb.fsf@gitster.dls.corp.google.com>
References: <4dc69237123e8962b2b2b901692ea78e.id@mailtor>
	<87lhuvb9kr.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: d9ba@mailtor.net, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Apr 24 21:02:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdOuW-0001EJ-1Q
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 21:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758298AbaDXTCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 15:02:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46495 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753229AbaDXTCI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 15:02:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D340180CE8;
	Thu, 24 Apr 2014 15:02:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=kH8ouhjX8Zv+fwPIkPctyGntN4o=; b=hdwOBkbZ6jqchcINYT2/
	DgFsKd7U6ggXIRRyFquvFOfANNys0Tqxj/suY781viPTC2tml0UN0tkL85492tnl
	daBCkhDyFVFKxJSANl9wE9cbJHusq0hFTdbYTMali5tTI2WFvifj+jlmSCp1g4Pp
	0UEBUTAr8doHtJhTv2mIOn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Z8dLHqiN/6XFQW2wcsx7gEHbNMyBLsZMB1gVGb3pwPdpaJ
	OcLdg1kZRLZcVabBl78ibVi7NvkO8258HdGxdQBZDLW9qWP++NLsUN4pQ9nX/07o
	0iq6XpEId1HtGoYH2At4a94OLS+A0r9433HrGavY108Ba9TYXCsDbQ5QpjHwY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8A7180CE6;
	Thu, 24 Apr 2014 15:02:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAC5A80CE2;
	Thu, 24 Apr 2014 15:02:05 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ED6BAE3C-CBE2-11E3-A467-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246997>

David Kastrup <dak@gnu.org> writes:

> d9ba@mailtor.net writes:
>
>> It would be nice if we could change the flags to either
>>
>>  a) avoid cutting off
>>  b) indicate something has been cut off (<- I prefer this)
>>
>> I assume there are more people with a similar workflow who're still
>> unaware of this feature.
>>
>> I would joke about how 3 letter agencies introduced this flag to
>> backdoor open source projects, but, well..
>
> Most terminals are wider than three letters.

I am having a hard time to decide if you genuinely misread what you
are responding to, or if you are joking.  If the latter, I find the
joke mildly funny in a twisted way ;-)

But the tangent aside...

> Still, it is a total nuisance.  I am constantly doing
>
> -S RET
>
> on my git output.  This should be left alone as an entirely personal
> preference quite unrelated to Git.  There is no point in having Git
> configure a default different from what is used elsewhere.

I almost agree with the general principle of the last sentence, but
with a bit of reservation.  The default value for LESS (i.e. when
the user does not have any) we pass is FRSX, and the Porcelain
output these days is colored by default.  If we don't set a default
at all, the end-user experience for a newbie will be bad, especially
without "R".

Among the other three, F and X are to avoid a short output (e.g "git
show" on a one-liner with a short explanation) from asking for
confirmation to leave the pager and from clearing the screen upon
leaving the pager, and are generally accepted as good things (or at
least, we haven't seen much issue raised after we started passing
the default LESS for those who do not have their own in their
environment).

Use of S is very subjective.  While I personally do appreciate that
we have it by default, I can perfectly well understand why some
people do not want to see it in the default.  The best we can do is
to arrange so that people from one of the camps have their favorite
out of the box and those from the other camp need to tell Git that
they want to (or do not want to) fold long lines.

Traditionally, because the tool grew in a context of being used in a
project whose participants are at least not malicious, always having
to be on the lookout for fear of middle-of-line tabs hiding bad
contents near the right edges of lines has never been an issue.  If
somebody brought up a potential issue of such mode of attack back
then, Linus may have chosen the default differently.  I may have
myself chosen not to have S, if I were the maintainer when the LESS
default was originally introduced, and had I been made aware of this
issue.

I am not opposed to changing the default in the longer term, as long
as we have a solid transition plan to ensure that it won't disrupt
and/or upset existing users too much.
