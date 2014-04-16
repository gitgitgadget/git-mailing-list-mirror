From: Junio C Hamano <gitster@pobox.com>
Subject: Re: On "interpret-trailers" standalone tool
Date: Wed, 16 Apr 2014 10:43:52 -0700
Message-ID: <xmqq38hdi2zr.fsf@gitster.dls.corp.google.com>
References: <xmqq61mi1djt.fsf@gitster.dls.corp.google.com>
	<20140412.213003.73509455950485398.chriscool@tuxfamily.org>
	<xmqqy4z7lhc4.fsf@gitster.dls.corp.google.com>
	<CAP8UFD0w9xUwuk9UZ_mu=qvjtYN1r5skidweruM8t1KbfQpQyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 19:44:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaTsQ-0006o5-CG
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 19:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801AbaDPRn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 13:43:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40661 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928AbaDPRn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 13:43:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3395D7CE32;
	Wed, 16 Apr 2014 13:43:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1kY7bFcdlaBwqRM5bHCtq7JEN3Q=; b=DblMKg
	AS2a3La+Sm86aNozdiFP9TTLzMOtyTyXjpkSIKqKKWUzcIk3oBuBYW8wftbF12Z+
	wCWrHJHMQIIV3fBB013ihizdxikoP3mMspyExeMvCEhSEYf7RAQc2WNec3IixOKR
	w2A7nlTWtOGqGTAlndoyktw+Zp2Ygj3g7sP4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ImHiJPiAUaPJPlluy+PsJMHFpOf1x11Z
	ZDuSSgPX8xSsp1HBSBRSPNkmGIWYaciFhyR4E3EFWE1poAONkVLg1fhP92Hwt/qq
	RKaatYP3hHo5cPnylmUdMwGwv0RBli1fUsXGLZwjxO7CUc3QIyffQ4EBRi569Dk/
	ANLkkTZx+n8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B07A7CE31;
	Wed, 16 Apr 2014 13:43:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74D137CE30;
	Wed, 16 Apr 2014 13:43:54 -0400 (EDT)
In-Reply-To: <CAP8UFD0w9xUwuk9UZ_mu=qvjtYN1r5skidweruM8t1KbfQpQyA@mail.gmail.com>
	(Christian Couder's message of "Wed, 16 Apr 2014 14:27:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ADEA130C-C58E-11E3-A60D-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246367>

Christian Couder <christian.couder@gmail.com> writes:

> If the input comes from stdin, then I agree that the command should be
> a filter, so its output should be on stdout. But if the input comes
> from files given as arguments, then I would say that the command
> should behave as an editor and by default it should edit its input
> file inplace.

I do not see where that "should" comes from.  I am looking at this
more from the angle of obtaining a useful building block, while you
seem to be thinking of this as a specialized tool for a narrow set
of specifkc tasks.

Thinking of examples in "sort" and "sed", I would say "read multiple
files, futz with the contents and spit out a single output stream"
is the way people expect a command to operate without being told to
operate in some other way.  Overwriting existing files should never
be the default for safety---otherwise you would require people who
want safety to do something like:

    cp realfile tmp
    futz tmp
    verify tmp
    mv tmp realfile

On the other hand, a usual "sort/sed/cat"-like command, even without
the "in-place edit" option, can be used as in-place with

    mv realfile tmp
    futz tmp >realfile

easily, and is more flexible as a building block.  Of course, that
does not rule out an option to work in-place (e.g. in a similar way
to "sort -o file file", or "perl -i -e 'y/a-z/A-Z/' frotz nitfol").

> Its input and output files should be different only if
> it is given one or more special option,
>
> Otherwise the example you gave:
>
>     $ git format-patch -5 --cover-letter -o +my-series/ my-topic
>     $ git interpret-trailers "some args" ./+my-series/0*.patch
>
> would result in having on stdout all the patches edited by "git
> interpret-trailers".

Didn't I mention that I do not mind "-i" already if in-place edit is
desired?  Add "-i" to the command line arguments among "some args",
and your complaints will disappear, no?
