From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 20/23] reflog_expire(): new function in the reference API
Date: Fri, 12 Dec 2014 10:57:15 -0800
Message-ID: <xmqqwq5wbss4.fsf@gitster.dls.corp.google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
	<1417734515-11812-21-git-send-email-mhagger@alum.mit.edu>
	<20141208233217.GL25562@google.com> <548AA5E9.9090201@alum.mit.edu>
	<20141212085022.GA11891@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 12 19:57:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzVPU-0005OU-IU
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 19:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965445AbaLLS5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 13:57:49 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57923 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932399AbaLLS5s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 13:57:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FA9625B31;
	Fri, 12 Dec 2014 13:57:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=whm/TmYmIYRuwv/envcmvWJqcz0=; b=bLmjqG
	ODk0byrltN6WkW4qTmyexNFHXJwhBCdyYva5qHnRTlk0xg9oFiVjV/s5wWmL5yQb
	s4dGtRFBxkQiEjT+Zx1hQtAo7XCo89HaJvXFMEPEvtDfLcQpayjye4na6Veguq0l
	a/LmPeWdpgsx4lTT7kUan70zRSXkKUpx2D710=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mx256t6kQYRswxM5f6VGp4gw0tQDLB2v
	nNQswT3ROak4X+NfiM5TdBFlT7HyS6o0io+T3ALWvEWyfqG881Z3OfygUO5SEjQH
	sD99L2zqhRjjxge1yRgkW/2eHT4Fhc4qeOCp4uF/T04YJLNDHlvUFRlycNFF0zad
	1S1Xkvydvl8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 749DB25B30;
	Fri, 12 Dec 2014 13:57:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A842A25B11;
	Fri, 12 Dec 2014 13:57:16 -0500 (EST)
In-Reply-To: <20141212085022.GA11891@peff.net> (Jeff King's message of "Fri,
	12 Dec 2014 03:50:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B1020C3E-8230-11E4-9F76-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261358>

Jeff King <peff@peff.net> writes:

>> > enum expire_reflog_flags {
>> >      EXPIRE_REFLOGS_DRY_RUN    = 1 << 0,
>> >      EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
>> >      EXPIRE_REFLOGS_VERBOSE    = 1 << 2,
>> >      EXPIRE_REFLOGS_REWRITE    = 1 << 3
>> > }
>> > 
>> > Do we have a preference in the coding style on this one?
>
> I think vertically aligned lists look really nice. But they often wreak
> havoc with diffs, because introducing one longer line means re-aligning
> the whole thing. IMHO, it's not worth it (but if you're going to do it,
> leave lots of extra room for expansion).
>
> Just my two cents, of course. I don't recall this particular style point
> coming up before.
>
>> Both styles are used in our codebase, and I don't think the style guide
>> says anything about it. My practice in such cases is:
>> 
>> * If I'm modifying existing code, preserve the existing style (to avoid
>> unnecessary churn)
>> * If most of our code uses one style, then use that style
>> * If our code uses both styles frequently, just use whatever style looks
>> better to me
>
> I think that is a very good philosophy in general.

Thanks.

About the indentation on the second and subsequent lines of a
logical line that is split into multiple lines, we explicitly say
"Both ar valid, and we use both."  Following the above three-bullet
list would be a good practice for this one, too.
